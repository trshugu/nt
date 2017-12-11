module.exports = (ctx, msg)->
  # ctx.body = "msg:" + msg
  dp = {}
  dp.msg = msg
  ctx.render "index", dp
