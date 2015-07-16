module.exports = (req, res)-> 
  client = require("redis").createClient()
  client.set "ke", "no"
  client.end()
  
  res.render 'index', { title:"exp" }