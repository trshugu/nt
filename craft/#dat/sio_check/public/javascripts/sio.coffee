siourl = location.protocol + "//" +  location.hostname + ':3001'

# @s = io.connect siourl
# @s = io.connect siourl, { transports: [ 'websocket' ] }
# @s = io.connect siourl, { transports: [ 'flashsocket' ] } # NG
# @s = io.connect siourl, { transports: [ 'htmlfile' ] } # NG
# @s = io.connect siourl, { transports: [ 'xhr-polling' ] } # NG
# @s = io.connect siourl, { transports: [ 'jsonp-polling' ] } # NG
# @s = io.connect siourl, { transports: [ 'polling' ] }
@s = io.connect siourl, { transports: [ 'websocket', 'polling' ] }
# @s = io.connect siourl, { transports: [ 'polling', 'websocket' ] }
# @s = io.connect siourl, { transports: [ 'xhr-polling', 'polling', 'websocket' ] }

console.log siourl

window.onload = ->
  vm=new Vue
    el:"#vue"
    data:
      conn:""
  
  @s.on "sev", (str)->
    console.log str
    vm.conn = str
  
# @s.emit "cli", "dynamo"
