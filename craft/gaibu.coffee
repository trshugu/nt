# root = exports ? this

soto = ->
  console.log("gaigai")

class hoge
  @seipro: 0
  
  @srtaFun: ->
    console.log("stasta")
    console.log(@name)
  
  constructor: (hiki)->
    @name = hiki
  
  pubFun: ->
    console.log("pubpub")



# root.hoge = hoge

module.exports = hoge
module.exports.soto = soto

