fun = (callback) ->
  fs = require('fs')
  readline = require('readline')
  
  rs = fs.ReadStream(__dirname + '/memo.txt')
  
  rl = readline.createInterface({
    input: rs,
    output: {}
  })
  
  reg = /^\d{4,4}\/\d{2,2}\/\d{2,2}\s\d{1,2}:\d{2,2}$/
  reg24 = /^\d{4,4}\/\d{2,2}\/\d{2,2}\s(\d{1,2}):\d{2,2}$/
  
  dairy = {}
  for i in [0..23]
    dairy[i] = 0
  
  rl.on('line', (line)->
    ++dairy[reg24.exec(line.trim())[1]] if reg.test(line.trim())
  )
  
  rs.on('close', ->
    res = []
    for i in [0..23]
      res.push("{x:" + i + ", y:" + dairy[i] + "}")
    
    callback( "[" + res.join() + "]")
  )
  
  rl.resume()
  

module.exports = fun
