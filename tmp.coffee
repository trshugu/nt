###
###


###
# 拡張子取得
file = "asdf.abc"
ext = file.match(/[.].*/)[0].slice 1
console.log ext
###


###
# 自分にメソッドを取り込む
require("./vali")()
# console.log vali

aaa = ->
  pri "eee"


aaa()
###



###
# api2
getApi = (url,cb)->
  require("http").get(url).on 'response', cb

# コールバック関数を返却させることでクロージャに
cb_res = ->
  return (res)->
    res.setEncoding("utf8")
    res.on 'data', cb_print


getApi "http://localhost/api", cb_res()

cb_print = (c)->
  # 続きの処理
  console.log c
###

###
# api
http = require "http"

http.get("http://localhost/api")
.on 'response',(res)->
  res.setEncoding("utf8")
  res.on 'data', (c)->
    console.log c
###




###
# Default date added at the end of the file
rotatingLogStreamA = require('file-stream-rotator').getStream({filename:"test.log", frequency:"daily", verbose: false});

# Default date added using file pattern
# rotatingLogStreamB = require('file-stream-rotator').getStream({filename:"tmp/test-%DATE%.log", frequency:"daily", verbose: false});

# Custom date added using file pattern using moment.js formats
# rotatingLogStreamC = require('file-stream-rotator').getStream({filename:"tmp/test-%DATE%.log", frequency:"daily", verbose: false, date_format: "YYYY-MM-DD"});
###

###
# 等尺
gm = require "gm"
a = gm("./height.png")
# a.resize(null, 240)
a.resize(240)
a.write "./out240w.png",(e)->
  if e?
    console.log e
  else
    console.log "success"
###

###
# サニタイズ
v = require "validator"
console.log v.escape "<asdf> #$%&'()=|{}"
###

###
# validator.js
v = require "validator"

console.log v.isEmail "for@asdfs.asdfsd"
console.log v.isEmail "forsafsdf"
console.log v.isEmail ""
console.log v.isEmail "asdfs@asdf."
console.log v.isEmail "asdfs@asdf"
console.log v.isEmail "asdfs@asdf.safsdf.sdfdf"

console.log v.isAlphanumeric "sdafjsdfoi"
console.log v.isAlphanumeric "sdafjsdfoss8090sfi3i"
console.log v.isAlphanumeric "3409834"
console.log v.isAlphanumeric "あいう"
console.log v.contains "100", "100"
console.log v.contains "101", "100"
console.log v.isLength "asdffsd"
console.log v.isLength "100", 1
console.log v.isLength "100", 3
console.log v.isLength "100", 5
console.log v.isLength "100", 1, 5
console.log v.isLength "100", 1, 2
console.log v.isLength "abcdefghij", 0, 2
console.log v.isLength "", 0
console.log v.isLength "", 1
console.log v.isLength "1", 0
console.log v.isLength "1", 1
console.log v.isLength "", 0, 1
console.log v.isLength "", 1, 1
console.log v.isLength "1", 0, 1
console.log v.isLength "1", 1, 1
console.log v.isFullWidth "あ"
console.log v.isFullWidth "a"
console.log v.isHalfWidth "あ"
console.log v.isHalfWidth "a"
console.log v.isVariableWidth "あいう"
console.log v.isVariableWidth "aiu"
console.log v.isVariableWidth "あiう"
###




###
# morgan
fs = require "fs"
m = require "morgan"

accessLogStream = fs.createWriteStream(__dirname + '/access.log', {flags: 'a'})

# logger = m "dev"
# logger = m "combined"
# logger = m "common"
# logger = m "short"
logger = m "tiny", stream: accessLogStream


require('http').createServer (q,s)->
  logger q, s, (e)->
    s.setHeader 'content-type', 'text/plain'
    s.end 'hell, world'
.listen 3000
###



###
# loggerモジュール
levels = [
  'info',
  'debug',
  'warn',
  'error'
]

levels.forEach (lv)->
  module.exports[lv] = (msg)->
    console.log lv + ":" +msg

this.info "death"
this.debug "hell"
###



###
# 画像の大きさ取得
ch = require("gm")("./logo.png")
ch.size (e,s)->
  if e?
    console.log e
  else
    console.log s
###

###
# バリデーションチェック
a = false
b = false
c = true

if a \
    || b \
    || c
  console.log "tari"
else
  console.log "tnasi"
###


###
redis = require "redis"

client = redis.createClient()

client.set "testewse", "soidoi"
client.get "testewse", (e,d)->
  console.log d
  client.end()
###




###
# 画像サイズ変更
resizer = (name, size, imageMagick) ->
  re = require("gm")("./in/" + name)
  re.options {imageMagick: true} if imageMagick
  re.resize size, size
  im = if imageMagick then "_im" else "_gm"
  outpath = "./out/" + size.toString() + im + "_" + name
  re.write outpath, (e)->
    if e?
      console.log e
    else
      console.log "success" + outpath
      endD = new Date
      console.log endD - startD

startD = new Date

# ディレクトリ内のファイル名を取得する
require('fs').readdir './in', (err, files) ->
  # console.log files
  for i in files
    resizer i, 200, false
###



###
# 画像サイズ変更
resizer = (name, size, imageMagick) ->
  re = require("gm")("./in/" + name)
  re.options {imageMagick: true} if imageMagick
  re.resize size, size
  im = if imageMagick then "_im" else "_gm"
  outpath = "./out/" + size.toString() + im + "_" + name
  re.write outpath, (e)->
    if e?
      console.log e
    else
      console.log "success" + outpath
      endD = new Date
      console.log endD - startD

startD = new Date

for i in [0...1000]
  resizer "logo.png", 240, true
  resizer "logo.png", 24, true
  resizer "logo.png", 120, true

for i in [0...1000]
  resizer "logo.png", 240, false
  resizer "logo.png", 24, false
  resizer "logo.png", 120, false
###


###
# 画像サイズ変更
resizer = (name, size, imageMagick) ->
  re = require("gm")("./in/" + name)
  re.options {imageMagick: true} if imageMagick
  re.resize size, size
  im = if imageMagick then "_im" else "_gm"
  outpath = "./out/" + size.toString() + im + "_" + name
  re.write outpath, (e)->
    if e?
      console.log e
    else
      console.log "success"

resizer "logo.png", 240, true
resizer "logo.png", 24, true
resizer "logo.png", 120, true

resizer "logo.png", 240, false
resizer "logo.png", 24, false
resizer "logo.png", 120, false
###



###
gm = require "gm"
a = gm("./logo.png")
a.resize(240, 240)
a.write "./out240.png",(e)->
  if e?
    console.log e
  else
    console.log "success"

b = gm("./logo.png")
b.resize(24, 24)
b.write("./out24.png",(e)->console.log e)
console.log b

c = gm("./logo.png")
c.resize(120, 120)
c.write("./out120.png",(e)->console.log e)
console.log c
###


###
# デコエン2
crypto = require 'crypto'

hash = crypto.createHash 'md5'
hash.update 'randomToken'
ive = hash.digest()

cipher = crypto.createCipheriv 'aes-256-cbc', "b52c96bea30646abf8170f333bbd42b9", ive
text = '共通鍵暗号方式'
crypted = cipher.update text, 'utf-8', 'hex'
crypted += cipher.final 'hex'
console.log crypted

decipher = crypto.createDecipheriv 'aes-256-cbc', "b52c96bea30646abf8170f333bbd42b9", ive
# decipher.update crypted, 'hex', 'utf-8'
decode = decipher.update crypted, 'hex', 'utf-8'
decode += decipher.final "utf-8"
console.log decode
###


###
# デコエン
crypto = require 'crypto'
cipher = crypto.createCipher 'aes-256-cbc', 'password'
text = '共通鍵暗号方式'
crypted = cipher.update text, 'utf-8', 'hex'
crypted += cipher.final 'hex'
console.log crypted

decipher = crypto.createDecipher 'aes-256-cbc', 'password'
# decipher.update crypted, 'hex', 'utf-8'
decode = decipher.update crypted, 'hex', 'utf-8'
decode += decipher.final "utf-8"
console.log decode
###



###
crypto = require 'crypto'
decipher = crypto.createDecipher "aes-256-cbc", "pass"
decode = decipher.update "59e768fc4bd8d7da30fc92306f1eaedf", "hex","utf-8"
decode += decipher.final "utf-8"
console.log decode
###


###
# n秒経過を判定
str_data = "1429766042952"
# console.log str_data - new Date().getTime()
# console.log parseInt str_data
console.log new Date().getTime() - parseInt(str_data)

m = 3
if (new Date().getTime() - parseInt(str_data)) > m *  60 * 1000
  console.log m + "分以上経過"
else
  console.log m + "分経過してない"

h = 1
if (new Date().getTime() - parseInt(str_data)) > h * 60 *  60 * 1000
  console.log h + "時間経過"
else
  console.log h + "時間経過してない"

d = 1
if (new Date().getTime() - parseInt(str_data)) > d * 24 * 60 *  60 * 1000
  console.log d + "日経過"
else
  console.log d + "日経過してない"
###




###
# 通過したらvalue NGならfalseを返すメソッドのチェーン
ichi = (val)->
  if val.length == 1
    val
  else
    false


ni = (val)->
  if val.match("a")
    val
  else
    false

console.log ichi "a"
console.log ichi "n"
console.log ichi "an"
console.log ichi "bn"

console.log ni "a"
console.log ni "n"
console.log ni "an"
console.log ni "bn"

console.log ichi ni "a"
console.log ichi ni "n"
console.log ichi ni "an"
console.log ichi ni "bn"
###

###
# ホワイトリストマッチング
censor_text = "abcd"
list =[
  "ab"
  "ff"
  "fe"
]

for i in list
  console.log i
  if censor_text.match new RegExp(i)
    console.log censor_text + "is matthi"
    break

console.log "end"
###



###
rege = new RegExp "ab"
i = rege

console.log censor_text + "is matthi" if censor_text.match(i)
###


###
# 三項演算子
a = if (true) then "ichi" else "ni"
console.log a
###

###
# 非同期例外スロー3 domainの利用 Explicit Binding
domain = require("domain").create()

domain.on "error", (e)->
  console.log "domain errort:"
  console.log e

console.log "start"

require("fs").readFile "noching.txt", "utf-8", domain.bind (e,d)->
  if e
    console.log "eraata"
    console.log e
    throw e
  else
    console.log "normal"
    console.log d

console.log "end"
###

###
# 非同期例外スロー2 domainの利用
domain = require("domain").create()

domain.on "error", (e)->
  console.log "domain errort:"
  console.log e

console.log "start"

domain.run ->
  console.log "domain start"
  
  require("fs").readFile "noching.txt", "utf-8", (e,d)->
    if e
      console.log "eraata"
      console.log e
      throw e
    else
      console.log "normal"
      console.log d
  
  console.log "domain  end"



console.log "end"
###





###
# 非同期例外スロー
console.log "start"

require("fs").readFile "noching.txt", "utf-8", (e,d)->
  try
    console.log "try"
    if e
      console.log "eraata"
      console.log e
      throw e
    else
      console.log "normal"
      console.log d
  catch e
    console.log "catch"
    console.log e
  finally
    console.log "final"

#  # throw "morenmore"
#  th = throw "anoutar"
#  console.log "th teigi"
#  th()
#  a()

# throw "death"

console.log "end"
###



###
# 10個毎スリープ
async = require "async"

hako = ->
  ire = [0...100]
  return -> ire.splice 0,10

tri = hako()
gett = tri()
async.forever (cb)->
  async.series [
    (cb)->
      console.log gett
      setTimeout cb, 1000
    (cb)->
      gett = tri()
      if gett.length > 0
        cb()
      else
        console.log "end"
  ], cb
###

###
# asyncスリープ
async = require "async"

rep = 0
async.forever (cb)->
  async.series [
    (cb)->
      console.log "idhi"
      setTimeout cb, 1000
    (cb)->
      if ++rep < 3
        cb()
      else
        console.log "end"
  ], cb
###

###
tri = hako()
gett = tri()
while gett.length > 0
  console.log gett
  gett = tri()
###

###
# リストから10個毎取り出す
hako = ->
  ire = [0...100]
  return -> ire.splice 0,10

tri = hako()

gett = tri()
while gett.length > 0
  console.log gett
  gett = tri()
###

###
# 10個毎に1秒スリープ 微妙
# for i in [0...100]
console.log "doi"

cb = ->
  console.log "mini"
  setTimeout cb2,1000

cb2 = ->
  console.log "mini2"

setTimeout cb,1000

console.log "ido"
###

###
# ミリ秒 エポック秒
startD = new Date
for i in [0...1000000000]
  i = i + i
endD = new Date
console.log endD - startD

starta = new Date
a = starta.getTime()
for i in [0...1000000000]
  i = i + i
enda = new Date
b = enda.getTime()
console.log b - a

console.log starta
console.log starta.getTime()
console.log new Date().getTime()
###


###
start = new Date
console.log start
console.log new Date - start

console.log start.getTime()
console.log start.getDate()
###

###
# bench2

t1 = ->
  for i in [0...10000]
    console.log i

t2 = ->
  [0...10000].forEach (i) ->
    console.log i

exports.compare =
  test1: t1
  test2: t2

require("bench").runMain()
###

###
# bench
exports.compare =
  test1: ->
    console.log "cooode1"
  test2: ->
    console.log "coooodooo2"

require("bench").runMain()
###

###
# config
config = require "config"
console.log config

console.log process.env.NODE_ENV
###



###
# gzipping4
e = require "express"
a = e()
c = require 'compression'
a.use c()

a.get "/",(q,s)->
  console.log "get"
  s.set "Pragma": "no-cache"
  s.status "200"
  s.contentType "multipart/mixed"
  s.set "Content-Encoding": "gzip"
  s.set "Transfer-Encoding": "chunked"
  s.attachment "dlz.txt"
  
  s.download "/gh/nt/big.txt", "dl.txt"
    
  # st = require("fs").createReadStream "big.txt", {encoding:"utf-8"}
  # st.on "data", (d)->
  #   s.write d
    # buf = new Buffer(d, "utf-8")
    # require("zlib").gzip buf, (err,result)->
    #   console.log err if err
    #   s.write result
  
  # st.on "end", ->
  #   console.log "endddd"
  #   s.end()

a.listen 3000,->
  console.log "on"
###



###
# gzipping3 ng
e = require "express"
a = e()
c = require 'compression'
a.use c()
a.get "/",(q,s)->
  console.log "get"
  s.set "Pragma": "no-cache"
  s.status "200"
  s.contentType "multipart/mixed"
  s.set "Content-Encoding": "gzip"
  s.set "Transfer-Encoding": "chunked"
  s.attachment "dlz.txt"
  
  
  st = require("fs").createReadStream "big.txt", {encoding:"utf-8"}
  st.on "data", (d)->
    s.write d
    # buf = new Buffer(d, "utf-8")
    # require("zlib").gzip buf, (err,result)->
    #   console.log err if err
    #   s.write result
  
  st.on "end", ->
    console.log "endddd"
    s.end()
  
  
  require("fs").readFile "/gh/nt/big.txt", "utf-8", (e,d)->
    console.log 1
    require("zlib").gzip d, (err,result)->
      console.log 2
      console.log err if err
      s.send result
  
  buf = new Buffer(require("fs").readFileSync("/gh/nt/big.txt", "utf-8"), "utf-8")
  console.log 1
  require("zlib").gzip buf, (err,result)->
    console.log 2
    console.log err if err
    s.send result
  
  # s.download "/gh/nt/big.txt", "dl.txt"

a.listen 3000,->
  console.log "on"
###

###
# gzipping2 一日にして成らず
a = require("express")()
a.get "/",(q,s)->
  console.log "get"
  s.set "Pragma": "no-cache"
  s.status "200"
  s.contentType "multipart/mixed"
  s.set "Content-Encoding": "gzip"
  s.attachment "dlz.txt"
  console.log 0
  buf = new Buffer(require("fs").readFileSync("/gh/nt/big.txt", "utf-8"), "utf-8")
  console.log 1
  require("zlib").gzip buf, (err,result)->
    console.log 2
    console.log err if err
    s.send result
  
  # s.download "/gh/nt/big.txt", "dl.txt"

