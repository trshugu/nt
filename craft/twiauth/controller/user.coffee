helper = require "./helper"

module.exports = (req, res)->
  # console.log req.query
  # console.log req.body
  # console.log req.session
  # console.log req.params
  
  client = helper.getTwitterClient req.session.oauth.access_token, req.session.oauth.access_token_secret
  
  console.log req.session.oauth.access_token
  console.log req.session.oauth.access_token_secret
  
  
  client.get "account/verify_credentials", {}, (e,t,r)->
    if e?
      console.log e
    else
      console.log typeof t
      console.log typeof r.body
  
  
  res.render 'index', { title:"expuser " }
  
  