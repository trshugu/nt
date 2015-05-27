
module.exports = (req, res)->
  console.log req.session
  console.log process.pid
  req.session.don = if req.session.don? then req.session.don + 1 else 1
  
  hel = require "./helper/helper"
  
  hel.ichi()
  hel.ni()
  
  res.render 'index', { title:"exp", raise: req.session.rai, emess:""}
