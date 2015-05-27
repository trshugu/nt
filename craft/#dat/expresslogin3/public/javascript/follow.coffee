console.log "konkan"

# console.log validator.isEmail "asdf@asdf.asfe"
url = "http://localhost/api"
http = new XMLHttpRequest()

console.log request

fun = (nodes)->
  document.getElementsByClassName("do")[0].style.display = "none"
  document.getElementsByClassName("done")[0].style.display = "block"


window.onload = ->
  f = document.getElementsByClassName("follow")[0]
  for i in f.childNodes
    i.style.display = "none"
  
  document.getElementsByClassName("do")[0].style.display = "block"
  
  ###
  console.log "in"
  console.log location
  console.log location.origin
  ###
  
  ###
  vm3 = new Vue
    el:"#follow3"
    data:
      items: [
        { text: 'one', done: true }
        { text: 'two', done: false }
      ]
    methods:
      toggle: (item)->
        item.done = !item.done
  ###
  
  vm3 = new Vue
    el:"#follow2"
    data:
      button: false
    methods:
      toggle:(e)->
        vm3.button = !vm3.button
        console.log "aa"
      on: (e)->
        vm3.button = true
      off: (e)->
        vm3.button = false
  
  vm2 = new Vue
    el:"#follow"
    data:
      button:false
  
  ###
  timeout_id = null
  vm=new Vue
    el:"#vali"
    data:
      vvv:"a"
      taisyo:""
      agree: false
      error:""
      niban:""
      erroniban:""
    watch:
      taisyo:(n,o)->
        clearTimeout to_id
        to_id = setTimeout ->
          vm.error = ""
          changet vm, checkt(vm.taisyo)
          vm.agree = doAllCheck vm
        , 1000, [vm]
        
      niban:(n,o)->
        clearTimeout to_id
        to_id = setTimeout ->
          vm.erroniban = ""
          changen vm, checkn1(vm.niban) if vm.erroniban == ""
          changen vm, checkn2(vm.niban) if vm.erroniban == ""
          vm.agree = doAllCheck vm
        , 1000, [vm]
  ###
