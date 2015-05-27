
module.exports = (req, res)->
  console.log req.session
  console.log process.pid
  req.session.don = if req.session.don? then req.session.don + 1 else 1
  
  res.render 'index', { title:"exp", raise: req.session.rai}