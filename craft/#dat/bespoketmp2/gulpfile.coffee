pkg = require('./package.json')
gulp = require('gulp')
gutil = require('gulp-util')
plumber = require('gulp-plumber')
rimraf = require('gulp-rimraf')
rename = require('gulp-rename')
connect = require('gulp-connect')
browserify = require('gulp-browserify')
uglify = require('gulp-uglify')
jade = require('gulp-jade')
stylus = require('gulp-stylus')
autoprefixer = require('gulp-autoprefixer')
csso = require('gulp-csso')
through = require('through')
opn = require('opn')
ghpages = require('gh-pages')
path = require('path')
isDist = process.argv.indexOf('serve') == -1

gulp.task 'js', ['clean:js'], ->
  gulp.src('src/scripts/main.js')
    .pipe if isDist then  through() else plumber()
    .pipe browserify( transform: ['debowerify'], debug: !isDist )
    .pipe if isDist then uglify() else through()
    .pipe rename('build.js')
    .pipe gulp.dest('dist/build')
    .pipe connect.reload()
  return

gulp.task 'html', ['clean:html'], ->
  gulp.src('src/*.jade')
    .pipe if isDist then through() else plumber()
    .pipe jade( pretty: true )
    .pipe gulp.dest('dist')
    .pipe connect.reload()
  return

gulp.task 'css', ['clean:css'], ->
  gulp.src('src/styles/main.styl')
    .pipe if isDist then through() else plumber()
    .pipe stylus
      'include css': true,
      'paths': ['./node_modules', './bower_components']
    .pipe autoprefixer('last 2 versions', map: false)
    .pipe if isDist then csso() else through()
    .pipe rename('build.css')
    .pipe gulp.dest('dist/build')
    .pipe connect.reload()
  return

gulp.task 'images', ['clean:images'], ->
  gulp.src('src/images/**/*')
    .pipe gulp.dest('dist/images')
    .pipe connect.reload()
  return

gulp.task 'clean', ->
  gulp.src('dist')
    .pipe rimraf()
  return

gulp.task 'clean:html', ->
  gulp.src('dist/index.html')
    .pipe rimraf()
  return

gulp.task 'clean:js', ->
  gulp.src('dist/build/build.js')
    .pipe rimraf()
  return

gulp.task 'clean:css', ->
  gulp.src('dist/build/build.css')
    .pipe rimraf()
  return

gulp.task 'clean:images', ->
  gulp.src('dist/images')
    .pipe rimraf()
  return

gulp.task 'connect', ['build'], (done)->
  connect.server
    root: 'dist'
    livereload: true
  
  opn 'http://localhost:8080', done

gulp.task 'watch', ->
  gulp.watch 'src/**/*.jade', ['html']
  gulp.watch 'src/styles/**/*.styl', ['css']
  gulp.watch 'src/images/**/*', ['images']
  gulp.watch [
    'src/scripts/**/*.js',
    'bespoke-theme-*/dist/*.js' # Allow themes to be developed in parallel
  ], ['js']

gulp.task 'deploy', ['build'], (done)->
  ghpages.publish path.join(__dirname, 'dist'), logger: gutil.log, done

gulp.task 'build', ['js', 'html', 'css', 'images']
gulp.task 'serve', ['connect', 'watch']
gulp.task 'default', ['build']

