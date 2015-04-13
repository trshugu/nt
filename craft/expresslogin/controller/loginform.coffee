module.exports = (req, res)->
  console.log "loginform is hare"
  req.session.nanka = "gyosyou"
  res.render 'loginform', { title:"exp" }