a.listen 3000,->
  console.log "on"
###

###
# gzipping
largetext = [0...(1024 * 1024 * 10)].map((i)->"a").join("")

a = require("express")()
a.get "/",(q,s)->
  console.log "get"
  s.set "Pragma": "no-cache"
  s.status "200"
  s.set "Content-Encoding": "gzip"
  buf = new Buffer(largetext, "utf-8")
  require("zlib").gzip buf, (err,result)->
    s.end result
  
  # s.end largetext
  

a.listen 3000,->
  console.log "on"
###

###
# express response
a = require("express")()
a.get "/",(q,s)->
  console.log "get"
  s.header "nai": "denndenn"
  s.set "saf": "etset"
  s.set "Pragma": "no-cache"
  s.status "200"
  # s.type "png"
  # s.attachment "aa.png"
  # s.cookie "mons", "nakami"
  # s.clearCookie "mons"
  # s.download "/gh/nt/a.png", "dl.png"
  # s.contentType "text/planeeee"
  # s.format
  #   "text/plain": -> s.send "for"
  #   "application/json": -> s.send {"for":2}
  # s.links
  #   next: "http://yahoo.co.jp"
  #   last: "http://google.co.jp"
  # s.status "302"
  # s.location "http://yahoo.co.jp"
  # s.redirect "http://localhost:3000"
  # s.sendStatus 200
  
  # s.jsonp {"sdaf":1}
  # s.json {"sdaf":1}
  # s.send "dead"
  # s.vary "User-Agent"
  # s.set "Content-Encoding": "gzip"
  # buf = new Buffer("aaaa", "utf-8")
  # require("zlib").gzip buf, (err,result)->
  #   s.end result
  
  # s.end("aaaa")
  

a.listen 3000,->
  console.log "on"
###


###
# http2https
app.use (req, res, next) ->
  schema = (req.headers['x-forwarded-proto'] || '').toLowerCase()
  if schema == 'https' || req.secure
    next()
  else
    res.redirect 'https://' + req.headers.host + req.url
###



###
# 並行mapreduce 微妙
stdt = new Date()

cluster = require 'cluster'
http = require('http')
list_length = 0
res_length = 0
res_list = []
# list_count = 100000000
list_count = 100000
splice_num = Math.ceil list_count / require("os").cpus().length

# 返却値取得
fromChild = (msg)->
  # console.log msg.sum
  res_length = msg.length + res_length
  res_list.push msg.sum
  if res_length >=list_length
    console.log res_list.map(M).reduce(R)
    eddt = new Date()
    console.log (eddt - stdt).toString()
    # console.log list_count + "/" + splice_num + ":" + (eddt - stdt).toString()

# リストをレキシカルスコープで作成し呼び出し毎に部分返却する
cl = ->
  # l = [0...list_count]
  # l = []
  # for i in [0...list_count]
  #   l.push Math.floor(Math.random() * 10)
  
  num = 1
  
  return ->
    # console.log l.length
    # l.splice(0,splice_num)
    ret_list = []
    for i in [0...splice_num]
      if list_count >= num 
        ret_list.push num
      num++
    
    ret_list

M = (i)->i 
R = (l,r)->l + r

if cluster.isMaster
  # クロージャリスト作成
  cList = cl()
  li = cList()
  while li.length > 0
    list_length = li.length + list_length
    if li.length != 0
      w = cluster.fork()
      # 子からの返却
      w.on 'message', fromChild
      w.send li
    
    li = cList()
  
else
  process.on 'message',(msg)->
    if msg.length != 0
      process.send
        sum : msg.map(M).reduce(R)
        length : msg.length
      
    
    process.exit()
  
###



###
# collect inject
# l = [1,5,3,2]
createList = ->
  l = []
  for i in [0...10]
    l.push Math.floor(Math.random() * 10)
  l

l = createList()
M = (i)->i 
R = (l,r)->l + r

console.log l.map(M).reduce(R)
###

###
# クロージャリスト
cl = ->
  l = []
  for i in [0...10]
    l.push Math.floor(Math.random() * 10)
  return ->
    console.log l
    l.splice(0,5)


a = cl()
i = 1
while  i > 0
  l = a()
  i = l.length
###

###
# cluster express multi
sleep = (s) ->
  e = (new Date).getTime() + s * 1000
  while (new Date).getTime() <= e
    continue
  return

exp = ->
  a=require("express")()

  a.get "/", (q,r)->
    console.log "getin"
    sleep 3
    r.send "test"

  a.listen 3000, ->
    console.log "onit"
  
  console.log "expre"


c = require("cluster")
if c.isMaster
  for i in [1..require("os").cpus().length]
    w = c.fork()
  
  c.on 'exit', (w, co, s)->
    console.log "exit"
    c.fork()
  
else
  console.log process.pid
  # exp()
  a=require("express")()

  a.get "/", (q,r)->
    console.log "getin"
    console.log process.pid
    # sleep 3
    r.send "test"
    # process.exit()

  a.listen 3000, ->
    console.log "onit"
  
  console.log "expre"
###


###
# cluster express single
sleep = (s) ->
  e = (new Date).getTime() + s * 1000
  while (new Date).getTime() <= e
    continue
  return

a=require("express")()

a.get "/", (q,r)->
  console.log "getin"
  sleep 3
  r.send "test"

a.listen 3000, ->
  console.log "onit"
###


###
# cluster server
cluster = require 'cluster'
http = require('http')

if cluster.isMaster
  i = 0
  while i < require('os').cpus().length
    w = cluster.fork()
    w.on 'message',(msg)->
      console.log msg
    
    i++
  
  
  cluster.on 'exit', (worker, code, signal) ->
    console.log 'worker(' + worker.id + ').exit ' + worker.process.pid
    return
  
  cluster.on 'online', (worker) ->
    console.log 'worker(' + worker.id + ').online ' + worker.process.pid
    return
  
  cluster.on 'listening', (worker, address) ->
    console.log 'worker(' + worker.id + ').listening ' + address.address + ':' + address.port
    return
else
  http.createServer (req, res) ->
    ip_address = null
    ip_address = req.connection.remoteAddress
    console.log 'client requested : ' + ip_address
    res.writeHead 200
    res.end 'hell world\n'
    process.send "iamchild"
    throw new Error "dead"
    # return
  .listen 3000
###



###
# callbackhellsleep 分割できない
repeating = 0
do ->
  redoFunc = arguments.callee
  console.log 'o'
  setTimeout (->
    console.log 't'
    setTimeout (->
      if ++repeating >= 5
        console.log 'e'
      else
        redoFunc()
      return
    ), 1000
    return
  ), 1000
  return
###

###
# async sleep
async = require 'async'
repeating = 0
async.forever (callback) ->
  async.series [
    (callback) ->
      console.log 'sleep one'
      setTimeout callback, 1000
      return
    (callback) ->
      console.log 'sleep two'
      setTimeout callback, 1000
      return
    (callback) ->
      if ++repeating < 5
        callback()
      else
        console.log 'endin'
      return
  ], callback
  return
, (err) ->
  console.log err
  return
###



###
# NGsleep
sleep = (s) ->
  e = (new Date).getTime() + s * 1000
  while (new Date).getTime() <= e
    continue
  return

# sleep 10
# sleep 10

c = require("cluster")
if c.isMaster
  for i in [1..require("os").cpus().length]
    w = c.fork()
  
  c.on 'exit', (w, co, s)-> console.log "exit"
  
else
  i = Math.floor(Math.random() * 10)
  console.log i
  sleep i
  console.log "pexit"
  process.exit()
###




###
# 並行処理 単一方向
cluster = require "cluster"
cpuCount = require("os").cpus().length

if cluster.isMaster
  console.log "master " + process.pid
  for i in [1..cpuCount]
    w = cluster.fork()
  
  # 終了を受け取る
  cluster.on 'exit',(worker, code, signal)->
    console.log worker.process.pid + ' exit:' + worker.id
  
else
  console.log "iamchild! " + process.pid
  process.exit()
  
###


###
cluster = require "cluster"
cpuCount = require("os").cpus().length

if cluster.isMaster
  for i in [1..cpuCount]
    w = cluster.fork()
    # 子から受け取る
    w.on 'message',(msg)->
      console.log 'master: get ' + msg
    
    # 子に送る
    w.send 'iammaster'
  
else
  # 親から受け取る
  process.on 'message',(msg)->
    console.log "worker: get " + msg
    process.exit()
  
  # 親に送る
  process.send "iamchild"
###

###
# 並行処理6
cluster = require "cluster"
cpuCount = require("os").cpus().length

if cluster.isMaster
  console.log process.pid + " in master"  
  for i in [1..cpuCount]
    console.log "fork:" + i
    w = cluster.fork()
    w.on 'message',(msg)->
      console.log 'on_message:MasterMsg:' + msg
    
    w.send 'fork send'
    console.log "forklast:" + i
  
  cluster.on 'exit',(worker, code, signal)->
    console.log 'exit:worker_id:' + worker.id
  
  console.log "master last"  
  
else
  console.log process.pid + " in worker"
  process.on 'message',(msg)->
    console.log 'on_messaage:WorkerMsg:' + msg
    process.send msg
    process.exit()
  
  process.send "worker last"
  
###




###
# 並行処理5(失敗例)
cluster = require "cluster"
cpuCount = require("os").cpus().length

if cluster.isMaster
  for i in [1..cpuCount]
    console.log "fork:" + i
    cluster.fork().send 'fork send'
  
  # forkの返り値(process)にイベントを設定しないと発火しない
  cluster.on 'message', (msg)->
    console.log 'on_message:MasterMsg:' + msg
  
  cluster.on 'exit',(worker, code, signal)->
    console.log 'exit:worker_id:' + worker.id
  
  console.log "master last"  
else
  console.log process.pid + " in worker"
  process.on 'message',(msg)->
    console.log 'on_messaage:WorkerMsg:' + msg
    process.send msg
    process.exit()
  
  process.send "worker last"
###




###
root = (cb) app.get "/", cb

root (q,s)-> s.render "index" {aaa:"dddd"}
###



###
# hapi
h = require "hapi"
s = new h.Server()
s.connection
  host: 'localhost'
  port: 8000

s.views
  engines:
    jade: require "jade"
  relativeTo: __dirname
  path: './views'

s.route
  method: "GET"
  path:"/"
  handler:
    view: "index"

hhell = (req, reply)-> reply "hell world", {"dead":"end"}
s.route
  method: "GET"
  path:"/hell"
  handler: hhell

nhell = (req, reply)-> reply 'Hell, ' + encodeURIComponent(req.params.name) + '!'
s.route
  method: "GET"
  path:"/{name}"
  handler: nhell

st = (s)-> console.log s.info.uri
s.start(st(s))
###

###
# エコーバック

S = (s,cb)->s.on "data", cb
E = (s,cb)->s.on "end", cb
scb = (d)-> s.write d
ecb = -> s.end "dead\n"


se = require("net").createServer (s)->
  s.write "hell\n"
  
  S s,(d)-> s.write d
  E s,->s.end "dead\n"
  

se.listen 7000, "localhost"
###

###
h=require "http"

o = 
  hostname: "yahoo.co.jp"
  port: 80
  method: "GET"

# イベントの定義
D = (sel, cb) -> sel.on "data", cb
E = (sel, cb) -> sel.on "end", cb
G = (o, cb) -> h.request o, cb

# 処理の定義
dcb = (c)-> console.log c.split("\n")[0]
ecb = -> console.log "end"
gcb = (r)->
  console.log "koko"
  r.setEncoding("utf8")
  D r, dcb
  E r, ecb

q=G o, gcb

console.log "ue"
q.on "error",(e)->console.log e
q.end()
console.log "shita"
###

###
# 並行処理4
cluster = require "cluster"
cpuCount = require("os").cpus().length

# クラスタを利用して処理を分散（CPUの数だけ）
if cluster.isMaster
  # console.log('CPU: ' + cpuCount)
  # console.log('isMaster?: ' + cluster.isMaster)
  
  for i in [1..cpuCount]
    w = cluster.fork()
    w.on 'message',(msg)->
      console.log 'Mmsg:' + msg
    
    w.send 'sensen'
  
  cluster.on 'exit',(worker, code, signal)->
    console.log 'worker_id:' + worker.id
  
  
else
  console.log process.pid + " hell..."
  process.on 'message',(msg)->
    console.log 'Wmsg:' + msg
    process.send msg
  
  process.send "deathhh"
  # process.exit()

###



###
# 並行処理(cluster) 3
cluster = require "cluster"
cpuCount = require("os").cpus().length

# クラスタを利用して処理を分散（CPUの数だけ）
if cluster.isMaster
  console.log 'CPU: ' + cpuCount
  console.log 'isMaster?: ' + cluster.isMaster
  
  for i in [1..cpuCount]
    cluster.fork().send('sensen')
  
  cluster.on 'message', (msg)->
    console.log 'Mmsg:' + msg
  
  cluster.on 'exit',(worker, code, signal)->
    console.log 'worker_id:' + worker.id
    console.log 'worker_pid:' + worker.process.pid
    # console.log 'code:' + code
    # console.log 'signal:' + signal
  
else
  console.log "hell..."
  process.on 'message',(msg)->
    console.log 'Wmsg:' + msg
    
    process.send msg
  
  process.send "deathhh"
  process.exit()
###





###
ichi = ->
  console.log 1
  setTimeout ni , 1000

ni = -> console.log 2

console.log 0
setTimeout ichi , 1000
###

###
f = require "fs"
res = {}

P = (r) -> console.log r.a + r.b + r.c
C = (e,c) ->
  res.c = c
  P(res)

B = (e,b) ->
  res.b = b
  f.readFile "c.txt", "utf-8", C

A = (e,a) ->
  res.a = a
  f.readFile "b.txt", "utf-8", B

Z = (cb)-> f.readFile "a.txt", "utf-8", cb

Z A
###

###
f = require "fs"

f.readFile "a.txt", "utf-8", (e,a) ->
  f.readFile "b.txt", "utf-8", (e,b) ->
    f.readFile "c.txt", "utf-8", (e,c) ->
      console.log a + b + c
###

###
P = (err, c) -> console.log a + b + c
C = (cb) -> get 'c.txt', cb
B = (cb) -> get 'b.txt', cb
A = (cb)-> get 'a.txt', cb

get = require('./get')

A B C P
###

###
A = (width, widthIndex) ->
  height = Math.round(width / aspect)
  console.log 'resizing ' + filename + 'to ' + height + 'x' + height
  @resize(width, height).write destination + 'w' + width + '_' + filename, (err) ->
    console.log 'Error writing file: ' + err if err

B = (err, values) ->
  if err
    console.log 'Error identifying file size: ' + err
    return
  
  console.log filename + ' : ' + values
  aspect = values.width / values.height
  widths.forEach (A).bind(this)

C = (filename, fileIndex) ->
  console.log filename
  gm(source + filename).size B

# zu viel
D = (err, files) ->
  if err
    console.log 'Error finding files: ' + err
    return
  
  files.forEach C

fs.readdir source, D
###

###
req = require "request"

G = (cb)-> req.get {uri:"http://yahoo.co.jp"}, cb
P = (h,cb)-> req.post {uri:"http://yahoo.co.jp", body:h + "noinoinoinoinionoinion"}, cb

postheader = (e,r,b) ->
  r.setEncoding("utf8")
  console.log r.request.body.toString("utf8")

G (e,r,b) ->
  console.log b.split("\n")[0]
  h = b.split("\n")[0]
  
  P h, postheader
###


###
req = require "request"

G = (cb)-> req.get {uri:"http://yahoo.co.jp"}, cb
P = (h,cb)-> req.post {uri:"http://yahoo.co.jp", body:h + "noinoinoinoinionoinion"}, cb

postheader = (e,r,b) ->
  r.setEncoding("utf8")
  console.log r.request.body.toString("utf8")

