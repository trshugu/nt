console.log "konkan"

# console.log validator.isEmail "asdf@asdf.asfe"

window.onload = ->
  timeout_id = null
  vm=new Vue
    el:"#vali"
    data:
      vvv:"a"
      taisyo:""
      agree: false
      error:""
      niban:""
      erroniban:""
    watch:
      taisyo:(n,o)->
        clearTimeout to_id
        to_id = setTimeout ->
          vm.error = ""
          changet vm, checkt(vm.taisyo)
          vm.agree = doAllCheck vm
        , 1000, [vm]
        
      niban:(n,o)->
        clearTimeout to_id
        to_id = setTimeout ->
          vm.erroniban = ""
          changen vm, checkn1(vm.niban) if vm.erroniban == ""
          changen vm, checkn2(vm.niban) if vm.erroniban == ""
          vm.agree = doAllCheck vm
        , 1000, [vm]
  
  # Post時のみ全体バリデーション
  doValidation vm if isPost? && isPost == "true"
  
  ###
  if isPost? && isPost == "true"
    console.log typeof isPost
    console.log isPost
    console.log "Post!"
  else
    console.log typeof isPost
    console.log isPost
    console.log "not post"
  ###

# "全体の"VMを変更する役割→単品でチェックできないといけない
doValidation = (vm) ->
  vm.error = ""
  changet vm, checkt(vm.taisyo) if vm.error == ""
  
  vm.erroniban = ""
  changen vm, checkn1(vm.niban) if vm.erroniban == ""
  changen vm, checkn2(vm.niban) if vm.erroniban == ""

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


###
# taisyoチェック(単体で変更)
ct = (vm)->
  if vexe vm.taisyo
    vm.error = ""
  else
    vm.error = "入力or 4文字まで"

# nibanチェック(単体で変更)
nt = (vm)->
  if vexe2 vm.niban
    vm.erroniban = ""
  else
    vm.erroniban = "2文字までです"
    return
  
  if v_require vm.niban
    vm.erroniban = ""
  else
    vm.erroniban = "入力してください"
    return

# 単体のバリデーション
vexe = (n)-> validator.isLength n, 1, 4
vexe2 = (n)-> validator.isLength n, 0, 2
v_require = (n)-> validator.isLength n, 1
###


