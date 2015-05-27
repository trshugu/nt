module.exports = (req, res)->
  console.log req.query
  console.log req.body
  console.log req.session
  console.log req.params
  
  # require("fs").readFileSync("./noi/asdf.asdf", "utf-8")
  file = require('fs').createWriteStream('./downloads/' + "asdfjio")
  file = require('fs').createWriteStream('./downloads/' + "asdfjio")
  
  res.send "death"
  file = require('fs').createWriteStream('./downloads/' + "asdfjio")
  
  

