logger = require('winston')
fs = require('fs')

check_uri = require("./checklinkmodule")
async = require('async')

# logger�쐬
logger.add(logger.transports.File, { filename: './log.txt', json: false })

# URL���X�g��ǂݍ���
if !process.argv[2]
  logger.error('argv nothing')
  throw ""



# ���ʃt�@�C����(�����t�@�C���������݂��Ă�����폜)
# uri�𒊏o�����X�g�Ɋi�[
# �������X�g�Ή�
# ������


# -----------------------------------------------------------------------------
# URI�`�F�b�N
# -----------------------------------------------------------------------------

# �v���I��


















# process.argv[2]

# uri = "http://yahoo.co.jp"
# ret = check_uri(uri)

arr = [
  "http://yahoo.co.jp"
  "http://www.yahoo.co.jp"
  "http://yahoocojp"
  "sdfl;kjsd;lkj"
]

stdt = new Date()
async.map(arr,check_uri,(e,r)->
  console.log "done"
  eddt = new Date()
  # console.log r
  console.log(eddt - stdt)
)




