# ログイン処理は一度しか通さないから通常のログインチェックのような機構は不要かと
# twittercheck = require "./callback"

module.exports = (app)->
  app.get "/", require "./index"
  # app.get "/user", twittercheck, require("./user")
  app.get "/home", require("./home")
  app.get "/user", require("./user")
  app.get "/twitter", require "./twitter"
  # app.get "/twitter_login", require "./twitter_login"
  app.get "/callback", require "./callback"
  
  # ログインボタン押下
  
  # ログイン状態の確認 → メインのログイン状態確認
  # twitterログインの状態確認 <- セッションの確認 アクセストークンの確認
  # アクセストークンの取得 <- コールバックURL
  # アクセストークンの確認 <- セッションの確認 アクセストークンの確認
  # 
  # ログインさせる
  # 




