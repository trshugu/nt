@s = io.connect location.origin

$(document).ready ->
  console.log "zep1"
  $('#jquery_jplayer_1').jPlayer
    ready: ->
      $(this).jPlayer 'setMedia',
        title: 'juke'
        m4a: "http://www.jplayer.org/audio/m4a/Miaow-07-Bubble.m4a"
        oga: "http://www.jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
    cssSelectorAncestor: '#jp_container_1'
    swfPath: '/jplayer/dist/jplayer/'
    supplied: "m4a, oga"
    useStateClassSkin: true
    autoBlur: false
    smoothPlayBar: true
    keyEnabled: true
    remainingDuration: true
    toggleDuration: true
  
  

window.onload = ->
  console.log "wo2"

