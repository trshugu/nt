module.exports = (req, res)->
  dp = {}
  dp.title = "hell"
  dp.hell = "dead"
  
  Redundant(req, res, dp).then (v)->
    render req, res, dp

Redundant = (req, res, dp)-> new Promise (f)->
  seed = Math.floor(Math.random() * 1000)
  
  console.log "aa",seed
  if seed > 200
    console.log "bb"
    lazy().then (v)->
      dp.title = "lzzzzzzzzz" + v
      # render req, res, dp
      f()
  else
    console.log "cc"
    dp.title = "spoooooo" + seed
    # render req, res, dp
    f()

lazy = -> new Promise (f)->
  seed = Math.floor(Math.random() * 1000)
  console.log "la", seed
  setTimeout ->
    f seed.toString()
  , seed

render = (req, res, dp)->
  res.render 'index', dp