getheader = (e,r,b) ->
  console.log b.split("\n")[0]
  h = b.split("\n")[0]
  
  P h, postheader


G getheader
###


###
req = require "request"

G = (cb)-> req.get {uri:"http://yahoo.co.jp"}, cb
P = (h,cb)-> req.post {uri:"http://yahoo.co.jp", body:h + "noinoinoinoinionoinion"}, cb

v = G (e,r,b) ->
  console.log b.split("\n")[0]
  b.split("\n")[0]
  console.log r.request.uri

console.log "v"
console.log v.uri
###

###
req = require "request"

G = (cb)-> req.get {uri:"http://yahoo.co.jp"}, cb
P = (h,cb)-> req.post {uri:"http://yahoo.co.jp", body:h + "noinoinoinoinionoinion"}, cb

G (e,r,b) ->
  console.log b.split("\n")[0]
  h = b.split("\n")[0]
  
  P h,(e,r,b) ->
    r.setEncoding("utf8")
    console.log r.request.body.toString("utf8")
###


###
req = require "request"

req.get {uri:"http://yahoo.co.jp"}, (e,r,b) ->
  console.log b.split("\n")[0]
  h = b.split("\n")[0]
  
  req.post {uri:"http://yahoo.co.jp", body:h + "noinoinoinoinionoinion"}, (e,r,b) ->
    r.setEncoding("utf8")
    console.log r.request.body.toString("utf8")
###








###
# sync vs stream
filelist = ["outputa.txt","outputs.txt","outputt.txt"]
for filename in filelist
  require("fs").unlinkSync(filename) if require("fs").existsSync(filename)
###

###
# stream
stdt = new Date()
r = require("fs").createReadStream "input.txt", {encoding:"utf-8"}
L = (cb) -> r.on "data", cb
S = (list)-> list.map (i)-> i.trim().toUpperCase()
w = require("fs").createWriteStream('outputt.txt', { encoding:"utf-8", flags: 'a' })
R = (set)-> w.write set.join("\r\n")
L (d) -> R S d.split('\n')
r.on "end",  -> w.end()
w.on "close", ->
  eddt = new Date()
  console.log "st:" + (eddt - stdt).toString()
###

###
# async
astdt = new Date()
aL = (cb)-> require("fs").readFile "input.txt", "utf-8" , cb
aS = (list)-> list.map (i)-> i.trim().toUpperCase()
aR = (set)-> require("fs").writeFile "outputa.txt", set.join("\r\n"), (e)->
  aeddt = new Date()
  console.log "as:" + (aeddt - astdt).toString()
aL (e,d)-> aR aS d.trim().split('\r\n')
###

###
# sync
sstdt = new Date()
sL = -> (require("fs").readFileSync "input.txt", "utf-8").trim().split('\r\n')
sS = (list)-> list.map (i)-> i.trim().toUpperCase()
sR = (set) -> require("fs").writeFileSync "outputs.txt", set.join("\r\n")
sR sS sL()
seddt = new Date()
console.log "sy:" + (seddt - sstdt).toString()
###





###
# stream2
# inputのリストを取得する
L = (cb) -> (require("fs").createReadStream "input.txt", {encoding:"utf-8"}).on "data", cb

# リストを加工する
S = (list)-> list.map (i)-> i.trim().toUpperCase()

# 結果をoutputする
R = (set)-> (require("fs").createWriteStream('output.txt', { encoding:"utf-8", flags: 'a' })).write set.join("\r\n")

# L (d) -> R S d.split('\n')
L (d) ->
  set =  S d.split('\n')
  R set
###



###
# stream1
# inputのリストを取得する
L = (cb) -> (require("fs").createReadStream "input.txt", {encoding:"utf-8"}).on "data", cb

# リストを加工する
S = (list)-> list.map (i)-> i.trim().toUpperCase()

# 結果をoutputする
R = (set)-> require("fs").appendFile "output.txt", set.join("\r\n"), (e)->

# L (d) -> R S d.split('\n')
L (d) ->
  set =  S d.split('\n')
  R set
###

###
# L (e,d)-> R S d.trim().split('\r\n')
L (e,d)-> 
  list = d.trim().split('\r\n')
  set = S list
  R set
###


###
# filewriteもstreamであるべき
w = require("fs").createWriteStream('output.txt', { encoding:"utf-8", flags: 'a' })

w.on "open", -> console.log "open"
w.on "close", -> console.log "close"
# w.write Math.floor(Math.random() * 100).toString()
for i in [1..10000]
  bit = 0
  if i % 2 == 0
    bit = 1
  w.write bit.toString()

w.end()
###


###
# filereadもstreamであるべき
# require("fs").readFile "input.txt", "utf-8" , (e,d) ->
#   console.log d

# createReadStream 非同期
r = require("fs").createReadStream "input.txt", {encoding:"utf-8"}

res = ""
ondata = (cb) -> r.on "data", cb

r.on "end", ->
  console.log res.length
  console.log "end"

ondata (d) ->
  res += d
  console.log d.length
  console.log "cccyaaannkkuu!!!!!!!!!!"
###



###
a=[1,2,3,4,5]
# console.log a.filter((i)->i%2==0).map((i)-> i * 2).reduce((l,r)->l+r)

filfun = (i)-> i % 2 == 0
mapfun = (i)-> i * 2
redfun = (l,r)-> l + r

res = a
  .filter( filfun )
  .map( mapfun )
  .reduce( redfun )

console.log res
###

###
# inputのリストを取得する
L = (cb)-> require("fs").readFile "input.txt", "utf-8" , cb

# リストを加工する
S = (list)-> list.map (i)-> i.trim().toUpperCase()

# 結果をoutputする
R = (set)-> require("fs").writeFile "output.txt", set.join("\r\n"), (e)->


# L (e,d)-> R S d.trim().split('\r\n')
L (e,d)-> 
  list = d.trim().split('\r\n')
  set = S list
  R set
###




###
# inputのリストを取得する
L = ->
  file = require("fs").readFileSync "input.txt", "utf-8"
  file.trim().split('\r\n')

# リストを加工する
S = (list)-> list.map (i)-> i.trim().toUpperCase()

# 結果をoutputする
R = (set) -> require("fs").writeFileSync "output.txt", set.join("\r\n")

se = L()
re = S(se)
R(re)
###


###
# inputのリストを取得する
L = ->
  fs  = require "fs"
  file = fs.readFileSync "input.txt", "utf-8"
  list = file.trim().split('\r\n')
  list

# リストを加工する
S = (list)->
  set = list.map (i)-> i.trim().toUpperCase()
  set

# 結果をoutputする
R = (set) ->
  fs  = require "fs"
  res = set.join("\r\n")
  
  fs.writeFileSync "output.txt", res

se = L()
re = S(se)
R(re)
###



###
# ページング
a = [1..98]
n = 5
p = [1..20]

p.forEach (p)->
  console.log p + "ページ目：" + a.slice n * (p-1), n * p
###



###
req = require "request"

o = 
  uri: "http://simple-note.appspot.com/api/login"
  body: ""

req.post o, (e,r,b)->
  r.setEncoding("utf8")
  console.log r
  console.log b
  console.log r.statusCode
###


###
# base64
b = new Buffer "ああああ"
s = b.toString "base64"
console.log s

a = new Buffer s, "base64"
c = a.toString()
console.log c

console.log new Buffer("ああああ").toString("base64")
console.log new Buffer("44GC44GC44GC44GC", "base64").toString()
###



###
# post express
a=require("express")()
b=require "body-parser"
a.use b.json()
a.use b.urlencoded(extended: false)

a.post "/", (q,r)->
  console.log r.body.name
  r.set 'Content-Type', 'application/json'
  r.json {"jjj":"dondon"}

a.listen 3000
###

###
# 最小サーバー
require("http").createServer((a,b)->b.end("sdf" + a.url)).listen 3000
###

###
# poster2 NG
h=require "http"

o = 
  uri: "http://yahoo.co.jp"
  form: {name: "testest"}
  json: true

q=h.request o,(r)->
  r.setEncoding("utf8")
  r.on 'data', (c)->
    console.log c.toString()
  r.on "end",->
    console.log "end"
.on "error",(e)->

# q.end()
###

###
# poster
req = require "request"

o = 
  uri: "http://localhost:3000"
  form: {name: "testest"}
  json: true

req.post o, (e,r,b)->
  # console.log e
  console.log r
  console.log b
###

###
# getter
http = require "http"

http.get("http://yahoo.co.jp").on 'response',(res)->
  res.setEncoding("utf8")
  res.on 'data', (c)->
    console.log c
###



###
# auth
CQAuth = ->
  @init()
  return

CQAuth.prototype =
  init: ->
    DROPBOX_APP_KEY = 'SET_YOUR_APP_KEY'
    
    @client = new (Dropbox.Client)(key: DROPBOX_APP_KEY)
    @client.authenticate { interactive: false }, (error) ->
      console.log 'Authentication error: ' + error if error
  
  login: -> @client.authenticate()
  logout: ->
    @client.signOut { mustInvalidate: false }, (error) ->
      console.log 'Singn out error: ' + error if error
    # location.reload()
  
  isLogin: -> @client.isAuthenticated()


auth = new CQAuth
console.log 'Login Success' if auth.isLogin()
auth.login()
console.log 'Login Success' if auth.isLogin()

# list
CQList = ->
  @init()
  return

CQList.prototype =
  init: ->
    @client = null
    @table = null
  
  load: (client) -> @client = client
  
  create: ->
    _self = this
    @client.getDatastoreManager().openDefaultDatastore (error, datastore) ->
      alert 'Error opening default datastore: ' + error if error
      _self.table = datastore.getTable('quill')
      _self.update()
      datastore.recordsChanged.addListener -> _self.update()
  
  update: ->
    records = @table.query()
    records.forEach (i) -> console.log i

# main
auth = new CQAuth
list = new CQList
if auth.isLogin()
  list.load auth.client
  list.create()
  table = list.table
  title = 'ABC'
  content = 'DEF'
  share = 'private'
  table.insert
    title: title
    content: content
    share: share
###


###
# classmethod
fun = ->
  @meso()

fun.prototype =
  meso: ->
    console.log "mememe"

new fun
###

###
# jsonに追加 同期でやらないとダメ
fs  = require "fs"

f=(d)->
  d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2) + " " \
   + ("0" + d.getHours()).slice(-2) + ":" \
   + ("0" + d.getMinutes()).slice(-2) + ":" \
   + ("0" + d.getSeconds()).slice(-2)

fs.writeFileSync "input.json", "[]" # 初期化

for i in [0..2]
  # 非同期
  fs.readFile "input.json", "utf-8" , (e,d)->
    fo = JSON.parse d
    add = {"val1":120 ,"val2":50, "vala":10, "date":f(new Date())}
    fo.push add
    st = JSON.stringify(fo)
    
    fs.writeFile "input.json", st, "utf-8", (e) -> 
      console.log e if(e)


for i in [0..2]
  # 同期
  d = fs.readFileSync "input.json", "utf-8"
  fo = JSON.parse d
  add = {"val1":120 ,"val2":50, "vala":10, "date":f(new Date())}
  fo.push add
  st = JSON.stringify(fo)
  fs.writeFileSync "input.json", st
###



###
# 日付リストをソート
dl = '[' + \ 
  '{"a":"2015/02/25 10:50:01"},' + \
  '{"a":"2015/02/25 13:50:10"},' + \
  '{"a":"2015/02/25 10:50:20"},' + \
  '{"a":"2015/02/25 10:51:10"},' + \
  '{"a":"2015/02/25 12:50:10"},' + \
  '{"a":"2015/02/25 10:50:10"},' + \
  '{"a":"2015/02/25 10:50:13"},' + \
  '{"a":"2015/02/25 10:50:11"},' + \
  '{"a":"2015/02/25 10:50:12"},' + \
  '{"a":"2015/03/11 15:40:43"},' + \
  '{"a":"2015/03/11 15:45:22"},' + \
  '{"a":"2015/03/11 15:40:41"},' + \
  '{"a":"2015/03/11 15:45:17"},' + \
  '{"a":"2015/03/11 15:45:19"},' + \
  '{"a":"2015/03/11 15:40:39"},' + \
  '{"a":"2015/03/11 15:40:54"},' + \
  '{"a":"2015/03/11 15:40:59"},' + \
  '{"a":"2015/03/11 15:40:58"},' + \
  '{"a":"2015/03/11 15:40:50"},' + \
  '{"a":"2015/03/11 15:40:46"},' + \
  '{"a":"2015/03/11 15:40:44"},' + \
  '{"a":"2015/03/11 15:40:37"},' + \
  '{"a":"2015/03/11 15:40:34"},' + \
  '{"a":"2015/03/11 15:40:31"},' + \
  '{"a":"2015/03/10 16:23:12"},' + \
  '{"a":"2015/03/10 16:11:57"},' + \
  '{"a":"2015/03/10 14:22:11"}' + \
  ']'
j = JSON.parse dl
console.log j.sort (i,j)-> Date.parse(j.a) - Date.parse(i.a)
###



###
# リストをソート
obj = [1,4,6,3,1]
console.log obj.sort()

j = JSON.parse '[{"a":1},{"a":4},{"a":6},{"a":3},{"a":1},{"a":2},{"a":2},{"a":1}]'
console.log j.sort (i,j)->i.a > j.a
###

###
# json保存
fs  = require "fs"

# オブジェクトからjsonへ変換テスト
obj = 
  ary:[0,1,2],
  obj:
    a:0,
    b:1,
    c:2

str = JSON.stringify(obj);

# テスト出力
# console.log str
# console.log typeof str

# jsonからオブジェクトへ変換テスト
str = '{"id":{"ary":[0,1,2],\n"ob'
str += 'j":{"a":0,"b":1,"c":22222}}}'
str = '[{"id":1},{"id":2}]'
obj = JSON.parse str

# console.log typeof obj

# テスト出力
# console.log obj.ary
# console.log obj.obj


fs.writeFile "str.txt", str, "utf-8", (e) -> console.log e if(e)
# fs.writeFile "obj.txt", obj, "utf-8", (e) -> console.log e if(e)

fs.readFile "str.txt", "utf-8" , (e,d)->
  console.log e if(e)
  console.log d
  console.log typeof d
  fo = JSON.parse d
  console.log fo.ary
  console.log fo.bon
  console.log fo[0].id
  console.log fo[1].id
  console.log fo.map (i)-> i.id

console.log "death"
###


###
# 日付→文字
d = new Date()
s = d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2) + " " \
   + ("0" + d.getHours()).slice(-2) + ":" \
   + ("0" + d.getMinutes()).slice(-2) + ":" \
   + ("0" + d.getSeconds()).slice(-2)

console.log s

# 文字→日付(数値)
console.log Date.parse("2015/02/25 10:50:10")

console.log Date.parse(s)

f=(d)->
  d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2) + " " \
   + ("0" + d.getHours()).slice(-2) + ":" \
   + ("0" + d.getMinutes()).slice(-2) + ":" \
   + ("0" + d.getSeconds()).slice(-2)

console.log "check"
console.log new Date()
console.log f(new Date())
console.log Date.parse(f(new Date()))
console.log Date(Date.parse(f(new Date())))
console.log new Date(Date.parse(f(new Date())))
console.log typeof new Date(Date.parse(f(new Date())))
###


###
# 日付型を数値で
console.log Date() # string
console.log Date().valueOf() # string

console.log new Date() # object
console.log new Date().valueOf() # number

console.log Date(new Date().valueOf()) # string
console.log new Date(new Date().valueOf()) # object
###


###
# mecab
k = require "kuromoji"
k.builder({dicPath: "node_modules/kuromoji/dist/dict/"}).build (e,t)->
  t.tokenize("すもももももも").forEach (i)->
    console.log i.surface_form + "," + i.pos + "," + i.pos_detail_1 + "," + i.pos_detail_2 + "," + i.reading
###


###
# future2
Future = require "fibers/future"
# wait = Future.wait

sl=(ms)->
  future = new Future
  setTimeout ->
    future.return()
  , ms
  future


