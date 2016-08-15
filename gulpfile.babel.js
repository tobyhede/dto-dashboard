import gulp from 'gulp';
import path from 'path';
import babelify from 'babelify';
import browserify from 'browserify';
import buffer from 'vinyl-buffer';
import exorcist from 'exorcist';
import notify from 'gulp-notify';
import source from 'vinyl-source-stream';
import transform from 'vinyl-transform';
import watchify from 'watchify';

import sourcemaps from 'gulp-sourcemaps';
import jsdoc from 'gulp-jsdoc3';
import eslintify from 'eslintify';
import changed from 'gulp-changed';
import print from 'gulp-print';

import sass from 'gulp-sass';
import sassLint from 'gulp-sass-lint';
import autoprefixer from 'gulp-autoprefixer';
import bourbon from 'bourbon';
import bourbonNeat from 'bourbon-neat';


export const ENV = process.env.NODE_ENV || 'development';
export const DIR_ROOT = ENV === 'development' ? path.resolve('./') : '';
export const DIR_SRC = path.join(DIR_ROOT, 'lib/assets/src');
export const DIR_DIST = path.join(DIR_ROOT, 'public/assets');
export const DIR_NPM = path.join(DIR_ROOT, 'node_modules');
export const DIR_TEST = path.join(DIR_ROOT, 'lib/assets/tests');
export const DIR_TESTDIST = path.join(DIR_ROOT, '.tmp');

const jsSource = {
    dev: {
        name: 'dev',
        entry: `${DIR_SRC}/scripts`,
        build: 'index.js',
        dest: DIR_DIST
    },
    test: {
        name: 'test',
        entry: `${DIR_TEST}/scripts`,
        build: 'index.js',
        dest: DIR_TESTDIST
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
            paths: [
                `${DIR_SRC}/scripts/`
            ]
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
            paths: [
                `${DIR_SRC}/scripts/`
            ]
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


/**
 * Tasks
 */

gulp.task('sass', function () {
    return gulp.src(`${DIR_SRC}/styles/**/*.scss`)
        .pipe(sassLint({
            configFile: './.sass-lint.yml'
        }))
        .pipe(sassLint.format())
        .pipe(sourcemaps.init())
        .pipe(sass({
            includePaths: [
                `${DIR_SRC}/styles`,
                DIR_NPM,
                bourbon.includePaths,
                bourbonNeat.includePaths
            ]
        }).on('error', sass.logError))
        .pipe(autoprefixer())
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest(`${DIR_DIST}`));
});

gulp.task('sass:watch', function () {
    gulp.watch(`${DIR_SRC}/styles/**/*.scss`, ['sass']);
});


gulp.task('scripts', function dev() {
    return build(jsSource.dev, false);
});

gulp.task('scripts:watch', function() {
    return watch(jsSource.dev, false);
});


gulp.task('test', function test() {
    return build(jsSource.test, false);
});

gulp.task('test:watch', function watchTest() {
    return watch(jsSource.test, false);
});


gulp.task('images', () => {
   return gulp.src(`${DIR_SRC}/images/**/*.{jpg,png,gif,svg}`)
       .pipe( changed(`${DIR_DIST}/images`) )  // ignore unchanged
       .pipe( print(function(file) {return 'Processing IMAGE: ' + file; }) )
       .pipe( gulp.dest(`${DIR_DIST}/images/`) );
});

gulp.task('images:watch', ['images']);


/**
 * Workflows
 */

gulp.task('default', ['build']);

gulp.task('build', ['scripts', 'sass', 'images', 'test']);

gulp.task('watch', ['scripts:watch', 'sass:watch', 'images:watch', 'test:watch']);

