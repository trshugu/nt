helper = require "./helper/helper"

module.exports = (io)->
  # redis = require('socket.io-redis')
  # io.adapter(redis({ host: 'localhost', port: 6379 }))
  ###
  redis = require('socket.io-redis')
  io.adapter redis(
    host: 'localhost'
    port: 6379
  )
  ###
  # console.log io
  # console.log io.sockets
  
  io.sockets.on 'connection', (soc)->
    soc.emit "sev_sess", "connectioooo " + process.pid
    console.log "conn!! " + process.pid
    # console.log soc
    console.log soc.handshake.query
    
    soc.on "sock", (d)->
      console.log d
      helper.ichi()
    
    soc.on "mod", (d)->
      console.log d
    
    soc.on "foll", (d)->
      console.log d
      soc.emit "foll_res" , "ress" + d
    
    soc.on "socjson", (d)->
      # console.log d
      # console.log d.jso
      # for i in d
      #   console.log i
      
      # io.emit "resjson", "res"
      # io.emit "resjson", {jso:"sotu"}
      io.emit "resjson", ["sotu","ni","san"]
    
    soc.on "cli_sess", (d)->
      console.log "sess " + process.pid
      soc.emit "sev_sess", "retttttt " + process.pid
      io.emit "sev_sess", "IOIOretttttt " + process.pid
      
    
    soc.on "pmessage", (p,c,m)->
      console.log "pmmmmm " + process.pid
      soc.emit "sev_sess", "PMPMretttttt " + process.pid
      
    
    soc.on 'message', (msg) -> 
      console.log "meeeeeeeeeeeeeeeeeeeeeee"
      soc.send socket.handshake.user.name
      soc.broadcast.send msg
    
    soc.on "disconnect", ->
      console.log "disconnnn"
      console.log soc.handshake.query
    
  io.on "pmessage", (p,c,m)->
    console.log "pmmmmmioio " + process.pid
    io.emit "sev_sess", "PMPMrettttttioio"
  ###
  io.on "pmessaage",(d)->
    console.log "pme"
    console.log d
    
  
  io.on "messaage",(d)->
    console.log "me"
    console.log d
  ###
  
  

