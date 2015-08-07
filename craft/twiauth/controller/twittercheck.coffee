helper = require "./helper"

# �F�؂���Ă��邩�ǂ�����account/verify_credentials�Ŋm���߂�ׂ�
module.exports = (req, res, next)->
  location = req.protocol + "://" + req.headers.host + req.path
  redirect_url = "/auth/twitter"
  redirect_url = redirect_url + "?location=" + encodeURIComponent(location) if location != ""
  oa = helper.getOauth(location)
  
  console.log req.session
  
  
  if req.session.oauth
    if req.session.oauth.access_token
      next()
    else
      req.session.oauth.verifier = req.query.oauth_verifier
      oauth = req.session.oauth
      
      oa.getOAuthAccessToken oauth.token, oauth.token_secret, oauth.verifier, (error, oauth_access_token, oauth_access_token_secret, results)->
        if (error)
          console.log error
          # res.send "yeah something broke."
          # �L�����Z���Ȃǂ�token�������̏ꍇ�͍ēx�F�؉�ʂɔ�΂�
          res.redirect redirect_url
        else
          req.session.oauth.access_token = oauth_access_token
          req.session.oauth.access_token_secret = oauth_access_token_secret
          console.log 'access token: ' + oauth_access_token
          console.log 'access token secret: ' + oauth_access_token_secret
          console.log results
          # res.send "worked. nice one."
          next()
        
      
  else
    res.redirect redirect_url
    # next new Error("you're not supposed to be here.")

  # res.render 'twitter', { title:"twitter" }

