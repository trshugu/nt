express = require('express')
app = express()

controller = {}
controller.index = require("./controller/index")
controller.other = require("./controller/other")
require("./routes")(app, controller)

server = app.listen 3000, ->
  host = server.address().address
  port = server.address().port
  console.log('Example app listening at http://%s:%s', host, port)

