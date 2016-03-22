module.exports = (app)->
  app.use route.get '/route', (next)->
    # bodyに対してindex.jadeの変更を実施。
    this.body = yield render('index.jade', {name: "koa"})
  
  # app.get "/route", require "./index"
  # app.get "/user", require "./user"


