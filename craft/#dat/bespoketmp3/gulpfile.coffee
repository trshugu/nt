gulp = require('gulp')
through = require('through')
plumber = require('gulp-plumber')
rename = require('gulp-rename')
connect = require('gulp-connect') # B
rimraf = require('rimraf')
opn = require('opn')
path = require('path')

# js
source = require('vinyl-source-stream')
transform = require("vinyl-transform")
browserify = require('browserify')
uglify = require('gulp-uglify')
coffee = require "gulp-coffee"
buffer = require('vinyl-buffer')
webpack = require "gulp-webpack"
webpacks = require('webpack-stream')
debowerify = require('debowerify')


# html
jade = require('gulp-jade')

# css
stylus = require('gulp-stylus')
autoprefixer = require('gulp-autoprefixer')
csso = require('gulp-csso')

isDist = process.argv.indexOf('serve') == false


gulp.task 'js', ['clean:js'], ->
  browserify
    entries: ['./src/scripts/main.coffee']
  .transform 'coffeeify'
  .transform 'debowerify'
  .bundle()
  .pipe source 'main.js'
  .pipe if isDist then uglify() else through()
  .pipe rename 'build.js'
  .pipe gulp.dest "./dist/build"
  .pipe if isDist then through() else plumber()
  .pipe connect.reload()

###
# good
gulp.task 'js', ['clean:js'], ->
  browserify
    entries: ['./src/scripts/main.coffee']
  .transform 'coffeeify'
  .transform 'debowerify'
  .bundle()
  .pipe source 'main.js'
  .pipe rename 'build.js'
  .pipe gulp.dest "./dist/build"
  .pipe connect.reload()
###


###
gulp.task 'js', ['clean:js'], ->
  gulp.src('./src/scripts/main.js')
    .pipe webpacks()
    .pipe rename('build.js')
    .pipe gulp.dest('./dist/build')
  
  
  return
###

###
gulp.task 'js', ['clean:js'], ->
  browserify './src/scripts/main.js'
    .bundle()
    .pipe source("d.js")
    .pipe buffer()
    .pipe if isDist then through() else plumber()
    .pipe if isDist then uglify() else through()
    .pipe rename('build.js')
    .pipe gulp.dest('./dist/build')
    .pipe connect.reload()
  return
###

###
gulp.task 'js', ['clean:js'], ->
  gulp.src('src/scripts/main.js')
    .pipe if isDist then through() else plumber()
    .pipe browserify( transform: ['debowerify'], debug: !isDist )
    .pipe if isDist then uglify() else through()
    .pipe rename('build.js')
    .pipe gulp.dest('dist/build')
    .pipe connect.reload()
  return
###

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

gulp.task 'clean:js', (cb)-> rimraf 'dist/build/build.js', cb
gulp.task 'clean:html', (cb)-> rimraf 'dist/*.html', cb
gulp.task 'clean:css', (cb)-> rimraf 'dist/build/build.css', cb
gulp.task 'clean:images', (cb)-> rimraf 'dist/images', cb
gulp.task 'clean', (cb)-> rimraf 'dist', cb

gulp.task 'images', ['clean:images'], ->
  gulp.src('src/images/**/*')
    .pipe gulp.dest('dist/images')
    .pipe connect.reload()
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
  gulp.watch 'src/scripts/**/*.js', ['js']
  gulp.watch 'src/scripts/**/*.coffee', ['js']
  gulp.watch 'bespoke-theme-*/dist/*.js', ['js'] # Allow themes to be developed in parallel
gulp.task 'build', ['js', 'html', 'css', 'images']
gulp.task 'serve', ['connect', 'watch']
gulp.task 'default', ['build', 'watch']

