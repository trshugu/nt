module.exports = (req, res)->
  console.log req.session
  console.log req.session.user
  
  console.log req.query
  console.log req.body
  if req.body.word == "true"
    console.log "loginsyori"
    console.log req.session.ninsyo = "niysoodesu"
    console.log req.query.url
    # res.redirect decodeURIComponent(req.query.url) # white list!!!!
    res.redirect "//" + req.query.url # white list!!!!
  else
    console.log "loginNGGGGGGGGGG"
    res.render "login"
  
