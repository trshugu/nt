module.exports = (req, res, next)->
  console.log req.session
  console.log req.session.user
  req.session.user = "useeeeeeee"
  console.log "ceeeeeeeck" if req.session.nanka
  
  isLogin = false
  
  if isLogin
    console.log "userdfine"
  else
    console.log "nothing"
    res.redirect "/loginform"
  
  console.log "login next"
  next()


