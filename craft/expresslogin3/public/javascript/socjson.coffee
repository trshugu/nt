@s = io.connect location.origin

window.onload = ->
  vm = new Vue
    el:"#vue"
    data:
      aaa:"asdf"
      laaa:[1,4,4,6]
      jso:{noi:0,ni:2}
      arrjso:[
        {noi:1, ni:3}
        {noi:2, ni:5}
        {noi:3, ni:7}
      ]
  
  s.on "resjson", (d)->
    console.log d
    # console.log d.jso
    for i in d
      console.log i
  
  # s.emit "socjson", "sotu"
  # s.emit "socjson", {jso:"sotu"}
  s.emit "socjson", ["sotu","ni","san"]
  
