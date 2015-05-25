@s = io.connect location.origin
console.log "konkan"

window.onload = ->
  vm = new Vue
    el: "#sid"
    data:
      b_sid: "aaa"
      c_button: false
    methods:
      res:(v)->
        console.log "res"
        console.log v
        this.b_sid = v
        this.c_button = true
    watch:
      b_sid:(n,o)->
        # console.log o
        # console.log n
  
  # console.log vm.b_sid
  # vm.b_sid = "channgee"
  # console.log vm.b_sid
  
  console.log a_sid
  
  s.on "foll_res", (d)->
    console.log "modori"
    console.log d
    vm.res d
  
  s.emit "foll", a_sid
  
  
