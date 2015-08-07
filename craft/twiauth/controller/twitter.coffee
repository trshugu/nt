helper = require "./helper"

module.exports = (req, res)->
  console.log req.session
  location = if req.query.location? then req.query.location else "/"
  oa = helper.getOauth(location)
  # console.log oa
  console.log location
  
  oa.getOAuthRequestToken (error, oauth_token, oauth_token_secret, results)->
    if error?
      console.log error
      res.send "yeah no. didn't work."
    else
      req.session.oauth = {}
      req.session.oauth.token = oauth_token
      req.session.oauth.token_secret = oauth_token_secret
      
      console.log req.session
      console.log 'oauth.token: ' + req.session.oauth.token
      console.log 'oauth.token_secret: ' + req.session.oauth.token_secret
      
      res.redirect 'https://twitter.com/oauth/authenticate?oauth_token=' + oauth_token
  
  
