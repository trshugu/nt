gulp = require("gulp")

browserify = require 'browserify'
source = require 'vinyl-source-stream'

gulp.task 'script', ->
  browserify
    entries: ['./src/main.coffee']
    extensions: ['.coffee'] # CoffeeScriptも使えるように
  .bundle()
  .pipe source 'main.js' # 出力ファイル名を指定
  .pipe gulp.dest "./js/" # 出力ディレクトリを指定


