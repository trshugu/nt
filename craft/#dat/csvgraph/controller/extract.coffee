module.exports = (cb) ->
  
  rs = require("fs").ReadStream(__dirname + './../memo.txt')
  rl = require("readline").createInterface({
    input: rs,
    output: {}
  })
  
  reg = /^\d{4,4}\/\d{2,2}\/\d{2,2}\s\d{1,2}:\d{2,2}$/
  reg24 = /^\d{4,4}\/\d{2,2}\/\d{2,2}\s(\d{1,2}):\d{2,2}$/
  
  daily = {}
  
  [0..23].forEach (i)->
    daily[i] = 0
  
  rl.on 'line', (line)->
    ++daily[reg24.exec(line.trim())[1]] if reg.test(line.trim())
  
  rs.on 'close', -> cb(daily)
  

