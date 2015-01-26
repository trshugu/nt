Modernizr = require 'browsernizr' # npm経由
$ = require 'jquery' # bower経由
# require './yourscript' # サイト用のスクリプト

# ここに書き足してもOK
console.log 'This page is ' + $('H1').text()