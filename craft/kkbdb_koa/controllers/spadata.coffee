module.exports = (render)-> ->
  dp = {}
  dp.data = "spaspa"
  @body = yield thank(dp)

# �T�[�o�[���̎��Ԑ���
thank = (dp)-> new Promise (f)->
  setTimeout ->
    f dp
  , 5000

