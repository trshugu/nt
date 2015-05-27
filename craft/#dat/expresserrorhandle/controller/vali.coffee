validator = require "validator"
module.exports = (req, res)->
  console.log req.query
  console.log req.body
  console.log req.session
  console.log req.params
  
  param = {}
  param.test = "tetete"
  param.taisyo = ""
  param.niban = ""
  
  if req.method == "POST"
    param.postback = true
    param.taisyo = if req.body.taisyo? then req.body.taisyo else ""
    param.niban = if req.body.niban? then req.body.niban else ""
    
    # バリデーションしてNGだったらもどす
    if doAllCheck param
      console.log "vali OK"
      param.postback = false
      param.ok = "ok"
      
      # サニタイズもここらへんで
      res.send param
    else
      console.log "vali NG"
      res.render 'vali', param
  else
    res.render 'vali', param

# ==============================================================================
# バリデーション
# ==============================================================================

# 単体のバリデーション
checkt = (n)-> if validator.isLength n, 1, 4 then "" else "入力or 4文字まで"
changet = (vm, emes)-> vm.error = emes

checkn1 = (n)-> if validator.isLength n, 0, 2 then "" else "2文字までです"
checkn2 = (n)-> if validator.isLength n, 1 then "" else "入力してください"
changen = (vm, emes)-> vm.erroniban = emes

# 全体をチェックする
doAllCheck = (param)->
  return false if checkt(param.taisyo) != ""
  return false if checkn1(param.niban) != ""
  return false if checkn2(param.niban) != ""
  
  return true


