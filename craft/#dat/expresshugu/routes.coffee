module.exports = (app, controller) ->
  app.get '/'    , controller.index.index
  app.get '/hoge', controller.other.hoge
  app.get '/fuga', controller.other.fuga
  app.get '/piyo', controller.other.piyo
