# ログイン処理は一度しか通さないから通常のログインチェックのような機構は不要かと
twittercheck = require "./callback"

module.exports = (app)->
  app.get "/", require "./index"
  app.get "/user", twittercheck, require("./user")
  app.get "/auth/twitter", require "./twitter"
  # app.get "/auth/twitter/callback", require "./callback"

