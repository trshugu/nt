# ���O�C�������͈�x�����ʂ��Ȃ�����ʏ�̃��O�C���`�F�b�N�̂悤�ȋ@�\�͕s�v����
# twittercheck = require "./callback"

module.exports = (app)->
  app.get "/", require "./index"
  # app.get "/user", twittercheck, require("./user")
  app.get "/home", require("./home")
  app.get "/user", require("./user")
  app.get "/twitter", require "./twitter"
  # app.get "/twitter_login", require "./twitter_login"
  app.get "/callback", require "./callback"
  
  # ���O�C���{�^������
  
  # ���O�C����Ԃ̊m�F �� ���C���̃��O�C����Ԋm�F
  # twitter���O�C���̏�Ԋm�F <- �Z�b�V�����̊m�F �A�N�Z�X�g�[�N���̊m�F
  # �A�N�Z�X�g�[�N���̎擾 <- �R�[���o�b�NURL
  # �A�N�Z�X�g�[�N���̊m�F <- �Z�b�V�����̊m�F �A�N�Z�X�g�[�N���̊m�F
  # 
  # ���O�C��������
  # 




