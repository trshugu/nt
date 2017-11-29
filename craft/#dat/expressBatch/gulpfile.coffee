gulp = require("gulp")
plumber = require "gulp-plumber"
jade = require("gulp-jade")
coffee = require("gulp-coffee")
stylus = require("gulp-stylus")
###
gulp.task 'jade', ->
  gulp.src("src/*.jade")
    .pipe plumber()
    .pipe jade(pretty: true)
    .pipe gulp.dest("./")
  return

gulp.task 'coffee', ->
  gulp.src("src/*.coffee")
    .pipe plumber()
    .pipe coffee(pretty: true)
    .pipe gulp.dest("./")
  return
###
gulp.task 'stylus', ->
  gulp.src("public/stylesheets/*.styl")
    .pipe plumber()
    .pipe stylus(pretty: true)
    .pipe gulp.dest("./public/stylesheets/")
  return

gulp.task 'watch', ->
  # gulp.watch("src/*.jade", ['jade'])
  # gulp.watch("src/*.coffee", ['coffee'])
  gulp.watch("public/stylesheets/*.styl", ['stylus'])
  return

gulp.task 'build', ->
  # gulp.run "jade"
  # gulp.run "coffee"
  gulp.run "stylus"

gulp.task "default", ['watch']
