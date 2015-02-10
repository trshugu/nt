fs = require "fs"

shuffle = (arr) ->
  len = arr.length
  res = []
  while(len)
    res.push( arr.splice( Math.floor(Math.random() * len--), 1 )[0] )
  res

module.exports = (path)->
  shuffle(fs.readFileSync(__dirname + "/" + path,"utf-8").trim().split("\n"))[0].trim()

