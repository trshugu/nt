module.exports = (req, res)->
  # endを返し終了する
  
  
  w = require('child_process').fork "controller/exec.coffee", ["doidio"]
  
  w.on "message", (msg, h)->
    console.log "msg", msg, h
    
  
  w.on "exit", (c,s)->
    console.log "owari", c, s
  
  
  
  ###
  c = require("cluster")
  
  console.log "pid:", process.pid
  console.log "c", c.isMaster
  
  if c.isMaster
    # expressをもう一個起動した
    w = c.fork()
  else
    console.log "ko", process.pid
    process.exit()
  ###
  
  res.end "batch"
  # process.exit()
  # res.render 'index', title:"exp"
  
  