calc = ((ms)->
  start = new Date
  sl(ms).wait()
  new Date - start
).future()


calc(2000).resolve (e,v)->
  console.log  v + "ms"
###



###
# fibonacci generator
Fiber = require "fibers"

Fib = ->
  f = Fiber ->
    Fiber.yield 0
    prev = 0
    curr = 1
    while true
      Fiber.yield  curr
      tmp = prev + curr
      prev = curr
      curr = tmp
  
  f.run.bind(f)

seq = Fib()
[1..19].forEach (i)-> console.log seq()
###




###
# ●fiber 使用できない
# Fiber = require "fiber"


# ●fibers
Fibers = require "fibers"
###


###
# ●future
Future = require "future"

# ●futures 存在しない
# Futures = require "futures"
###


###
Fiber = require "fibers"
Future = require "fibers/future"
wait = Future.wait

sleep = (ms)->
  future = new Future
  setTimeout ->
    future.return()
  , ms
  future

f = Fiber ->
  console.log("1")
  sleep(2000).wait()
  console.log("2")
  "3"

ret = f.run()
console.log "ret:" + ret
###



###
# intput -> outputの例 fiberを使った場合
Fiber = require "fibers"
fs  = require "fs"

console.log "1"
resume_cb = (f)->
  console.log "res 1 関数定義"
  ->
    console.log "res 2 fsの処理完了" # read完了
    f.run Array.prototype.slice.call arguments
    console.log "res 3 終了" # writeを待つ

console.log "2"
main = ->
  console.log "4 current定義"
  f = Fiber.current
  console.log "5 readFile開始"
  fs.readFile "input.txt", "utf-8", resume_cb(f) # 関数定義
  console.log "6 mainから出るyield"
  input_res = Fiber.yield() # mainから出る
  console.log "8 readが完了し戻ってくる" # readが完了し戻ってくる
  console.log input_res[0] if(input_res[0])
  
  console.log "9 writeFile開始"
  fs.writeFile "output.txt", input_res[1], "utf-8", resume_cb(f) # 関数定義
  console.log "10 rea
  dのresumeに戻すyield"
  output_res = Fiber.yield() # readのresumeに戻す
  console.log "11 writeが完了し戻ってくる" # writeが完了し戻ってくる
  console.log output_res[0] if(output_res[0])
  console.log "12 main終了"
  

console.log "3 mainに入る"
Fiber(main).run() # mainに入る
console.log "7 readを待つ" # readを待つ
###



###
# intput -> outputの例
fs  = require "fs"

fs.readFile "input.txt", "utf-8" , (e,d)->
  console.log e if(e)
  console.log d
  
  fs.writeFile "output.txt", d, "utf-8", (e) ->
    console.log e if(e)
###


###
# fiber3 fiberの直接利用は非推奨とのこと
Fiber = require "fibers"

inc = Fiber ->
  i = 0
  while true
    Fiber.yield(i++)

[1..5].forEach (i)-> console.log inc.run()
###


###
# yield(co) --harmonyをつけたらできた
fs = require 'fs'
co = require 'co'

co ->
  files = yield co.wrap(fs.readdir)('.')
  data = yield co.wrap(fs.readFile)(files[0], 'utf-8')
  console.log data
###


###
# deferred NG
fs = require 'fs'
Q = require 'q'

a = Q.nfcall(fs.readdir, '.')
  .then (files) ->
    return Q.nfcall(fs.readFile, files[0], 'utf-8')
  .then (data) ->
    console.log data

a.done()

###


###
# yield以前
fs = require 'fs'

fs.readdir '.', (err, files) ->
  console.log files
  fs.readFile files[1], 'utf-8', (err, data)->
    console.log data
###



###
# promise
Promise = require "Promise"
p1 = new Promise (res,rej) ->
  setTimeout(res, 1000)

p1.all
###

###
# future
context = 'foo': 'bar'
Future = require 'future'

future = Future.create(context)
err = ""
message = 'Hello World!'

future.whenever (error, data) ->
  # throw err if(error)
  console.log @foo + ' says: ' + data
  return


future.setTimeout 1000
future.deliver err, message
###


###
# filter
console.log [1,2,3,2].filter (i)-> i>=2
console.log (item for item in [1,2,3,2] when item >= 2)

# includes
included = "a long test string".indexOf("test") isnt -1
console.log included

# -1 の比較をビット演算子をつかって代替する
string   = "a long test string"
included = !!~ string.indexOf "test"
console.log included

# Min/Max
console.log Math.max [14, 35, -7, 46, 98]
console.log Math.min [14, 35, -7, 46, 98]

console.log Math.max [14, 35, -7, 46, 98]...
console.log Math.min [14, 35, -7, 46, 98]...
###


###
# future ファイルの容量計算
Future = require "fibers/future"
fs = Future.wrap require 'fs'

Future.task(->
  # Get a list of files in the directory
  fileNames = fs.readdirFuture('.').wait()
  console.log 'Found ' + fileNames.length + ' files'
  
  # Stat each file
  # stats = fileNames.map((i) -> fs.statFuture(i))
  stats = ( fs.statFuture(i) for i in fileNames)
  stats.map (f) -> f.wait()
  
  # Print file size
  stdt = new Date()
  for q in [1..1000000]
    fileNames.forEach (i,j) -> i + ": " + stats[j].get().size
  eddt = new Date()
  ichi = eddt - stdt
  
  # forEachよりもこっち(for in)のほうがはやい
  stdt = new Date()
  for q in [1..1000000]
    a + ": " + stats[b].get().size for a, b in fileNames
  eddt = new Date()
  console.log ichi
  console.log(eddt - stdt)
).detach()
###


###
# fiber2
Fiber = require "fibers"

console.log "1@@" # 1 関数の定義
sleep = (ms)->
  console.log "4@@"
  fiber = Fiber.current
  console.log "5@@"
  setTimeout(->
    console.log "8@@" # 6 タイムアウトし実行開始
    fiber.run() # 7 4のyieldが実行される
    console.log "11@@" # 10 7の処理が終わったので残りを処理
  , ms)
  console.log "6@@"
  Fiber.yield() # 4 停止し、いったん抜ける
  console.log "9@@" # 8 7のrunを受けて実行され終了

console.log "2@@" # 2 Fiber実行
Fiber(->
  console.log "3@@"
  console.log "wait.." + new Date
  sleep(1000) # 3 関数実行 停止
  console.log "10@@" # 9 sleepが終了したので開始
  console.log "OK" + new Date
).run()

console.log "7@@"  # 5 ここから一秒待つ
###



###
# fiber1
Fiber = require "fibers"

inc = Fiber((start)->
  console.log("1@@:" + start)
  total = start
  while (true)
    console.log("2@@:" + start)
    console.log("2@@:" + total)
    total += Fiber.yield(total)
    console.log("3@@:" + start)
    console.log("3@@:" + total)
)

console.log("4@@")
ii = inc.run(1)
console.log("5@@")
while ii <= 10
  console.log("6@@")
  console.log ii
  # console.log typeof ii
  ii = inc.run(2)
  console.log("7@@")
###


###
# console.log 10**1

sorocon=(ichi)->
  val = ichi[0]
  if(ichi[1])
    val += 5
  
  val

# console.log sorocon([4,true])
# console.log sorocon([4,false])

so = [
  [4,true]
  [4,false]
  [2,true]
]

# console.log so
res = so.reverse().map((a,i)->
  sorocon(a) * (10 ** i)
).reduce((a,b)->
  a+b
)

console.log res
###


###
# idを検索し、なければ追記
fs = require "fs"
# id = Math.floor(Math.random() * 100)
id = 12
console.log fs.readFileSync(__dirname + "/donelist.txt", "utf-8").trim().split("\n")
if fs.readFileSync(__dirname + "/donelist.txt", "utf-8").trim().split("\n").indexOf(id.toString()) == -1
  fs.appendFileSync(__dirname + "/donelist.txt", id + "\n")
else
  console.log "atta"
###

###
val = "abc"

if /abc/.test(val)
  console.log "aru"
else
  console.log "nai"
###

###
val = "abc"
reg = new RegExp(val)


if reg.test("abcd")
  console.log "aru"
else
  console.log "nai"
###

###
console.log(__filename)
console.log(require('path').basename(__filename))
###

###
def = (word="naiyo")->
  console.log word


def()
def("aruyo")
###


###
d = new Date()

res = switch d.getHours()
  when 1 then "ichi"
  when 2,11 then "ni"

console.log res
###

###
# ランダム返却
cacha_rand = (list) ->
  list.splice( Math.floor(Math.random() * list.length), 1 )[0].trim()

console.log cacha_rand(["あ","い","う","え"])

cacha = ->
  cacha_rand(["タ","チ","ツ","テ","ト","カ","キ","ク","ケ","コ"]) +
  cacha_rand(["ァ","ィ","ゥ","ェ","ォ","ャ","ュ","ョ",""]) +
  "ッ" +
  cacha_rand(["タ","チ","ツ","テ","ト","カ","キ","ク","ケ","コ"]) +
  cacha_rand(["ァ","ィ","ゥ","ェ","ォ","ャ","ュ","ョ"])

console.log cacha()
###


###
params = screen_name: "sage"
client.get('statuses/user_timeline', params, (e,t,r)->
  t.map((t)-> console.log t.text.replace(/^@\w+?\s/g,"").replace(/\s/g,""))
)
###


###
# シャッフル
array = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']
times = 1000

trial = (shuffle) ->
  average = {}
  i = 0
  while i < array.length
    average[array[i]] = 0
    i++
  
  i = times
  while i--
    arr = shuffle(array)
    j = 0
    while j < arr.length
      elem = arr[j]
      average[elem] += j
      j++
  
  for elem of average
    average[elem] /= times
  
  return average

goodShuffle = (arr) ->
  i = undefined
  j = undefined
  temp = undefined
  arr = arr.slice()
  i = arr.length
  if i == 0
    return arr
  while --i
    j = Math.floor(Math.random() * (i + 1))
    temp = arr[i]
    arr[i] = arr[j]
    arr[j] = temp
  arr


console.log trial(goodShuffle)

badShuffle1 = (arr) ->
  arr.slice().sort(->
    Math.round(Math.random() * 2) - 1
  )

console.log trial(badShuffle1)

ordersf= (arr) ->
  random = arr.map(Math.random)
  arr.sort((a, b)->
    random[arr.indexOf(b)] - random[arr.indexOf(a)]
  )


console.log trial(ordersf)


splixe = (arr) ->
  len = arr.length
  ary = arr.concat()
  res = []
  while(len)
    res.push( ary.splice(Math.floor(Math.random()*len--),1) )
  res

console.log trial(splixe)

###


###
# while
n=5
while(n)
  console.log n
  console.log Math.floor(Math.random() * n--)
###

###
# log出力3(winston)
winston = require('winston')
logger = new (winston.Logger)(
  transports: [
    # 使う出力方法を transports で宣言する
    new (winston.transports.Console)(
      level: 'silly', # level は silly 以上
      colorize: true, # 色付き
      timestamp: true # 時間つき
    ),
    new (winston.transports.File)(
      level: 'silly', # level は silly 以上
      colorize: true, # 色付き
      timestamp: false, # 時間つき
      filename: 'log.txt',
      json: false
    )
  ]
)

logger.silly('ばかばかしいこと')
logger.debug('とてもどうでもいいこと')
logger.verbose('どうでもいいこと')
logger.info('じょうほう')
logger.warn('やばい')
logger.error('すごくやばい')
###

###
# anode
anode = require 'anode'

cnf = new anode.Configuration debug : true

httpServer = cnf.actor anode.http.server_beh()
helloworld = cnf.actor anode.behavior( 'httpServer'
  '#start' : ->
    @send( @, '#listen', 8080, '127.0.0.1' ).to @httpServer
  '$httpServer, #listen' : ->
    @send( 'Server running at http://127.0.0.1:8080/' ).to cnf.console.log
  '$httpServer, #request, request, response' : ->
    @send( null, '#end', 'Hello Actor World\n' ).to @response
)( httpServer ) # helloworld 
 
cnf.send( '#start' ).to helloworld
###


###
# 足し算
Number.prototype.plus = (x) ->
  # this.toString(2)
  # x.toString(2)
  res = this
  for i in [1..x]
    res = res + 1
  res

Number.prototype.あ = (x) ->
  # this.toString(2)
  # x.toString(2)
  res = this
  for i in [1..x]
    res = res + 1
  res

console.log 0x1 | 0x2
console.log 1 | 2

console.log 0xa | 0xb
console.log 10 | 11
console.log parseInt(10.toString(16),16) | parseInt(11.toString(16),16)

# 1010 1011
console.log 5.あ 3
###



###
# カリー化
func = (x,y)->
  x + y

cfuncp = (x)->(y)->
  x + y

res = func(2,3)
console.log res

cres = cfuncp(2)
console.log  cres(3)
console.log  cfuncp(2)(3)
###


###
# 引数の取得
min = ->
  args = Array.prototype.slice.call(arguments, 1);
  return args.reduce (prev, current) ->
    if (prev < current)
      return prev;
    
    return current
  

console.log min(3,6,3,1,9)
###

###
# MD5
crypto = require "crypto"

md5_hex = (src) ->
  md5 =  crypto.createHash 'md5'
  md5.update src, 'utf8'
  md5.digest('hex')
  

mdtmp = (src) ->
  md5 =  crypto.createHash 'SHA256'
  md5.update src, 'utf8'
  md5.digest('hex').substr(5,5).toUpperCase()
  

# console.log md5_hex "nodnoe"
console.log mdtmp "sodia"
###


###
# 大文字にする
console.log "sdfUIeu".toUpperCase()
console.log "sdfUIeu".toLowerCase()
###


###
# expectの配列をやりとり
init = ->
  arr = []
  arr.gen = "asf"
  arr.gen = "asf3"
  arr.ni = "ninini"
  arr


arrr = init()
console.log arrr.gen
###


###
# 配列で定義すると2番目にインデックスが返る
arr = [1..10]
for x,i in arr
  console.log x + " " + i
###



###
# ガード節による値変換2
convert=(type)->
  switch type
    when 1 then "ichi"
    when 2 then "ni"
    when 3 then "san"
    when 4 then "shi"
    else "death"


console.log convert 2
console.log convert 4
console.log convert 3
console.log convert 5
###



###
# ガード節による値変換
convert=(type)->
  return "ichi" if type == 1
  return "ni" if type == 2
  return "san" if type == 3
  return "shi" if type == 4
  return "death"


console.log convert 2
console.log convert 4
console.log convert 3
console.log convert 5
###


###
# cheerio2
cheerio = require "cheerio"

# xml作成
builder = require "xmlbuilder"

root = builder.create "root"
ids = root.ele "ids"
ids.ele "id", "gen1"
ids.ele "id", "gen2"

# console.log root.end({pretty: true})
xml = root.end({pretty: true})

$ = cheerio.load xml, {ignoreWhitespace: true, xmlMode: true}
console.log $("ids").length 
console.log $("id").length

console.log $("id").eq(0).text()
console.log $("id").get().length
console.log $("id").is("id")
console.log $("message").is("message")
console.log $("root").find("ids").text()
console.log $("root").find("id").text()
console.log $("root").find("ids").eq(0).text()
console.log $("root").find("ids").eq(1).text()
console.log $("root").find("id").eq(0).text()
console.log $("root").find("id").eq(1).text()
###



###
# 配列IDSQL反映
arr = ["000", "111", "222"]
console.log arr

arr.forEach (i)->
  console.log i
###



###
# 日付フォーマット
require "date-utils"
console.log new Date()
console.log new Date().toFormat "YYYY/MM/DD HH24:MI:SS"
###


###
# 文字連結の速度測定
n=12582912

# +
stdt = new Date()
p = ""
for i in [1..n]
  p = p + "aaa"
  p = p + "bbb"
  p = p + "ccc"
  p = p + "ddd"
eddt = new Date()
console.log (eddt - stdt).toString() + ":p"
# console.log p

