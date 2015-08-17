# ログイン処理は一度しか通さないから通常のログインチェックのような機構は不要かと
# twittercheck = require "./callback"

module.exports = (app)->
  # ログインフォーム
  app.get "/", require "./index"
  
  # twitterログイン画面
  app.get "/twitter", require "./twitter"
  
  # コールバックのアクション
  app.get "/callback", require "./callback"
  
  # マイページ
  app.get "/home", require("./home")
  
  # ユーザーページ
  app.get "/user", require("./user")
  
  
  
  
  # app.get "/user", twittercheck, require("./user")
  # app.get "/twitter_login", require "./twitter_login"
  
  # ログインボタン押下
  
  # ログイン状態の確認 → メインのログイン状態確認
  # twitterログインの状態確認 <- セッションの確認 アクセストークンの確認
  # アクセストークンの取得 <- コールバックURL
  # アクセストークンの確認 <- セッションの確認 アクセストークンの確認
  # 
  # ログインさせる
  # 




