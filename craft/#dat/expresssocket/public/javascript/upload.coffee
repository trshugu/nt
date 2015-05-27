window.onload = ->
  vm = new Vue
    el:"#form"
    data:
      fileup: ""
    watch:
      fileup:(n,o)->
        console.log n
        console.log o
    methods:
      toggle:(e)->
        vm3.button = !vm3.button
        console.log "aa"
      on: (e)->
        vm3.button = true
      off: (e)->
        vm3.button = false
  
  console.log vm.fileup