# +=
stdt = new Date()
pe = ""
for i in [1..n]
  pe += "aaa"
  pe += "bbb"
  pe += "ccc"
  pe += "ddd"
eddt = new Date()
console.log (eddt - stdt).toString() + ":pe"
# console.log pe

# concat
stdt = new Date()
con = ""
for i in [1..n]
  con = con.concat "aaa"
  con = con.concat "bbb"
  con = con.concat "ccc"
  con = con.concat "ddd"
eddt = new Date()
console.log (eddt - stdt).toString() + ":concat"
# console.log con


# 配列にpushしてjoin
stdt = new Date()
arr=[]
for i in [1..n]
  arr.push "aaa"
  arr.push "bbb"
  arr.push "ccc"
  arr.push "ddd"
arr.join("")
eddt = new Date()
console.log (eddt - stdt).toString() + ":arr"
# console.log arr.join("")


# 文字配列[]
stdt = new Date()
sa = []
for i in [1..n]
  sa[ sa.length ] = "aaa"
  sa[ sa.length ] = "bbb"
  sa[ sa.length ] = "ccc"
  sa[ sa.length ] = "ddd"
sa.join("")
eddt = new Date()
console.log (eddt - stdt).toString() + ":sa"
# console.log sa.join("")
###



###
# pg client instance
pg = require "pg"
conString = "postgres://username:password@localhost/database"

client = new pg.Client conString
client.connect (err) ->
  return console.error 'could not connect to postgres', err if err
  
  client.query 'SELECT NOW() AS "theTime"', (err, result) ->
    return console.error 'error running query', err if err
    
    console.log result.rows[0].theTime
    client.end()
###


###
# pg client pooling
pg = require "pg"
conString = "postgres://username:password@localhost/database"

pg.connect conString, (err, client, done)->
  return console.error('error fetching client from pool', err) if err
  
  client.query 'SELECT 1 AS number', (err, result)->
    # call `done()` to release the client back to the pool
    done()
    
    return console.error 'error running query', err if err
    
    console.log result.rows[0].number
###


###
# xml作成3
builder = require "xmlbuilder"

root = builder.create "root"
root.ele "first", "gen"
  .att "amo1", "ineine1"
  .att "amo2", "ineine2"
  .att "amo3", "ineine3"
root.ele "first"
  .ele "seccond"
    .att "tamo", "ineine1"
    .ele "thirdt", "lkjklj"
      .att "sanbama", "kanami--"
root.ele "first", "nakami"

console.log root.end({pretty: true})
###


###
# xml作成2
builder = require "xmlbuilder"

root = builder.create "root"
root.com('f(x) = x^2')
for i in [1..5]
  item = root.ele 'data'
  item.att 'x', i
  item.att 'y', i * i

console.log root.end({pretty: true})
###

###
# xml作成1
builder = require "xmlbuilder"

xml = builder.create "root"
  .ele "ichiban", {"for":"nodenode"}
  .ele "repo", {"tytptyp":"gege"}, "nantokananntoka"
  .end {pretty: true}

console.log xml
###


###
# cheerio
cheerio = require "cheerio"
http = require "http"

xml =  ''

# $ = cheerio.load xml,{ignoreWhitespace: true, xmlMode: true}
# console.log $("re").text()

url = ""
http.get(url).on 'response',(res)->
  res.setEncoding("utf8")
  res.on 'data', (c)->
    # if c == xml
    #   console.log "onaji"
    # else
    #   console.log "tigau"
    $ = cheerio.load c,{ignoreWhitespace: true, xmlMode: true}
    console.log $("r").text()
###



###
# fluent5
f = require('fluent-logger-node')

stdt = new Date()

potter=(mes,o, count, l)->
  for i in [0..count]
    # console.log i
    js = {}
    js[mes] = "foo" + (o * i).toString()
    l.post("tag.coffee", js)
    
  eddt = new Date()
  console.log(eddt - stdt)


for i in [1..1000]
  l = f.createLogger()
  potter "coffee" + i.toString(), i, 1000, l
  
###

###
# fluent stream
f = require('fluent-logger-node')
l = f.createLogger({tagPrefix:"tag"})
l.post("first", {stream:"0"})

# u = f.createLogger({tagPrefix:"unknouw"})
# u.post("first", {stsdfsream:"0"})


l.stream.on "end",->console.log "end"
l.stream.on "finish",->console.log "fini"
l.stream.on "connect",->
  console.log "con"
  l.post("event", {stream:"0"})
l.stream.on "error",->console.log "err"
l.stream.on "close",->
  console.log "clo"
  process.exit()

b = new Buffer "tag.buf"
l.stream.resume()
l.stream.write b,"utf8",(a)->console.log a

w =-> console.log l.stream._writableState.buffer
r =-> console.log l.stream._readableState.buffer
###


###
# fluent4 emitter
f = require('fluent-logger-node')
l = f.createLogger()

# 本処理
stdt = new Date()

l.on "flu",(i)->
  l.post "tag.coffee", {coffeen:"post" + i.toString()}

count = 10000 * 10
for i in [0..count]
  l.emit "flu", i

eddt = new Date()
console.log(eddt - stdt)
# console.log l.pushQueue()
# console.log l.sendQueue()

# process.exit()
###


###
# fluent3
f = require('fluent-logger-node')
l = f.createLogger()
EventEmitter = require('events').EventEmitter

asyncFunc = ->
  ev = new EventEmitter
  ev.on 'fluent', (i)->
    # console.log i
    l.post "tag.coffee", {coffeen:"post" + i.toString()}
  
  ev

# 本処理
stdt = new Date()

flu = asyncFunc()
count = 10000 * 10
for i in [0..count]
  # console.log i
  # js = {}
  # js[mes] = "foo" + i.toString()
  flu.emit "fluent", i
  # l.post("tag.coffee", js)



eddt = new Date()
console.log(eddt - stdt)

# process.exit()
###



###
# fluent2 NG 10000行しか送られない
f = require('fluent-logger-node')
l = f.createLogger()

stdt = new Date()

potter=(mes, count)->
  for i in [0..count]
    console.log i
    js = {}
    js[mes] = "foo" + i.toString()
    l.post("tag.coffee", js)


for i in [0..100]
  potter "coffee" + i.toString(), 1000 * 1

eddt = new Date()
console.log(eddt - stdt)
###

###
h = require "http"
a = require "assert"
chai = require "chai"
chai.should()

# RESTTEST
if process.argv[2] == "s"
  console.log "server!"
  s = h.createServer()
  s.on "request",(q,s)->
    s.setHeader 'Content-Type', 'text/html'
    s.writeHead 200
    s.end 'ok'
    # s.end '<div id="#aide">ok</div>'
    console.log "done"
  
  s.listen 80
else
  url = "http://localhost:80"
  
  suite "tddd",->
    test "monmone",->
      a.equal 1,1 
      
  describe "OKtest",->
    before ->
      # console.log "beee"
    
    after ->
      # console.log "aeee"
    
    it "OKが返却されること",->
      h.get(url).on 'response',(i)->
        # console.log i.statusCode
        # console.log i.headers["date"]
        # console.log JSON.stringify( i.headers)["date"]
        
        i.setEncoding("utf8")
        i.on 'data', (c)->
          # console.log c
          a.equal "ok", c
          chai.assert.equal "ok", c
          chai.expect(c).to.equal "ok"
          # chai.should().equal "ok",c
          c.should.equal "ok"
          
  
  sw = require 'selenium-webdriver'
  driver = new sw.Builder()
    .withCapabilities(sw.Capabilities.chrome())
    .build()

  chai = require 'chai'
  chaiWebdriver = require 'chai-webdriver'
  chai.use chaiWebdriver(driver)

  driver.get "http://localhost:80"
  chai.expect("div").dom.to.contain.text("ok")
###






###
describe "tes", ->
  it "iiii", (done)->
    a.equal 1,2
    c.assert.equal 1,2
    done()
###

###
# 使っているスクリプト
console.log process.argv[0]
# 自分のファイルパス
console.log process.argv[1]
# 引数
console.log process.argv[2]
console.log process.argv[3]
console.log process.argv[4]
###


###
# EventEmitter3
EventEmitter = require('events').EventEmitter

asyncFunc = ->
  ev = new EventEmitter
  console.log 'in asyncFunc'
  ev.on 'ichi', (gospel,hoka)->
    console.log gospel
    hoka.emit "ni", "nidesu",hoka
  
  ev.once "ni",(desu, kore)->
    console.log desu
    kore.emit "ni", "aaaa", kore
  ev


sol = asyncFunc()
sol.emit 'ichi', "gooos",sol

del = asyncFunc()
del.emit 'ichi', "gooos",sol
###


###
# EventEmitter2
EventEmitter = require('events').EventEmitter


asyncFunc = ->
  ev = new EventEmitter
  console.log 'in asyncFunc'
  ev

async = asyncFunc()
async.on 'done', (arg1, arg2)->
  console.log arg1, arg2

async.on 'death', (gospel)->
  console.log gospel

setTimeout ->
  async.emit 'done', 'foo', 'bar'
, 1000
setTimeout ->
  async.emit 'death', "voooid"
, 2000
###


###
# EventEmitter1
EventEmitter = require('events').EventEmitter

asyncFunc = ->
  ev = new EventEmitter
  console.log 'in asyncFunc'
  setTimeout ->
    ev.emit 'done', 'foo', 'bar'
  , 1000
  setTimeout ->
    ev.emit 'death', "voooid"
  , 2000
  ev

async = asyncFunc()
async.on 'done', (arg1, arg2)->
  console.log arg1, arg2

async.on 'death', (gospel)->
  console.log gospel
###


###
# 非同期
http = require('http')
url = "http://localhost:1337"

f = (url)->
  http.get(url)


a = f(url)
a.on 'response',(i)->
  console.log i.statusCode
  console.log JSON.stringify( i.headers)
  
  i.setEncoding("utf8")
  i.on 'data', (c)->
    console.log c
###


###
# データパイプライン9(失敗)
stdt = new Date()
fs = require('fs')
firstFile = 'output.txt'
secondFile = 'result.txt'
readline = require('readline')

console.log "-- start --"

ws = fs.WriteStream firstFile

writeFile = (i,stm) ->
  stm.write(i.toString())

for i in [0..100000]
  writeFile(i,ws)

ws.end()

readFile =(name) ->
  r = fs.ReadStream(firstFile, {encoding:"utf-8"})
  return r

rs = readFile firstFile
bf = ""
rs.on "data",(d)->
  bf = bf + d

rs.on "close",->
  writeFile(bf,fs.WriteStream secondFile)

console.log "-- end --"
###


###
# counter
counter =->
  i = 0
  return -> ++i

c = counter()
###

###
# データパイプライン8 アクターモデル(失敗)
stdt = new Date()
fs = require('fs')
firstFile = 'output.txt'
secondFile = 'result.txt'
readline = require('readline')

console.log "-- start --"

# 書き込み
writeStart = (filename, message)->
  ws = fs.WriteStream filename
  ws.on "open", ->
    console.log "fopen"
    for i in [0..0]
      ws.write(message + i + "\n")
    ws.end()
  
  return ws

readStart = (filename) ->
  r = fs.ReadStream(firstFile, {encoding:"utf-8"})
  data = ""
  r.on "data", (d) -> 
    data = data.concat( treat2( d.toString() ) )
  
  return r


# ・加工
treat = (buffer)->
  console.log "treated!"
  return buffer.substr(5,5)

treat2 = (buffer)->
  console.log "treated2!"
  return buffer.toUpperCase()

# tmp削除
fileDelete = (filename) ->
  fs.unlinkSync(filename) if fs.existsSync(filename)

# fileDelete firstFile
# fileDelete secondFile

ws = writeStart firstFile, "amppo"
ws.on "close",->
  r = readStart firstFile
  r.on "close",-> 
    ss = writeStart secondFile, "sedonc"


console.log "-- end --"
###


###
# データパイプライン7 using風
stdt = new Date()
fs = require('fs')
firstFile = 'output.txt'
secondFile = 'result.txt'
readline = require('readline')

console.log "-- start --"
# ・加工
treat = (buffer)->
  console.log "treated!"
  return buffer.substr(5,5)

treat2 = (buffer)->
  console.log "treated2!"
  return buffer.toUpperCase()

# tmp削除
fileDelete = (filename) ->
  fs.unlinkSync(filename) if fs.existsSync(filename)

# fileDelete firstFile
# fileDelete secondFile


firstFileWs = fs.WriteStream(firstFile)
secondFileWs = fs.WriteStream(secondFile)

firstFileWs.on "open", ->
  console.log "1Ws:open"
  # console.log "testete"
  for i in [0..150000]
    firstFileWs.write("testete" + i + "\n")
    # console.log i
  firstFileWs.end()
  

firstFileWs.on "close", ->
  console.log "1Ws:close"
  # bufferString = ""
  
  fs.readFile(firstFile, "utf-8", (e,d)->
    console.log d.toString().length
    # bufferString = bufferString.concat( treat2( d.toString() ) )
    # bufferString = bufferString + treat2( d.toString() )
    secondFileWs.write(treat2( d.toString() ))
    secondFileWs.end()
  )
  

firstFileWs.on "end", -> console.log "1Ws:end"

secondFileWs.on "open", -> console.log "2Ws:open"
secondFileWs.on "end", -> console.log "2Ws:end"
secondFileWs.on "close", -> 
  console.log "2Ws:close"
  eddt = new Date()
  console.log(eddt - stdt)




console.log "-- end --"
###



###
# データパイプライン6
stdt = new Date()
fs = require('fs')
firstFile = 'output.txt'
secondFile = 'result.txt'
readline = require('readline')

console.log "-- start --"

firstFileWs = fs.WriteStream(firstFile)
secondFileWs = fs.WriteStream(secondFile)

firstFileWs.on "open", ->
  console.log "1Ws:open"
  # console.log "testete"
  for i in [0..150000]
    firstFileWs.write("testete" + i + "\n")
    # console.log i
  firstFileWs.end()
  

firstFileWs.on "close", ->
  console.log "1Ws:close"
  # bufferString = ""
  
  firstFileRs = fs.ReadStream(firstFile, {encoding:"utf-8"})
  firstFileRs.on "open", -> 
    console.log "1Rs:open"
  
  firstFileRs.on "data", (d) -> 
    console.log d.toString().length
    # bufferString = bufferString.concat( treat2( d.toString() ) )
    # bufferString = bufferString + treat2( d.toString() )
    secondFileWs.write(treat2( d.toString() ))
  
  firstFileRs.on "close", ->
    console.log "1Rs:close"
    # console.log bufferString
    # secondFileWs.write(bufferString)
    secondFileWs.end()
  
  firstFileRs.on "end", -> console.log "1Rs:end"



firstFileWs.on "end", -> console.log "1Ws:end"

secondFileWs.on "open", -> console.log "2Ws:open"
secondFileWs.on "end", -> console.log "2Ws:end"
secondFileWs.on "close", -> 
  console.log "2Ws:close"
  eddt = new Date()
  console.log(eddt - stdt)



# ・加工
treat = (buffer)->
  console.log "treated!"
  return buffer.substr(5,5)

treat2 = (buffer)->
  console.log "treated2!"
  return buffer.toUpperCase()

# tmp削除
fileDelete = (filename) ->
  fs.unlinkSync(filename) if fs.existsSync(filename)

# fileDelete firstFile
# fileDelete secondFile


console.log "-- end --"
###


###
# データパイプライン5 buffer作成(成功)
fs = require('fs')
firstFile = 'output.txt'
bufferString = ""
secondFile = 'result.txt'
readline = require('readline')

console.log "-- start --"

firstFileWs = fs.WriteStream(firstFile)
secondFileWs = fs.WriteStream(secondFile)

firstFileWs.on "open", ->
  console.log "1Ws:open"
  # console.log "testete"
  for i in [0..100000]
    firstFileWs.write("testete" + i + "\n")
    # console.log i
  firstFileWs.end()
  

