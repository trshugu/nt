logger = require('winston')
fs = require('fs')
check_uri = require("./checklinkmodule")
async = require('async')

# logger作成
logger.add(logger.transports.File, { filename: './log.txt', json: false })

# URLリストを読み込む
file = process.argv[2]
if !file
  logger.error('argv nothing')
  process.exit(1)

unless fs.existsSync(file)
  logger.error('file nothing')
  process.exit(1)


# 結果ファイル名(同じファイル名が存在していたら削除)
resultfile = "zzresult_" + file
fs.unlinkSync(resultfile) if fs.existsSync(resultfile)

# uriを抽出しリストに格納
urilist = []
list = fs.readFileSync( file, 'utf8')
lines = list.trim().split('\n')
for line in lines
  if line.match(/^http/)
    urilist.push(line.trim())

# 無視リスト対応
ignorefile = "ignore.txt"
if fs.existsSync(ignorefile)
  ilist = fs.readFileSync(ignorefile, 'utf8')
  ilines = ilist.trim().split('\n')
  for s in ilines
    urilist = urilist.filter(((i)->i != this.ignore),{ignore: s})

# 総件数
logger.info(urilist.length + '件\n')
fs.writeFileSync(resultfile, urilist.length + '件\n')

# -----------------------------------------------------------------------------
# URIチェック
# -----------------------------------------------------------------------------
stdt = new Date()
async.map(urilist,check_uri,(e,r)->
  # 計測終了
  eddt = new Date()
  time = eddt - stdt
  logger.info('done ' + time)
)


