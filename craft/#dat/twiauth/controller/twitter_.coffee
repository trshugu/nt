helper = require "./helper"

module.exports = (req, res)->
  console.log "==twitter=="
  console.log req.query
  console.log req.body
  console.log req.session
  console.log req.params
  
  # location = req.protocol + "://" + req.headers.host + "/callback"
  # oa = helper.getOauth(location)
  # console.log oa
  # oa = helper.getOauth("callback")
  # console.log location
  
  oa = helper.getOauth(req.protocol + "://" + req.headers.host + "/callback")
  oa.getOAuthRequestToken (error, requestToken, requestTokenSecret, results)->
    if error?
      console.log error
      res.send "yeah no. didn't work."
    else
      req.session.oauth = {}
      req.session.oauth.request_token = requestToken
      req.session.oauth.request_token_secret = requestTokenSecret
      
      console.log req.session
      console.log 'oauth.request_token: ' + req.session.oauth.request_token
      console.log 'oauth.request_token_secret: ' + req.session.oauth.request_token_secret
      
      res.redirect 'https://twitter.com/oauth/authenticate?oauth_token=' + requestToken
  
  