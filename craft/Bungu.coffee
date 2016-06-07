###
###


# リスコフの置換原則とTDD
module.exports.Bungu = class Bungu
  @live: false
  
  @use: ->
    console.log "naniyara"

module.exports.pen = class pen extends Bungu
  @use: ->
    console.log "this is"

module.exports.gum = class gum extends Bungu
  @live: true
  
  # @use: ->
  #   console.log "gomgom"

