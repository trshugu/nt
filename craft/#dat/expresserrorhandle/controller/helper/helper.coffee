module.exports.ichi = ->
  console.log "im ichi"

module.exports.ni = ->
  this.ichi()
  console.log "im ni"

