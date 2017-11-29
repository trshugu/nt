f = require 'fluent-logger-node'
l = f.createLogger()

exports.index = (req, res)-> 
  l.post "tag.root", req.body
  l.post "tag.resres", res.body
  res.render('index')
exports.users = (req, res)-> res.render('users')
