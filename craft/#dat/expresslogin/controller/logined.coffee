module.exports = (req, res)->
  console.log "gyosyou"
  req.session.nanka = "gyosyou"
  res.render 'logined', { title:"exp" }
  