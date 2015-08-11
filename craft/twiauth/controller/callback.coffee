helper = require "./helper"

module.exports = (req, res)->
  if req.session.oauth? && req.session.oauth.request_token? && req.session.oauth.request_token_secret
    oa = helper.getOauth(req.protocol + "://" + req.headers.host + "/callback")
    oa.getOAuthAccessToken req.session.oauth.request_token, req.session.oauth.request_token_secret, req.query.oauth_verifier, (e, accessToken, accessTokenSecret, results)->
      if e?
        console.log "atでエラー"
        console.log e
        res.send e
        # topへ飛ばすのが妥当
      else
        console.log results
        client = helper.getTwitterClient accessToken, accessTokenSecret
        client.get "account/verify_credentials", {}, (e,t,r)->
          if e?
            console.log "verifyでエラー"
            console.log e
            res.send e
          else
            res.send t
            # リダイレクト推奨だが、ここで登録or新規
  else
    res.send "null"
    # topへ
