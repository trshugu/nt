fs = require "fs"

module.exports = (path)->
  arr = fs.readFileSync(__dirname + "/" + path,"utf-8").trim().split("\n")
  arr.splice( Math.floor(Math.random() * arr.length), 1 )[0].trim()

