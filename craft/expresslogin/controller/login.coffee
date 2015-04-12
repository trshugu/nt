module.exports = (req, res, next)->
  console.log req.session
  console.log req.session.user
  req.session.user = "useeeeeeee"
  console.log "ceeeeeeeck" if req.session.nanka
  if req.session
    console.log "userdfine"
  else
    console.log "nothing"
    res.redirect "/user"
  
  console.log "login next"
  next()


