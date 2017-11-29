i=require('iconv').Iconv
c=new i("SHIFT_JIS","utf-8")

module.exports = (render, messages)-> ->
  dp = {}
  
  a = require("child_process").execSync("fsutil volume diskfree c:")
  b = c.convert a
  d = b.toString()
  arr = d.split("\r\n")
  all = parseInt arr[1].split(": ")[1]
  free = parseInt arr[2].split(": ")[1]
  
  dp.all = all
  dp.free = free
  dp.use = 100-Math.floor((free / all) * 100) + "%"
  
  @body = yield dp

