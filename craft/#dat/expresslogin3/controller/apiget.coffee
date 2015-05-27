module.exports = (req, res)->
  console.log req.params
  console.log req.body
  console.log req.query
  
  result = ""
  
  require('http')
  
  
  
  res.send result
