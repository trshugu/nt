app = require('koa')()

# jadeをテンプレートエンジンとして設定。
render = require('co-views') __dirname + '/views', map: html: 'jade'

route = require 'koa-route'
# GET /views => render template engine
app.use route.get '/', (next)->
  # bodyに対してindex.jadeの変更を実施。
  @body = yield render 'index.jade', name: "koa"

# routes
require("./controller/routes") app, route, render

# static file serve
app.use require('koa-static') __dirname + '/public'

app.listen 3000, ->
  console.log "listen"
