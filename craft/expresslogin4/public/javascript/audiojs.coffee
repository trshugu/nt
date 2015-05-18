@s = io.connect location.origin


window.onload = ->
  console.log "wo2"
  audiojs.events.ready ->
    # as = audiojs.createAll()
    as = audiojs.create(document.getElementById("ichi"))
  
