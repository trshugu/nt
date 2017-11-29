module.exports = (io)->
  cnt = 0
  io.sockets.on 'connection', (soc)->
    io.emit "sev", soc.client.conn.server.clientsCount
    
    # soc.on "cli", (client)->
    #   console.log "cli"
    #   console.log soc.client.conn.server.clientsCount
    #   io.emit "sev", soc.client.conn.server.clientsCount
    
    soc.on "disconnect", (d)->
      console.log "dis"
      console.log d
      io.emit "sev", soc.client.conn.server.clientsCount

