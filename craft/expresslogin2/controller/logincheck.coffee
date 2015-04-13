module.exports = (req, res, next)->
  # セッションの確認
  console.log req.query
  console.log req.body
  console.log req.headers.host
  console.log req.path
  url = ""
  url = req.headers.host + req.path
  console.log url
  isLogin = false
  
  if req.session.ninsyo?
    console.log "isl"
    console.log req.session.ninsyo
    isLogin = true
  else
    console.log req.session.ninsyo
    console.log "nailog"
  
  if isLogin
    next()
  else
    if url != ""
      console.log "ariiiiii"
      res.redirect "/login?url=" + encodeURIComponent(url)
    else
      console.log "naiiiiiiiiiiiiii"
      res.redirect "/login"
  