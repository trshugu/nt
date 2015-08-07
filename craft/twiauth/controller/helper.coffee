OAuth = require("oauth").OAuth
Twitter = require 'twitter'

module.exports.getTwitterClient = (at, ats) ->
  new Twitter
    consumer_key: ""
    consumer_secret: ""
    access_token_key: at
    access_token_secret: ats

module.exports.getOauth = (callbackUrl)->
  new OAuth(
    "https://api.twitter.com/oauth/request_token",
    "https://api.twitter.com/oauth/access_token",
    ""
    ""
    "1.0A",
    callbackUrl,
    "HMAC-SHA1")
  


