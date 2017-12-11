i=require('iconv').Iconv
c=new i("SHIFT_JIS","utf-8")

module.exports = (render, messages)-> ->
  dp = {}
  
  @body = yield render 'dataset', dp

