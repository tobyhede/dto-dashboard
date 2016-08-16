import gulp from 'gulp';

import path from 'path';

import del from 'del';

import babelify from 'babelify';
import browserify from 'browserify';
import buffer from 'vinyl-buffer';
import exorcist from 'exorcist';
import notify from 'gulp-notify';
import source from 'vinyl-source-stream';
import transform from 'vinyl-transform';
import watchify from 'watchify';

import sourcemaps from 'gulp-sourcemaps';
import eslintify from 'eslintify';
import changed from 'gulp-changed';
import print from 'gulp-print';

import sass from 'gulp-sass';
import sassLint from 'gulp-sass-lint';
import autoprefixer from 'gulp-autoprefixer';
import bourbon from 'bourbon';
import bourbonNeat from 'bourbon-neat';


export const ENV = process.env.NODE_ENV || 'development';
export const DIR_SRC = path.join(__dirname, 'lib/assets/src');
export const DIR_DIST = path.join(__dirname, 'public');
export const DIR_NPM = path.join(__dirname, 'node_modules');
export const DIR_TEST = path.join(__dirname, 'lib/assets/tests');
export const DIR_TESTDIST = path.join(__dirname, '.tmp');

export const DIR_SRC_STYLES = path.join(DIR_SRC, 'styles');
export const DIR_SRC_SCRIPTS = path.join(DIR_SRC, 'scripts');
export const DIR_SRC_IMAGES = path.join(DIR_SRC, 'images');
export const DIR_DIST_STYLES = path.join(DIR_DIST, 'stylesheets');
export const DIR_DIST_SCRIPTS = path.join(DIR_DIST, 'javascripts');
export const DIR_DIST_IMAGES = path.join(DIR_DIST, 'images');

const jsSource = {
    dev: {
        name: 'dev',
        entry: DIR_SRC_SCRIPTS,
        build: 'javascripts/index.js',
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

gulp.task('clean', (done) => {
	return del([
		DIR_DIST_STYLES + '/**/*',  // don't remove the folder
		DIR_DIST_SCRIPTS + '/**/*',
		DIR_DIST_IMAGES + '/**/*',
	], done);
});

gulp.task('sass', () => {
	return gulp.src(`${DIR_SRC_STYLES}/**/*.scss`)
		.pipe(sassLint({
			configFile: './.sass-lint.yml'
		}))
		.pipe(sassLint.format())
		.pipe(sourcemaps.init())
		.pipe(sass({
			includePaths: [
				DIR_NPM,
				bourbon.includePaths,   // todo - these aren't _really_ necessary
				bourbonNeat.includePaths
			]
		}).on('error', sass.logError))
		.pipe( print( (file) => 'Reading Sass: ' + file) )
		.pipe(autoprefixer())
		.pipe(sourcemaps.write('./'))
		.pipe(gulp.dest(DIR_DIST_STYLES));
});

gulp.task('sass:watch', () => {
    gulp.watch(`${DIR_SRC_STYLES}/**/*.scss`, gulp.parallel('sass'));
});


gulp.task('scripts', () => build(jsSource.dev, false));

gulp.task('scripts:watch', () => watch(jsSource.dev, false));


gulp.task('test', () => build(jsSource.test, false));

gulp.task('test:watch', () => watch(jsSource.test, false));


gulp.task('images', () => {
	return gulp.src(`${DIR_SRC_IMAGES}/**/*.{jpg,png,gif,svg}`)
		.pipe( changed(DIR_DIST_IMAGES) )                       // ignore unchanged
		.pipe( print((file) => 'Reading IMAGE: ' + file))
		.pipe( gulp.dest(`${DIR_DIST_IMAGES}/`) );
});

gulp.task('images:watch', () => {
	gulp.watch(`${DIR_SRC_IMAGES}/**/*.{jpg,png,gif,svg}`, gulp.parallel('images'));
});


/**
 * Workflows
 */

gulp.task('build', gulp.series('clean', gulp.parallel('scripts', 'sass', 'images', 'test')));

gulp.task('watch', gulp.series('build', gulp.parallel('scripts:watch', 'sass:watch', 'images:watch', 'test:watch')));
