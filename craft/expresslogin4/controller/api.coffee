module.exports = (req, res)->
  console.log req.params
  console.log req.body
  console.log req.query
  
  res.send "api"
