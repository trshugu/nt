window.onload = ->
  console.log "coffee"
  vm=new Vue
    el:"#vue"
    data:
      sele: "vuw"
      sss: "vvvv"
      ooo: [
        {text:"ttt",value:"vvvv"}
        {text:"222",value:"nini"}
      ]
    watch:
      sele:(n,o)->
        console.log "selewath"
        console.log o
        console.log n
      sss:(n,o)->
        console.log "swath"
        console.log o
        console.log n
      ooo:(n,o)->
        console.log "owath"
        console.log o
        console.log n
    created:-> console.log "creatio!!" + this.sele
    beforeCompile:-> console.log "B.C." + this.sele
    compiled:->
      console.log "konekone" + this.sele
      this.ooo = "nini"
    ready:-> console.log "let it" + this.sele
    attached:-> console.log "attache!" + this.sele
    detached:-> console.log "detachee!!!!!!!!!" + this.sele
  console.log vm.sss
