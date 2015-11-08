var gulp = require('gulp'),
	nodemon = require('gulp-nodemon'),
	plumber = require('gulp-plumber'),
	livereload = require('gulp-livereload'),
	rename = require('gulp-rename'),
	browserify = require('gulp-browserify'),
	sass = require('gulp-sass');

gulp.task('coffee', function () {
	gulp.src('./public/coffee/sneaquence.coffee', { read: false })
		.pipe(plumber())
		.pipe(browserify({ transform: ['coffeeify'], extensions: ['.coffee'] }))
		.pipe(rename(function(path) {
			path.extname = '.js'
		}))
		.pipe(gulp.dest('./public/js'))
		.pipe(livereload());
});

gulp.task('sass', function () {
	gulp.src('./public/scss/**/*.scss')
		.pipe(plumber())
		.pipe(sass())
		.pipe(gulp.dest('./public/css'))
		.pipe(livereload());
});

gulp.task('watch', function() {
	gulp.watch('./public/coffee/**/*.coffee', ['coffee']);
	gulp.watch('./public/scss/**/*.scss', ['sass']);
});

gulp.task('develop', function () {
	livereload.listen();
	nodemon({
		script: 'app.js',
		ext: 'js coffee swig',
		stdout: false
	}).on('readable', function () {
		this.stdout.on('data', function (chunk) {
			if(/^Express server listening on port/.test(chunk)){
				livereload.changed(__dirname);
			}
		});
	this.stdout.pipe(process.stdout);
	this.stderr.pipe(process.stderr);
	});
});

gulp.task('default', [
	'coffee',
	'sass',
	'develop',
	'watch'
]);
