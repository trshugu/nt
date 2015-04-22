module.exports = (req, res)-> 
  console.log req.query
  console.log req.body
  console.log req.params
  
  
  param = {}
  param.title = "exp"
  param.val = if req.body.valiin? then req.body.valiin else ""
  param.kakure = req.body.hid if req.body.hid?
  param.error = ichi(req.body.valiin) if req.body.valiin?
  
  param.arr = {}
  param.arr.a = asdf:"djdjd"
  param.arr.b = "mon"
  
  res.render 'index', param

ichi=(val)->
  console.log val
  if val? && val.length == 1
    true
  else
    false


# 一秒後にチェックする
checkValidation = (v)->
  console.log ichi(v)

