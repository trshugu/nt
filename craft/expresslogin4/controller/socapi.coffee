helper = require "./helper/helper"

module.exports = (io)->
  io.sockets.on 'connection', (soc)->
    soc.on "sock", (d)->
      console.log d
      helper.ichi()
    
    soc.on "mod", (d)->
      console.log d
    
    soc.on "foll", (d)->
      console.log d
      io.emit "foll_res" , "ress" + d
    
    soc.on "socjson", (d)->
      # console.log d
      # console.log d.jso
      # for i in d
      #   console.log i
      
      # io.emit "resjson", "res"
      # io.emit "resjson", {jso:"sotu"}
      io.emit "resjson", ["sotu","ni","san"]

