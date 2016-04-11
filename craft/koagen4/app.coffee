app = module.exports = require('koa')()

# Logger
app.use require('koa-logger')()

# route
route = require('koa-route')
render = require('co-views')(require("path").join(__dirname + '/views'), map: html: 'jade')
require("./controllers/routes") app, route, render

# Serve static files
app.use require('koa-static')(require('path').join(__dirname, 'public'))

# Compress
app.use require('koa-compress')()

if !module.parent
  app.listen 3000
  console.log 'listening on port 3000'