firstFileWs.on "close", ->
  console.log "1Ws:close"
  
  firstFileRs = fs.ReadStream(firstFile, {encoding:"utf-8"})
  firstFileRs.on "open", -> 
    console.log "1Rs:open"
  
  firstFileRs.on "data", (d) -> 
    console.log d.toString().length
    bufferString = bufferString.concat( treat2( d.toString() ) )
  
  firstFileRs.on "close", ->
    console.log "1Rs:close"
    # console.log bufferString
    secondFileWs.write(bufferString)
    secondFileWs.end()
  
  firstFileRs.on "end", -> console.log "1Rs:end"



firstFileWs.on "end", -> console.log "1Ws:end"

secondFileWs.on "open", -> console.log "2Ws:open"
secondFileWs.on "end", -> console.log "2Ws:end"
secondFileWs.on "close", -> console.log "2Ws:close"



# ・加工
treat = (buffer)->
  console.log "treated!"
  return buffer.substr(5,5)

treat2 = (buffer)->
  console.log "treated2!"
  return buffer.toUpperCase()

# tmp削除
fileDelete = (filename) ->
  fs.unlinkSync(filename) if fs.existsSync(filename)

# fileDelete firstFile
# fileDelete secondFile


console.log "-- end --"
###



###
# データパイプライン4 フルオープン
fs = require('fs')
firstFile = 'output.txt'
secondFile = 'result.txt'
readline = require('readline')

console.log "-- start --"

# ・出力
firstFileWs = fs.WriteStream(firstFile)
secondFileWs = fs.WriteStream(secondFile)

# first Write
firstFileWs.on "open", ->
  console.log "firstFileWs:" + "open"
  for i in [0..100000]
    firstFileWs.write("message"+ i + "aaaa\n")
  
  firstFileRs = fs.ReadStream(firstFile, {encoding:"utf-8"})
  
  # first Read
  firstFileRs.on "open",->console.log "firstFileRs:open"
  firstFileRs.on "end",->
    console.log "firstFileRs:end"
  
  data = ""
  firstFileRs.on "data", (d)->
    console.log d
    data = data + d
    
  
  firstFileRs.on "close", ->
    console.log "firstFileRs:close"
    secondFileWs.write(treat2(data.toString()))
  


firstFileWs.on "close", ->
  console.log "firstFileWs:close"




firstFileWs.on "end", -> console.log "firstFileWs:end"


secondFileWs.on "open", -> console.log "secondFileWs:open"
secondFileWs.on "end", -> console.log "secondFileWs:end"
secondFileWs.on "close", -> console.log "secondFileWs:close"


# ・加工
treat = (buffer)->
  console.log "treated!"
  return buffer.substr(5,5)

treat2 = (buffer)->
  console.log "treated2!"
  return buffer.toUpperCase()

# tmp削除
fileDelete = (filename) ->
  fs.unlinkSync(filename) if fs.existsSync(filename)

# fileDelete firstFile
# fileDelete secondFile


console.log "-- end --"
###


###
# データパイプライン3 戻り値を返す
fs = require('fs')
firstFile = 'output.txt'
secondFile = 'result.txt'
readline = require('readline')

console.log "-- start --"

# ・出力
Output = (filename, message)->
  Ws = fs.WriteStream(filename)
  Ws.on("open", ->
    console.log "Oopen:" + message
    for i in [0..100]
      Ws.write(message + "\n")
    Ws.end()
  )
  Ws.on("drain", ->console.log "Odrain:" + message)
  Ws.on("end", ->console.log "Oend:" + message)
  Ws.on("close", ->
    console.log "Oclose:" + message
  )
  Ws.on("pipe", (s)->console.log "Opipe:" + s)
  
  return Ws

# ・入力
fileInput = (filename) ->
  stringBuffer = ""
  r = fs.FileReadStream(filename, {encoding:"utf-8"})
  r.on("open", (d)->console.log "iopen")
  r.on("data", (d)->
    # console.log d
    stringBuffer = d
  )
  r.on("end", ->console.log "iend")
  r.on("close", -> 
    console.log "iclose"
    # iclose(stringBuffer)
  )
  
  return r
  

# 入力終了時の処理
iclose = (stringBuffer) ->
  console.log "ic:"+stringBuffer
  # console.log treat(stringBuffer)
  treated = Output secondFile, treat2(treat(stringBuffer))
  treated.on("close",->
    console.log "LAZYLAZYfclose"
  )

# ・加工
treat = (buffer)->
  console.log "treated!"
  return buffer.substr(2,4)

treat2 = (buffer)->
  console.log "treated2!"
  return buffer.toUpperCase()

# tmp削除
fileDelete = (filename) ->
  fs.unlinkSync(filename) if fs.existsSync(filename)


# 遅延処理
firstRs = Output firstFile, "anokutara"
firstRs.on("close",->
  console.log "LAZYfclose"
)

Input = fileInput firstFile
stringBuffer = ""
Input.on("data", (d)-> 
  # console.log "LAZYdata:" + d
  stringBuffer = d
)
Input.on("close",->
  console.log "LAZYiclose"
  iclose(stringBuffer)
)




fileDelete firstFile
fileDelete secondFile

console.log "-- end --"
###


###
# データパイプライン2
fs = require('fs')
firstFile = 'output.txt'
secondFile = 'result.txt'
readline = require('readline')

console.log "-- start --"

# ・出力
Output = (filename, message)->
  Ws = fs.WriteStream(filename)
  Ws.on("open", ->console.log "Oopen:" + message)
  Ws.on("drain", ->console.log "Odrain:" + message)
  Ws.on("end", ->console.log "Oend:" + message)
  Ws.on("close", ->console.log "Oclose:" + message)
  Ws.on("pipe", (s)->console.log "Opipe:" + s)

  for i in [0..100000]
    Ws.write(message + "\n")
  Ws.end()

# ・入力
fileInput = (filename) ->
  stringBuffer = ""
  r = fs.FileReadStream(filename, {encoding:"utf-8"})
  r.on("open", (d)->console.log "iopen")
  r.on("data", (d)->
    # console.log d
    stringBuffer = d
  )
  r.on("end", ->console.log "iend")
  r.on("close", -> 
    console.log "iclose"
    iclose(stringBuffer)
  )
  

# 入力終了時の処理
iclose = (stringBuffer) ->
  # console.log stringBuffer
  # console.log treat(stringBuffer)
  Output secondFile, treat(stringBuffer)

# ・加工
treat = (buffer)->
  return buffer.substr(2,4)

# tmp削除
fileDelete = (filename) ->
  fs.unlinkSync(filename) if fs.existsSync(filename)


# 遅延処理
Output firstFile, "anokutara"
fileInput firstFile

fileDelete firstFile
# fileDelete secondFile

console.log "-- end --"
###



###
# データパイプライン
fs = require('fs')
firstFile = 'output.txt'
secondFile = 'result.txt'
readline = require('readline')

console.log "-- start --"

# ・初期出力
firstOutput = (filename, message)->
  firstWs = fs.WriteStream(filename)
  firstWs.on("open", ->console.log "fopen")
  firstWs.on("drain", ->console.log "fdrain")
  firstWs.on("close", ->console.log "fclose")
  firstWs.on("pipe", (s)->console.log s)

  for i in [0..0]
    firstWs.write(message + "\n")
  firstWs.end()

# 入力終了時の処理
iclose = (stringBuffer) ->
  console.log "iclose"
  console.log stringBuffer
  console.log treat(stringBuffer)
  firstOutput secondFile, treat(stringBuffer)

# stringBuffer
bufferWrite = ->
  stringBuffer = ""
  return (data) ->
    if data 
      stringBuffer = data
    else
      stringBuffer

# ・入力
fileInput = (filename) ->
  stringBuffer = ""
  r = fs.FileReadStream(filename, {encoding:"utf-8"})
  r.on("open", (d)->console.log "iopen")
  r.on("data", (d)->
    # console.log d
    stringBuffer = d
  )
  r.on("end", ->console.log "iend")
  r.on("close", -> iclose(stringBuffer) )
  

# ・加工
treat = (buffer)->
  return buffer.substr(2,4)

# ・二次出力
# 同じにすればよかった

# ・加工
# こっちも

# 遅延処理
firstOutput firstFile, "firsttext"
fileInput firstFile


# tmp削除
fileDelete = (filename) ->
  fs.unlinkSync(filename) if fs.existsSync(filename)


fileDelete firstFile
# fileDelete secondFile

console.log "-- end --"
###



###
console.log "Mstart"
fs = require('fs')
file = 'memo.txt'
readline = require('readline')

rs = fs.ReadStream(file)

rl = readline.createInterface({
  input: rs,
  output: {}
})

rl.on("pause",->console.log "pause")
rl.on("resume",->console.log "resume")
rl.on("line",(l)->console.log l)
rl.on("close",->console.log "close")

rl.resume()
# rl.close()


console.log "Mend"
###


###
# memograph再考
fs = require('fs')
file = 'memo.txt'
wf = "kaki.txt"

console.log "Mstart"

# readFile 非同期
fs.readFile(file, "utf-8", (e,d)->
  console.log d
)
# readFileSync 同期
console.log fs.readFileSync(file, "utf-8")

# createReadStream 非同期
r = fs.createReadStream(file, {encoding:"utf-8"})
r.on("open", (d)->console.log "open")
r.on("data", (d)->console.log d)
r.on("end", ->console.log "end")
r.on("close", ->console.log "close")

# ReadStream 非同期
r = fs.ReadStream(file, {encoding:"utf-8"})
r.on("open", (d)->console.log "open")
r.on("data", (d)->console.log d)
r.on("end", ->console.log "end")
r.on("close", ->console.log "close")

# FileReadStream
r = fs.FileReadStream(file, {encoding:"utf-8"})
r.on("open", (d)->console.log "open")
r.on("data", (d)->console.log d)
r.on("end", ->console.log "end")
r.on("close", ->console.log "close")

# writeFile 非同期
fs.writeFile(wf,"writeFile", (e)->console.log e)

# writeFileSync 同期
fs.writeFileSync(wf, "writeFileSync")

# createWriteStream
w = fs.createWriteStream(wf)
w.on("open", ->console.log "open")
w.on("drain", ->console.log "drain")
w.on("close", ->console.log "close")
w.on("pipe", (s)->console.log s)
w.write("death")
w.end()

# WriteStream
w = fs.WriteStream(wf)
w.on("open", ->console.log "open")
w.on("drain", ->console.log "drain")
w.on("close", ->console.log "close")
w.on("pipe", (s)->console.log s)
w.write("death")
w.end()

# FileWriteStream
w = fs.FileWriteStream(wf)
w.on("open", ->console.log "open")
w.on("drain", ->console.log "drain")
w.on("close", ->console.log "close")
w.on("pipe", (s)->console.log s)
w.write("death")
w.end()

# SyncWriteStream ?
w = fs.SyncWriteStream(wf)



console.log "Mend"
###



###
# 関数風us
_ = require "lodash"

console.log _.first([2,3,5,3], (x)->
  console.log x
  return x + x)
###


###
# us check
console.log "sdfd"
console.log _
_ = require "lodash"
# console.log _
console.log _.first([3,2,4])
"asf"
# console.log _
console.log _.first([3,2,4])
###

###
# 全部足す
data = [1,3,5,7,4,2]

# 一行で
console.log data.reduce((a,b)->a+b)
###


###
# 関数型風
plus = (a,b)->a+b

s = data.reduce(plus)
console.log s
###

###
# coffee風
s = 0
data.forEach (n) ->
  s = s + n

console.log s
###

###
# node風
s = 0
for n in data
  s = s + n

console.log s
###

###
# 手続風
s = 0
i = 0
while i < data.length
  s = s + data[i]
  i++

console.log s
###



###
# クロージャ
c = ->
  vvv = "asf"
  i = 0
  return ->
    console.log i
    i = i + 1

c.c = ->
  vvv = "cyenje"

d = c()
d()

c.c()

d()

d.c = ->
  vvv = "cyenje"

d.c()
d()
d()
d()
d()
###



###
# frp7
_ = require("lodash")
bulk = [1,3,5,6]

# 収集
data = (b) -> b

# 抽出(model)
extract = (d) -> d

# 加工 treat
treat = (t) -> t  + 2

# 出力 void(view)
output = (t) -> console.log t


c = _.compose(output)
c(bulk)
###

# bulk.map(data).output

# bulk.map(data).map(extract).map(treat).map(output)
# [2,4,6].map(data).map(extract).map(treat).map(output)

# bulk.data.extract.treat.output


###
# frp6 並べ替え
bulk = [1,3,5,6]

# 収集
data = (b) -> b

# 抽出(model)
extract = (d) -> d

# 加工 treat
treat = (t) -> t  + 2

# 出力 void(view)
output = (t) -> console.log t

bulk.map(data).map(extract).map(treat).map(output)
[2,4,6].map(data).map(extract).map(treat).map(output)
###


###
# frp6
# 出力 void(view)
output = (t) -> console.log t

# 加工 treat
treat = (t) -> t  + 2

# 抽出
extract = (d) -> d

# 収集
data = (b) -> b

bulk = [1,3,5,6]
bulk.map(data).map(extract).map(treat).map(output)

[2,4,6].map(data).map(extract).map(treat).map(output)
###


###
# FRP5
# 出力(view)
output = (t) -> console.log t

# 加工
treat = (e) -> output(e)

# 抽出
extract = (d) -> treat(d + 2)

# 収集
data = (b) -> extract(b)

bulk = [1,3,5,6]
bulk.map(data)

[2,4,6].map(data)
###



###
# FRP4
data=[]
datapush = (b) -> data.push(b)

bulk = [1,3,5,6]
bulk.map(-> datapush)



data.map(-> extract)

pone = (i) -> i+1

console.log data
console.log data.map(pone)
###


###
# FRP3
a = 1
b = -> a + 2
console.log a
console.log b()
a = 3
console.log b()
###


###
# FRP2
a = 1
b = a + 2
console.log a
console.log b
a = 3
console.log b
###


###
# FRP
data = [1,3,5,6]

pone = (i) -> i+1

console.log data
console.log data.map(pone)
###



###
# express2
require('coffee-script/register')
debug = require('debug')('expresstmp')
express = require("express")
path = require("path")
app = express()
app.set "view engine", "jade"

app.get '/', (req, res) ->
  # res.render('index', { title: 'kani' })
  res.send('Hell World!')


app.set('port', process.env.PORT || 3000)

server = app.listen(app.get('port'), ->
  debug('Express server listening on port ' + server.address().port)
)
###


###
# express
cont = (app) ->
  app.get '/', (req, res) -> res.send('Hell World!')

app = require('express')()
cont(app)
app.listen 3000
###



###
# インスタンスに動的にメソッド追加
str = new String("bbb")
str.fun = -> this.toString()

console.log str
console.log str.fun()
###



###
# 拡張メソッド
String.prototype.ichi=->this + "ichi"
String.prototype.ni=->this + "ni"
console.log "zero".ichi().ni()
###


###
fun = ->
  console.log("ffff")
  return "death"

module.exports.fun = fun
###



###
# 日付のみ抽出
fs = require('fs')
readline = require('readline')

rs = fs.ReadStream(__dirname + '/memo.txt')
ws = fs.WriteStream(__dirname + '/find.txt')

rl = readline.createInterface({
  input: rs,
  output: {}
})


reg = /^\d{4,4}\/\d{2,2}\/\d{2,2}\s\d{1,2}:\d{2,2}$/

i = 1
rl.on('line', (line)->
  # console.log( i++ + ': ' + line.trim() )
  # console.log( line.trim() )
  # console.log( reg.exec(line.trim())[0] ) if reg.test(line.trim())
  ws.write(reg.exec(line.trim())[0] + "\n") if reg.test(line.trim())
)

console.log("kaisi")
rl.resume()
console.log("owaari")
###



###
# 正規表現.test
reg = /^\d{4,4}\/\d{2,2}\/\d{2,2}\s\d{1,2}:\d{2,2}$/

txt1 = "2014/10/27 9:15"
txt2 = "2014/10/27 10:15"

if reg.test(txt1)
  console.log "1 find"
else
  console.log "1 nothing"

