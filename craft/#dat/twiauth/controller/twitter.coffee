helper = require "./helper"

module.exports = (req, res)->
  # URL•ÛŽ‚Ì‚½‚ß‚É•K—vH
  oa = helper.getOauth(req.protocol + "://" + req.headers.host + "/callback")
  oa.getOAuthRequestToken (e, requestToken, requestTokenSecret, results)->
    if e?
      console.log e
    else
      req.session.oauth = {}
      req.session.oauth.request_token = requestToken
      req.session.oauth.request_token_secret = requestTokenSecret
      
      res.redirect 'https://twitter.com/oauth/authenticate?oauth_token=' + requestToken
