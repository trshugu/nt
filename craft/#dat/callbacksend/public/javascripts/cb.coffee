@s = io.connect(location.origin)

$ ->
  
  param = {}
  param.nakami = "iikanji"
  
  s.emit "sev_cb",
    nakami: "iikan"
    , (res)->
      console.log "func"
      console.log res
  
  ###
  s.emit "sev_cb", param, (res)->
    console.log "func"
    console.log res
  ###
  
  
  
  ###
  s.on "cli_one", (d)->
    console.log "from sev"
    console.log d
  
  s.emit "sev_one", "from cli"
  ###