if reg.test(txt2)
  console.log "2 find"
else
  console.log "2 nothing"
###




###
f = require('fluent-logger-node')
l = f.createLogger()

l.post("fluentest", {hell: "jigoku!"})
###


###
# orchestrator
Orchestrator = require('orchestrator')
orchestrator = new Orchestrator

orchestrator.add('thing1', ->
  console.log "thingu1"
)
orchestrator.add('thing2', ->
  console.log "thingu2"
)

orchestrator.start('thing1', 'thing2', (err) ->
  console.log "alldone"
)
###



###
# render jade
http = require('http')
jade = require('jade')
fs = require("fs")

server = http.createServer((req, res)-> 
  res.writeHead(200, {"Content-Type":"text/html"})
  output = fs.readFileSync("./index.jade", "utf-8")
  res.end(jade.compile(output)())
).listen(process.env.VMC_APP_PORT || 3000)

socketio = require('socket.io')
io = socketio.listen(server)
io.sockets.on('connection', (soc) ->
  console.log 'con'
  soc.on('mes', (data)->
    console.log data
  )
)
###


###
# socket.io 2
http = require('http')
sio = require('socket.io')

server = http.createServer( (req, res) -> 
  res.writeHead( 200, {'Content-Type': 'text/html'} )
  res.end( '<html><head><script src="/socket.io/socket.io.js"></script></head>\n<body>socsoc\n</body></html>' )
)
.listen(3000)

io = sio.listen(server)

io.sockets.on('connection', (soc) ->
  console.log 'concon'
  console.log soc
  
  soc.on('mes', (data)->
    console.log data
  )
)


io.sockets.emit('mes', "sadf")
###



###
# exitするとlog出力されない
winston = require('winston')

winston.add(winston.transports.File, { filename: 'log.txt', json: false });
winston.info('あああ')
winston.warn('いいい')
winston.error('ううう')

process.exit()

fs = require('fs')
stream = fs.createWriteStream('delme.txt', { flags: 'a' })


process.on('uncaughtException', ->
  console.log "ueueue"
  stream.write('\n')
  stream.on('drain', ->
    # process.exit(1)
  )
)

console.log "somdomse"
stream.write('Something bad happened\n')
throw "eee"

console.log("end")
###




###
# 非同期getのコード取得4
async = require('async')
http = require('http')

stdt = new Date()

v = (c,callback)->
  setTimeout (->
    console.log c
    callback(null, "ccc")
  ), c * c
#  ), Math.floor(Math.random() * 2000 )

console.log v

# async.map([1000,2000,3000],v,(e,r)->
async.map([0..100],v,(e,r)->
  eddt = new Date()
  console.log r
  console.log(eddt - stdt)
)

console.log "done."

###





###
# 非同期getのコード取得3 NG
async = require('async')
http = require('http')

c = (i,callback) ->
    # 並行処理開始
    console.log "parallel" + i
    
    setTimeout( ()->
        # 処理の内部
        console.log i + "parallel done."
        callback("", i)
      , 1000)


arr = [1,2,3]
b = []
arr.forEach (i) ->
  b.push((callback) ->
    c(i,callback))

console.log b

async.parallel [
  b.forEach (f) ->
    console.log("asfsd")
    f()
], (err, results) ->
  throw err if err
  console.log "parallel all done. " + results
  return

console.log "done."
###


###
# 非同期getのコード取得2
async = require('async')
http = require('http')

c = (i,callback) ->
    # 並行処理開始
    console.log "parallel" + i
    
    setTimeout( ()->
        # 処理の内部
        console.log i + "parallel done."
        callback(null, i)
      , 1000)


async.parallel [
  (callback) ->
    c(1,callback)
  (callback) ->
    c(2,callback)
  (callback) ->
    c(3,callback)
], (err, results) ->
  throw err if err
  console.log "parallel all done. " + results
  return

console.log "done."
###


###
# 非同期getのコード取得
http = require('http')
url = "http://yahoo.co.jp"

f = (url)->(
  bi = null
  return http.get(url)
)

a = f(url)
console.log "kofrekore"
a.on('response',(i)->
  console.log "naika"
  console.log i.statusCode
)
###

###
# underscore
# _ = require('underscore')
# _ = require('lodash')

# underscore.js用共通データ
numbers = [1,2,3,4,5]
persons = [
  {
    name: "jonny"
    age: 24
    birth_month: 8
    gender: 0 # 0 : male, 1, female
  }
  {
    name: "paul"
    age: 52
    birth_month: 7
    gender: 1
  }
  {
    name: "under score"
    age: 32
    birth_month: 8
    gender: 0
  }
]

# arrays
console.log _.first([5, 4, 3, 2, 1])
console.log _.rest([5, 4, 3, 2, 1])
console.log _.rest([5, 4, 3, 2, 1], 3)
console.log _.last([5, 4, 3, 2, 1])
console.log _.compact([0, 1, false, 2, '', 3])
console.log _.flatten([1, [2], [3, [[[4]]]]])
console.log _.without([1, 2, 1, 0, 3, 1, 4], 0, 1)
console.log _.uniq([1, 2, 1, 3, 1, 4])
# console.log _.intersect([1, 2, 3], [101, 2, 1, 10], [2, 1]); できなかった
console.log _.indexOf([1, 2, 3], 2)
console.log _.lastIndexOf([1, 2, 3, 1, 2, 3], 2)
console.log _.range(0, 30, 5)

###


###
# ListDelete
arr = [1,2,3,6,7,677,6766,22,11,3,89,987]
console.log arr.indexOf(2) if arr.indexOf(2) != -1
console.log arr.indexOf(5) if arr.indexOf(5) != -1


f = (i,a,b)->
  console.log this
  i != this.ignore

r = arr.filter(f,{ignore: 3})

console.log arr
console.log r
###


###
# List操作
async = require('async')

arr = [1,2,3]
console.log Array.isArray(arr)

console.log("sync")
arr.forEach (i) ->
  console.log i


console.log("async")
async.each( arr, ((i,c)->
  console.log i
),(err)->
  throw err if err
  console.log "eerreeeooo"
)
###



###
# uriを抽出
url = "http://yahooo"

if url.match(/^http/)
  console.log("is url")
else
  console.log("is not url")

console.log("  sadlkfj  ".trim())
###

###
# ファイルに追記
fs = require('fs')

fs.appendFile('res.txt', "app\n")
###


###
# 同じファイルが存在していたら削除(同期)
fs = require('fs')

fs.unlinkSync('./log2.txt') if fs.existsSync('./log2.txt')

console.log("continue")
###



###
# readlineの利用
fs = require('fs')
readline = require('readline')

rs = fs.ReadStream('log.txt')

rl = readline.createInterface({
  input: rs,
  output: {}
})


i = 1
rl.on('line', (line)->
  console.log( i++ + ': ' + line.trim() )
)
console.log("kaisi")
rl.resume()
console.log("owaari")

# rl.close()
# console.log("close")
###


###
# ignoreファイルなどの読み込み

list = fs.readFileSync( './log.txt', 'utf8')
console.log list

lines = list.trim().split('\n')
console.log lines

for s in lines
  console.log s
###

###
# ログ追記スタイル 同期
fs = require('fs')

# fd = fs.openSync('./log.txt', 'a+')
fs.appendFileSync( './log2.txt' , 'kani\n' )
# fs.writeFileSync( './log2.txt' , 'kani\n' )
###


###
# ログ追記スタイル
fs = require('fs')

fs.open('./log.txt', 'a+', (err, fd)->
  if err
    console.log("hairanai")
    console.log(err)
    console.log(err.code)
  
  fs.write(fd, "beni\n", 0, "ascii")
  
  fd && fs.close(fd, (err)->
    console.log('append!')
    console.log(fd)
    
    console.log(err)
  )
)
###



###
# ファイル存在確認→existsはオワコンらしい
fs = require('fs')

# 読み込んで、なければエラー、など
fs.open('./log.txt', 'ax+', (err, fd)->
  if err
    console.log("exist!")
    console.log(err)
    console.log(err.code)
  
  fd && fs.close(fd, (err)->
    console.log('open')
    console.log(err)
  )
)
###


###
# 引数取得
console.log(process.argv)
console.log(process.argv[0])
console.log(process.argv[1])
console.log(process.argv[2]) # 引数
###


###
# log出力3(log)
Log = require('log')
fs = require('fs')
stream = fs.createWriteStream(__dirname + '/log.txt')

# log = new Log(Log.INFO)
log = new Log(Log.WARNING, stream);

log.debug('preparing email')
log.info('sending email')
log.error('failed to send email')

# 読み込み
stream = fs.createReadStream(__dirname + '/log.txt')
log = new Log(Log.DEBUG, stream);


log.on('line',(l)->
  console.log(l)
  console.log(l.date)
).on('end',->
  console.log('owari')
)
###


###
# log出力2(winston)
winston = require('winston')
logger = new (winston.Logger)({
  transports: [
    # 使う出力方法を transports で宣言する
    new (winston.transports.Console)({
      level: 'silly', # level は silly 以上
      colorize: true, # 色付き
      timestamp: true # 時間つき
    }),
    new (winston.transports.File)({
      level: 'silly', # level は silly 以上
      colorize: true, # 色付き
      timestamp: false, # 時間つき
      filename: 'log.txt',
      json: false
    })
  ]
})

logger.silly('ばかばかしいこと')
logger.debug('とてもどうでもいいこと')
logger.verbose('どうでもいいこと')
logger.info('じょうほう')
logger.warn('やばい')
logger.error('すごくやばい')
###


###
# log出力(winston)
winston = require('winston')

winston.add(winston.transports.File, { filename: 'log.txt', json: false });
winston.silly('ばかばかしいこと')
winston.debug('かいはつのこと')
winston.verbose('どうでもいいこと')
winston.info('じょうほう')
winston.warn('やばい')
winston.error('すごくやばい')
###



###
# 並行処理2
cluster = require("cluster")
cpuCount = require("os").cpus().length

# クラスタを利用して処理を分散（CPUの数だけ）
if cluster.isMaster
  # console.log('CPU: ' + cpuCount)
  # console.log('isMaster?: ' + cluster.isMaster)
  
  for i in [1..cpuCount]
    w = cluster.fork()
    w.on('message',(msg)->
      console.log('Mmsg:' + msg)
    )
    w.send('sensen')
  
  cluster.on('exit',(worker, code, signal)->
    console.log('worker_id:' + worker.id)
    # console.log('worker_pid:' + worker.process.pid)
    # console.log('code:' + code)
    # console.log('signal:' + signal)
  )
  
  
else
  console.log process.pid + " hell..."
  process.on('message',(msg)->
    console.log('Wmsg:' + msg)
    
    process.send(msg)
  )
  
  process.send("deathhh")
  #process.exit()
###




###
# 並行処理(cluster)
cluster = require("cluster")
cpuCount = require("os").cpus().length

# クラスタを利用して処理を分散（CPUの数だけ）
if cluster.isMaster
  console.log('CPU: ' + cpuCount)
  console.log('isMaster?: ' + cluster.isMaster)
  
  for i in [1..cpuCount]
    cluster.fork().send('sensen')
  
  cluster.on('message',(msg)->
    console.log('Mmsg:' + msg)
  )
  
  cluster.on('exit',(worker, code, signal)->
    console.log('worker_id:' + worker.id)
    console.log('worker_pid:' + worker.process.pid)
    console.log('code:' + code)
    console.log('signal:' + signal)
  )
  
else
  console.log "hell..."
  process.on('message',(msg)->
    console.log('Wmsg:' + msg)
    
    process.send(msg)
  )
  
  process.send("deathhh")
  process.exit()
###

###
# parse2
url = require('url')

ssl_check = (uri)->
  u = url.parse(uri)
  switch u.protocol
    when 'http:'
      console.log("http")
    when 'https:'
      console.log("https")
    else
      console.log("other")

ssl_check("http://www.yahoo.co.jp")
ssl_check("https://www.youtube.com/")
ssl_check("ftp://www.youtube.com/")
###

###
# parse
url = require('url')

ssl_check = (uri)->
  u = url.parse(uri)
  if u.protocol == "http:" 
    console.log("http")
  else
    console.log("https")

ssl_check("http://www.yahoo.co.jp")
ssl_check("https://www.youtube.com/")
###


###
# https通信 レスポンス取得
http = require('https')

http.get("https://www.youtube.com/",(res)->
  console.log(res.statusCode)
  location = res.headers["location"]
  console.log(location)
  body = ''
  res.on('data', (c)->
    body += c
  )
  
  res.on('end',(res)->
    console.log(body)
  )
  console.log("test")
)
###

###
# body取得
http = require('http')

http.get("http://yahoo.co.jp",(res)->
  console.log(res.statusCode)
  location = res.headers["location"]
  console.log(location)
  http.get(location,(res)->
    console.log(res.statusCode)
    body = ''
    res.on('data', (c)->
      body += c
    )
    
    res.on('end',(res)->
      console.log(body)
    )
    console.log("test")
  )
)
###

###
# http通信 レスポンス取得2
http = require('http')
# optional = require('./lib/optional')
# https = optional('https')

http.get("http://yahoo.co.jp",(res)->
  console.log(res.statusCode)
  location = res.headers["location"]
  console.log(location)
  http.get(location,(res)->
    console.log(res.statusCode)
    location = res.headers["location"]
    console.log(location)
  )
)
###


###
# ステータスコード一覧
a = "4"
o = require('http').STATUS_CODES

console.log(o)

for k in o
  if !a || !k.indexOf(a) || o[k].indexOf(a) > -1
    console.log(k, o[k])

# console.log process.argv
###

###
# http通信 レスポンス取得1
http = require('http')
url = "http://yahoo.co.jp"
http.get((url),(res)->
  body = ''
  res.on('data', (c)->
    body += c
  )
  
  res.on('end',(res)->
    ret = body
    console.log(ret)
  )
  console.log("test")
)
###

###
# nodeストップウォッチ
# require('date-utils')

HeavySleep = (T) ->
  d1 = new Date().getTime()
  d2 = new Date().getTime()
  # T秒待つ 
  d2 = new Date().getTime()  while d2 < d1 + 1000 * T

stdt = new Date()
HeavySleep 3
eddt = new Date()
console.log(eddt - stdt)
###

###
# coffeeの状態で
hoka = require("./gaibu")

# hoka.soto()

console.log hoka
ho = new hoka("namae")
console.log ho.name
console.log ho.pubFun()
###



###
# module.exports = 
hoka = require("./gaibu.js")
hoka.soto()

console.log hoka
ho = new hoka("namae")
console.log ho.name
console.log ho.pubFun()
###



###
# socket.io
http = require('http')
io = require('socket.io')
fs = require("fs")

server = http.createServer((req, res)-> 
  res.writeHead(200, {"Content-Type":"text/html"});
  output = fs.readFileSync("./index.html", "utf-8");
  res.end(output);
).listen(process.env.VMC_APP_PORT || 3000);

listen = io.listen(server);

listen.sockets.on("connection", (socket)->
  # メッセージ送信（送信者にも送られる）
  socket.on("C_to_S_message", (data)->
    listen.sockets.emit("S_to_C_message", {value:data.value})
  )
  
  # ブロードキャスト（送信者以外の全員に送信）
  socket.on("C_to_S_broadcast", (data)->
    socket.broadcast.emit("S_to_C_message", {value:data.value})
  )
 
  # 切断したときに送信
  socket.on("disconnect", ->
    # listen.sockets.emit("S_to_C_message", {value:"user disconnected"});
  );
);
###


###
# 例外処理
try
  console.log("try")
  throw("morenmore")
  th = throw("anoutar")
  th()
  a()
catch e
  console.log("catch")
  console.log(e)
finally
  console.log("final")
###


###
# 受け手がいないと配列を返さない
t=10
while t-=1
  t*2
###

###
# whileは配列を返す
f = ->
  t = 10
  while t-=1
    t*2

console.log(f())
###


###
# while
c=0
while c < 5
  ++c
  console.log(c)

c=0
(++c;console.log(c)) while c < 5
###


