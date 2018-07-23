module.exports = (ctx)->
  dp = {}
  dp.list = JSON.stringify [
    artist_id:"a" , name:"な"
  ,
    artist_id:"b" , name:"ま"
  ,
    artist_id:"c" , name:"え"
  ]
  
  ctx.render "index", dp
