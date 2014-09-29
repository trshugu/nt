logger = require('winston')
fs = require('fs')

check_uri = require("./checklinkmodule")
async = require('async')

# logger作成
logger.add(logger.transports.File, { filename: './log.txt', json: false })

# URLリストを読み込む
if !process.argv[2]
  logger.error('argv nothing')
  throw ""



# 結果ファイル名(同じファイル名が存在していたら削除)
# uriを抽出しリストに格納
# 無視リスト対応
# 総件数


# -----------------------------------------------------------------------------
# URIチェック
# -----------------------------------------------------------------------------

# 計測終了


















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