###
# switch文
val = "c"
switch val
  when "a","b"
    console.log "kase"
  else
    console.log "nothing"
###


###
# 三項演算子は存在しない
a = if b? then 1 else 2
console.log a
###



###
# アクセス演算子
a?.undi()
###



###
# 存在演算子
if a?
  console.log "a is"
else
  console.log "a noching"

b = "anokutara"
console.log a ? b

a="death"
if a?
  console.log "a is"
else
  console.log "a noching"

console.log a ? b
###

###
# 改行できないパターン
for food in ['toast', 'cheese', 'wine'] 
  when food is 'cheese'
  console.log(food)

for food 
  in ['toast', 'cheese', 'wine'] when food is 'cheese'
  console.log(food)
###

###
# イテレーションと改行
console.log item for item in ["wata","chiha","bai"]

for item in ["wata","chiha","bai"]
  console.log item
###


###
# ハッシュの条件付き
hash = {"key1": "value1", "key2": "value2"}
 
for key, val of hash when key is "key1"
  console.log "key = #{key}, value = #{val}"
###

###
# keyのみ
for key of {"key1": "value1", "key2": "value2"}
  console.log key
###


###
# ハッシュ
for key, val of {"key1": "value1", "key2": "value2"}
  console.log "key = #{key}, value = #{val}"
###

###
# 条件付き
eat = (food) ->
  console.log "eat " + food

for food in ['toast', 'cheese', 'wine'] when food is 'toast' or food is 'cheese'
  eat(food)
###


###
# インデックス付き
eat = (food) ->
  console.log "eat " + food
 
evaluate = (food) ->
  console.log food + " is very delicious."
 
for food, i in ['toast', 'cheese', 'wine']
  console.log "looping #{i} times"
  eat(food)
  evaluate(food)
###


###
eat = (food) ->
  console.log "eat " + food
 
evaluate = (food) ->
  console.log food + " is very delicious."

for food in ['toast', 'cheese', 'wine']
  eat(food)
  evaluate(food)
###

###
# 配列
arrl=(item) ->
  console.log "at:" + item

arrl(i) for i in ["asdxfs", "bad", "c"]
###

###
# nextTickの順番
process.nextTick ->
  setTimeout ->
    console.log "4"
  ,0
  process.nextTick -> console.log "3"
  console.log "2"
console.log "1"
###

###
# イベントループ
http = require('http')
server = http.createServer((req,res) ->
  res.writeHead( 200, {'Content-Type': 'text/plain'} )
  res.end( 'イベントループ\n' )

  # console.log(res)
  # console.log(req)
  server.close()
)

server.listen(1337)
###


###
# Clusterの利用
cluster = require("cluster")
cpuCount = require("os").cpus().length

HeavySleep = (T) ->
  d1 = new Date().getTime()
  d2 = new Date().getTime()
  # T秒待つ 
  d2 = new Date().getTime()  while d2 < d1 + 1000 * T

# クラスタを利用して処理を分散（CPUの数だけ）
if cluster.isMaster
  console.log cpuCount
  console.log cluster.isMaster
  i = 0

  while i < cpuCount
    cluster.fork()
    i += 1
else
  console.log "imamade"
  HeavySleep 10
  console.log "hell..."
  process.exit()
###



###
# 並列化試験2
HeavySleep = (T) ->
  d1 = new Date().getTime()
  d2 = new Date().getTime()
  # T秒待つ 
  d2 = new Date().getTime()  while d2 < d1 + 1000 * T

async = require("async")
console.log "start"

async.parallel [
  (callback) ->
    console.log "wait1"
    setTimeout (->
      console.log "parallel 1 done."
      HeavySleep 10
      callback(null, 1)
    ), 1000
  (callback) ->
    console.log "wait2"
    setTimeout (->
      console.log "parallel 2 done."
      HeavySleep 10
      callback(null, 2)
    ), 1000
  (callback) ->
    console.log "wait3"
    setTimeout (->
      console.log "parallel 3 done."
      HeavySleep 10
      callback(null, 3)
    ), 1000
], (err, result) ->
  throw err if err
  console.log "all done." + result

console.log "end"
###



###
n=5
for i in [0..n-1] by 1
  for j in [i+1..n-1] by 1
    console.log i, j, n
###

###
n=5
for i in [0..n-1]
  for j in [i+1..n-1]
    console.log i, j, n
###


###
# 要素のスキップ
numbers = [0..30]

for number in numbers by 5
  console.log number
###


###
# switch
targetName = "World"

# 結果は hell
switch targetName
  when 'World' then console.log 'hell'
  when 'under' then console.log 'rondo'
  else console.log 'Cant find'
###


###
# loop
count = 0
loop
  if ++count >= 15
    break
console.log count
###

###
# until
count = 0
count++ until count >= 10
console.log count
###

###
# while
count = 0
while count < 15
 count++

console.log count
###

###
# for in
arrs = ["tsafi", "masdya", "ydeathzu"]

for item in arrs
  console.log item
###

###
# ヒアドキュメント
name = "world"
console.log "hell #{name}"

sentence = """
複数の行で
文字列を書いている私は
the #{name}
"""
console.log(sentence)
###

###
# 並列処理確認 -> not 並行
async = require("async")
async.parallel [
  (callback) ->
    console.log "parallel 1"
    setTimeout (->
      count1 = 0
      while count1 < 1000 * 1000 * 1000 * 1
        count1++
      console.log "parallel 1 done."
      callback(null, 1)
    ), 500
  (callback) ->
    console.log "parallel 2"
    setTimeout (->
      count2 = 0
      while count2 < 1000 * 1000 * 1000 * 1
        count2++
      console.log "parallel 2 done."
      callback(null, 2)
    ), 300
  (callback) ->
    console.log "parallel 3"
    setTimeout (->
      count3 = 0
      while count3 < 1000 * 1000 * 1000 * 1
        count3++
      console.log "parallel 3 done."
      callback(null, 3)
    ), 100
], (err, results) ->
  throw err if err
  console.log "parallel all done. " + results
  return

console.log "done."
###



###
# async.jsによるフロー制御
async = require("async")

# 前の関数から引数を受け取ることができる
async.waterfall [
  (callback) ->
    console.log "waterfall 1"
    setTimeout (->
      console.log "waterfall 1 done."
      callback(null, 1)
    ), 500
  (arg, callback) ->
    console.log "waterfall 2"
    setTimeout (->
      console.log "waterfall 2 done."
      callback(null, arg + 1)
    ), 300
  (arg, callback) ->
    console.log "waterfall 3"
    setTimeout (->
      console.log "waterfall 3 done."
      callback(null, arg + 1)
    ), 100
], (err, result) ->
  throw err if err
  console.log "waterfall all done." + result


# 順番に実行。callbackが呼ばれると次が呼ばれる
async.series [
  (callback) ->
    console.log "series 1"
    setTimeout (->
      console.log "series 1 done."
      callback(null, 1)
    ), 500
  (callback) ->
    console.log "series 2"
    setTimeout (->
      console.log "series 2 done."
      callback(null, 2)
    ), 300
  (callback) ->
    console.log "series 3"
    setTimeout (->
      console.log "series 3 done."
      callback(null, 3)
    ), 100
], (err, results) ->
  throw err if err
  console.log "series all done. " + results


# 渡されたものを平行で走らせる
async.parallel [
  (callback) ->
    console.log "parallel 1"
    setTimeout (->
      console.log "parallel 1 done."
      callback(null, 1)
    ), 500
  (callback) ->
    console.log "parallel 2"
    setTimeout (->
      console.log "parallel 2 done."
      callback(null, 2)
    ), 300
  (callback) ->
    console.log "parallel 3"
    setTimeout (->
      console.log "parallel 3 done."
      callback(null, 3)
    ), 100
], (err, results) ->
  throw err if err
  console.log "parallel all done. " + results
  return

console.log "done."
###




###
# nodejsが見るパス。これに加えてNODE_PATHを見に行く。
global.module.paths
###

###
# オブジェクトからjsonへ変換テスト
obj = 
  ary:[0,1,2],
  obj:
    a:0,
    b:1,
    c:2

str = JSON.stringify(obj);

# テスト出力
console.log(str);

###



###
# jsonからオブジェクトへ変換テスト
str = '{"ary":[0,1,2],"obj":{"a":0,"b":1,"c":2}}';
obj = JSON.parse(str);

# テスト出力
console.log(obj.ary);
console.log(obj.obj);
###



###
# compileするようにした
console.log("hell world");
###

###
# もっともシンプルなhttpサーバー
http = require('http')

http.createServer( (req, res) -> 
  res.writeHead( 200, {'Content-Type': 'text/plain'} )
  res.end( '地獄世界\n' )
)
.listen(1337, "127.0.0.1")

console.log('Server running at http://127.0.0.1:1337/')
###


###
# 常に基数を関数に渡す
console.log parseInt('010') is 8
console.log parseInt('010') is 10

console.log parseInt('010',8) is 8
console.log parseInt('010',8) is 10
###

###
# やってはいけません
model = eval(modelName)

# 代わりに角括弧を使いましょう
model = window[modelName]
###



###
# 自動的に..になる
console.log (5).toString();
console.log 5.toString()
#console.log 5..toString();
###


###
console.log "空配列"   unless [].length
console.log "空文字列" unless ""
console.log "数値の0"  unless 0

# 空文字はnullとは等しくない
console.log "これは呼ばれない" unless ""?
console.log "これは呼ばれる" unless ""
###

###
# すべてfalse
console.log ""        == "0"
console.log 0         == ""
console.log 0         == "0"
console.log false     == "false"
console.log false     == "0"
console.log false     == undefined
console.log false     == null
console.log null      == undefined
console.log " \t\r\n" == 0
###

###
# 関数をすぐに実行する
type = do ->
  classToType = {}
  for name in "Boolean Number String Function Array Date RegExp Undefined Null".split(" ")
    classToType["[object " + name + "]"] = name.toLowerCase()
  
  # 関数を返す
  (obj) ->
    strType = Object::toString.call(obj)
    classToType[strType] or "object"

console.log type("asdf")
console.log type(12)
###


###
# 外部ライブラリの使用
$ = jQuery
$ ->
  $(".el").click ->
    alert("Clicked!")
###

###
# AND/OR
console.log string = "migrating coconuts"
console.log string == string # true
console.log string is string # true

# hashがfalse(0,"",null)なら代入
hash = null # 初期化しないとエラーっぽい
hash or= {}

# 存在確認演算子(hashがundefined、nullなら代入)
hash ?= {}
###


###
# 複数の引数(と、インターセプト)
Log =
  logPrefix: "(App)"
  
  log: (args...) ->
    args.unshift(@logPrefix) if @logPrefix
    console?.log(args...)

Log.log "asdf","asfb","sdfc"
###


###
# プロパティの繰り返し
object = {one: 1, two: 2}
console.log("#{key} = #{value}") for key, value of object
###



###
# 配列の中に値があるかを確認
array = ["adsfd","bdf","cdr"]
included = "test" in array

# 裏側ではCoffeeScriptは配列の中に値があるかを確認するのにArray.prototype.indexOf()を使用
# そしてもし必要ならその代替を利用しています。
# 残念なことですがこれは同じinという文法が文字列に対しては動作しない。
# indexOf()を使う方法に戻って、結果が-1でないか確認します。

included = "a long test string".indexOf("test") isnt -1

# またはより良い方法として、ビット演算をハイジャックして-1との比較をしなくてもすむようにします

string   = "a long test string"
included = !!~ string.indexOf "test"
###



###
# 最小、最大(スプラットをつける)
console.log Math.max [14, 35, -7, 46, 98]...
console.log Math.min [14, 35, -7, 46, 98]...
###



###
# filter
array = ["adsfd","bdf","cdr"]
result = (item for item in array when item.name is "test")

passed = []
failed = []
(if score > 60 then passed else failed).push score for score in [49, 58, 76, 82, 88, 90]

# または
scores = [49, 58, 76, 82, 88, 90]
passed = (score for score in scores when score > 60)

# もし内包表記が長すぎる場合には複数行に分けることが可能です。
passed = []
failed = []
for score in [49, 58, 76, 82, 88, 90]
  (if score > 60 then passed else failed).push score
###



###
array = ["ithi","nii","sann"]

# map()と同じ処理
result = (item for item in array)
console.log result

# 配列にならない(普通のeach)
result = item for item in array
console.log result
###


###
# クラス拡張
moduleKeywords = ['extended', 'included']

class Module
  @extend: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @[key] = value

    obj.extended?.apply(@)
    this

  @include: (obj) ->
    for key, value of obj when key not in moduleKeywords
      # Assign properties to the prototype
      @::[key] = value

    obj.included?.apply(@)
    this

classProperties = 
  find: (id) ->
  create: (attrs) ->

instanceProperties =
  save: -> 

class User extends Module
  @extend classProperties
  @include instanceProperties

# Usage:
user = User.find(1)

user = new User
user.save()

# 静的、インスタンスプロパティを適用するプロセスはショートカット可能
ORM = 
  find: (id) ->
  create: (attrs) ->
  extended: ->
    @include
      save: -> 

class User extends Module
  @extend ORM
###



###
# ミックスイン
class Animal
  constructor: (@name) ->

class Parrot extends Animal

Animal::rip = true

parrot = new Parrot("Macaw")

extend = (obj, mixin) ->
  obj[name] = method for name, method of mixin
  obj

include = (klass, mixin) ->
  extend klass.prototype, mixin

# Usage
include Parrot,
  isDeceased: true

(new Parrot).isDeceased
###


###
# class拡張
moduleKeywords = ['extended', 'included']

class Module
  @extend: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @[key] = value
    
    obj.extended?.apply(@)
    this
    
  @include: (obj) ->
    for key, value of obj when key not in moduleKeywords
      # Assign properties to the prototype
      @::[key] = value
    
    obj.included?.apply(@)
    this
###


###
# ミックスイン
extend = (obj, mixin) ->
  obj[name] = method for name, method of mixin
  obj

include = (klass, mixin) ->
  extend klass.prototype, mixin

# Usage
include Parrot,
  isDeceased: true

(new Parrot).isDeceased
###

###
# 継承
class Animal
  constructor: (@name) ->

  alive: ->
    false

class Parrot extends Animal
  constructor: ->
    super("Parrot")

  dead: ->
    not @alive()

p = new Parrot
console.log p.dead()
###


###
# 静的プロパティ
class Animal
  @find = (name) ->

console.log Animal.find("Parrot")
###

###
# イベントコールバック
class Animal
  price: 5

  sell: =>
    console.log "#{@price}シリングになります!"

animal = new Animal
animal.sell()
###


###
# インスタンスプロパティ
class Customer

class Animal
  price: 5

  sell: (customer) ->

animal = new Animal
animal.sell(new Customer)
console.log animal.price
###


###
# class
class Animal
  constructor: (@name) ->
    #@name = name

animal = new Animal "asdf"
console.log "Animal is a #{animal.name}"
###


###
#southern = 33
velocity = southern ? 40
console.log velocity
###


###
aa = 44 
if aa
  console.log aa

# 後置のifが使える
aa if console.log aa

# 1行でif else も書ける
if aa == 44 then console.log "if" else console.log "else"
if aa == 22 then console.log "if" else console.log "else"

# 値の有無(null,undefined以外なら真) nil?と同様
console.log "aaari" if aa?
console.log "bbari" if bb?
###


###
# これでなんとかできた
couchbase = require "couchbase"
couchbase.connect({"hosts":["localhost:8091"],"user":"suzuki","password":"suzuki","bucket":"default"}, (err,rb)-> rb.get("Aaron0",(e,d,m)-> console.log e+d+m.id))
###



###
# インデントでネスト
obj=
  name: "namae"
  daini: "nibanme"

{name, daini}=obj
console.log name
console.log daini
console.log obj

###


###
# コメント
#sys.puts:文字列だけを対象としている
#console.log:Array、JSON、JSObject などの複雑なオブジェクトも表示できる
num = 1
nem = 3
console.log num + nem

sys = require 'sys'
sys.puts 'ああああ'
###




