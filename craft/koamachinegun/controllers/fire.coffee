module.exports = (render)-> (url, cnt)->
  # console.log url
  get = -> new Promise (f, r)->
    console.log "re1"
    require("request") url, (e, res)->
      if e?
        console.log "e", e
        r e
      else
        f res
  
  arr = []
  [0...1000].forEach ->
    arr.push get().then (v)-> console.log v.statusCode

  Promise.all arr
  .then (v)->
    console.log v.length
    console.timeEnd "tmp"
    yield [@body = v.length.toString()]
  .catch (e)->
    console.log e
    yield [@body = "death"]
