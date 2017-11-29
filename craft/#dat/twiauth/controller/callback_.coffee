helper = require "./helper"

module.exports = (req, res)->
  console.log "==callback=="
  console.log req.query
  console.log req.body
  console.log req.session
  console.log req.params
  
  # コールバックURL保持
  location = req.protocol + "://" + req.headers.host + req.path
  redirect_url = "/twitter"
  redirect_url = redirect_url + "?location=" + encodeURIComponent(location) if location != ""
  oa = helper.getOauth("")
  
  console.log req.session
  
  # ここではリクエストトークンの有無と正当性のみを確認する
  if req.session.oauth
    if req.session.oauth.access_token
      # ログインしてたらnext→ログインではなくアクセストークンが存在しているというだけ
      # next()
      res.send "logined"
      # ここでも認証の正当性のチェックができるが、リクエストトークン時にoauthを初期化しているのでここには入らない模様
      
    else
      # 許可確認
      req.session.oauth.verifier = req.query.oauth_verifier
      oauth = req.session.oauth
      
      oa.getOAuthAccessToken oauth.request_token, oauth.request_token_secret, oauth.verifier, (error, accessToken, accessTokenSecret, results)->
        if error
          console.log error
          # res.send "yeah something broke."
          # キャンセルなどでtokenが無効の場合は再度認証画面に飛ばす
          res.redirect redirect_url
        else
          # アクセストークンが取得できたらnext
          req.session.oauth.access_token = accessToken
          req.session.oauth.access_token_secret = accessTokenSecret
          console.log 'access token: ' + accessToken
          console.log 'access token secret: ' + accessTokenSecret
          # screen_name
          console.log results
          # res.send "worked. nice one."
          # next()
          # res.send "get access token"
          
          # ここでやっと認証の正当性のチェック
          client = helper.getTwitterClient req.session.oauth.access_token, req.session.oauth.access_token_secret
          client.get "account/verify_credentials", {}, (e,t,r)->
            if e?
              console.log e
            else
              console.log typeof t
              console.log typeof r.body
              res.send t
              # リダイレクト推奨だが、ここで登録or新規
      
  else
    res.redirect redirect_url
    # next new Error("you're not supposed to be here.")

  # res.render 'twitter', { title:"twitter" }

