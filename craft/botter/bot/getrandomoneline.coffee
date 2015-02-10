fs = require "fs"

shuffle = (a) ->
  i = a.length - 1
  while i >= 0
    r = Math.floor(i * Math.random())
    tmp = a[i]
    a[i] = a[r]
    a[r] = tmp
    i--
  a

module.exports = (path)->
  shuffle(fs.readFileSync(__dirname + "/" + path,"utf-8").trim().split("\n"))[0].trim()

