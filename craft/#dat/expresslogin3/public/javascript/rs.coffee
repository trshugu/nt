@s = io.connect location.origin + ":3000"
console.log location.origin
console.log "konkan"

window.onload = ->
  vm = new Vue
    el:"#sock"
    data:
      m:"asdf"
      m_wri:""
    methods:
      socke:(e)->
        console.log "kiteru"
        s.emit 'sock', "doidoi"
        s.emit 'mod', "modmod"
        s.emit "cli_sess", "sessss"
  
  s.on "sev_sess", (v)->
    console.log "sevREs"
    console.log v
    
  
