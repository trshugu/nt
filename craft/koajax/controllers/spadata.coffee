module.exports = (render)-> ->
  dp = {}
  dp.data = "spaspa"
  @body = yield thank(dp)

# サーバー側の時間制御
thank = (dp)-> new Promise (f)->
  setTimeout ->
    f dp
  , 5000

