redis = require "redis"

module.exports = (req, res)->
  console.log req.session
  
  req.session.don = "k"
  c = redis.createClient()
  c.set "aaa", "vvv"
  
  res.render 'index', { title:"exp", raise: req.session.rai}