# One way to deal with asynchronous call
doSomeAsync = ->
  return (callback) ->
    setTimeout ->
      callback(null, 'this was loaded asynchronously and it took 3 seconds to complete')
    , 3000

module.exports = (render, messages)-> ->
  @body = yield doSomeAsync()
