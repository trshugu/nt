validator = require "validator"
module.exports = (req, res)->
  console.log req.query
  console.log req.body
  console.log req.session
  console.log req.params
  
  res.render 'follow'
  
  

