gulp = require("gulp")

gulp.task 'copy', ->
  gulp.src("src/**")
    .pipe gulp.dest("dist")
  return

gulp.task "default", ->
  gulp.run "copy"
  return
