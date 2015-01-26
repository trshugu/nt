gulp = require("gulp")

browserify = require 'browserify'
source = require 'vinyl-source-stream'

gulp.task 'script', ->
  browserify
    entries: ['./src/main.coffee']
    extensions: ['.coffee'] # CoffeeScript���g����悤��
  .bundle()
  .pipe source 'main.js' # �o�̓t�@�C�������w��
  .pipe gulp.dest "./js/" # �o�̓f�B���N�g�����w��


