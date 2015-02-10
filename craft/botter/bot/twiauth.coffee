twitter = require "twitter"
fs = require "fs"

module.exports = ->
  lineArray = fs.readFileSync(__dirname + '/oauth.txt', "utf-8").trim().split("\n")
  client = new twitter(
    consumer_key: lineArray[0].trim()
    consumer_secret: lineArray[1].trim()
    access_token_key: lineArray[2].trim()
    access_token_secret: lineArray[3].trim()
  )
  
  return client
