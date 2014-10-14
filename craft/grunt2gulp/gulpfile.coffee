gulp = require("gulp")
jade = require("gulp-jade")
coffee = require("gulp-coffee")
stylus= require("gulp-stylus")

gulp.task 'jade', ->
  gulp.src("src/*.jade")
    .pipe jade(pretty: true)
    .pipe gulp.dest("./")
  return

gulp.task 'coffee', ->
  gulp.src("src/*.coffee")
    .pipe coffee(pretty: true)
    .pipe gulp.dest("./")
  return

gulp.task 'stylus', ->
  gulp.src("src/*.styl")
    .pipe stylus(pretty: true)
    .pipe gulp.dest("./")
  return

gulp.task 'watch', ->
  gulp.watch("src/*.jade", ['jade'])
  gulp.watch("src/*.coffee", ['coffee'])
  gulp.watch("src/*.styl", ['stylus'])
  return

gulp.task "default", ['watch']
