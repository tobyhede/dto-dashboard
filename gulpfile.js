'use strict';
const babelify = require('babelify');
const browserify = require('browserify');
const buffer = require('vinyl-buffer');
const exorcist = require('exorcist');
const gulp = require('gulp');
const notify = require('gulp-notify');
const source = require('vinyl-source-stream');
const transform = require('vinyl-transform');
const watchify = require('watchify');
const sass = require('gulp-sass');
const sourcemaps = require('gulp-sourcemaps');
const uglify = require('gulp-uglify');
const jsdoc = require('gulp-jsdoc3');
const eslintify = require('eslintify');
const sassLint = require('gulp-sass-lint');

const sassGlob = ['./lib/sass/*.scss',
                './lib/sass/**/*.scss',
                './lib/sass/**/**/*.scss'];

const jsSource = {
    dev: {
        name: 'dev',
        entry: './lib/javascripts',
        build: 'index.js',
        dest: './public/assets/javascripts'
    },
    test: {
        name: 'test',
        entry: './spec/javascripts',
        build: 'indexSpec.js',
        dest: './spec/build'
    }
};

function handleErrors() {
    const args = Array.prototype.slice.call(arguments);
    notify.onError({
        title: 'Compile Error',
        message: '<%= error.message %>'
    }).apply(this, args);
    this.emit('end'); // Keep gulp from hanging on this task
}

var neat = require('node-neat').includePaths;

gulp.task('sass', function () {
    return gulp.src('./lib/sass/*.scss')
        .pipe(sassLint({
            configFile: './.sass-lint.yml'
        }))
        .pipe(sassLint.format())
        .pipe(sourcemaps.init())
        .pipe(sass({
            includePaths: ['sass'].concat(neat)
        }).on('error', sass.logError))
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest('./public/assets/css'));
});

gulp.task('default',function(){
    gulp.start('sass');
});

gulp.task('scripts', function dev() {
    return build(jsSource.dev, false);
});

gulp.task('test', function test() {
    return build(jsSource.test, false);
});

gulp.task('scripts:watch', function() {
    return watch(jsSource.dev, false);
});

gulp.task('sass:watch', function () {
    gulp.watch(sassGlob, ['sass']);
});

gulp.task('test:watch', function watchTest() {
    return watch(jsSource.test, false);
});

gulp.task('watch', ['scripts:watch', 'test:watch', 'sass:watch']);

gulp.task('build', ['scripts', 'test', 'sass']);

gulp.task('default', ['build']);

gulp.task('doc', function (cb) {
    gulp.src(['README.md', 'node_modules/d3-charts-dto/lib/javascripts/**/*.js'], {read: false})
        .pipe(jsdoc(cb));
});

function bundle(env, bundler, minify, catchErrors) {
    let result = bundler.bundle();
    if (catchErrors) {
        // Display errors to the user, and don't let them propagate.
        result = result.on('error', handleErrors);
    }
    result = result
        .pipe(source(env.build))
        .pipe(buffer());

    result = result
        // Extract the embedded source map to a separate file.
        .pipe(transform(function() { return exorcist(env.dest + '/' + env.build + '.map'); }))
        // Write the finished product.
        .pipe(gulp.dest(env.dest));

    return result;
}

function build(env) {
    return bundle(env, browserify({
            entries: env.entry,
            debug: true,
            paths: ['./lib/javascripts/']
        })
        .transform({continuous: true}, eslintify)
        .transform(babelify),
        true,
        false
    );
}

function watch(env, minify) {
    const bundler = watchify(
        browserify({
                entries: env.entry,
                debug: true,
                cache: {},
                packageCache: {},
                paths: ['./lib/javascripts/']
            })
            .transform({continuous: true}, eslintify)
            .transform(babelify),
            {poll: 1000}
    );

    function rebundle(ids) {
        // Don't rebundle if only the version changed.
        if (ids && ids.length === 1 && (/\/version\.js$/).test(ids[0])) {
            return false;
        }
        const start = new Date();
        const result = bundle(env, bundler, minify, true);
        result.on('end', function() {
            console.log('Rebuilt ' + env.build + ' in ' + (new Date() - start) + ' milliseconds.');
        });
        return result;
    }

    bundler.on('update', rebundle);
    return rebundle();
}
