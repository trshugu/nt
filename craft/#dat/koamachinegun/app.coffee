app = module.exports = require('koa')()
sc = require 'koa-static-cache'

app.use sc( require("path").join(__dirname + '/public'), maxAge: 1*24*60*60 )

# Logger
app.use require('koa-logger')()

# route
route = require('koa-route')
render = require('co-views')(require("path").join(__dirname + '/views'), default: "jade")
require("./controllers/routes") app, route, render

# Compress
app.use require('koa-compress')()

# js/css
app.use require('koa-stylus')(require("path").join(__dirname, 'public'))
app.use require('koa-coffee-script')(require("path").join(__dirname, 'public'))

# Serve static files
app.use require('koa-static')(require('path').join(__dirname, 'public'), maxAge: 1*24*60*60)

if !module.parent
  app.listen 3001
  console.log 'listening on port 3001'
