module.exports = (render)-> (id)->
  # random next strage
  console.log "id", id
  seed = Math.floor(Math.random() * 1000)
  
  dp = {}
  dp.data = "randomStrage"
  dp.seed = seed
  dp.next = "true" if seed > 200
  
  @body = yield thank(dp)

# サーバー側の時間制御
thank = (dp)-> new Promise (f)->
  setTimeout ->
    f dp
  , 1000


