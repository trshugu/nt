gulp = require "gulp"
plumber = require "gulp-plumber"
# jade = require "gulp-jade"
jade = require "gulp-pug"
coffee = require "gulp-coffee"
stylus = require "gulp-stylus"

###
gulp.task 'jade', ->
  gulp.src("src/*.jade")
    .pipe plumber()
    .pipe jade(pretty: true)
    .pipe gulp.dest("./")
  return
###

###
gulp.task 'pug', ->
  gulp.src("src/*.pug")
    .pipe plumber()
    .pipe pug(pretty: true)
    .pipe gulp.dest("./")
  return
###

gulp.task 'coffee', ->
  gulp.src("public/scripts/*.coffee")
    .pipe plumber()
    .pipe coffee(pretty: true)
    .pipe gulp.dest("public/scripts/")
  return

gulp.task 'stylus', ->
  gulp.src("public/styles/*.styl")
    .pipe plumber()
    .pipe stylus(pretty: true)
    .pipe gulp.dest("public/styles/")
  return

gulp.task 'watch', ->
  # gulp.watch("src/*.jade", ['jade'])
  # gulp.watch("src/*.pug", ['pug'])
  gulp.watch("public/scripts/*.coffee", ['coffee'])
  gulp.watch("public/styles/*.styl", ['stylus'])
  return

gulp.task 'build', ->
  # gulp.run "jade"
  # gulp.run "pug"
  gulp.run "coffee"
  gulp.run "stylus"

gulp.task "default", ['watch']
