Koa = require('koa')
app = new Koa()

###
app.use (ctx, next)->
  console.log "kiteru"
  next()

app.use (ctx, next) ->
  start = Date.now()
  await next()
  ms = Date.now() - start
  console.log ctx.method, ctx.url, ms

app.use (ctx)->
  ctx.body = "hell"
###

# Logger
app.use require("koa-logger")()

# views
app.use require("koa-views")(__dirname + "/views", extension:"pug")

# route
require("./controllers/routes") app

# route = require('koa-route')

# app.use route.get "/:msg", (ctx, msg)->
#   ctx.body = "msg:" + msg

# app.get "/user", require "./user"




###
# router ˆê’UƒVƒ“ƒvƒ‹‚È•û‚Å
router = require('koa-router')()

# require("./controllers/routes") app, route, render
router.get "/:msg", (ctx, next)->
  ctx.body = "msg:" + ctx.params["msg"]

app.use router.routes()
# app.use router.allowedMethods()
# app.get "/user", require "./user"
###


###
render = require('co-views')(require("path").join(__dirname + '/views'), map: html: 'jade')
require("./controllers/routes") app, route, render

# Serve static files
app.use require('koa-static')(require('path').join(__dirname, 'public'))
###

# Compress
app.use require('koa-compress')()

if !module.parent
  port = process.env.PORT || 3000
  server = app.listen port, ->
    console.log 'listening on port', server.address().port
