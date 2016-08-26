Koa = require('koa')
app = module.exports = new Koa()
convert = require('koa-convert')

sc = require 'koa-static-cache'

app.use convert sc( require("path").join(__dirname + '/public'), maxAge: 1*24*60*60 )

app.use async (ctx, next)->
  console.log "kiteru"
  next()

###
# Logger
app.use require('koa-logger')()

# route
route = require('koa-route')
render = require('co-views')(require("path").join(__dirname + '/views'), default: "pug")
require("./controllers/routes") app, route, render

# Compress
app.use require('koa-compress')()

# js/css
app.use require('koa-stylus')(require("path").join(__dirname, 'public'))
app.use require('koa-coffee-script')(require("path").join(__dirname, 'public'))

# Serve static files
app.use require('koa-static')(require('path').join(__dirname, 'public'), maxAge: 1*24*60*60)
###

if !module.parent
  app.listen 3000
  console.log 'listening on port 3000'
