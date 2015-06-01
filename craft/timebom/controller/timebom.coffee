module.exports = (req, res)->
  # 今の時間
  now = new Date()
  console.log now
  
  # 目的の時間
  targetTime = new Date(Date.parse("2015/06/01 16:00:00"))
  console.log targetTime
  
  # 時間判定
  if now > targetTime
    console.log "目的の時間を過ぎている"
    res.render "bom1"
  else
    console.log "目的の時間がきていない"
    res.render "bom2"
  


