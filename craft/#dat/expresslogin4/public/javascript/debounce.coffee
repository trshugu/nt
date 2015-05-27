$ ->
  console.log "coffee"
  vm=new Vue
    el:"#vue"
    data:
      debu: "asdf"
      debu2: "asdf2"
    watch:
      debu:(n,o)->
        console.log o
        console.log n
      debu2:(n,o)->
        console.log o
        console.log n
