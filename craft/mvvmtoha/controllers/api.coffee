module.exports = (ctx)->
  ctx.type = "application/json"
  ctx.body = [
    artist_id:"a" , name:"な"
  ,
    artist_id:"b" , name:"ま"
  ,
    artist_id:"c" , name:"え"
  ]

