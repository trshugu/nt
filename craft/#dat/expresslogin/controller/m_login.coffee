module.exports = (req, res)->
  console.log req.session
  console.log req.session.user
  # req.session.user = "useeeeeeee"
  # console.log "ceeeeeeeck" if req.session.nanka
  
  console.log req.query
  console.log req.body
  
  isLogin = false
  
  if req.body.word == "true"
    console.log "truth"
    isLogin = true
  
  if isLogin
    console.log "userdfine"
    if url?
      next()
    else
      res.redirect "m_top"
  else
    console.log "nothing"
    # res.redirect "/m_login"
    res.render "m_login"
  
  console.log "login next"
  
  
  
  
  