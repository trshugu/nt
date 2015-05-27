console.log "1"
window.onload = ->
  console.log "2"
  vm=new Vue
    el:"#ddl"
    data:
      dropdown:""
    watch:
      "dropdown":(n,o)->
        console.log n
        console.log o
  
  ###
  sel = document.getElementById "jav"
  sel.onchange = ->
    i = this.options[this.selectedIndex]
    console.log i.value
  ###

###
oc = (a)->
  document.getElementsByClassName("a")[0].style.display = "none"
  document.getElementsByClassName("i")[0].style.display = "none"
  document.getElementsByClassName("u")[0].style.display = "none"
  document.getElementsByClassName(a.options[a.options.selectedIndex].value)[0].style.display = "block"
###
