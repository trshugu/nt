Koa = require('koa')
app = new Koa()

app.use (ctx, next)->
  console.log "kiteru"
  next()

app.use (ctx)->
  ctx.body = "hell"

app.listen 3000

