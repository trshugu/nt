# ���O�C�������͈�x�����ʂ��Ȃ�����ʏ�̃��O�C���`�F�b�N�̂悤�ȋ@�\�͕s�v����
twittercheck = require "./callback"

module.exports = (app)->
  app.get "/", require "./index"
  app.get "/user", twittercheck, require("./user")
  app.get "/auth/twitter", require "./twitter"
  # app.get "/auth/twitter/callback", require "./callback"

