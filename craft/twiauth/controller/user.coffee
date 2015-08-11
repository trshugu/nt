helper = require "./helper"

module.exports = (req, res)->
  # console.log req.query
  # console.log req.body
  # console.log req.session
  # console.log req.params
  
  if req.session?
    console.log "sessionあり"
    if req.session.oauth?
      console.log "oauthあり"
      if req.session.oauth.access_token? && req.session.oauth.access_token_secret?
        console.log "アクセストークンあり"
        console.log req.session.oauth.access_token
        console.log req.session.oauth.access_token_secret
        
        client = helper.getTwitterClient req.session.oauth.access_token, req.session.oauth.access_token_secret
        
        client.get "account/verify_credentials", {}, (e,t,r)->
          if e?
            console.log e
          else
            console.log typeof t
            console.log typeof r.body
      else
        console.log "未ログイン"
    else
      console.log "リクエストトークンはない"
  
  
  res.render 'user', 
    title:"expuser "
    
  
  