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
