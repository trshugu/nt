###
###
console.time "tmp"
# console.timeEnd "tmp"







###
# 配列 distinct
a=[]
a.push "aa"
a.push "aa"
a.push "aa"
a.push "bb"
a.push "cc"
a.push "aa"
a.push "bb"


# 重複を削除
console.log a.filter (x, i, self)-> self.indexOf(x) == i

# 重複のみをリスト
console.log a.filter (x, i, self)-> self.indexOf(x) != self.lastIndexOf(x)

# 重複を検出したものを重複しないでリスト
console.log a.filter (x, i, self)-> self.indexOf(x) == i and i != self.lastIndexOf(x)
###






###
# promise map の中身がなかった場合の挙動
# li = [1,2,3]
# li = []
li = ""
Promise.all [
  new Promise (g)->
    Promise.all li.map (i)->
      new Promise (f)->
        f i + 10
    .then (v)->
      console.log "c"
      g v
]
.then (v)->
  console.log "a"
  console.log v
.catch (e)->
  # listでなかった場合catchしないと止まる
  console.log "b"
  console.log e
###



###
# test facroty
[1..20].forEach (i)->
  s = String("0" + i).slice(-2)
  
  [1..8].forEach (j)->
    b = String("0" + j).slice(-2)
    
    [1..5].forEach (k)->
      p = String("0" + k).slice(-2)
      
      console.log s, b, p
      
###


###
# オブジェクト同士の結合
ao = {}
ao["id"] = S :"iuiui"

bo = {}
bo.noi = S: "asdf"
bo.noimoi = S: "fefefa"
bo.noimoidoi = S: "ei3ij"

Object.keys(bo).forEach (k)->
  ao[k] = bo[k]

console.log ao
###


###
# 配列を特定の個数に合わせる
arr = ["a","s","d","f","g","h","j"] # 7
arr = ["a","s","d","f","g","h","j","k","l","z"] # 10
arr = []
con = ["q","w","e","r","t","y","u","i","o"]

arr = arr.concat con.splice(0, 10 - arr.length)


console.log arr
console.log arr.length
###

###
# 同期的forEach2
list = [1,2,3,4,5,6,7,8,9,10]
sent = ""

Promise.all list.map (i)->
  new Promise (f,r)->
    setTimeout ->
      sent += 'hello world: ' + i + '\n'
      f()
    ,1000
.then (v)->
  require('fs').writeFile 'hello.txt', sent, (err)->
    throw err if(err)
.catch (err)->
  throw err if(err)
###

###
# 同期的forEach
list = [1,2,3,4,5,6,7,8,9,10]

sent = ""
require('async').each list, (i, cb)->
    setTimeout ->
      sent += 'hello world: ' + i + '\n'
      cb()
    , 5000

, (err)->
  throw err if(err)
  require('fs').writeFile 'hello.txt', sent, (err)->
    throw err if(err)
###


###
# 同期的forEach NGなパターン
a = [1,2,3,4,5,6,7,8,9,10]
sent = ""

a.forEach (i)->
  setTimeout ->
    sent += 'hello world: ' + i + '¥n'
  , 5000

require("fs").writeFile 'hello.txt', sent, (err)->
  throw err if(err) 
###



###
# redisにDBを展開2
# メモリ展開が遅い
strage = "strage"

getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

# 展開したデータをスキャン
redis_get = (id, cb)->
  redis = require "redis"
  cli = redis.createClient()
  
  cli.get id, (e,d)->
    if e?
      console.log e
    else
      # console.log d
      cli.end()
      cb JSON.parse d

# redis_get "000130db34c733db4e0130ab87b38c657cb72e6dcef74f3f5792739ab4897e6", (d)->
#   console.log d

redis_scan = (cb)->
  redis = require "redis"
  cli = redis.createClient()
  
  cli.keys "0000*", (e,d)->
    if e?
      console.log e
    else
      cli.end()
      cb d

# redis_scan (d)->
#   console.log d

# scanによるview作成
writeView = (list, cb, getData = [])->
  if list.length != 0
    target = list.shift()
    redis_get target, (d)->
      getData.push d
      writeView list, cb, getData
  else
    cb getData

createView = ->
  redis_scan (d)->
    writeView d, (getList)->
      require("fs").writeFile "view.json", JSON.stringify(getList), (e)->
        if e?
          console.log e

# createView()

# さらにviewのデータを取得
getView = (cb)->
  require("fs").readFile "view.json", (e,d)->
    if e?
      console.log e
    else
      cb JSON.parse d

# getView (j)->
#   console.log j.map((i)-> i._id)

###




###

# ファイル全スキャン&メモリ展開
get = (id, cb)->
  require("fs").readFile strage + "/" + id, (e,d)->
    j = JSON.parse d
    cb j

getItem = (list, cb, getData = [])->
  if list.length != 0
    target = list.shift()
    get target, (d)->
      getData.push d
      getItem list, cb, getData
  else
    cb getData

scan = (cb)->
  require("fs").readdir strage, (e, f)->
    getItem f, (d)->
      cb d


setter = (dataList, cb)->
  if dataList.length !=0
    target = dataList.shift()
    cli.set target._id, JSON.stringify(target), (e,d)->
      if e?
        console.log e
      else
        # console.log d
        setter dataList, cb
  else
    cli.end()
    cb "done"

redis = require "redis"
cli = redis.createClient()

scan (d)->
  setter d, (done)->
    console.log "setterend"
    console.timeEnd "tmp"


# strage大量作成
put = (o, cb)->
  data = o
  hash = getHash()
  data["_id"] = hash
  require("fs").writeFile strage + "/" + hash, JSON.stringify(data), (e)->
    if e?
      console.log e
    
    cb()


i = 0
serial = ->
  # console.log "done"
  if i < 5000000
    i = i + 1
    put zaiko: i, ->
      serial()
  else
    # console.log "end"
    console.timeEnd "tmp"

# serial()
###








###
# redisにDBを展開
strage = "strage"

getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

# 展開したデータをスキャン
redis_get = (id, cb)->
  redis = require "redis"
  cli = redis.createClient()
  
  cli.get id, (e,d)->
    if e?
      console.log e
    else
      # console.log d
      cli.end()
      cb JSON.parse d

# redis_get "4b86ed6b1b22d183885a4a37ce8dffcf33335ea8584e0a3333dc9fb26ecd28a5", (d)->
#   console.log d.zaiko

redis_scan = (cb)->
  redis = require "redis"
  cli = redis.createClient()
  
  cli.keys "pre_25*", (e,d)->
    if e?
      console.log e
    else
      cli.end()
      cb d

# redis_scan (d)->
#   console.log d.filter((i)-> i=="pre_259").map((i)->i.toUpperCase())



# ファイル全スキャン&メモリ展開
get = (id, cb)->
  require("fs").readFile strage + "/" + id, (e,d)->
    j = JSON.parse d
    cb j

getItem = (list, cb, getData = [])->
  if list.length != 0
    target = list.shift()
    get target, (d)->
      getData.push d
      getItem list, cb, getData
  else
    cb getData

scan = (cb)->
  require("fs").readdir strage, (e, f)->
    getItem f, (d)->
      cb d


setter = (dataList, cb)->
  if dataList.length !=0
    target = dataList.shift()
    cli.set target._id, JSON.stringify(target), (e,d)->
      if e?
        console.log e
      else
        # console.log d
        setter dataList, cb
  else
    cli.end()
    cb "done"

# redis = require "redis"
# cli = redis.createClient()

# scan (d)->
#   setter d, (done)->
#     console.log "setterend"
#     console.timeEnd "tmp"


# strage大量作成
put = (o, cb)->
  data = o
  hash = getHash()
  data["_id"] = hash
  require("fs").writeFile strage + "/" + hash, JSON.stringify(data), (e)->
    if e?
      console.log e
    
    cb()


i = 0
serial = ->
  # console.log "done"
  if i < 10
    i = i + 1
    put zaiko: i, ->
      serial()
  else
    # console.log "end"
    console.timeEnd "tmp"

# serial()
###




###
# redisメモリ容量確認
redis = require "redis"
cli = redis.createClient()

cli.on "ready", ->
  # console.log cli.server_info
  console.log cli.server_info.used_memory
  console.log cli.server_info.used_memory_peak
  cli.end()
###



###
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

redis = require "redis"
cli = redis.createClient()

setter = (i, cb)->
  # console.log "kok"
  cli.set i, getHash(), (e,d)->
    if e?
      console.log e
    else
      # console.log d
    
    cb()

serial = (i, j)->
  # console.log "s", i
  if i < j
    i = i + 1
    console.log i if i % 10000 == 0
    setter "pre_" + i, ->
      serial i, j
  else
    # console.log "end"
    console.timeEnd "tmp"
    cli.end()

# serial(0, 1000 * 20)

[0...1000000].forEach (i)->
  setter "pre2_" + getHash(), ->
    if i % 100000 == 0
      console.log i
      console.timeEnd "tmp"
###


###
[0...100].forEach (i)->
  cli.set i, i + getHash(), (e,d)->
    if e?
      console.log e
    else
      console.log d
###




###
# redis再考
redis = require "redis"
cli = redis.createClient()

set = ->
  cli.set "nanika", "nakami", (e,d)->
    if e?
      console.log e
    else
      console.log d
      console.log "getiku"
      get()

get = ->
  cli.get "nanika", (e,d)->
    if e?
      console.log e
    else
      console.log d
      cli.end()
set()

# cli.end()
###

###
tab = "asds\tdfa"
console.log tab
trim = tab.replace(/\t/g, "")
console.log trim
###



###
# 実質的なデータストアの運用
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

strage = "strage"

checkDirectory = (dir, cb)->
  require("fs").stat dir, (e,s)->
    if e?
      # console.log e
      cb true
    else
      cb s.isDirectory() != true

get = (id, cb)->
  require("fs").readFile strage + "/" + id, (e,d)->
    j = JSON.parse d
    cb j

# get "cd3dc0fe27db34186e6cc9dfb72cfd0f7715205a32390fd1a2cc3b5fc3e99cf6", (d)->
#   console.log d

getItem = (list, cb, getData = [])->
  if list.length != 0
    target = list.shift()
    get target, (d)->
      getData.push d
      getItem list, cb, getData
  else
    cb getData

scan = (cb)->
  require("fs").readdir strage, (e,f)->
    getItem f, (d)->
      cb d

# scan (d)->
#   console.log d



# putみなおし
put = (o, cb)->
  data = o
  hash = getHash()
  data["_id"] = hash
  require("fs").writeFile strage + "/" + hash, JSON.stringify(data), (e)->
    if e?
      console.log e
    
    cb()


i = 0
lili = ->
  # console.log "done"
  if i < 10000
    i = i + 1
    put zai: i, ->
      lili()
  else
    # console.log "end"

# lili()

###




###
# put
putObject = (filename, data, cb)->
  ws = require("fs").createWriteStream filename, "utf-8"
  ws.write new Buffer(JSON.stringify(data))
  cb()
  # require("fs").writeFile filename, JSON.stringify(data), (e)->
  #   if e?
  #     console.log e
  #     # NGならリトライ
  #     putObject filename, data

put = (o, cb)->
  # checkDirectory strage, (nothing)->
    # require("fs").mkdirSync(strage) if nothing
    
  data = o
  hash = getHash()
  data["_id"] = hash
  putObject strage + "/" + hash, data, ->
    cb()
  
  
  # require("fs").writeFile strage + "/" + hash, JSON.stringify(data), (e)->
  #   if e?
  #     console.log e
  #     # NGならリトライ
  #     put o

# put aaaa:"bbb"


###





# too many openでダメ
# [0...10000].forEach (i)->
#   put zaiko: i

# for i in [0...10000]
#   put zai: i


# i = 0
# lili = ->
#   if i < 10000
#     i = i + 1
#     setTimeout ->
#       put zai: i, ->
#         lili()
#     , 0
# lili()


###
arr = []
for i in [0...1000000]
  arr.push Math.random()
###

###
start = "2015/07/29"
stdt = new Date(start)
console.log stdt
console.log stdt.setDate(stdt.getDate()+1)
###

###
epoch2date = (d)->
  d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2)

sDate = new Date("2015/07/29")
eDate = new Date("2016/01/27")

dateList = []
while epoch2date(sDate) != epoch2date(eDate)
  dateList.push epoch2date(sDate)
  sDate.setDate(sDate.getDate()+1)

console.log dateList
###

###
koa = require('koa')
route = require 'koa-route'
serve = require 'koa-static'
views = require 'co-views'
app = koa()

# jadeをテンプレートエンジンとして設定。
render = views(__dirname + '/views', { map : {html : 'jade'}})

# GET /views => render template engine
app.use route.get('/views', (next)->
  # bodyに対してindex.jadeの変更を実施。
  this.body = yield render('index.jade', {name: "koa"})
)

# GET /hello => 'Hello!'
app.use route.get('/hello', (next)=>
  this.body = 'Hello!!'
)

# GET /hello/:name => 'Hello :name'
app.use route.get('/hello/:name', (name) ->
  this.body = 'Hello ' + name;
)

# static file serve
app.use serve(__dirname + '/public')
###


###
sw = (st)->
  setTimeout ->
    dRap = new Date(new Date() - st)
    console.log ("0" + dRap.getMinutes()).slice(-2) + ":" + ("0" + dRap.getSeconds()).slice(-2)
    sw st
  ,1000


sw new Date()
###



###
sw =(i)->
  setTimeout ->
    console.log i
    sw i + 1
  ,1000


sw parseInt process.argv[2]
###


###
# 並行処理を直列に
promise = require "bluebird"

new promise (f)->
  console.log "111"
  setTimeout ->
    console.log "111kita"
    f "ichi"
  , 2000
.then (f)->
  new promise (f)->
    console.log "222"
    setTimeout ->
      console.log "222kita"
      f "nii"
    , 1000
.then (f)->
  new promise (f)->
    console.log "333"
    setTimeout ->
      console.log "333kita"
      f "sann"
    , 1000
.then (f)->
  console.log "end", f
.catch (e)->
  console.log "error", e
###




###
# 処理速度を測る
while true
  console.time "measurement"
  count1 = 0
  while count1 < 1000 * 1000 * 1000 * 1
    count1++
  
  console.timeEnd "measurement"

# [0...3000000].filter((i)->i % 2 == 0 ).map((i)->i * 2).sort((a,b)-> b-a)
###


###
# 一括で返すには再帰的呼び出しが不可欠ではなかった
scanData = (filename, cb)->
  data = []
  
  stream = require('JSONStream').parse() 
  stream.on 'data', (r)-> data.push r
  stream.on 'close', -> cb data
  
  rs = require("fs").createReadStream filename + ".json", "utf-8"
  rs.pipe(stream)

scanData "db", (d)-> console.log d
###


###
# 一括で返すには再帰的呼び出しが不可欠？
scanData = (cb)->
  data = []
  rs = require("fs").createReadStream "db.json", "utf-8"
  stream = require('JSONStream').parse()
  
  stream.on 'data', (r)->
    console.log "int", r
    data.push r
  
  stream.on 'close', ->
    # ここで返却すればいい
    console.log "close"
    cb data
  
  rs.pipe(stream)

scanData (d)->
  console.log d
###




###
# jsonDB #
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'


# C
createData = (obj)->
  # 書き込み
  data = obj
  data["_id"] = getHash()
  data["_rev"] = 0
  
  require("fs").appendFile "db.json", JSON.stringify(obj) + "\n", (e)->


# createData jjj:"kkkk"

# R
scanData = (cb)->
  rs = require("fs").createReadStream "db.json", "utf-8"
  stream = require('JSONStream').parse() 
  stream.on 'data', (data)-> cb data
  
  rs.pipe(stream)

# scanData (d)->
#   console.log d

readData = (id, cb)->
  rs = require("fs").createReadStream "db.json", "utf-8"
  stream = require('JSONStream').parse() 
  stream.on 'data', (data)->
    cb(data) if data._id == id
  
  rs.pipe(stream)
  

# readData "161bff92b47859e4bc2561577e42faeae58284b4565a786ef378804f0a5cd4d5", (d)->
#   console.log d

# U
updateDate = (id)->
  # revをインクリメントする

# D
deleteData = (id)->
  # 削除
###



###
Promise.race [
  new Promise (f)->
    console.log "1"
    setTimeout ->
      console.log "ichi"
      f 1
    ,2000
  new Promise (f)->
    console.log "2"
    setTimeout ->
      console.log "ni"
      f 2
    ,3000
  new Promise (f)->
    console.log "3"
    setTimeout ->
      console.log "san"
      f 3
    ,800
  new Promise (f)->
    console.log "4"
    setTimeout ->
      console.log "shi"
      f 4
    ,2000
]
.then (v)->
  console.log "end"
  console.log v
###





###
Promise.all [
  new Promise (f)-> f "1"
  new Promise (f)-> f "2"
  new Promise (f)-> f "3"
  new Promise (f)-> f "4"
]
.then (v)-> console.log v
###

###
spawn = (generatorFunc) ->
  continuer = (verb, arg) ->
    result
    try
      result = generator[verb](arg)
    catch err
      return Promise.reject(err)
    
    
    if (result.done)
      return result.value
    else
      return Promise.resolve(result.value).then(onFulfilled, onRejected)
    
  
  generator = generatorFunc();
  onFulfilled = continuer.bind(continuer, "next");
  onRejected = continuer.bind(continuer, "throw");
  return onFulfilled();


a = spawn ->
  console.log "asdf"

console.log a
console.log a.next
###


###
# 標準promise
console.log "s"
p = new Promise (f,r)->
  f "kitreru"

p.then (v)->
  console.log "thene"
  console.log v

console.log "e"
###


###
http = require('http')
koa = require('koa')
app = koa()

app.use ->
  this
  this.request
  this.response

http.createServer(app.callback()).listen(3000)
###


###
# multiple addresses
http = require('http')
koa = require('koa')
app = koa()

http.createServer(app.callback()).listen(3000)
http.createServer(app.callback()).listen(3001)
###


###
# bluebirdのyield
Promise = require 'bluebird'

console.log "1@@"
timer = (str, ms) =>
  console.log "2@@"
  return new Promise (resolve) =>
    console.log "3@@"
    console.log str 
    setTimeout () =>
      console.log "4@@"
      resolve()
    , ms

console.log "5@@"
Promise.coroutine(->
  console.log "6@@"
  yield timer('1', 1000)
  yield timer('2', 1000)
  # 並列処理
  yield Promise.all([timer('3', 1000), timer('4', 1000), timer('5', 1000)])
  yield timer('6', 1000)
)()
###





###
http = require "http"
get = require 'get'
co  = require 'co'
console.log "1"
###



###
http.get 'http://google.com', (a,b,c)->
  console.log a
  console.log b
  console.log c
###

###
co ->
  console.log "2"
  a = yield http.get('http://google.com')
  console.log "3"
  b = yield http.get('http://yahoo.com')
  c = yield http.get('http://cloudup.com')
  console.log(a.status)
  console.log(b.status)
  console.log(c.status)
.then (v)->
###

###
co ->
  console.log "2"
  a = get('http://google.com')
  b = get('http://yahoo.com')
  c = get('http://cloudup.com')
  res = yield [a, b, c]
  console.log(res)
###


###
fun = ->
  console.log "bobo"
  @.next()
  return "doi"


require("co") ->
  console.log "a"
  yield Promise.resolve(1)
  console.log "b"
  yield fun
  console.log "c"
  return 99
.then (v)->
  console.log v
  return "omake"
.then (v)->
  console.log v
###


###
co = require "co"

sleep = (ms) ->
  new Promise (done) ->
    setTimeout (-> done ms), ms

co ->
  console.log 'sleep 1'
  a = yield sleep(1000)
  console.log 'sleep 2'
  b = yield sleep(500)
  console.log 'sleep 3'
  console.log a, b
  return "vvvv"
.then (v)->
  console.log "modottekita"
  console.log v
  "dajio"
.then (v)->
  console.log "nikai"
  console.log v
###


###
# do
x = do ->
  yield 0
  yield 1
  yield 2

# gen = x() # generatorを生成
console.log x.next().value
console.log x.next().value
console.log x.next().value
###



###
# readdir2
co = require "co"
fs = require "fs"
Promise = require "bluebird"
Promise.promisifyAll fs

co ->
  f = yield fs.readdirAsync "."
  console.log f
###



###
# readdir
require("fs").readdir ".",(e,f)->
  console.log typeof f
  console.log f.map((i)->i)
###



###
# フィボナッチ2
fib = ->
  a = 0
  b = 1
  while true
    yield a
    tmp = b
    b = a + b
    a = tmp

gen = fib()
[0...100].forEach ->
  console.log gen.next()
###



###
yi = ->
  i = 1
  yield "bon"
  i++
  yield i
  i++
  yield "don"
  i++
  yield i
  i++
  yield 99
  i++
  yield i
  i++

console.log typeof yi()
console.log yi()

yy = yi()

console.log "a"
console.log yy.next(20)
console.log "b"
console.log yy.next(30)
console.log "c"
console.log yy.next(40)
console.log "d"
console.log yy.next(50)
console.log "e"
console.log yy.next(60)
console.log "f"
console.log yy.next(70)
console.log "g"
console.log yy.next(70)
console.log "h"
console.log yy.next(70)
###

###
yi = ->
  i = 1
  while 1
    yield "bon"
    console.log "nikaimenotugi"
    i++
    return 99

yy = yi()

console.log "a"
console.log yy.next(20)
console.log "b"
console.log yy.next(30)
console.log "c"
console.log yy.next(40)
console.log "d"
console.log yy.next(50)
console.log "e"
###

###
# yieldを使ったフィボナッチ
fib = (n)->
  i1 = 0
  i2 = 1
  while(1)
    yield "asdf"
    console.log i1
    i1 = i2
    i2 = i1+i2


f = fib(10)
console.log f

f.next (n) -> console.log n
f.next (n) -> console.log n
f.next (n) -> console.log n
f.next (n) -> console.log n
f.next (n) -> console.log n
f.next (n) -> console.log n
f.next (n) -> console.log n
###


###
# ama3
i = 1
g = ->
  while(1)
    yield i
    i++

a = g()

console.log a

console.log i
a.next i
console.log a
a.next i
console.log a
console.log i
###

###
# ama2
console.log "1@@"
i = 1
g = ((l)->
  console.log "2@@"
  console.log l
  while(1)
    console.log "3@@"
    yield(l)
    console.log "4@@"
    i++
    console.log "5@@")("dan")

console.log "6@@"
console.log i
console.log "7@@"
g.next("doi")
console.log "8@@"
g.next()
console.log "9@@"
console.log i
console.log "10@@"
###


###
# ama
i = 1
g = (->
  while(1)
    yield i
    i++)()


console.log i
g.next i
g.next i
console.log i
###


###
# koa2
koa = require "koa"
app = koa()

app.use *()->
  this.body = "hell"

app.listen 3000
###

###
# koa
koa = require "koa"
app = koa()

console.log "1"
app.use (n) ->
  console.log "2"
  st = new Date
  yield n
  console.log "3"
  ms = new Date - st
  @set "X-Response-Time", "#{ms}ms"

console.log "4"
app.use (n) ->
  console.log "5"
  st = new Date
  yield n
  console.log "6"
  ms = new Date - st
  console.log "#{@method} #{@url} - #{ms}"

console.log "7"
app.use (n) ->
  console.log "8"
  @body = 'Hello World'
  yield n
console.log "9"

app.listen 3000

console.log "10"
###



###
yy = (n)->
  yield n
###


###
# jsonを一行ずつ読む
rs = require("fs").createReadStream "aaa.json", encoding: "utf-8"
js = require('JSONStream').parse() 

arrJson = []
js.on "data", (d)-> arrJson.push d

js.on "end", ->
  console.log "end"
  console.log arrJson.filter((i)->i.platform.S == "APP").map((i)->i.user_agent.S )

js.on "close", ->
  console.log "close"

rs.pipe js
###

###
# リバースプロキシ ng
px = require "http-proxy"

ps = px.createServer
  hostnameOnly: true
  router:
    "lw-api.cloud.recochoku.jp": "127.0.0.1"

ps.listen 80
console.log "ok"
###




###
# 配列操作の拡張メソッド
Array.prototype.nanka = (cb)->
  O = Object this
  len = O.length >>> 0
  A = new Array(len)
  
  k = 0
  while(k < len)
    if (k of O)
      kValue = O[ k ]
      mappedValue = cb.call(null, kValue + 1)
      console.log mappedValue
      A[ k ] = mappedValue
    k++
  
  return A


arr = [1,2,4,2,23]
console.log arr.nanka((i)->i)
###



###
# map
Array.prototype.mape = (cb, thisArg)->
  throw new TypeError(" this is null or not defined") if (this == null)
  O = Object this
  len = O.length >>> 0
  
  throw new TypeError(cb + " is not a function") if ({}.toString.call(cb) != "[object Function]")
  
  T = thisArg if (thisArg)
  
  A = new Array(len)
  k = 0
  while(k < len)
    if (k of O)
      kValue = O[ k ]
      mappedValue = cb.call(T, kValue, k, O)
      A[ k ] = mappedValue
    k++
  
  return A

arr = [1,2,4,2,23]
console.log arr.map((i)->i)
console.log arr.mape((i)->i)
###



###
# ベーシック認証
a = require("express")()
b = require "basic-auth-connect"

a.use b("user", "pass")

a.get "/",(q,s)->
  console.log "get"
  s.header "nai": "denndenn"
  s.set "saf": "etset"
  s.set "Pragma": "no-cache"
  s.status "200"
  s.end("ex end")
  

a.listen 3003,->
  console.log "on"
###

###
# クラスタリングチェック
promise = require "bluebird"
throng = require "throng"

start = ->
  console.log "start worker"
  
  process.on "SIGTERM",->
    console.log "death"
    process.exit()
  
  promise.all [
    new promise (f)->
      count1 = 0
      while count1 < 1000 * 1000 * 1000 * 1
        count1++
      
      console.timeEnd "tmp"
      f "1"
    # =========================================
    new promise (f)-> 
      count1 = 0
      while count1 < 1000 * 1000 * 1000 * 1
        count1++
      
      console.timeEnd "tmp"
      f "2"
    # =========================================
    new promise (f)-> 
      count1 = 0
      while count1 < 1000 * 1000 * 1000 * 1
        count1++
      
      console.timeEnd "tmp"
      f "3"
  ]
  .then (v)->
    console.log "all promiss done:", v
    console.timeEnd "tmp"
    process.exit()
  .catch (e)->
    console.log "error", e

throng start, workers: 3
###



###
# 日付バリデーション2 yyyy-mm-dd hh:mi:ss
chai = require "chai"

reg = new RegExp(/^\d{4}-\d{2}-\d{2}\s{1}\d{2}:\d{2}:\d{2}$/)

chai.assert.isTrue reg.test "2016-23-11 23:32:23"
chai.assert.isTrue reg.test "2016-23-11 23:02:00"
chai.assert.isTrue reg.test "2016-01-01 23:02:00"
chai.assert.isNotTrue reg.test "2016/23/11 23:32:23"
chai.assert.isNotTrue reg.test "2016/23/1123:32:23"
chai.assert.isNotTrue reg.test "2016/23/11 23:32"
chai.assert.isNotTrue reg.test "2016/2/1 3:3"
###


###
# 日付バリデーション yyyy-mm-dd hh:mi:ss
chai = require "chai"
chai.assert true
chai.assert !false

datevali = (str)->
  reg = new RegExp(/^\d{4}-\d{2}-\d{2}\s{1}\d{2}:\d{2}:\d{2}$/)
  # console.log reg.test str
  
  if reg.test str
    console.log "aru"
    return true
  else
    console.log "nai"
    return false

datevali "20162311"
datevali "2016-23-11 23:32:23"
datevali "2016-23-11"
datevali "2016-23-11 "
datevali "2016-23-11  "
datevali "2016-23-11 00"


datevali "a20162311"
datevali "a2016-23-11 23:32:23"
datevali "a2016-23-11"
datevali "a2016-23-11 "
datevali "a2016-23-11  "


chai.assert.isTrue datevali "2016-23-11 23:32:23"
chai.assert.isTrue datevali "2016-23-11 23:02:00"
chai.assert.isTrue datevali "2016-01-01 23:02:00"
chai.assert.isNotTrue datevali "2016/23/11 23:32:23"
chai.assert.isNotTrue datevali "2016/23/1123:32:23"
chai.assert.isNotTrue datevali "2016/23/11 23:32"
chai.assert.isNotTrue datevali "2016/2/1 3:3"
###

###
# 期間のリストを算出
epoch2date = (d)->
  d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2)

sDate = new Date("2015/07/01")
eDate = new Date("2015/11/25")

dateList = []
while epoch2date(sDate) != epoch2date(eDate)
  dateList.push epoch2date(sDate).replace(/\//g, "")
  sDate.setDate(sDate.getDate()+1)

console.log dateList
###



###
# 個別のpromise allは配列を返さない
Promise = require "bluebird"

Promise.all [1,2,3,4,5].map (num)->
  new Promise (f,r)->
    setTimeout ->
      console.log num
      f num
    ,1000
.then (v)->
  console.log v
###

###
# promiseによる並列処理
promise = require "bluebird"

promise.all [
  new promise (f)->
    f "aaa"
  new promise (f)->
    f "bbbb"
  ]
  .then (v)->
    console.log "all promiss done:", v
###


###
require("async").parallel [
  (cb)->
      cb null, "aaa"
  (cb)->
      cb null, "bbbb"
], (e, r) ->
  if e?
    throw e
  else
    console.log "all done:", r
###

###
# sortの分解
cnt = 0
console.log [4,2,2,2,25,3,2,2,2,6,6,6,2,2,6,8,54,6].sort (a,b)->
  cnt += 1
  console.log "a",a
  console.log "b",b
  console.log a < b
  console.log cnt
  if a > b
    1
  else
    -1
###



###
# すべてfalseにするものである
ted.sort (a,b)->
  console.log a > b
  a > b
###

###
# HTTP GetのAsync
promise = require "bluebird"
request = require "request"

console.log "1"
get_http1 = new promise (resolve, reject)->
  console.log "2"
  console.log 'start http get to google...'
  request 'http://google.co.jp/', (error, response)->
    console.log "3"
    if !error && response.statusCode == 200
      console.log "4"
      resolve response
    else
      console.log "5"
      reject response
    console.log "6"

console.log "7"
get_http1
  .then (response)->
    console.log "8"
    console.log 'http get to google done! '
    console.log response.statusCode
  .catch (error)->
    console.log "9"
    console.log 'http get failed...'
    console.log error.statusCode

console.log "10"
###

###
# promise all3 async.eachEachの代替 NG
Promise = require "bluebird"

[1,2,3,4,5].reduce (p,n)->
  return new p.then (v)->
    return new Promise (f,r)->
      setTimeout ->
        console.log n
        f n
      ,1000
, Promise.resolve()
  .then (v)->
    console.log "end", v
###



###
# promise all2 async.eachの代替
Promise = require "bluebird"

Promise.all [1,2,3,4,5].map (num)->
  new Promise (f,r)->
    setTimeout ->
      console.log num
      f num
    ,1000
  .then (v)->
    console.log "end", v
###



###
# promise race
Promise = require "bluebird"

p1 = new Promise (f,r)->
  setTimeout ->
    f 1
  ,1000

p2 = new Promise (f,r)->
  setTimeout ->
    f 2
  ,2000

Promise.race([p1,p2])
  .then (v)->
    console.log v
###

###
# promise all
Promise = require "bluebird"

p1 = new Promise (f,r)->
  setTimeout ->
    f 1
  ,1000

p2 = new Promise (f,r)->
  setTimeout ->
    f 2
  ,2000

Promise.all([p1,p2])
  .then (v)->
    console.log v
###



###

# promise3
fs = require "fs"
Promise = require "bluebird"
Promise.promisifyAll fs

fs.readFileAsync "memo.txt", "utf-8"
  .then (v)->
    console.log v
    new Promise (f,r)->
      setTimeout ->
        f "timeoute"
        # r new Error("timeoutafiel")
      .1000
    
  .then (v)->
    console.log v, "thenのほう1"
    new Promise (f,r)->
      f "ninini"
  .then (v)->
    console.log v, "thenのほう2"
  .then (v)->
    console.log v, "thenのほう3"
  .then (v)->
    console.log v, "thenのほう4"
  .then (v)->
    console.log v, "thenのほう5"
  .catch (e)->
    console.log e, "errorのほう"
  .catch (e)->
    console.log e, "errorのほう2"
###



###
# promise2
fs = require "fs"
Promise = require "bluebird"
Promise.promisifyAll fs

fs.readFileAsync "memo.txt", "utf-8"
  .then (v)->
    new Promise (f,r)->
      setTimeout ->
        f "timeoute"
      , 1000
  .then (v)->
    console.log v
  , (e)->
    console.log e
###

###
# promise
fs = require "fs"
Promise = require "bluebird"

Promise.promisifyAll fs

fs.readFileAsync "memo.txt", "utf-8"
  .then (v)->
    console.log v
  , (e)->
    console.log e
###




###
# dirExistsは必要か->必要だった
require("fs").appendFile()
###

###
console.log "2015/11/15 23:59:59 -> " + (new Date("2015/11/15 23:59:59").getTime())
console.log "2015/11/22 23:59:59 -> " + (new Date("2015/11/22 23:59:59").getTime())
console.log "2015/11/24 23:59:59 -> " + (new Date("2015/11/24 23:59:59").getTime())
console.log "2015/12/06 23:59:59 -> " + (new Date("2015/12/06 23:59:59").getTime())
console.log "2015/12/13 23:59:59 -> " + (new Date("2015/12/13 23:59:59").getTime())
console.log "2015/12/20 23:59:59 -> " + (new Date("2015/12/20 23:59:59").getTime())
console.log "2015/12/23 23:59:59 -> " + (new Date("2015/12/23 23:59:59").getTime())
# 2015/11/15 23:59:59 -> 1447599599000
# 2015/11/22 23:59:59 -> 1448204399000
# 2015/11/24 23:59:59 -> 1448377199000
# 2015/12/06 23:59:59 -> 1449413999000
# 2015/12/13 23:59:59 -> 1450018799000
# 2015/12/20 23:59:59 -> 1450623599000
# 2015/12/23 23:59:59 -> 1450882799000
###



###
# Arrar.applyの場合
getArg = ->
  # console.log arguments
  console.log Array.apply(null, arguments)

getArg()
getArg 5 # lengthとして認識されるためNG
getArg "1"
getArg 1,2,"sadf"
###

###
getArg = ->
  console.log arguments
  console.log [].slice.call(arguments)[0]
  console.log [].slice.call(arguments, 1)[1]

getArg()
getArg 1
getArg "1"
getArg 1,2,"sadf"
###

###
# JSONをPrettyPrintする
obj =
  7: 'zero'
  1: 'one'
  2: 'two'
  3: 'three'
  4: 'four'
  length: 9

# 2スペースでインデントされたJSON形式
console.log JSON.stringify(obj, null, 2); 

# 小数点以下を指定(近似値が返却される)
console.log 123.456.toFixed(2) # 123.5
###


###
# 配列のコピーなど
obj =
  7: 'zero'
  1: 'one'
  2: 'two'
  3: 'three'
  4: 'four'
  length: 9

# arrayライクなものを変換
console.log Array.prototype.slice.call(obj)
console.log [].slice.call(obj)
###




###
# FRP2
Bacon = require "baconjs"
client = require "cheerio-httpcli"

list = [
  'http://qiita.com/advent-calendar/2011'
  'http://qiita.com/advent-calendar/2012'
  'http://qiita.com/advent-calendar/2013'
  'http://qiita.com/advent-calendar/2014'
]

# stream = Bacon.fromArray(list)
# stream.log()

console.log "1"

fetchFromUrl = (url)->
  console.log "2"
  Bacon.fromCallback (cb)->
    console.log "3"
    client.fetch url, {}, (e,$,r)->
      console.log "4"
      cb $
      console.log "5"

console.log "6"

getTitle = ($)->
  console.log "7"
  $("title").text()
console.log "8"

stream = Bacon.fromArray(list)
stream
  .bufferingThrottle 1000
  .flatMap fetchFromUrl
  .map getTitle
  .log()

console.log "9"
###



###
# 検索
client.fetch 'http://www.google.com/search', {q: 'node.js'}, (err, $, res)->
  console.log res.headers
  console.log $('title')
  console.log $('title').text()
  
  $('a').each (idx) ->
    console.log $(this).attr('href')
###


###
# 2つの非同期処理をつなげる
hidoki = (v, cb)->
  console.log "dokidokicon", v
  cb new Date().getTime()

dokidon = (v, cb)->
  console.log "hudatmer", v
  cb new Date().getTime()


arr = []
arr.push asdfdfas:3
arr.push asdfdf:4
arr.push asdf:56

seri = (array)->
  if array.length != 0
    val = array.shift()
    require("async").parallel [
      (cb)->
        hidoki val, (v)->
          console.log v, "henkyaku"
          cb null, "hido" + v
      (cb)->
        dokidon val, (v)->
          console.log v, "henkyakudokik"
          cb null, "doki" + v
    ], (e, r) ->
      if e?
        throw e
      else
        # 順序は担保される模様
        console.log "all done:", r
        seri array
  else
    console.log "iwata"

seri arr
###



###
# parallel
require("async").parallel [
  (cb)->
    console.log "seri 1"
    setTimeout ->
      console.log "seri 1 out"
      cb null, 1
    , 5000
  (cb)->
    console.log "seri 2"
    setTimeout ->
      console.log "seri 2 out"
      cb null, 2
    , 1000
  (cb)->
    console.log "seri 3"
    setTimeout ->
      console.log "seri 3 out"
      cb null, 3
    , 1000
], (e, r) ->
  if e?
    throw e
  else
    # 順序は担保される模様
    console.log "all done:", r
###


###
# series
require("async").series [
  (cb)->
    console.log "seri 1"
    cb null, 1
  (cb)->
    console.log "seri 2"
    cb null, 2
  (cb)->
    console.log "seri 3"
    cb null, 3
], (e, r) ->
  if e?
    throw e
  else
    console.log "all done:", r
###



###
# waterfall
require("async").waterfall [
  (callback) ->
    console.log "waterfall 1"
    setTimeout ->
      console.log "waterfall 1 done."
      callback null, 10, "strr"
    , 500
  (arg, str, callback) ->
    console.log "waterfall 2"
    
    # 複数回呼ぶと後続が複数回よばれる
    callback null, "bonbon"
    setTimeout ->
      console.log "waterfall 2 done."
      console.log str
      callback null, arg + 1
    , 300
  (arg, callback) ->
    console.log "waterfall 3"
    setTimeout ->
      console.log "waterfall 3 done."
      callback null, arg + 100
    , 100
], (err, result) ->
  throw err if err
  console.log "waterfall all done." + result
###




###
# 非同期な処理を直列につなぐ配列
hidoki = (v, cb)->
  console.log "dokidokicon", v
  cb new Date().getTime()

arr = []
arr.push asdfdfas:3
arr.push asdfdf:4
arr.push asdf:56

seri = (array)->
  if array.length != 0
    
    hidoki array.shift(), (v)->
      console.log v, "henkyaku"
      setTimeout ->
        seri array
      , 1000
  else
    console.log "iwata"

seri arr
###




###
console.log "2015/10/13 00:00:00 -> " + (new Date("2015/10/13 00:00:00").getTime())
console.log "2015/10/30 00:00:00 -> " + (new Date("2015/10/30 00:00:00").getTime())
console.log "2015/11/13 00:00:00 -> " + (new Date("2015/11/13 00:00:00").getTime())
###


###
# for ofは微妙 NG
o = {}
o.a = 1
o.d = 2
o.fe = 4
o.s = 4
o.cf = 3

doi = (k, cb)->
  cb(k + "no:")

for k,v of o
  console.log "1", k
  setTimeout ->
    console.log "2", k
    doi k, (d)->
      console.log "3", k
      console.log d
  , 1000
  
###

###
# 10万件のデータと1万件のIDをメモリ内でサマリする 関数2
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

ids = [0...100000].map(->getHash())
data = [0...10000000].map(->ids[Math.floor(Math.random() * 10000)])

# console.log data


summary = {}
data.forEach (i)-> summary[i] = if summary[i]? then summary[i] + 1 else 1

# summary = data.reduce( ((p,c)->
#   p[c] = if p[c]? then p[c] + 1 else 1
#   return p)
#   ,{} )


console.timeEnd "tmp"
# console.log summary

# for k,v of summary
#   console.log k,v if v > 20
###



###
# 10万件のデータと1万件のIDをメモリ内でサマリする 関数
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

ids = [0...10000].map(->getHash())
data = [0...100000].map(->ids[Math.floor(Math.random() * 10000)])

# console.log data

# summary = {}
# data.forEach (i)-> summary[i] = if summary[i]? then summary[i] + 1 else 1


# イマイチ
summary = data.reduce( ((p,c)->
  p[c] = if p[c]? then p[c] + 1 else 1
  return p)
  ,{} )

# console.log summary

for k,v of summary
  console.log k,v if v > 20
###

###
# 10万件のデータと1万件のIDをメモリ内でサマリする
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

ids = []
[0...10000].forEach (i)->
  ids.push getHash()

# console.log ids.length

# Math.floor(Math.random() * 10000)
data = []
[0...100000].forEach (i)->
  data.push ids[Math.floor(Math.random() * 10000)]

# console.log data

summary = {}
data.forEach (i)->
  if summary[i]?
    # console.log summary[i]
    summary[i] = summary[i] + 1
  else
    # console.log summary[i]
    summary[i] = 1
    # console.log i
    # console.log summary[i]
    # console.log summary[i]?

# cnt = 0
for k,v of summary
  # cnt = cnt + 1
  # console.log cnt
  if v > 1
    console.log k,v

###



###
# 間違い
summary = {}
for k,v of data
  # console.log k
  # console.log summary[k]
  # console.log summary[k]?
  
  if summary[k]?
    console.log summary[k]
    summary[k] = summary[k] + 1
  else
    # console.log summary[k]
    summary[k] = 1
    # console.log k
    # console.log summary[k]
    # console.log summary[k]?

cnt = 0
for k,v of summary
  cnt = cnt + 1
  # console.log cnt
  if v != 1
    console.log k,v
###




###
# クラスターは中止したものの、一個流しはできるようにする
getLists = (cb) ->
  arr = []
  [0...10].forEach (i)->
    arr.push i
  
  cb(null, arr)

ikko = (msg, cb)->
  cb(null, msg + "dondake")

cluster = require "cluster"
if cluster.isMaster
  getLists (e,d)->
    # forEachではダメ
    # d.forEach (i)->
    #   switch i
    #     when ""
    #       console.log "skip:", i
    #     else
    #       console.log "buckup:",i
    #       w = cluster.fork()
    #       w.send i
    
    forkin = (i)-> cluster.fork().send i
    forkin d.shift() if d.length != 0
    cluster.on "exit", -> forkin d.shift() if d.length != 0
else
  process.on "message", (msg)->
    ikko msg, (e,d)->
      if e?
        console.log e
      else
        console.log d
        console.timeEnd "tmp"
        process.exit()
###


###
# (10回実行したら終了)
limi = (cnt = 0)->
  console.log "don", cnt
  if cnt < 10
    limi cnt + 1

limi()
###



###
# スワイプサンプル
start = Bacon.fromEventTarget el,'touchstart'
move  = Bacon.fromEventTarget el,'touchmove'
end   = Bacon.fromEventTarget el,'touchend'

moving = start.flatMap (init) ->
  return move
    .takeUntil end
    .scan({}, (acc, move)->
      return
        init : acc.init || init.changedTouches[0],
        curt : move.changedTouches[0]
    ).skip(1)

swipeLeft = moving.filter (moves) ->
  init = moves.init
  curt = moves.curt
  delta = init.clientX - curt.clientX
  return delta > 50

swipeLeft.onValue ->
  # swipe left

###



###
rx = require "rx"
rx.Observable.of 1, 2, 3
  .map (x)->
    throw new Error() if x == 2
    x
  .onErrorResumeNext rx.Observable.of 4, 5, 6
  .subscribe (v)->
    console.log v
###

###
rx.Observable.of 1, 2, 3
  .map (x)->
    console.log "mapyo"
    throw new Error() if x == 2
    x
  .catch (e)->
    console.log "catyo"
    rx.Observable.return e instanceof Error
  .subscribe (v)->
    console.log "subyo"
    console.log v
###

###
rx.Observable.of 1, 2, 3
  .flatMap (x)->
    rx.Observable.of x, x * x
  .subscribe (v)->
    console.log v
###

###
# ng
a = rx.Observable.fromEvent(el,"click").map("a")
b = rx.Observable.fromEvent(el,"click").map("b")

a.merge(b).subscribe (v)->
  console.log v
###




###
rx.Observable.range 1, 7
  .filter (x)->
    x % 2 == 0
  .subscribe (v)->
    console.log v
###


###
rx.Observable.of 1, 2, 3
  .map (x)->
    x * x
  .subscribe (v)->
    console.log v
###



###
# baconjs
beats = (you, opponent)->
  if you is 'rock'
    if opponent is 'scissors'
      return true
    else
      return false 
  else if you is 'paper'
    if opponent is 'rock'
      return true
    else
      return false
  else if you is 'scissors'
    if opponent is 'paper'
      return true
    else
      return false
  else
    throw new Error("your hand is unexpected: #{you}")

Bacon = require "baconjs"
you = new Bacon.Bus()
opponent = new Bacon.Bus()

res = you.toProperty()
  .combine opponent.toProperty(), beats
  .onValue (d)-> console.log d


you.push "paper"
opponent.push "paper"
opponent.push "rock"
you.push "scissors"
opponent.push "paper"
###



###
# parseの返却値
json = '{"asdf":24,"asdff":234,"ff":"boo'

try
  console.log JSON.parse json
catch e
  console.log "catch"
  console.log e
###



###
# ユニット合わせ
b1 = 1023
b2 = 1024
b3 = 1025

b4 = 2047
b5 = 2048
b6 = 2049

computeCapUni = (b, name)->
  console.log name, Math.ceil( b/1024 )

computeCapUni b1, "b1"
computeCapUni b2, "b2"
computeCapUni b3, "b3"

computeCapUni b4, "b4"
computeCapUni b5, "b5"
computeCapUni b6, "b6"
###


###
# 複数リストを複数プロセスにやらせる
list = [1,4,9,5,4,3,5,6,4,6,7,6,9]

cluster = require "cluster"
if cluster.isMaster
  list.forEach (i)->
    w = cluster.fork()
    w.send i
else
  console.log "kopurodayo"
  process.on "message", (msg)->
    console.log msg * 123
    process.exit()
###




###
# stringをbufferにしてサイズを出す
obj = {}
obj.ichi = "one"
obj.ni = "twr"
buf = new Buffer(JSON.stringify(obj))
console.log buf.length
console.log buf.toString()
###

###
# bylineに鞍替え2
rs = require("fs").createReadStream("memo.txt")
bl = require("byline").createStream(rs)

stm = require("through2")( (c,e,n)->
    this.push c
    n()
  )

# bl.pipe require("fs").createWriteStream("memo_copy.txt")
bl.pipe(stm).pipe(require("fs").createWriteStream("memo_copy.txt"))
###




###
# randomな文字列をn文字生成する
idgen = (cnt)->
  str = ""
  [0...cnt].forEach ->
    str += require("node-uuid").v4()[0]
  
  return str

console.log idgen 35
###

###
# bylineに鞍替え
bl = require("byline")(require("fs").createReadStream("memo.txt"))

stm = require("through2")( (c,e,n)->
    this.push c
    n()
  )

# bl.pipe require("fs").createWriteStream("memo_copy.txt")
bl.pipe(stm).pipe(require("fs").createWriteStream("memo_copy.txt"))
###

###
stm = require("through2")( (c,e,n)->
    this.push c
    n()
  )

# readlineに鞍替え NG
rs = require("fs").createReadStream("memo.txt")
ws = require("fs").createWriteStream("memo_copy.txt")

rl = require("readline").createInterface(rs, stm)

rl.on "pause",->
  console.log "pause"

rl.on "resume",->
  console.log "resume"

rl.on "line",(l)->
  # console.log l
  rl.write l

rl.on "close",->
  console.log "close"

rl.resume()
###




###
require("http").get "http://www.yahoo.co.jp/", (d)->
  d.on "data", (c)->
    console.log c.toString()
###


###
# stmの制御
stm = require("through2")( (c,e,n)->
    this.push c
    n()
  )

stm.write "d"
stm.on "data", (a,b,c)->
  console.log a

stm.write "dopdio"
stm.write "d"
stm.write "dere"
stm.write "dereijife"

process.stdin.resume()
process.stdin.pipe(stm).pipe(process.stdout)
###


###
# json取得3 gzip
request = require "request"
http = require "http"
through2 = require "through2"

s = http.createServer (req, res)-> 
  console.time "dl"
  res.writeHead 200,
    "Content-Type": "multipart/mixed"
    "Content-Encoding": "gzip"
    "Transfer-Encoding": "chunked"
    "Content-Disposition": "attachment; filename=dlz.txt"
    
  z = require("zlib").createGzip()
  z.on "data", (d)->
    res.write d
    
  
  z.on "end", ->
    console.timeEnd "dl"
    res.end()
  
  stm = through2( (c,e,n)->
    this.push c
    n()
  )
  
  jst = require('JSONStream').parse()
  jst.on "data", (d)->
    z.write JSON.stringify d
    
  jst.on "end", -> z.end()
  
  request.get("http://localhost:3001/testlargetrue").pipe(stm).pipe(jst)

s.listen 3002
###


###
# json取得2
request = require "request"
http = require "http"
through2 = require "through2"

s = http.createServer (req, res)-> 
  console.time "dl"
  res.writeHead 200,
    "Content-Type": "multipart/mixed"
    "Content-Disposition": "attachment; filename=notgzip.txt"
  
  stm = through2( (c,e,n)->
    this.push c
    n()
  )
  
  jst = require('JSONStream').parse()
  jst.on "data", (d)->
    res.write JSON.stringify d
    
  jst.on "end", ->
    console.timeEnd "dl"
    res.end()
  
  request.get("http://localhost:3001/testlargetrue").pipe(stm).pipe(jst)

s.listen 3002
###


###
# json取得
request = require "request"
http = require "http"
through2 = require "through2"

s = http.createServer (req, res)-> 
  stm = through2( (c,e,n)->
    console.log "transss2"
    this.push c
    n()
  )
  
  jst = require('JSONStream').parse()
  jst.on "data", (d)->
    console.log "data"
    # console.log d
    # console.log "data/////endddddddd"
    res.write JSON.stringify d
  
  jst.on "end", ->
    console.log "end"
    res.end()
  
  request.get("http://localhost:3001/testlargetrue").pipe(stm).pipe(jst)

s.listen 3002
###



###
# ng
s = http.createServer (req, res)-> 
  stm = through2( (c,e,n)->
    console.log "transss"
    # chunkではparseできない事象発生
    j = JSON.parse c
    this.push c
    n()
  )
  
  # request.get("http://localhost:3001/don").pipe(stm).pipe(res)
  # request.post("http://localhost:3001/pika").pipe(res)
  # request.post("http://localhost:3001/pika").form(
  #   form: 
  #     kkk:"vvv"
  # )
  
  request.get("http://localhost:3001/testlarge").pipe(stm).pipe(res)
  

s.listen 3002
###



###
# Streamを使ってレスポンスデータを加工する3
request = require "request"
http = require "http"
through2 = require "through2"


s = http.createServer (req, res)-> 
  stm = through2( (c,e,n)->
    console.log "transss"
    console.log c.toString()
    this.push c
    n()
  )
  
  # request.get("http://localhost:3001/don").pipe(stm).pipe(res)
  # request.post("http://localhost:3001/pika").pipe(res)
  request.post("http://localhost:3001/pika").form(
    form: 
      kkk:"vvv"
  )
  

s.listen 3002
###

###
# express response2
a = require("express")()
a.get "/",(q,s)->
  console.log "get"
  s.header "nai": "denndenn"
  s.set "saf": "etset"
  s.set "Pragma": "no-cache"
  s.status "200"
  s.end("ex end")
  

a.listen 3003,->
  console.log "on"
###

###
# Streamを使ってレスポンスデータを加工する2
request = require "request"
http = require "http"
through2 = require "through2"


s = http.createServer (req, res)-> 
  stm = through2( (c,e,n)->
    console.log "transss"
    console.log c.toString()
    this.push c
    n()
  )
  
  request.get("http://localhost:3001").pipe(stm).pipe(res)
  
  # res.writeHead 418, "Content-Type":"text/html"
  # res.end "tea pot"

s.listen 3002
###

###
# Streamを使ってレスポンスデータを加工する 
request = require "request"
http = require "http"
through2 = require "through2"


s = http.createServer (req, res)-> 
  stm = through2(
    transform: (c,e,n)->
      console.log "transss"
      console.log c
      console.log e
      console.log n
      n("aa")
    
    flush: (cb)->
      console.log "kita"
      this.push("qqqq")
      cb()
  )
  
  request.get("http://localhost:3001").pipe(stm).pipe(res)
  
  # res.writeHead 418, "Content-Type":"text/html"
  # res.end "tea pot"

s.listen 3002
###

###
request = require "request"
http = require "http"

s = http.createServer (req, res)-> 
  request.get("https://www.google.co.jp/images/nav_logo231.png").pipe(res)
  
  # res.writeHead 418, "Content-Type":"text/html"
  # res.end "tea pot"

s.listen 3001
###

###
request = require "request"
fs = require "fs"

# request("http://localhost:3001").pipe(fs.createWriteStream("dondon.txt"))
fs.createReadStream("dondon.txt").pipe(request.put("http://localhost:3001"))
###



###
request = require "request"

request "http://localhost:3001", (e,r,b)->
  if e?
    console.log e
  else
    console.log r.statusCode
    console.log r
    console.log b
###


###
http = require "http"

s = http.createServer (req, res)-> 
  console.log req
  res.writeHead 418, "Content-Type":"text/html"
  res.end "tea pot"

s.listen 3001
###




###
net = require "net"


sev = net.createServer (c)->
  c.on "data", (d)->
    console.log "doi"
  
  c.on "error", (e)->
    console.log e
  
  c.pipe(process.stdout)

sev.listen 0,->
  # console.log "port is :" + sev.address().port
  console.log sev.address()
  


# net.connect ->
#   console.log "connetcteeed"
###


###
net = require "net"

have = 0
net.createServer (c)->
  console.log "come server1"
  c.on "data", (d)->
    cli = new net.Socket()
    cli.setEncoding "utf8"
    cli.connect "3002", "localhost", ->
      setTimeout ->
        cli.write d
      , ((Math.floor(Math.random() * 5)) * 1000) + 1
      # randomWrite()
    
    cli.on "data", (d)->
      have = have + 1
      c.end d + " : "+ have
    
.listen 3001, ->
  console.log "start 3001"

have2 = 0
net.createServer (c)->
  console.log "come server2"
  c.on "data", (d)->
    setTimeout ->
      res = d + "resuponsu"
      have2 = have2 + 1
      c.end res + " : "+ have2
    , ((Math.floor(Math.random() * 120)) * 1000) + 1
  
.listen 3002, ->
  console.log "start 3002"

randomWrite = (i=0)->
  console.time "cli" + i.toString()
  setTimeout ->
    cli = new net.Socket()
    cli.setEncoding "utf8"
    cli.connect "3001", "localhost", ->
      cli.write "fromClient"  
      randomWrite i + 1
    
    cli.on "data", (d)->
      console.log "response->" + d
      console.timeEnd "cli" + i.toString()
  , 1000
  # , ((Math.floor(Math.random() * 5)) * 1000) + 1

randomWrite()
###



###
require("net").createServer((c)->c.on("data", (d)->c.end(d))).listen(3001,->console.log "start")
require("http").createServer((a,b)->b.end("sdf" + a.url)).listen(3000,->console.log "start")
###

###
# cilentの解析4
net = require "net"

# server
sev = net.createServer (c)->
  c.on "data", (d)->
    c.write "sever data:" + d
    c.end "emd"
  
sev.listen 3001

# client
cli = new net.Socket()
cli.connect "3001", "localhost", -> cli.write "cliesite"
cli.on "data", (d)-> console.log "response->" + d
###


###
# cilentの解析3
net = require "net"

# server
sev = net.createServer (c)->
  c.setEncoding "utf8"
  
  c.on "data", (d)->
    c.write "sever data:" + d
    c.end "emd"
  
  c.on "close", -> console.log "server closing"

sev.listen 3001

# client
process.stdin.resume()
process.stdin.on "data", (inp)->
  cli = new net.Socket()
  cli.setEncoding "utf8"
  cli.connect "3001", "localhost", -> cli.write inp
  cli.on "data", (d)-> console.log "response->" + d
  cli.on "close", -> console.log "client closing"
###



###
# cilentの解析2
net = require "net"

# server
console.log "1"
sev = net.createServer (c)->
  console.log "2 createsever"
  c.setEncoding "utf8"
  
  c.on "data", (d)->
    console.log "3 server data start"
    console.log "sds:" + d + ":boibio:"
    console.log "3.1 server data start"
    c.write "sever data:" + d
    console.log "3.2 server data start"
    c.end()
    console.log "3.3 server data start"
    console.log "4 serber data end"
  
  c.on "close", ->
    console.log "5 server clo str"
    console.log "server closing"
    console.log "6 server clo end"
.listen 3001

# client
console.log "11"
process.stdin.resume()
console.log "12"

process.stdin.on "data", (inp)->
  console.log "13 pro data s"
  
  console.log "7 cli init"
  cli = new net.Socket()

  cli.setEncoding "utf8"

  console.log "8"
  cli.connect "3001", "localhost", ->
    console.log "9 conn start"
    cli.write "clicone write!!"
    console.log "10 con end"
  
  cli.on "data", (d)->
    console.log "15 cli data"
    console.log "data cli->" + d

  cli.on "close", ->
    console.log "17"
    console.log "client closing"
  
  cli.write inp
  console.log "14 pro data e"


console.log "18 endin"

###



###
# cilentの解析
net = require "net"

# server
console.log "1"
sev = net.createServer (c)->
  console.log "2 createsever"
  c.setEncoding "utf8"
  
  c.on "data", (d)->
    console.log "3 server data start"
    c.write "sever data:" + d
    c.end()
    console.log "4 serber data end"
  
  c.on "close", ->
    console.log "5 server clo str"
    console.log "server closing"
    console.log "6 server clo end"
.listen 3001

# client
console.log "7 cli init"
cli = new net.Socket()

cli.setEncoding "utf8"

console.log "8"
cli.connect "3001", "localhost", ->
  console.log "9 conn start"
  cli.write "clicone write!!"
  console.log "10 con end"

console.log "11"
process.stdin.resume()
console.log "12"

process.stdin.on "data", (d)->
  console.log "13 pro data s"
  cli.write d
  # ここでエラー
  console.log "14 pro data e"

cli.on "data", (d)->
  console.log "15 cli data"
  console.log "data cli->" + d

cli.on "close", ->
  console.log "17"
  console.log "client closing"

console.log "18 endin"
###

###
net = require "net"
http = require "http"
tcp = require "net"

# net
netser = net.createServer (res)-> 
  # res.writeHead 200, "Content-Type":"text/html"
  # console.log res
  res.write "write "
  res.end "net desu"

netser.listen 3001, ->
  console.log "net done",  netser.address().port

# http
httpser = http.createServer (req, res)-> 
  res.writeHead 200, "Content-Type":"text/html"
  res.end "http desu"

httpser.listen 3002, ->
  console.log "http done", httpser.address().port

# tcp デフォルトでは入っていない。なおかつ非推奨
tcpser = tcp.createServer (soc)-> 
  # res.writeHead 200, "Content-Type":"text/html"
  # console.log soc
  # soc.write "write "
  # soc.end "tcp desu"
  
  # soc は streamらしい
  # ない
  # soc.addListener "connection", ->
  #   console.log "wantyai"
  #   soc.write "conne: "
  
  soc.addListener "data", (d)->
    soc.write "data:"
    soc.write d
    soc.end " kan"
  
  # endは存在しない
  # soc.addListener "end", ->
  #   soc.write "enddd "
  #   soc.end " kan"
  
  console.log "kita"

tcpser.on "close", ->
  console.log "real clotheeee"

tcpser.on "connection", ->
  console.log "konekuto"

tcpser.listen 3003, ->
  console.log "tcp done", tcpser.address().port



net3004 = net.createServer (c)->
  c.setEncoding "utf8"
  
  console.log "net300004"
  c.on "data", (d)->
    console.log "kantai"
    console.log d
    c.write "re@eeee" + d
    c.end()
  
  c.on "close", ->
    console.log "cccccliccclicli"
.listen 3004


# client
cli = new net.Socket()

cli.setEncoding "utf8"

cli.connect "3004", "localhost", ->
  console.log "cli cone!"
  cli.write "clicone write!!"

process.stdin.resume()

process.stdin.on "data", (d)->
  cli.write d

cli.on "data", (d)->
  console.log "cli->" + d

cli.on "close", ->
  console.log "clitheereere clicli"
###



###
cluster = require "cluster"

# pidからワーカーを返却
getWorker = (workers, pid, cb)->
  resWorker = null
  workers.forEach (w)->
    if w.process.pid == pid
      resWorker = w
  
  cb resWorker

# action check
check = (process)->
  if lock == false
    lock = true
    process.send
      action : "check"
      state : "OK"
      pid : process.pid
  else
    process.send
      action : "check"
      state : "NG"
      pid : process.pid

# マスターの処理
execMaster = ->
  workers = []
  for i in [0...require("os").cpus().length]
    w = cluster.fork()
    w.on "message", (msg)->
      console.log msg
      switch msg.action
        when "check"
          if msg.state == "OK"
            console.log "OKdatta.PIDnitaisitesyori"
            getWorker workers, msg.pid, (w)->
              # console.log w
              w.send action : "check"
              # w.send
              #   action : "omoi"
              #   value : "nimotu"
            
          else
            console.log "damedatta"
    
    workers.push w
  
  workers[0].send
    action : "check"
  


# スレーブの処理
execSlave = ->
  # 自分の状態を保持することが必要
  lock = false
  process.on "message", (msg)->
    switch msg.action
      when "check" then check(process)
    

if cluster.isMaster
  execMaster()
else
  execSlave()
###


###
# ng
cluster = require "cluster"

if cluster.isMaster
  wokers = []
  kikulock = false
  
  for i in [0...require("os").cpus().length]
    w = cluster.fork()
    console.log "fork:" + w.process.pid
    
    w.on "message", (msg)->
      console.log "kokara"
      console.log kikulock
      if kikulock == false
        if msg == "okey"
          console.log "OKkita"
          kikulock = true
    
    wokers.push w
  
  exec = (w)->
    # きく
    w.send "kiku"
  
  
  wokers.forEach (w)->
    exec w
  
  
  
  # 終了を受け取って再起動する
  # cluster.on 'exit',(worker, code, signal)->
  #   console.log worker.process.pid + ' exit:' + worker.id
  #   cluster.fork()
else
  # console.log "oiodi"
  # process.send "jijiji"
  # process.exit()
  process.on "message", (msg)->
    console.log "s"
    if msg == "kiku"
      console.log "kikareta"
      process.send "okey"
    
    console.log "e"
###

###
# nactor4
actor = require("nactor").actor (opt)->
  @seq = 0
  @timeout = opt.timeout
  
  return {
    ping : (d, a) ->
      a.enable()
      setTimeout ->
        a.replay "done!!!"
      , @timeout
  }

actor.init
  timeout : 200

actor.ping (msg)->
  console.log msg
###



###
# nactor3
actor = require("nactor").actor
  fun:(msg)->
    console.log msg
    # return "noi:"

actor2 = require("nactor").actor
  ctio:(msg)->

actor.init()
actor2.init()

[0...10000000].forEach (i)->
  actor.fun "jijiji" + i.toString()
    # , (d)->
    # console.log "res:",d
###


###
# nactor2
console.log "1"
actor = require("nactor").actor
  metho:(msg)->
    actor2.ni msg, (d)->
      console.log d

actor2 = require("nactor").actor
  ni:(msg)->
    console.log msg
    return "noi"

console.log "6"
actor.init()
actor2.init()

actor.metho "ichiban", (d)->
  console.log "ichiret"
  console.log d

console.log "7"


# actor.metho "deadman", (d)-> console.log d
# actor2.ni "deadman", (d)-> console.log d
###


###
# 垂直タブのトリム
console.log "start"
virtab = "\t  \v "
console.log virtab
console.log "a" + virtab.toString() + "b"
console.log virtab.toString("utf8")
console.log "a" + virtab.toString().trim() + "b"
console.log "a" + virtab.toString().replace("\v","") + "b"
console.log "end"
###



###
# streamの次のpipeが作れればうまくいくかも
# →write stream実装 解析 & transform実装
getWS = ->
  st = -> require("stream").Writable.call @
  require("util").inherits st, require("stream").Writable
  
  st.prototype._write = (ch, enc, cb)->
    console.log "write:", ch.toString()
    cb()
  
  new st()

getTS = ->
  st = -> require("stream").Transform.call @
  require("util").inherits st, require("stream").Transform
  
  st.prototype._transform = (ch, enc, cb)->
    console.log "trans:", ch.toString()
    @.push ch
    @.push ch
    cb()
  
  new st()

# process.stdin.pipe i

file = "txt"
rs = require("fs").createReadStream "./" + file + ".txt", 
  encoding: "utf-8"
  highWaterMark: 16
rs.pipe(getTS()).pipe(getWS())
###


###
# jsonを検索(逆)
JSONStream = require('JSONStream')

param = 
  encoding: "utf-8"

ichi = require("fs").createReadStream "./" + "test_suzuki_ni" + ".json", param
ni = require("fs").createReadStream "./" + "test_suzuki" + ".json", param

# ni の取得と検索
niSt = JSONStream.parse() 
niList = []
niSt.on 'data', (data)->
  niList.push data.id.S

ni.pipe(niSt)
ni.on "end", ->
  # console.log niList
  
  # ichi の取得
  ichiSt = JSONStream.parse() 
  ichiSt.on 'data', (ichiData)->
    # ichiData.id.S で検索
    if niList.indexOf(ichiData.ichi_id.S) == -1
      console.log ichiData.id.S
    
  ichi.pipe(ichiSt)
###



###
# jsonを検索
JSONStream = require('JSONStream')

param = 
  encoding: "utf-8"

ichi = require("fs").createReadStream "./" + "test_suzuki" + ".json", param
ni = require("fs").createReadStream "./" + "test_suzuki_ni" + ".json", param

# ni の取得と検索
niSt = JSONStream.parse() 
niList = []
niSt.on 'data', (data)->
  niList.push data.ichi_id.S

ni.pipe(niSt)
ni.on "end", ->
  # console.log niList
  
  # ichi の取得
  ichiSt = JSONStream.parse() 
  ichiSt.on 'data', (ichiData)->
    # ichiData.id.S で検索
    if niList.indexOf(ichiData.id.S) == -1
      console.log ichiData.id.S
    
  ichi.pipe(ichiSt)
###



###
# 読み取れるjsonのパターン
# jsonの破片とparse
# JSONStreamを利用
JSONStream = require('JSONStream')

param = 
  encoding: "utf-8"
  highWaterMark: 3

file = "test_suzuki"
rs = require("fs").createReadStream "./" + file + ".json", param

# これで行ごとに投入可能
stream = JSONStream.parse() 
stream.on 'data', (data)->
  console.log 'received:', data.id.S
  console.timeEnd "tmp"

rs.pipe(stream)
###



###
# このままではjsonとして処理できない
param = 
  encoding: "utf-8"
  highWaterMark: 333

file = "test_suzuki"
rs = require("fs").createReadStream "./" + file + ".json", param
ws = require("fs").createWriteStream "./" + file + ".log"

# readが読み込めるようになった
rs.on "readable", ->
  data = rs.read()
  
  # 失敗の場合false
  if data?
    console.log data
    
    bl = ws.write(data)
    rs.pause() if bl == false

# writeが書き込めるようになった
ws.on "drain", -> rs.resume()
###






###
createWSJson = (fileName, cb) ->
  ws = require("fs").createWriteStream fileName + ".json"
  cb(ws)

# 正しいjsonではないがこれでいいかも
createWSJson "cwsj", (ws)->
  [0...100].forEach ->
    [0...10000].forEach (i)->
      ws.write "nanigasi" + "\n"
      console.timeEnd "tmp" # tmp: 36085ms
###


###
# cwsを都度作ってみる ->メモリリークでNG
[0...100].forEach ->
  [0...10000].forEach (i)->
    console.log i
    ws = require("fs").createWriteStream "fileName" + ".json"
    ws.write "nanigsi" + i.toString() + "\n"
    ws.end()
    ws.close()
    console.timeEnd "tmp"
###



###
# cwsで対応する
ws = require("fs").createWriteStream "fileName" + ".json"

[0...100].forEach ->
  [0...10000].forEach (i)->
    console.log i
    ws.write "nanigsi" + i.toString() + "\n"
    console.timeEnd "tmp" # tmp: 64403ms
###

###
# 書き込みの後に書き込むようにする(通常は難しい)
writeJson = (fileName, value, cb) ->
  require("fs").appendFile fileName + ".json", value + "\n",(e)->
    cb(e)

recursiveWrite = (total, cnt = 1) ->
  if total >= cnt
    writeJson "name", "ippai" + cnt.toString(), (e)->
      if e?
        # ここで終了
        console.log "wrriteerrorr"
        console.log e
      else
        # 次の処理
        console.log "ok" + cnt.toString()
        recursiveWrite total, cnt + 1
  else
    console.log "end"
    console.timeEnd "tmp" # tmp: 117175ms

[0...100].forEach (i)->
  recursiveWrite 10000
###



###
# 分割しても同じ
[0...10000].forEach (i)->
  require("fs").appendFile "mokkai" + ".json", "doi" + "\n",(e)->
    if e?
      console.log "wrriteerrorr"
      console.log e
    else
      console.log "ok"
###

###
# 連続すぎてopenできない
writeJson = (fileName, value, cb) ->
  require("fs").appendFile fileName + ".json", value + "\n",(e)->
    cb(e)

[0...10000].forEach (i)->
  writeJson "fairumei", "kakumono" + i.toString(), (e)->
    if e?
      console.log "wrriteerrorr"
      console.log e
    else
      console.log "ok"
###


###
# こうかく2
meso = (param, cb)->
  if param.bool
    d = param.bool.toUpperCase()
  else
    e = "error"
  
  cb(e,d)

meso
  bool: "doiasnoNONOjijoi"
  ,(e,d)->
    if e?
      console.log e
    else
      console.log d
###

###
# こうかく1
meso = (cb)->
  e = null
  d = "data"
  cb(e,d)

meso (e,d)->
  if e?
    console.log e
  else
    console.log d
###


###
console.log "start"

console.log Math.floor(Math.random() * 4)

# console.log Math.floor(Math.random() * 2)
# 1/nで死ぬ処理
death = (n)->  throw "dead" if Math.floor(Math.random() * n) == 0

fiftyDeath = ->
  switch Math.floor(Math.random() * 2)
    when 0
      throw "dead"

death 1

console.log "end"
###

###
# Use the Simplified Constructor API
stream = require "stream"
writable = new stream.Writable(
  write: (chunk, encoding, next)->
    console.log chunk.toString()
    next()
)

rs = require("fs").createReadStream "./txt.txt", encoding: "utf-8"
rs.pipe writable
###

###
# write stream実装 OK
stream = require "stream"
util = require "util"

st = ->
  stream.Writable.call @

util.inherits st, stream.Writable

st.prototype._write = (ch,end,done)->
  console.log ch.toString()
  done()

i = new st()

# process.stdin.pipe i

file = "txt"
rs = require("fs").createReadStream "./" + file + ".txt", encoding: "utf-8"
rs.pipe i
###


###
# stream2で同期なし
param = 
  encoding: "utf-8"
  # highWaterMark: 1

file = "txt_large"
rs = require("fs").createReadStream "./" + file + ".txt", param
ws = require("fs").createWriteStream "./" + file + ".log"

rs.on "readable", ->
  data = rs.read()
  if data?
    ws.write(data)
###

###
# stream2で
param = 
  encoding: "utf-8"
  # highWaterMark: 1

file = "txt_large"
rs = require("fs").createReadStream "./" + file + ".txt", param
ws = require("fs").createWriteStream "./" + file + ".log"

rs.on "readable", ->
  console.log "in readable"
  data = rs.read()
  # 失敗の場合false
  if data?
    console.log data.length
    bl = ws.write(data)
    console.log bl
    if bl == false
      console.log "pause!"
      rs.pause()

ws.on "drain", ->
  console.log "in drain"
  rs.resume()
###



###
# streamの実装 NG
stream = require "stream"
util = require "util"

st = ->
  this.writable = true
  this.buf = []
  
  write: (d)->
    console.log "write"
    console.log d.toString().trim()
    this.buf.push d.toString().trim()
    return true
  
  end: (d)->
    console.log "end"
    if d?
      this.write d
    
    this.writable = false
  
  finish:->
  error:->
  drain:->
  pipe:->
  unpipe:->
  destroy:->
  destroySoon:->

util.inherits(st, stream.Stream)

# console.log st
# console.log new st
# console.log new st()

process.stdin.pipe st
process.stdin.resume()
###


###
# writeがfalseの場合の処理2
param = 
  encoding: "utf-8"
  # bufferSize: 1 # もうサポートされていない
  highWaterMark: 1

file = "txt_large"
rs = require("fs").createReadStream "./" + file + ".txt", param
ws = require("fs").createWriteStream "./" + file + ".log"
rs.on "data", (d)-> rs.pause() if ws.write(d) == false
ws.on "drain", -> rs.resume()
###



###
# writeがfalseの場合の処理
param = 
  encoding: "utf-8"
  # bufferSize: 1 # もうサポートされていない
  # highWaterMark: 1

file = "txt_65537"
rs = require("fs").createReadStream "./" + file + ".txt", param
ws = require("fs").createWriteStream "./" + file + ".log"

# ws false→rs pause→ ws drain→rs resume
rs.on "data", (d)->
  console.log d.length
  # console.log ws
  if ws.write d
    # 余裕あり
    console.log "true"
  else
    # バッファがフル
    rs.pause()
    console.log "false"
  # console.log ws
  

rs.on "end", -> console.log "end"

ws.on "drain", ->
  # console.log ws
  console.log "drain"
  # ここでresume
  rs.resume()

ws.on "end", (d)->
  console.log "endddd"
  console.log d
###

###
# 書き込む
param = 
  encoding: "utf-8"
  # bufferSize: 1 # もうサポートされていない
  # highWaterMark: 1

rs = require("fs").createReadStream "./txt.txt", param
ws = require("fs").createWriteStream "./txt.log"

rs.on "data", (d)->
  console.log d.length
  # console.log ws
  [0...1].forEach (i)->
    console.log ws.write d
  # console.log ws
  
  rs.pause()
  setTimeout ->
    console.log "resuming"
    rs.resume()
  , 1000
  
rs.on "end", -> console.log "end"

ws.on "drain", ->
  # console.log ws
  console.log "drain"

ws.on "end", (d)->
  console.log "endddd"
  console.log d
###

###
# pauseとresume
param = 
  encoding: "utf-8"
  # bufferSize: 1 # もうサポートされていない
  # highWaterMark: 1

rs = require("fs").createReadStream "./txt_65537.txt", param
rs.on "data", (d)->
  console.log d.length
  rs.pause()
  setTimeout ->
    console.log "resuming"
    rs.resume()
  , 1000
  
rs.on "end", -> console.log "end"
###

###
param = 
  # encoding: "utf-8"
  # bufferSize: 1 # もうサポートされていない
  highWaterMark: 1

rs = require("fs").createReadStream "./txt.txt", param
rs.on "data", (d)->
  console.log d
rs.on "end", -> console.log "end"
###

###
# strategy
func = (action)->
  switch action
    when "ichi" then -> console.log "one"
    when "ni" then -> console.log "two"
    when "san" then -> console.log "thlree"
    when "si" then -> console.log "foor"

func("ni")()
###

###
# cb(strResult)
func = (str,cb)->
  console.log "this func"
  console.log str
  cb "func pathes"

func "tekitou", (strResult)->
  console.log "this tekito"
  console.log strResult
###


###
# 拡張子あるなし判定
aru = "as.sdfa/asdf.abc"
nasi = "as.sdfa/asdfabc"

getExt = (str)->
  filename = str.match(/(.*)(?:\/([^/]+$))/)[2]
  if filename.match(/(.*)(?:\.([^.]+$))/)? && filename.match(/(.*)(?:\.([^.]+$))/)[2]?
    filename.match(/(.*)(?:\.([^.]+$))/)[2]
  else
    ""

console.log getExt(aru)
console.log getExt(nasi)
###


# getExt = (str)-> if str.toLowerCase().match(/(.*)(?:\.([^.]+$))/)? && str.toLowerCase().match(/(.*)(?:\.([^.]+$))/)[2]? then str.toLowerCase().match(/(.*)(?:\.([^.]+$))/)[2] else null

# スラッシュ以降にピリオド判定
# getFilename = (str)-> str.toLowerCase().match(/(.*)(?:\/([^/]+$))/)[2]

# file = "as.sdfa/asdf.abc"
# ext = file.match(/[.].*/)[0].slice 1
# console.log ext
# console.log checkExt(file)
# fn = getFilename(file)
# console.log getExt(fn)


###
rs = require("fs").createReadStream('./.txt')
data = ""

drainwait = false
rs.on "readable", ->
  console.log "readを明示的にコール"
  data = rs.read()

rs.on "end", ->
  console.log "完了"
###

###
# NG
rs = require("fs").createReadStream('./.txt')
ws = require("fs").createWriteStream('./_write.txt')
data = ""

drainwait = false
rs.on "readable", ->
  console.log "readを明示的にコール"
  data = rs.read()
  if data?
    # 失敗の場合false
    drainwait = ws.write(data) == false

rs.on "end", ->
  console.log "完了"
  ws.end()

ws.on "drain", ->
  console.log "write可能"
  if drainwait
    if data?
      drainwait = ws.write(data) == false
      return
    
    drainwait = !drainwait
###


###
rs = require("fs").createReadStream('./_sort.txt')
rs.pipe require("fs").createWriteStream('./_sort_write.txt')
###

###
# stream2-3
rs = require("fs").createReadStream('./.txt')
ws = require("fs").createWriteStream('./_write.txt')
data = ""

rs.on "readable", ->
  console.log "readを明示的にコール"

rs.on "end", ->
  console.log "完了"
  ws.end()

ws.on "drain", ->
  console.log "write可能"
  data = rs.read()
  if data?
    # 失敗の場合false
    ws.write data

bl = true
require("async").forever (cb)->
  if bl
    console.log "p"
    rs.pause()
  else
    console.log "r"
    rs.resume()
  
  bl = !bl
  setTimeout cb, 1000
###


###
# stream2-2
rs = require("fs").createReadStream('./.txt')
ws = require("fs").createWriteStream('./_write.txt')
data = ""

rs.on "readable", ->
  console.log "readを明示的にコール"
  data = rs.read()
  if data?
    # 失敗の場合false
    ws.write data

rs.on "end", ->
  console.log "完了"
  ws.end()

ws.on "drain", ->
  console.log "write可能"


# rs.pause()
# rs.resume()
###


###
# stream2
data = ""
rs = require("fs").createReadStream('./.txt')

rs.on "readable", ->
  console.log "readを明示的にコール"
  data = rs.read()

rs.on "end", ->
  console.log "完了"


rs.pause()
rs.resume()

ws = require("fs").createWriteStream('./_write.txt')

ws.write data
ws.end()

ws.on "drain", ->
  console.log "write可能"
###


###
# stream
fs = require('fs')
_ = require('lodash')
JSONStream = require('JSONStream')
map = require('event-stream').map
th = require "through2"


fs.createReadStream('./.txt')
  .pipe(JSONStream.parse('Items.*'))
  .pipe(require("fs").createWriteStream(".log"))
###


###
# transform NG
idSt = th(
  transform: (ch, en, ne)->
    console.log "1"
    console.log ch
    console.log en
    # console.log en
    # console.log ne
    # da = ch.id.S
    ne(null, "asdf")
  
  flush: (cb)->
    console.log "2"
    this.push "noinoi"
    console.log "3"
    cb()
    console.log "4"
)

###



###
fs.createReadStream('./.txt')
  .pipe(JSONStream.parse('Items.*'))
  .pipe(map( (data, callback)->
    console.log data
    callback(null, data.id.S + "\n")
  ))
  .pipe(require("fs").createWriteStream(".log"))
###

###
# pipeイベント
r = require("fs").createReadStream("test_log.txt")
w = require("fs").createWriteStream("test_log.log")
w.on "pipe", (src)->
  console.log "piping"
  src.pipe process.stdout

r.pipe w
###



###
# 出力先のend()は入力元の"end"が生成されたときに呼び出される。
r = require("fs").createReadStream("test_log.txt")
w = require("fs").createWriteStream("test_log.log")
r.pipe w, end:false
r.on "end", ->
  w.end "enddddd\n"
###



###
process.stdin
.pipe process.stdout
###



# require("fs").createReadStream("test_log.txt")
# .pipe( require("JSONStream").parse("Items.*").pipe( process.stdout ) )

###
# catエミュレート
process.stdin.pipe process.stdout
###


###
# gzip圧縮
r = require("fs").createReadStream("test_log.txt")
z = require("zlib").createGzip()
w = require("fs").createWriteStream("test_log.txt.gz")

# r.pipe(z).pipe(w)
r
.pipe z
.pipe w
###




###
stream = require("fs").createReadStream "test_log.txt"
stream
.pipe(JSONStream.parse("Count"))
.pipe(map( (d,c)->c(null,d.toString() + "\n") ))
.pipe(process.stdout)
###





# fs.createReadStream('./test_log.txt').pipe( fs.createWriteStream("./ws.txt")  )
# fs.createReadStream('./test_log.txt').pipe( process.stdout )


###
fs.createReadStream('./test_log.txt')
  .pipe(JSONStream.parse('Items.*'))
  .pipe(map( (data, callback)->
    console.log data
    callback(null, _.values(data).join("\t") + "\n")
  ))
  # .pipe(process.stdout)
###




###
couchbase = require "couchbase"
cluster = new couchbase.Cluster "couchbase://54.64.140.92"
bucket = cluster.openBucket "mfm_test"

getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'
###


###
# ランダムに関連情報を取得
require("request").get
  uri: "http://:8092/mfm_test/_design/docy/_view/user"
  json: true # defaultでfalse
  , (e,r,b)->
    if e?
      console.log e
    else
      # ランダムにユーザーを取得
      rand_user = b.rows.map((i)->{key:i.key, value:i.value}).splice( Math.floor(Math.random() * b.total_rows), 1 )[0]
      rand_key = rand_user.key
      
      console.log rand_user
      
      # 紐づけ検索
      require("request").get
        uri: "http://:8092/mfm_test/_design/docy/_view/c_src"
        json: true
        , (e,r,b)->
          if e?
            console.log e
          else
            # 複数ある可能性
            pos =  b.rows.filter( (i)-> i.key == rand_key )
            if pos.length != 0
              # 保持するもの検索
              require("request").get
                uri: "http://:8092/mfm_test/_design/docy/_view/src"
                json: true
                , (e,r,b)->
                  if e?
                    console.log e
                  else
                    pos.forEach (p)->
                      console.log b.rows.filter( (i)-> i.key == p.value.src_id )[0].value
                      console.log "hojari"
                      console.timeEnd "tmp"
                      process.exit()
            else
              console.log "hojinasi"
              console.timeEnd "tmp"
              process.exit()
###


###
# 保持するものを作成
# userリストを保持する
user = undefined
require("request").get
  uri: "http://:8092/mfm_test/_design/docy/_view/user"
  json: true # defaultでfalse
  , (e,r,b)->
    if e?
      console.log e
    else
      user = b
      
      put = 10000
      [0...put].forEach (i)->
        srcid = getHash()
        bucket.insert getHash(),
          table_name: "r_src"
          id: srcid
          hojisuru: "hojihijo:" + i.toString()
          hojisareta: "sadfihijo:" + i.toString()
          , (e,r)->
            if e?
              console.log "error!"
              console.log e
              # process.exit()
            else
              # ランダムに保持者を決定
              rand_key = user.rows.map((i)->{key:i.key, value:i.value}).splice( Math.floor(Math.random() * user.total_rows), 1 )[0].key
              
              # 保持者と保持するものを紐づけ
              bucket.insert getHash(),
                table_name: "c_src"
                user_id: rand_key
                src_id: srcid
                , (e,r)->
                  if e?
                    console.log "error!"
                    console.log e
                    # process.exit()
                  else
                    if i == put - 1
                      console.log "owari"
                      console.timeEnd "tmp"
                      # process.exit()
              
###



###
put = 1
[0...put].forEach (i)->
  bucket.insert getHash(),
    table_name: "r_user"
    id: getHash()
    nanka: "nanigasi:" + i.toString()
    ,(e,r)->
      if e?
        console.log e
      else
        console.log r
        if i == put - 1
          console.log "owari"
          console.timeEnd "tmp"
          # process.exit()
###


###
require("request").get
  uri: "http://:8092/mfm_test/_design/docy/_view/user"
  json: true # defaultでfalse
  , (e,r,b)->
    if e?
      console.log e
    else
      # console.log r
      # console.log b.total_rows
      # console.log b.rows.map((i)->{key:i.key, value:i.value})
      
      # ランダムにIDを取得
      rand_key = b.rows.map((i)->{key:i.key, value:i.value}).splice( Math.floor(Math.random() * b.total_rows), 1 )[0].key
      
      # 保持者と保持するものを紐づけ
      bucket.insert getHash(),
        table_name: "c_src"
        user_id: rand_key
        src_id: srcid
        , (e,r)->
          if e?
            console.log "error!"
            console.log e
            # process.exit()
          else
            if i == put - 1
              console.log "owari"
              console.timeEnd "tmp"
              # process.exit()
###


###
# bucket.insert "id01",
# bucket.upsert "id01",
bucket.replace "id02",
  a: "taaable"
  b: "valjvalu"
  e: 100
  , (e,r)->
    if e?
      console.log "error!"
      console.log e
      process.exit()
    else
      console.log r
      
      # console.log "nexttt"
      bucket.get "id01", (e,r)->
        if e?
          console.log "error!"
          console.log e
        else
          console.log r.value
        
        process.exit()
###


###
bucket.get "test0", (e,r)->
  if e?
    console.log "error!"
    console.log e
  else
    console.log r
  
  process.exit()
###

###
# cbGet
require("request").get
  uri: "http://:8092/beer-sample/_design/test_ddn/_view/test_view"
  json: true # defaultでfalse
  , (e,r,b)->
    if e?
      console.log e
    else
      # console.log r
      console.log b.rows.filter((i)->i.id.lastIndexOf("ty", 0) == 0).map((i)->i.id.toUpperCase())
###

###
# toMap
hashlist = {}
hashlist.yndi = undefined
hashlist.nunll = null
hashlist.strl = "string"
hashlist.suuji = 34598
hashlist.suuti = 3093
hashlist.renso = {asdf:"asdf",suuji:2123,nanigasi:null,unden:undefined,"234234":3434,"aa":"ee"}
hashlist.hauire = [1,3,5,"asdf",null,undefined,{rendo:"hairetu"}]

toList = (arr)->
  list = []
  for v in arr
    if !v? || v == null
      list.push NULL: true
      continue
    
    if Array.isArray(v)
      list.push toList(v)
      continue
    
    switch typeof(v)
      when "string" then list.push S: v
      when "number" then list.push N: v
      when "boolean" then list.push BOOL: v
      when "object" then list.push toMap(v)
  
  L: list

toMap = (hl)->
  map = {}
  for k,v of hl
    if !v? || v == null
      map[k] = {NULL: true} 
      continue
    
    if Array.isArray(v)
      map[k] = toList(v)
      continue
    
    switch typeof(v)
      when "string" then  map[k] = S: v
      when "number" then  map[k] = N: v
      when "boolean" then  map[k] = BOOL: v
      when "object" then  map[k] = toMap(v)
  
  M: map

res = toMap hashlist

console.log res.M
console.log res.M.renso.M
console.log res.M.hauire.L[6]
###


###
# startsWith
startsWith = (a,b)-> a.lastIndexOf(b, 0) == 0

console.log startsWith "anokutra", "ano"
console.log startsWith "anokutra", "noi"
###



###
try
  require("request")
    .get "httahoo.co.jp"
    
    .on "response", (response) ->
      # ダウンロード結果を取得する
      console.log response.headers["content-type"]
      console.log response.statusCode
      # 200かつ画像でなければ削除
      if response.headers["content-type"].lastIndexOf("image/", 0) == 0 && response.statusCode == 200
        console.log "ok"
      else
        require("fs").unlinkSync './saved.jpg'
    
    .on "error", (e)->
      console.log e
      require("fs").unlinkSync './saved.jpg'
    
    .on "end", ->
      console.log "end"
    
    .pipe require("fs").createWriteStream('./saved.jpg')
catch e
  console.log "無効なURLなど"
  console.log e
###


###
data = path: './saved.jpg'

# クローズ
ch = () ->
  console.log "null,data返却"

file = require("fs").createWriteStream('./saved.jpg')
file.on "close", ch

# リクエスト実行
require("request").get("http://asdfasdf.com")
  .on "response", (response) ->
    # ダウンロード結果を取得する
    data.contentType = response.headers["content-type"]
    data.status = response.statusCode
  
  .on "error", (e) ->
    # closeハンドラを解除しないとここのcloseでハンドラを呼んでしまう
    file.removeListener "close", ch
    file.close()
    
    # ファイル削除
    require("fs").unlinkSync filePath
    
    # エラーとしてハンドラを呼び出す
    console.log "error,data返却"
  
  .pipe file
###

###
# 画像DL ng
require("request").get "ng"
  , (e,res,body)->
    if e?
      console.log e
      console.log res.statusCode
    else
      # console.log s
      console.log body
      
      w = require("fs").createWriteStream './saved.jpg'
      w.write body
###

###
require("request")
  .get "noinio"
  .pipe require("fs").createWriteStream('./saved2.jpg')
###

###
require("request")
  .get "naimon"
  .on "response", (r)->
    console.log 'statusCode: ', r.statusCode
    console.log 'content-length: ', r.headers['content-length']
  .pipe require("fs").createWriteStream('./saved.jpg')
###


###
obj = {}

ichi = {}
ichi.one = 1
ichi.one2 = 2
ichi.one3 = 3
ni = {}
ni.nii1 = ichi
ni.nii2 = 5
ni.nii3 = ichi
san = {}
san.thu = 7
san.thu2 = 8
san.thu3 = ni
ni.nii4 = ichi

obj.a = ichi
obj.i = ni
obj.u = san

# 変わらない・・・
console.log obj
console.dir obj
console.log obj.u
console.dir obj.u
###


###
# stdtいらない
# stdt = new Date()

console.time "tmp"
console.timeEnd "tmp"


console.time "a"
console.time "b"
[0...100000].forEach (i)->
console.timeEnd "b"
console.timeEnd "a"
###

###
# fat arrow 2
module.exports.tfunc = ->
  console.log "tfunc!"

# 使える
fa = (fv)=>
  this.tfunc()
  console.log fv

fa "ffvv"

# 使えない
sa = (sv)->
  # this.tfunc()
  console.log sv

sa "ssvv"
###

###
# fat arrow 1
fa = (fv)=>
  console.log @
  console.log fv

# console.log fa
fa()

sa = (sv)->
  # console.log @
  console.log sv

# console.log sa
sa()
###


###
# null value logic
nvl = (v)-> if v? then return v else return ""

console.log "OK1" if nvl("") == ""
console.log "OK2" if nvl(undefined) == ""
console.log "OK3" if nvl(null) == ""
console.log "OK4" if nvl("nanika") == "nanika"
console.log "OK5" if nvl(0) == 0
###


###
# nactor
nactor = require "nactor"
actor = nactor.actor
  hell:(msg)->
    console.log msg
    return "death"


actor.init()

actor.ask "hell", "dead"

actor.hell "deadman", (rep)->
  console.log rep
###

###
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

createList = (count)->
  i=0
  a=[]
  dt1 = new Date()
  # while 10000000 > i
  while count > i
    a.push getHash()
    i=1+i
    if i % 100000 == 0
      console.log new Date() - dt1
      console.log i 
      dt1 = new Date()
  a

para2 = (cb)->
  setTimeout ->
    j = "ok"
    createList 10000000
    
    cb j
  ,1

console.log "s"
para2 (j)-> console.log j
para2 (j)-> console.log j
para2 (j)-> console.log j
para2 (j)-> console.log j
console.log "e"
###

###
clo = (list)->
  list=[]
  
  a:(arr)->
    list = list.concat arr
  
  b:->
    console.log list


reki = clo()
# console.log reki
reki.a([1,2,3])
reki.b()
###



###
para = (cb)->
  setTimeout ->
    cb "asdf"
  ,1000

console.log "start"
para (str)-> console.log str
para (str)-> console.log str
para (str)-> console.log str
para (str)-> console.log str
console.log "end"
###

###
# async.map2
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

checkList = (a)->
  j = 0
  for i,ind in a
    if i != a[ind]
      console.log "ari"
    # else
    #   console.log "nasi"
    
    # if checkDuple(a, i)
    #   console.log "ari"
    j=1+j
    console.log j if j % 100000 == 0
  
  console.log new Date() - stdt

arr = []
dt1 = new Date()
require("async").map [0...10000000], (i)->
  if i % 100000 == 0
    console.log new Date() - dt1
    console.log i
    dt1 = new Date()
  
  arr.push getHash()

checkList arr
###

###
# async.map
ite = (i)->
  console.log i
  return i

require("async").map [0...10], ite, (e,r)->
  console.log e if e?
  console.log r
  console.log "end"
###

###
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

createList = (count)->
  i=0
  a=[]
  dt1 = new Date()
  # while 10000000 > i
  while count > i
    a.push getHash()
    i=1+i
    if i % 100000 == 0
      console.log new Date() - dt1
      console.log i 
      dt1 = new Date()
  a

checkList = (a)->
  j = 0
  for i,ind in a
    if i != a[ind]
      console.log "ari"
    # else
    #   console.log "nasi"
    
    # if checkDuple(a, i)
    #   console.log "ari"
    j=1+j
    console.log j if j % 100000 == 0
  
  console.log new Date() - stdt

# checkList createList(10000000)

# 一件ずつに変更
cluster = require "cluster"
if cluster.isMaster
  child = []
  arr = []
  # for i in [0...require("os").cpus().length]
  for i in [0...4]
    w = cluster.fork()
    console.log "fork:" + w.process.pid
    child.push w.process.pid
    
    w.on "message", (msg)->
      # console.log "concat"
      # console.log msg.length
      
      # console.log msg
      # dt1 = new Date()
      
      arr.push msg
      # arr = arr.concat msg
      # Array.prototype.push.apply(arr, msg);
      
      # console.log new Date() - dt1
    
    w.on "exit", (w)->
      console.log child
      child.pop()
      if child.length == 0
        checkList arr
        console.log "end"
        console.log new Date() - stdt
else
  # require("async").forever (cb)-> checker(); cb()
  # process.send createList(2500000)
  # process.send createList(5)
  i = 0
  while 1000000 > i
    process.send getHash()
    i=1+i
    if i % 100000 == 0
      console.log new Date() - dt1
      console.log i 
      dt1 = new Date()
  
  process.exit(process.pid)
###

###
cluster = require "cluster"
if cluster.isMaster
  child = []
  arr = []
  # for i in [0...require("os").cpus().length]
  for i in [0...4]
    w = cluster.fork()
    console.log "fork:" + w.process.pid
    child.push w.process.pid
    
    w.on "message", (msg)->
      console.log "concat"
      console.log msg.length
      
      # console.log msg
      dt1 = new Date()
      
      arr = arr.concat msg
      # Array.prototype.push.apply(arr, msg);
      
      console.log new Date() - dt1
    
    w.on "exit", (w,c,s,i)->
      console.log child
      child.pop()
      if child.length == 0
        checkList arr
        console.log "end"
        console.log new Date() - stdt
else
  # require("async").forever (cb)-> checker(); cb()
  process.send createList(2500000)
  # process.send createList(5)
  process.exit(process.pid)
###


###
# async再度
async = require 'async'

# parallel->非同期関数を利用できるというだけ
cntval = 5000000
async.parallel [
  (cb)->
    console.log "s1"
    setTimeout ->
      console.log "1"
      cb null, createList(cntval),
    ,1
  (cb)->
    console.log "s3"
    setTimeout ->
      console.log "2"
      cb null, createList(cntval),
    ,1
  (cb)->
    console.log "s3"
    setTimeout ->
      console.log "3"
      cb null, createList(cntval),
    ,1
  (cb)->
    console.log "s4"
    setTimeout ->
      console.log "4"
      cb null, createList(cntval),
    ,1
],(e,v)->
  console.log e if e?
  # console.log v
  
  # マージする
  console.log "==checkstart=="
  arr = []
  dt1 = new Date()
  for i in v
    arr = arr.concat i
    # Array.prototype.push.apply(arr, i);
    
    console.log new Date() - dt1
    dt1 = new Date()

  # console.log arr
  checkList arr
###


###
# series
cntval = 50000
async.series [
  (cb)->
    console.log "1"
    cb null, createList(cntval),
  (cb)->
    console.log "2"
    cb null, createList(cntval),
  (cb)->
    console.log "3"
    cb null, createList(cntval),
  (cb)->
    console.log "4"
    cb null, createList(cntval),
],(e,v)->
  console.log e if e?
  # console.log v
  
  # マージする
  console.log "==checkstart=="
  arr = []
  dt1 = new Date()
  for i in v
    arr = arr.concat i
    # Array.prototype.push.apply(arr, i);
    
    console.log new Date() - dt1
    dt1 = new Date()

  # console.log arr
  checkList arr
###



###
# parallel
async.parallel [
  (cb)->
    setTimeout ->
      [0...4].forEach (i)->
        console.log "a"+ i.toString()
      cb null, "1"
    ,1
  (cb)->
    setTimeout ->
      [0...4].forEach (i)->
        console.log "b"+ i.toString()
      cb null, "2"
    ,1
],(e,v)->
  console.log v

###


###
# チェックの関数を作り一件ずつループ
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

checkDuple = (list, value)-> list.indexOf(value) != list.lastIndexOf(value)

# i = 0
# while 3000000000 > i
#   i=1+i
#   # console.log i

# 14800000件までのは1秒だったのにそこから75秒かかるようになった
i = 0
a=[]
dt1 = new Date()
# while 10000000 > i
while 40000000 > i
  a.push getHash()
  i=1+i
  if i % 100000 == 0
    console.log new Date() - dt1
    console.log i 
    dt1 = new Date()

j = 0
for i,ind in a
  if i != a[ind]
    console.log "ari"
    
  # if checkDuple(a, i)
  #   console.log "ari"
  j=1+j
  console.log j if j % 100000 == 0

console.log  new Date() - stdt
###

###
cluster = require "cluster"
if cluster.isMaster
  # for i in [0...require("os").cpus().length]
  for i in [0...1]
    w = cluster.fork()
    console.log "fork:" + w.process.pid
else
  require("async").forever (cb)-> checker(); cb()
###

###
# 本来はこうやるのが正しいログイン
redis = require "redis"

client = redis.createClient()

client.set "exp", "ireire", (e,d)->
  console.log e if e?
  console.log d

  client.expire "exp", 20, (e,d)->
    console.log e if e?
    console.log d
    client.end()


# client.get "exp", (e,d)->
#   console.log d
#   client.end()
###


###
# 逐次にファイルに出力
[0...10].forEach (i)->
  require("fs").appendFile "output.txt", "nakami\n",(e)->
    if e?
      console.log e
###


###
# 10ケタでも重複しないか確認
uuid = require "node-uuid"
# console.log uuid.v1()
# console.log uuid.v4()

getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  # cry.update Math.floor(Math.random() * 1000000000000000000).toString(), "utf8"
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'


sikou = 0
checker = ->
  stdt1 = new Date()
  cnt = 20000000
  list = []
  i = 0
  
  while i < cnt
    hash = getHash().slice(0,10)
    if list.indexOf(hash) == -1
      list.push hash
    else
      console.log "duplex!"
      process.exit()
    
    i = 1 + i|0
    
    if i % 10000 == 0
      console.log i
  
  
  # console.log process.pid + ":" + (Object.keys(list).length).toString() + "/" + cnt.toString()
  
  console.log new Date().getTime() - stdt1
  
  sikou = 1 + sikou|0
  if sikou >= 5
    console.log new Date().getTime() - stdt
    process.exit()
###


###
sikou = 0
checker = ->
  stdt1 = new Date()
  cnt = 20000000
  list = {}
  i = 0
  
  while i < cnt
    # list.push getHash()
    
    # list[getHash()] = null
    # list[getHash().slice(0,10)] = null
    hash = getHash().slice(0,10)
    if list[hash]?
      console.log "duplex"
      process.exit()
    else
      list[hash] = null
    
    i = 1 + i|0
    
    if i % 100000 == 0
      console.log i
  
  # if Object.keys(list).length != cnt
  #   console.log "duplex!"
  
  # console.log process.pid + ":" + (Object.keys(list).length).toString() + "/" + cnt.toString()
  
  console.log new Date().getTime() - stdt1
  
  sikou = 1 + sikou|0
  if sikou >= 5
    console.log new Date().getTime() - stdt
    process.exit()
###


###
cluster = require "cluster"
if cluster.isMaster
  # for i in [0...require("os").cpus().length]
  for i in [0...1]
    w = cluster.fork()
    console.log "fork:" + w.process.pid
else
  require("async").forever (cb)-> checker(); cb()
###
# require("async").forever (cb)-> checker(); cb()


###
# メモリがリークする
[0...2000].forEach (i)->
  # console.log i.toString() + "回目"
  checker()
###



###
checker = ->
  # cnt = 10000000 # いったんこれで様子見
  cnt = 100000
  list = {}
  i = 0
  
  while i < cnt
    # list.push getHash()
    hash = getHash()
    list[hash] = 0
    i = 1 + i|0
    
    if i % 100000 == 0
      console.log i
  
  console.log list.length
  console.log new Date().getTime() - stdt
  
  # console.log list.map((i,ind)->list.indexOf(i)!=ind|0).every((i)->!i)
  
  # 重複確認
  if list.map((i,ind)->list.indexOf(i)!=ind).every((i)->!i)
    console.log "non duplex"
  else
    console.log "is duplex"
  
  console.log new Date().getTime() - stdt

[0...1].forEach (i)->
  # console.log i.toString() + "回目"
  checker()
###

###
# こりはダメだ・・・
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update Math.floor(Math.random() * 1000000000000000000).toString(), "utf8"
  cry.digest 'hex'
###


###
checker = ->
  # cnt = 10000000 # いったんこれで様子見
  cnt = 100000
  list = {}
  i = 0
  # [0...cnt].forEach (i)->
  while i < cnt
    # list[getHash().slice(0,10)] = i|0
    hash = getHash()
    # hash = Math.floor(Math.random() * 1000000000000000000).toString()
    # hash = Math.random().toString()
    
    # if list[hash]?
    #   console.log "ari!"
    #   console.log list
    #   console.log hash
    #   process.exit()
    # else
    #   list[hash] = i|0
    #   list[Math.floor(Math.random() * 1000000000000000000).toString()] = i|0
    
    # list[hash] = i|0
    list[hash] = 0
    i = 1 + i|0
    
    if i % 100000 == 0
      console.log i
  
  # console.log list
  # listcount = 0
  # for i of list
  #   # console.log i
  #   listcount = 1 + listcount|0
  
  
  # if cnt != listcount
  #   console.log "diff!!"
  #   console.log listcount.toString() + "/" + cnt.toString()
  #   console.log new Date().getTime() - stdt
  # else
    # console.log "noi"
    # console.log list
    # console.log new Date().getTime() - stdt
###


###
[0...1].forEach (i)->
  # console.log i.toString() + "回目"
  checker()
###

# checker()
# console.log getHash().slice(0,10)

###
console.log stdt-0
console.log stdt-1
###

###
# 明示的な型指定
kaisu = 2000000000
stdt1 = new Date()
i = 0
n = 0
while i < kaisu
  n = 1 + n|0
  i = 1 + i|0
console.log new Date() - stdt1

stdt2 = new Date()
i = 0
n = 0
while i < kaisu
  n = 1 + n
  i = 1 + i
console.log new Date() - stdt2
###

###
arr = [ 1, 3, 4, 5, 4, 4, 6, 76 ]

# どれか一つでもtrueならtrue
console.log arr.some( (e,i)-> e > 70 )

# すべてtrueならtrue
console.log arr.every( (e,i)-> e > 0 )

en = arr.entries()
console.log en.next()

readEntry = (en)->
  i = en.next()
  if i.done
    return
  else
    console.log i.value[1]
    readEntry en

readEntry arr.entries()
###



###
# ログもDBも同期的再帰処理で
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update Math.floor(Math.random() * 1000000).toString() + new Date().getTime().toString(), "utf8"
  cry.digest 'hex'


# fluent check 5 
cnt = 0
putter = ->
  obj = {}
  obj.id = getHash()
  obj.date = new Date().getTime().toString()

  require("request").post
    uri: "http://192.168.59.103:8888/debug.test" + cnt
    json: obj
    , (e,r,b)->
      if e?
        console.log e
      else
        # console.log r
        # console.log b
        console.log process.pid + ":" + (new Date() - stdt).toString() + ":"+ cnt.toString()
        cnt = cnt + 1
        
        if cnt >= 100000
          console.log "end!" + process.pid + ":" + (new Date() - stdt).toString() + ":"+ cnt.toString()
        else
          putter()
  
  # console.log process.pid + ":" + (new Date() - stdt).toString() + ":"+ cnt.toString()

# putter()

cluster = require "cluster"
if cluster.isMaster
  for i in [0...(require("os").cpus().length)]
    w = cluster.fork()
    console.log "fork:" + w.process.pid
else
  putter()


# async = require "async"
# async.forever (cb)->
#   putter()
#   setTimeout cb, 10
###



###
console.log "2015/07/17 20:00:00 -> " + (new Date("2015/07/17 20:00:00").getTime())
console.log "2015/07/17 11:00:00 -> " + (new Date("2015/07/17 11:00:00").getTime())
console.log "2015/07/17 10:30:00 -> " + (new Date("2015/07/17 10:30:00").getTime())
console.log "2015/07/17 10:15:00 -> " + (new Date("2015/07/17 10:15:00").getTime())
console.log new Date().getTime()
###



###
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update Math.floor(Math.random() * 1000000).toString() + new Date().getTime().toString(), "utf8"
  cry.digest 'hex'


# fluent check 4 -> 10ミリ待つとうまくいった
cnt = 0
putter = ->
  obj = {}
  obj.id = getHash()
  obj.date = new Date().getTime().toString()

  cnt = cnt + 1
  require("request").post
    uri: "http://192.168.59.103:8888/debug.test" + cnt
    json: obj

  console.log process.pid + ":" + (new Date() - stdt).toString() + ":"+ cnt.toString()


async = require "async"
async.forever (cb)->
  putter()
  setTimeout cb, 10
###


###
# fluent check 3 -> 多すぎて死
cnt = 0
blm = false
putter = ->
  if cnt >= 100000
    # process.exit()
    if blm == false
      console.log process.pid + ":para end:" + (new Date() - stdt).toString()
      blm = true
    else
      return
  else
    obj = {}
    obj.id = getHash()
    obj.date = new Date().getTime().toString()
    
    [0...100].forEach (i)->
      require('http').get "http://192.168.59.103:8888/debug.test" + cnt + "_" + i + "?json=" + encodeURIComponent(JSON.stringify(obj))
    
    cnt = cnt + 1
    console.log process.pid + ":" + (new Date() - stdt).toString() + ":"+ cnt.toString()
    if cnt % 1000 == 0
      true
      # console.log cnt
      # console.log process.pid + ":" + (new Date() - stdt).toString() + ":"+ cnt.toString()
      # console.log new Date() - stdt

async = require "async"

# async.forever (cb)-> putter(); cb()

cluster = require "cluster"
if cluster.isMaster
  for i in [0...(require("os").cpus().length)]
    w = cluster.fork()
    console.log "fork:" + w.process.pid
else
  async.forever (cb)-> putter(); cb()
###

###
# fluent check 2 ->30秒で死
cnt = 0
blm = false
putter = ->

  if cnt >= 100000
    # process.exit()
    if blm == false
      console.log process.pid + ":para end:" + (new Date() - stdt).toString()
      blm = true
    else
      return
  else
    obj = {}
    obj.id = getHash()
    obj.date = new Date().getTime().toString()
    
    require("request").post
      uri: "http://192.168.59.103:8888/debug.test" + cnt
      json: obj
    
    cnt = cnt + 1
    console.log process.pid + ":" + (new Date() - stdt).toString() + ":"+ cnt.toString()
    if cnt % 1000 == 0
      true
      # console.log cnt
      # console.log process.pid + ":" + (new Date() - stdt).toString() + ":"+ cnt.toString()
      # console.log new Date() - stdt

async = require "async"
async.forever (cb)-> putter(); cb()
###

###
# fluent check 1 ->1万件あたりで死にはじめる
[0...30000].forEach (i)->
  obj = {}
  obj.id = getHash()
  obj.date = new Date().getTime().toString()

  require("request").post
    uri: "http://192.168.59.103:8888/debug.test" + i
    json: obj

  console.log i + ":" + (new Date() - stdt).toString()
###



###
# fluentd2post
req = require "request"

obj = {}
obj.nopoaspo = "suststa"

req.post
  uri: "http://192.168.59.103:8888/debug.test"
  json: obj
  , (e,r,b)->
    console.log e
    # console.log r
    console.log b
###

###
# fluentd2get
obj = {}
obj.noi = "berg"

require('http').get "http://192.168.59.103:8888/debug.test?json=" + encodeURIComponent(JSON.stringify(obj)), (res)->
  # console.log res
  body = ''
  res.on 'data', (c)->
    console.log "data!"
    console.log c
    body += c
  
  
  res.on 'end',(res)->
    console.log "end!"
    console.log res
    console.log(body)
  
  console.log("test")
###


###
# fluent6
f = require('fluent-logger-node')
l = f.createLogger
  host: "192.168.59.103"
  port: 8888
  tagPrefix: "tag"

obj = {}
obj.joi = "npoi"

l.post {"":""}
###

###
# 配列メソッド
log = console.log.bind(console)

am = 
  a: -> log "is a"
  b: -> log "is b"
  c: -> log "is c"

am.a()
log am
###


###
# 次の処理渡しの設計
log = console.log.bind(console)

createCb = (cb)->
  return (str)->
    str = str + "dfdf"
    cb(str)

postCb = (cb)->
  log "posted"
  cb("possss")

render = (str)->
  log "render no game:" + str

env = "debag"
if env == "debag"
  log "debug mode"
  postCb createCb (st)->
    render st
  # postCb (str)->
  #   str = str + "dfdf"
  #   render str
  
else
  log "not debug"
  render "noi"
###


###
# socket分離
switch process.argv[2]
  when "1"
    console.log "1"
    require('http').createServer (req, res)-> 
      res.writeHead 200, "Content-Type":"text/html"
      res.end require('jade').compileFile("./index.jade")()
    .listen(process.env.VMC_APP_PORT || 3001)
  when "2"
    console.log "2"
    io = require('socket.io').listen(3002)
    io.adapter require("socket.io-redis")()
    
    io.sockets.on "connection", (soc)->
      console.log "server_conn"
      soc.on "ioemit",(data)-> io.emit "cast",(data)
      soc.on 'broadcast', (data) -> soc.broadcast.emit "cast",(data)
      soc.on 'socemit', (data) -> soc.emit "cast",(data)
###

###
# emitter5
switch process.argv[2]
  when "1"
    console.log "1"
    io = require('socket.io').listen(
      require('http').createServer (req, res)-> 
        res.writeHead 200, "Content-Type":"text/html"
        res.end require('jade').compileFile("./index.jade")()
      .listen(process.env.VMC_APP_PORT || 3001)
    )
    
    io.adapter require("socket.io-redis")()
    # io.set "transports",["websocket", "polling"]
    
    io.sockets.on "connection", (soc)->
      console.log "server_conn"
      soc.on "s",(d)->
        console.log "s"
        console.log d
      
      soc.on "ioemit",(data)-> io.emit "cast",(data)
      soc.on 'broadcast', (data) -> soc.broadcast.emit "cast",(data)
      soc.on 'socemit', (data) -> soc.emit "cast",(data)
    
  when "2"
    console.log "2"
    clisoc = require("socket.io-client").connect("http://localhost:3001")
    clisoc.on 'c', (data) ->
      console.log "c"
      console.log data
    
    clisoc.on "c_emit",(v)-> clisoc.emit 's', v
    
  when "3"
    console.log "3"
    # redisの場所を指定
    e = require("socket.io-emitter")("localhost")
    e.emit "tofro3", "noifor"
    e.emit "s", "tos"
    e.emit "c", "toc"
    e.emit "c_emit", "toc_tmi"
    
    e.emit "ion", "ion!"
    e.emit "son", "son!"
    e.emit "socon", "socon!"
  else
    console.log "else"
###






###
# emitter4
io = require('socket.io').listen(
  require('http').createServer (req, res)-> 
    res.writeHead 200, "Content-Type":"text/html"
    res.end require('jade').compileFile("./index.jade")()
  .listen(process.env.VMC_APP_PORT || 3001)
)

io.adapter require("socket.io-redis")()
# io.set "transports",["websocket", "polling"]

io.sockets.on "connection", (soc)->
  console.log "sev-conn"
  soc.on "sev-emit",(d)->
    console.log "rust"
    console.log d
  
  soc.on "disconnect", ->
    console.log "discon"
  
  soc.on 'ioemit', (data) -> io.emit "cast",(data)
  soc.on 'broadcast', (data) -> soc.broadcast.emit "cast",(data)
  soc.on 'socemit', (data) ->
    console.log "check"
    soc.emit "cast",(data)
  
  soc.on "tofro2",(v)->
    console.log "nininini"
    soc.emit 'tofro3', "eses"


clisoc = require("socket.io-client").connect("http://localhost:3001")

clisoc.on 'connect', -> console.log "cli-conn"

clisoc.on 'cli-putter', (data) ->
  console.log "putter"
  console.log data
  clisoc.emit "sev-emit", "severemit"

clisoc.on "emitkeycli",(v)->
  console.log "emitcli-kta"
  console.log v
  clisoc.emit "cli-putter", "puttau@tta"

clisoc.on "tosev",(v)->
  clisoc.emit 'ioemit', v

clisoc.on "tofro1",(v)->
  console.log "ichi"
  clisoc.emit 'tofro2', "onono"



# redisの場所を指定
e = require("socket.io-emitter")("localhost")
e.emit "cli-putter", "putted"
e.emit "emitkeycli", "hakka"
e.emit "tosev", "this is emittter"
e.emit "socemit", "noi"
e.emit "tofro3", "noifor"
###


###
# emitter3
io = require('socket.io').listen(
  require('http').createServer (req, res)-> 
    res.writeHead 200, "Content-Type":"text/html"
    res.end require('jade').compileFile("./index.jade")()
  .listen(process.env.VMC_APP_PORT || 3001)
)

io.adapter require("socket.io-redis")()
# io.set "transports",["websocket", "polling"]

# io.sockets.on "koreka", (d)->
#   console.log "korenanone"
 #  console.log d

io.sockets.on "connection", (soc)->
  console.log "conn-sev"
  soc.on "koreka",(d)->
    console.log "rust"
    console.log d
  
  soc.on "emitkey", (d)->
    console.log "emit-sev"
    console.log d
  
  soc.on 'ioemit', (data) -> io.emit "cast",(data)
  soc.on 'broadcast', (data) -> soc.broadcast.emit "cast",(data)
  soc.on 'socemit', (data) -> soc.emit "cast",(data)
  
  soc.on "disconnect", ->
    console.log "discon"

clisoc = require("socket.io-client").connect("http://localhost:3001")

clisoc.on 'cliioemit', (data) ->
  console.log "emitnasi io"
  clisoc.emit "cast",(data)
  clisoc.emit "koreka",(data)

# clisoc.on 'clibroadcast', (data) -> clisoc.broadcast.emit "cast",(data)

clisoc.on 'clisocemit', (data) ->
  console.log "emit nasi soc"
  clisoc.emit "cast",(data)

clisoc.on 'connection', (d)-> 
  console.log "cli-conntion"

clisoc.on 'connect', ()-> 
  console.log "cli-conn"

clisoc.on "emitkeycli",(v)->
  console.log "emitcli-kta"
  console.log v

# redisの場所を指定
e = require("socket.io-emitter")("localhost")
e.emit "emitkeycli", "valVal"
e.emit "ioemit", "emitter-io"
e.emit "broadcast", "emitter-bc"
e.emit "socemit", "emitter-se"
e.emit "cliioemit", "emitter-io2"
e.emit "clibroadcast", "emitter-bc2"
e.emit "clisocemit", "emitter-se2"

e.emit "koreka", "koreyooo-se"
###


###
# emitter2
server = require("http").createServer (q,s)->
  s.writeHead 200, "Content-Type": "text/html"
  s.end require('jade').compileFile("./index.jade")()

io = require("socket.io").listen(server)
server.listen 3001

io.adapter require("socket.io-redis")()

io.sockets.on "connection", (soc)->
  console.log "conn-sev"
  soc.on "emitkey", (d)->
    console.log "emit-sev"
    console.log d
  
  soc.on 'ioemit', (data) -> io.emit "cast",(data)
  soc.on 'broadcast', (data) -> soc.broadcast.emit "cast",(data)
  soc.on 'socemit', (data) -> soc.emit "cast",(data)
  
  soc.on "disconnect", ->
    console.log "discon"

clisoc = require("socket.io-client").connect("http://localhost:3001")

# console.log clisoc
clisoc.on 'ioemit', (data) -> clisoc.io.emit "cast",(data)
# clisoc.on 'broadcast', (data) -> clisoc.broadcast.emit "cast",(data)
clisoc.on 'socemit', (data) -> clisoc.emit "cast",(data)

clisoc.on 'connection', (d)-> 
  console.log "conntion"


clisoc.on 'connect', (d)-> 
  console.log "conn"
  console.log d

clisoc.on "emitkeycli",(v)->
  console.log "emitcli-kta"
  console.log v

# redisの場所を指定
e = require("socket.io-emitter")("localhost")
e.emit "emitkeycli", "valVal"
e.emit "ioemit", "emitter-io"
e.emit "broadcast", "emitter-bc"
e.emit "socemit", "emitter-se"
###

###
# bind
log = console.log.bind(console)

log "noi"
###


###
interceptFilenameText = (filename, text)->
  file = filename
  splited = file.split(".")
  if splited.length > 1
    ext = splited.pop()
    splited.push splited.pop() + text
    splited.push ext
    splited.join(".")
  else
    return "err"

console.log interceptFilenameText "assadflj.jpg", "_20150101"
###

###
# 拡張子の入れ替えパターン(splitしてpop)
file = "asdfsdf.jpg"
splited = file.split(".")
ext = splited.pop()
splited.push "_20150101"
splited.push "."
splited.push ext
console.log splited.join("")
###



###
# ランダムな数字がランダムに返ってくるのをソートする
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update Math.floor(Math.random() * 1000000).toString() + new Date().getTime().toString(), "utf8"
  cry.digest 'hex'

getRandomRandomList = ()->
  list = []
  
  [0...Math.floor(Math.random() * 10)].forEach (i)->
    obj = {}
    obj.id = getHash()
    obj.num = Math.floor(Math.random() * 1000000000000)
    list.push obj
  
  return list

sorting = (list)->
  list.sort (a,b)-> 
    return 1 if parseInt(a.num) < parseInt(b.num)
    return -1 if parseInt(a.num) > parseInt(b.num)
    return 0
  return list
###

# getMax = (list, max)->
#   sorting(list).splice(0, max)

###
list = []
allcnt = 0
# [0...10].forEach (i)->
# while allcnt < 6500000
# 一千万逐次処理なら80秒
# while allcnt < 10000000
while allcnt < 100000
  grrl = getRandomRandomList()
  allcnt = allcnt + grrl.length 
  list = list.concat grrl
  # list = getMax(list, 25)
  # list = sorting(list).splice(0, 25)
  list = sorting(list).splice(0, 100)
###

###
# 一千万最後pop方式なら60秒
list = []
allcnt = 0
while allcnt < 10000000
  grrl = getRandomRandomList()
  allcnt = allcnt + grrl.length 
  grrl.forEach (i)->
    if list.length >= 100
      if i.num > list[99].num 
        list.pop()
        list.push i
        list = sorting list
    else
      list.push i
      list = sorting list

console.log list.map((i)->i.num)
console.log list.length
console.log "allcnt:" + allcnt.toString()
console.log "alltime:" + (new Date() - stdt).toString()
###

###
getRandomList = (cnt = 10)->
  list = []
  
  [0...cnt].forEach (i)->
    obj = {}
    obj.id = getHash()
    obj.num = Math.floor(Math.random() * 100000000)
    list.push obj
  
  return list
###





# 一千万ソートは無理がありそう
# sorting getRandomList(10000000)

###
# ng
list = []
while list.length < 1000000
  list = list.concat sorting getRandomRandomList()
###


###
[0...5].forEach (i)->
  return false if list.length > 10
  
  list = list.concat sorting getRandomRandomList()
###

# console.log list.length
# console.log "alltime:" + (new Date() - stdt).toString()


###
# NG
num = Math.floor(Math.random() * 100)
switch num
  when [1...30].map((i)->i)
    console.log "ture"
  else
    console.log "noi"

console.log num
###

###
# コンソールを表示したときに演算が行われる
a = {}
 
setTimeout ->
  a.hoge = "Hello world!"
,1000
 
console.log "output a ->", a
console.log "output a.hoge ->", a.hoge
###

###
# jointjs
j = require "jointjs"
g = new j.dia.Graph
el1 = new j.shapes.basic.Rect
  position:{x:50,y:50}
  attrs:{text:{fill:"yellow"}}

g.addCells [el1]

console.log g.toJSON()
###


###
# 再帰的@→不可
recu = (con, nene=null)->
  console.log con
  console.log nene
  
  console.log @
  
  if nene == null
    recu "nikaime", "nini"

console.log "start"
recu "dodo"
console.log "end"
###


###
# express-jwtその2
app = require("express")()
jwt= require "jsonwebtoken" 
ejwt = require "express-jwt"


SEC = "rexret"

app.use "/api", ejwt secret:SEC

app.get "/auth", (req,res)->
  pro =
    saf:"ichi"
    werwer:"nii"
    fefef:"sann"
  
  token = jwt.sign pro, SEC, {expiresInMinutes: 60*5}
  
  res.json {token:token}
  console.log req.body
  for i,j of res
    console.log i
  
  if !req.body? or req.body.jjwwtt != "noi"
    res.send "nothinn"
    return
  else
    pro =
      saf:"ichi"
      werwer:"nii"
      fefef:"sann"
    
    token = jwt.sign pro, SEC, {expiresInMinutes: 60*5}
    
    res.json {token:token}

app.get "/",(req,res)->
  # console.log req
  # console.log res
  res.json req

require("http").createServer(app).listen 3000,-> console.log "go"
###

###
# express-jwtその1
app = require("express")()
jwt = require "express-jwt"

app.get "/",
  jwt secret: "rexret"
  (req,res)->
    console.log req
    console.log res
    res.send "deash"


require("http").createServer(app).listen 3000,-> console.log "go"
###


###
# JWTその2 
token = require("jsonwebtoken").sign
  da: "taa"
  , "secrett"

require("jsonwebtoken").verify token, "secrett", (e, d)->
  if e?
    console.log e
    console.log e.name
    console.log e.message
  else
    console.log d
    console.log d.da

deco = require("jsonwebtoken").decode token, complete:true
console.log deco
console.log deco.header
console.log deco.payload
console.log deco.signature
###



###
# JWTその1
jwt = require "jsonwebtoken"

data = da: "taa"
# console.log data

token = jwt.sign data, "secrett"
# console.log token

jwt.verify token, "secrett", (e, d)->
  console.log d.da
###

###
console.log "2015/06/11 00:00:00 -> " + (new Date("2015/06/11 00:00:00").getTime())
console.log "2015/06/12 00:00:00 -> " + (new Date("2015/06/12 00:00:00").getTime())
console.log "2015/06/12 10:30:00 -> " + (new Date("2015/06/12 10:30:00").getTime())
console.log "2015/06/12 11:00:00 -> " + (new Date("2015/06/12 11:00:00").getTime())
console.log "2015/06/12 12:00:00 -> " + (new Date("2015/06/12 12:00:00").getTime())
###

###
console.log "2015/06/14 00:00:00 -> " + (new Date("2015/06/14 00:00:00").getTime())
console.log "2015/06/16 00:00:00 -> " + (new Date("2015/06/16 00:00:00").getTime())
console.log "2015/06/17 00:00:00 -> " + (new Date("2015/06/17 00:00:00").getTime())
console.log "2015/06/18 00:00:00 -> " + (new Date("2015/06/18 00:00:00").getTime())
console.log "2015/06/19 00:00:00 -> " + (new Date("2015/06/19 00:00:00").getTime())
###

###
console.log (1433862000000 / 600000) % 60
console.log (1433862600000 / 600000) % 60
console.log 1433863200000 / 600000
console.log 1433863800000 / 600000
console.log 1433864400000 / 600000
console.log 1433865000000 / 600000
console.log 1433865600000 / 600000
console.log 1433866200000 / 600000
console.log 1433866800000 / 600000
console.log 1433867400000 / 600000
console.log 1433868000000 / 600000
console.log 1433868600000 / 600000
console.log 1433869200000 / 600000
console.log 1433869800000 / 600000
console.log 1433870400000 / 600000
console.log 1433871000000 / 600000
console.log 1433871600000 / 600000
console.log 1433872200000 / 600000
console.log 1433872800000 / 600000
###

###
a=2
switch
  when 1>a then console.log "ichi"
  when 2>a then console.log "ni"
  when 3>a then console.log "san"
  when 4>a then console.log "shi"
  else console.log "death"
###

###
# 時刻
console.log "2015/06/10 00:00:00 -> " + (new Date("2015/06/10 00:00:00").getTime())
console.log "2015/06/10 00:10:00 -> " + (new Date("2015/06/10 00:10:00").getTime())
console.log "2015/06/10 00:20:00 -> " + (new Date("2015/06/10 00:20:00").getTime())
console.log "2015/06/10 00:30:00 -> " + (new Date("2015/06/10 00:30:00").getTime())
console.log "2015/06/10 00:40:00 -> " + (new Date("2015/06/10 00:40:00").getTime())
console.log "2015/06/10 00:50:00 -> " + (new Date("2015/06/10 00:50:00").getTime())

console.log "2015/06/10 01:00:00 -> " + (new Date("2015/06/10 01:00:00").getTime())
console.log "2015/06/10 01:10:00 -> " + (new Date("2015/06/10 01:10:00").getTime())
console.log "2015/06/10 01:20:00 -> " + (new Date("2015/06/10 01:20:00").getTime())
console.log "2015/06/10 01:30:00 -> " + (new Date("2015/06/10 01:30:00").getTime())
console.log "2015/06/10 01:40:00 -> " + (new Date("2015/06/10 01:40:00").getTime())
console.log "2015/06/10 01:50:00 -> " + (new Date("2015/06/10 01:50:00").getTime())
                                                               
console.log "2015/06/10 02:00:00 -> " + (new Date("2015/06/10 02:00:00").getTime())
console.log "2015/06/10 02:10:00 -> " + (new Date("2015/06/10 02:10:00").getTime())
console.log "2015/06/10 02:20:00 -> " + (new Date("2015/06/10 02:20:00").getTime())
console.log "2015/06/10 02:30:00 -> " + (new Date("2015/06/10 02:30:00").getTime())
console.log "2015/06/10 02:40:00 -> " + (new Date("2015/06/10 02:40:00").getTime())
console.log "2015/06/10 02:50:00 -> " + (new Date("2015/06/10 02:50:00").getTime())
                                                               
console.log "2015/06/10 03:00:00 -> " + (new Date("2015/06/10 03:00:00").getTime())
console.log "2015/06/10 03:10:00 -> " + (new Date("2015/06/10 03:10:00").getTime())
console.log "2015/06/10 03:20:00 -> " + (new Date("2015/06/10 03:20:00").getTime())
console.log "2015/06/10 03:30:00 -> " + (new Date("2015/06/10 03:30:00").getTime())
console.log "2015/06/10 03:40:00 -> " + (new Date("2015/06/10 03:40:00").getTime())
console.log "2015/06/10 03:50:00 -> " + (new Date("2015/06/10 03:50:00").getTime())
                                                               
console.log "2015/06/10 04:00:00 -> " + (new Date("2015/06/10 04:00:00").getTime())
console.log "2015/06/10 04:10:00 -> " + (new Date("2015/06/10 04:10:00").getTime())
console.log "2015/06/10 04:20:00 -> " + (new Date("2015/06/10 04:20:00").getTime())
console.log "2015/06/10 04:30:00 -> " + (new Date("2015/06/10 04:30:00").getTime())
console.log "2015/06/10 04:40:00 -> " + (new Date("2015/06/10 04:40:00").getTime())
console.log "2015/06/10 04:50:00 -> " + (new Date("2015/06/10 04:50:00").getTime())
                                                               
console.log "2015/06/10 05:00:00 -> " + (new Date("2015/06/10 05:00:00").getTime())
console.log "2015/06/10 05:10:00 -> " + (new Date("2015/06/10 05:10:00").getTime())
console.log "2015/06/10 05:20:00 -> " + (new Date("2015/06/10 05:20:00").getTime())
console.log "2015/06/10 05:30:00 -> " + (new Date("2015/06/10 05:30:00").getTime())
console.log "2015/06/10 05:40:00 -> " + (new Date("2015/06/10 05:40:00").getTime())
console.log "2015/06/10 05:50:00 -> " + (new Date("2015/06/10 05:50:00").getTime())
                                                               
console.log "2015/06/10 06:00:00 -> " + (new Date("2015/06/10 06:00:00").getTime())
console.log "2015/06/10 06:10:00 -> " + (new Date("2015/06/10 06:10:00").getTime())
console.log "2015/06/10 06:20:00 -> " + (new Date("2015/06/10 06:20:00").getTime())
console.log "2015/06/10 06:30:00 -> " + (new Date("2015/06/10 06:30:00").getTime())
console.log "2015/06/10 06:40:00 -> " + (new Date("2015/06/10 06:40:00").getTime())
console.log "2015/06/10 06:50:00 -> " + (new Date("2015/06/10 06:50:00").getTime())
                                                               
console.log "2015/06/10 07:00:00 -> " + (new Date("2015/06/10 07:00:00").getTime())
console.log "2015/06/10 07:10:00 -> " + (new Date("2015/06/10 07:10:00").getTime())
console.log "2015/06/10 07:20:00 -> " + (new Date("2015/06/10 07:20:00").getTime())
console.log "2015/06/10 07:30:00 -> " + (new Date("2015/06/10 07:30:00").getTime())
console.log "2015/06/10 07:40:00 -> " + (new Date("2015/06/10 07:40:00").getTime())
console.log "2015/06/10 07:50:00 -> " + (new Date("2015/06/10 07:50:00").getTime())
                                                               
console.log "2015/06/10 08:00:00 -> " + (new Date("2015/06/10 08:00:00").getTime())
console.log "2015/06/10 08:10:00 -> " + (new Date("2015/06/10 08:10:00").getTime())
console.log "2015/06/10 08:20:00 -> " + (new Date("2015/06/10 08:20:00").getTime())
console.log "2015/06/10 08:30:00 -> " + (new Date("2015/06/10 08:30:00").getTime())
console.log "2015/06/10 08:40:00 -> " + (new Date("2015/06/10 08:40:00").getTime())
console.log "2015/06/10 08:50:00 -> " + (new Date("2015/06/10 08:50:00").getTime())
                                                               
console.log "2015/06/10 09:00:00 -> " + (new Date("2015/06/10 09:00:00").getTime())
console.log "2015/06/10 09:10:00 -> " + (new Date("2015/06/10 09:10:00").getTime())
console.log "2015/06/10 09:20:00 -> " + (new Date("2015/06/10 09:20:00").getTime())
console.log "2015/06/10 09:30:00 -> " + (new Date("2015/06/10 09:30:00").getTime())
console.log "2015/06/10 09:40:00 -> " + (new Date("2015/06/10 09:40:00").getTime())
console.log "2015/06/10 09:50:00 -> " + (new Date("2015/06/10 09:50:00").getTime())
                                                               
console.log "2015/06/10 10:00:00 -> " + (new Date("2015/06/10 10:00:00").getTime())
console.log "2015/06/10 10:10:00 -> " + (new Date("2015/06/10 10:10:00").getTime())
console.log "2015/06/10 10:20:00 -> " + (new Date("2015/06/10 10:20:00").getTime())
console.log "2015/06/10 10:30:00 -> " + (new Date("2015/06/10 10:30:00").getTime())
console.log "2015/06/10 10:40:00 -> " + (new Date("2015/06/10 10:40:00").getTime())
console.log "2015/06/10 10:50:00 -> " + (new Date("2015/06/10 10:50:00").getTime())
                                                               
console.log "2015/06/10 11:00:00 -> " + (new Date("2015/06/10 11:00:00").getTime())
console.log "2015/06/10 11:10:00 -> " + (new Date("2015/06/10 11:10:00").getTime())
console.log "2015/06/10 11:20:00 -> " + (new Date("2015/06/10 11:20:00").getTime())
console.log "2015/06/10 11:30:00 -> " + (new Date("2015/06/10 11:30:00").getTime())
console.log "2015/06/10 11:40:00 -> " + (new Date("2015/06/10 11:40:00").getTime())
console.log "2015/06/10 11:50:00 -> " + (new Date("2015/06/10 11:50:00").getTime())
                                                               
console.log "2015/06/10 12:00:00 -> " + (new Date("2015/06/10 12:00:00").getTime())
console.log "2015/06/10 12:10:00 -> " + (new Date("2015/06/10 12:10:00").getTime())
console.log "2015/06/10 12:20:00 -> " + (new Date("2015/06/10 12:20:00").getTime())
console.log "2015/06/10 12:30:00 -> " + (new Date("2015/06/10 12:30:00").getTime())
console.log "2015/06/10 12:40:00 -> " + (new Date("2015/06/10 12:40:00").getTime())
console.log "2015/06/10 12:50:00 -> " + (new Date("2015/06/10 12:50:00").getTime())
                                                               
console.log "2015/06/10 13:00:00 -> " + (new Date("2015/06/10 13:00:00").getTime())
console.log "2015/06/10 13:10:00 -> " + (new Date("2015/06/10 13:10:00").getTime())
console.log "2015/06/10 13:20:00 -> " + (new Date("2015/06/10 13:20:00").getTime())
console.log "2015/06/10 13:30:00 -> " + (new Date("2015/06/10 13:30:00").getTime())
console.log "2015/06/10 13:40:00 -> " + (new Date("2015/06/10 13:40:00").getTime())
console.log "2015/06/10 13:50:00 -> " + (new Date("2015/06/10 13:50:00").getTime())
                                                               
console.log "2015/06/10 14:00:00 -> " + (new Date("2015/06/10 14:00:00").getTime())
console.log "2015/06/10 14:10:00 -> " + (new Date("2015/06/10 14:10:00").getTime())
console.log "2015/06/10 14:20:00 -> " + (new Date("2015/06/10 14:20:00").getTime())
console.log "2015/06/10 14:30:00 -> " + (new Date("2015/06/10 14:30:00").getTime())
console.log "2015/06/10 14:40:00 -> " + (new Date("2015/06/10 14:40:00").getTime())
console.log "2015/06/10 14:50:00 -> " + (new Date("2015/06/10 14:50:00").getTime())
                                                               
console.log "2015/06/10 15:00:00 -> " + (new Date("2015/06/10 15:00:00").getTime())
console.log "2015/06/10 15:10:00 -> " + (new Date("2015/06/10 15:10:00").getTime())
console.log "2015/06/10 15:20:00 -> " + (new Date("2015/06/10 15:20:00").getTime())
console.log "2015/06/10 15:30:00 -> " + (new Date("2015/06/10 15:30:00").getTime())
console.log "2015/06/10 15:40:00 -> " + (new Date("2015/06/10 15:40:00").getTime())
console.log "2015/06/10 15:50:00 -> " + (new Date("2015/06/10 15:50:00").getTime())
                                                               
console.log "2015/06/10 16:00:00 -> " + (new Date("2015/06/10 16:00:00").getTime())
console.log "2015/06/10 16:10:00 -> " + (new Date("2015/06/10 16:10:00").getTime())
console.log "2015/06/10 16:20:00 -> " + (new Date("2015/06/10 16:20:00").getTime())
console.log "2015/06/10 16:30:00 -> " + (new Date("2015/06/10 16:30:00").getTime())
console.log "2015/06/10 16:40:00 -> " + (new Date("2015/06/10 16:40:00").getTime())
console.log "2015/06/10 16:50:00 -> " + (new Date("2015/06/10 16:50:00").getTime())
                                                               
console.log "2015/06/10 17:00:00 -> " + (new Date("2015/06/10 17:00:00").getTime())
console.log "2015/06/10 17:10:00 -> " + (new Date("2015/06/10 17:10:00").getTime())
console.log "2015/06/10 17:20:00 -> " + (new Date("2015/06/10 17:20:00").getTime())
console.log "2015/06/10 17:30:00 -> " + (new Date("2015/06/10 17:30:00").getTime())
console.log "2015/06/10 17:40:00 -> " + (new Date("2015/06/10 17:40:00").getTime())
console.log "2015/06/10 17:50:00 -> " + (new Date("2015/06/10 17:50:00").getTime())
                                                               
console.log "2015/06/10 18:00:00 -> " + (new Date("2015/06/10 18:00:00").getTime())
console.log "2015/06/10 18:10:00 -> " + (new Date("2015/06/10 18:10:00").getTime())
console.log "2015/06/10 18:20:00 -> " + (new Date("2015/06/10 18:20:00").getTime())
console.log "2015/06/10 18:30:00 -> " + (new Date("2015/06/10 18:30:00").getTime())
console.log "2015/06/10 18:40:00 -> " + (new Date("2015/06/10 18:40:00").getTime())
console.log "2015/06/10 18:50:00 -> " + (new Date("2015/06/10 18:50:00").getTime())
                                                               
console.log "2015/06/10 19:00:00 -> " + (new Date("2015/06/10 19:00:00").getTime())
console.log "2015/06/10 19:10:00 -> " + (new Date("2015/06/10 19:10:00").getTime())
console.log "2015/06/10 19:20:00 -> " + (new Date("2015/06/10 19:20:00").getTime())
console.log "2015/06/10 19:30:00 -> " + (new Date("2015/06/10 19:30:00").getTime())
console.log "2015/06/10 19:40:00 -> " + (new Date("2015/06/10 19:40:00").getTime())
console.log "2015/06/10 19:50:00 -> " + (new Date("2015/06/10 19:50:00").getTime())
                                                               
console.log "2015/06/10 20:00:00 -> " + (new Date("2015/06/10 20:00:00").getTime())
console.log "2015/06/10 20:10:00 -> " + (new Date("2015/06/10 20:10:00").getTime())
console.log "2015/06/10 20:20:00 -> " + (new Date("2015/06/10 20:20:00").getTime())
console.log "2015/06/10 20:30:00 -> " + (new Date("2015/06/10 20:30:00").getTime())
console.log "2015/06/10 20:40:00 -> " + (new Date("2015/06/10 20:40:00").getTime())
console.log "2015/06/10 20:50:00 -> " + (new Date("2015/06/10 20:50:00").getTime())
                                                               
console.log "2015/06/10 21:00:00 -> " + (new Date("2015/06/10 21:00:00").getTime())
console.log "2015/06/10 21:10:00 -> " + (new Date("2015/06/10 21:10:00").getTime())
console.log "2015/06/10 21:20:00 -> " + (new Date("2015/06/10 21:20:00").getTime())
console.log "2015/06/10 21:30:00 -> " + (new Date("2015/06/10 21:30:00").getTime())
console.log "2015/06/10 21:40:00 -> " + (new Date("2015/06/10 21:40:00").getTime())
console.log "2015/06/10 21:50:00 -> " + (new Date("2015/06/10 21:50:00").getTime())
                                                               
console.log "2015/06/10 22:00:00 -> " + (new Date("2015/06/10 22:00:00").getTime())
console.log "2015/06/10 22:10:00 -> " + (new Date("2015/06/10 22:10:00").getTime())
console.log "2015/06/10 22:20:00 -> " + (new Date("2015/06/10 22:20:00").getTime())
console.log "2015/06/10 22:30:00 -> " + (new Date("2015/06/10 22:30:00").getTime())
console.log "2015/06/10 22:40:00 -> " + (new Date("2015/06/10 22:40:00").getTime())
console.log "2015/06/10 22:50:00 -> " + (new Date("2015/06/10 22:50:00").getTime())

console.log "2015/06/10 23:00:00 -> " + (new Date("2015/06/10 23:00:00").getTime())
console.log "2015/06/10 23:10:00 -> " + (new Date("2015/06/10 23:10:00").getTime())
console.log "2015/06/10 23:20:00 -> " + (new Date("2015/06/10 23:20:00").getTime())
console.log "2015/06/10 23:30:00 -> " + (new Date("2015/06/10 23:30:00").getTime())
console.log "2015/06/10 23:40:00 -> " + (new Date("2015/06/10 23:40:00").getTime())
console.log "2015/06/10 23:50:00 -> " + (new Date("2015/06/10 23:50:00").getTime())
###





###
# request再度
require("request").get
  url: "http://localhost:3000/json"
  json:false
  , (e,s,b)->
    if e?
      console.log e
    else
      console.log s
      console.log b.asdf
###



###
# デコエン3
crypto = require 'crypto'

# cryptkey作成
getMD5Hash = -> 
  cry = require("crypto").createHash 'MD5'
  cry.update "randomToken", "utf8"
  cry.digest 'hex'

# IVの鍵作成
hash = crypto.createHash 'md5'
hash.update 'randomToken'
ive = hash.digest()

text = '共通鍵暗号方式'

hash = "526b0e737e7ad6e3"
# hash = getMD5Hash()
# 526b0e737e7ad6e3
# 344da44e56559ce5
console.log getMD5Hash()

cipher = crypto.createCipheriv 'aes-128-cbc', hash, ive
crypted = cipher.update text, 'utf-8', 'hex'
crypted += cipher.final 'hex'

console.log crypted

decipher = crypto.createDecipheriv 'aes-128-cbc', hash, ive
# decipher.update crypted, 'hex', 'utf-8'
decode = decipher.update crypted, 'hex', 'utf-8'
decode += decipher.final "utf-8"

console.log decode
console.log new Date().getTime() + (60 * 60 * 1000)
###

###
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update Math.floor(Math.random() * 1000000).toString() + new Date().getTime().toString(), "utf8"
  cry.digest 'hex'

console.log getHash
###

###
@method sadf
  @param [String] fdfdf
  @option [sdfkj] fefe
sadf= ->
  console.log "noi"
###

###
# emitter
server = require("http").createServer (q,s)->
  res.writeHead 200,
    Content-Type: "text/html"
  res.end("sev conn")

console.log "1"
io = require("socket.io").listen(server)
server.listen 3000

rs = require "socket.io-redis"
io.adapter rs(
  host: "localhost"
  port: 6379
  )


console.log "2"
io.sockets.on "connection", (soc)->
  soc.on "emitkey", (d)->
    console.log "emit11"
    console.log d
  
  soc.on "disconnect", ->
    console.log "discon"
  

console.log "3"
cli = require("socket.io-client")
clisoc = cli.connect("http://localhost:3000")

console.log "4"
clisoc.on 'connect', (d)-> 
  console.log "ccc"

console.log "5"
clisoc.on "emitkey",(v)->
  console.log "kta"
  console.log v


console.log "6"
e = require("socket.io-emitter")("localhost")
e.emit "emitkey", "valVal"
###



###
# Greenwich対応
# 今の時間
now = new Date()
console.log now
console.log Date.parse(now)

# 目的の時間 NG
targetTime = new Date(Date.parse("2015/06/01 15:08:00"))
console.log targetTime
console.log Date.parse(targetTime)

# 目的の時間2 NG
targetTime2 = new Date(Date.parse("2015/06/01 15:08:00") - (1000 * 60 * 60 * 9))
console.log targetTime2
console.log Date.parse(targetTime2)

# 絶対的な値で使う
targetTime3 = Date.parse("2015/06/01 16:00:00") # 1433142000000
console.log targetTime3

# 時間判定
if now > 1433142000000
  console.log "目的の時間を過ぎている"
else
  console.log "目的の時間がきていない"
###



###
# 時限装置
# 今の時間
now = new Date()
console.log now

# 目的の時間
targetTime = new Date(Date.parse("2015/06/01 15:08:00"))
console.log targetTime

# 時間判定
if now > targetTime
  console.log "目的の時間を過ぎている"
else
  console.log "目的の時間がきていない"
###



###
# 配列が存在しなかった場合foreachに影響があるかどうか→ない
arrayA = []

listA = []
if arrayA[0]?
  for i in arrayA
    listA.push i

console.log listA


arrayB = [1,2,3]

listB = []
if arrayB[0]?
  for i in arrayB
    listB.push i

console.log listB
###


###
# 基本
module.exports.noi = ->
  console.log "boumow"

console.log @
@.noi()

console.log this
this.noi()

console.log 0b1010

for num in [0...10] by 2
  console.log num

console.log [1,2,3,4,5,6,7][2..4]
c = [1..10][2..4]=[11,12]
console.log c

[a, b, c...] = [1,2,3,4,5,6,7]
console.log a
console.log c

console.log not "a"
console.log not undefined
console.log not null
console.log yes
console.log no
console.log on
console.log off
console.log 5**5
console.log 3125//5

param = {}
console.log param.noi?.noir

console.log i for i in [1,2,34,5]
console.log i + j for i,j of {a: "asdf",b: "asdf"}
###


###
# オブジェクト連想配列のループ2
h = {}
h.a = "aaa"
h.b = "bbb"
h.i = {}
h.i.c = "ccc"
h.i.d = "ddd"
console.log h

for k, v of h
  console.log k
  console.log v

for k, v of h when k is "i"
  for ke, va of v
    console.log ke
    console.log va
###

###
# オブジェクト連想配列のループ
item = {}
item.c = "ccc"
item.d = "ddd"

h = {}
h.a = "aaa"
h.b = "bbb"
h.i = item
console.log h

for k, v of h
  console.log k
  console.log v

for k, v of h when k is "i"
  for ke, va of v
    console.log ke
    console.log va
###



###
# 文
console.log "a" is "a"
console.log "a" is "A"
console.log a?
console.log undifined?
console.log null?
console.log 0?
console.log ""?
console.log ''?
console.log if true or "a" == "b" then "t" else "f"
console.log if true and "a" == "b" then "t" else "f"
console.log "a" isnt "b"
console.log !"a" == false

a = 5
if 4 < a > 2
  console.log "t"
else
  console.log "f"
###


###
a = null
b = "bbb"
# a ? a = b
# console.log a

# 定義されてなかったらエラー
# a ?= b
# console.log a
###

###
a = null
b = "bbb"
# a or a = b
# console.log a

a or= b
console.log a
###


###
# server = require("http").createServer (q,s)->
#   res.writeHead 200,
#     Content-Type: "text/html"
#   res.end("sev conn")

require("http").createServer((a,b)-> 
  b.end("""
  <a href="http://localhost:3000/weakness">link</a>
  <form method="POST" action="http://localhost:3000/weakness">
    <input type='text' name="intext">
    <input type='submit'>
  </form>
  """)
).listen 3001
###


###
# 日付変換
epoch2date = (d)->
  console.log d
  d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2) + " " \
   + ("0" + d.getHours()).slice(-2) + ":" \
   + ("0" + d.getMinutes()).slice(-2)
###

###
# redis expire
redis = require "redis"

client = redis.createClient()

client.set "exp", "ireire"
client.expire "exp", 20

client.get "exp", (e,d)->
  console.log d
  client.end()
###

###
# ランダムでリストから一件取得
li = [1,2,3,4,5,6,7]
console.log li.splice( Math.floor(Math.random() * li.length), 1 )[0]
console.log li.splice( Math.floor(Math.random() * li.length), 1 )[0]
console.log li.splice( Math.floor(Math.random() * li.length), 1 )[0]
console.log li.splice( Math.floor(Math.random() * li.length), 1 )[0]
console.log li.splice( Math.floor(Math.random() * li.length), 1 )[0]
console.log li.splice( Math.floor(Math.random() * li.length), 1 )[0]
console.log li.splice( Math.floor(Math.random() * li.length), 1 )[0]
console.log li.splice( Math.floor(Math.random() * li.length), 1 )[0]
console.log li.splice( Math.floor(Math.random() * li.length), 1 )[0]
console.log li.splice( Math.floor(Math.random() * li.length), 1 )[0]
###


###
# コンバート
convertTypeName = (type)->
  switch type
    when "a" then return "eee"
    when "b" then return "bii"
    when "c" then return "shii"
  
  return "noi"


console.log convertTypeName "a"
###

###
console.log if "アア".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "ンン".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "ーー".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "ヮッ".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "ゥゥ".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false

console.log if "ゎッ".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "アア".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "あア".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "ああ".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "ｱｱ".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "アjkjア".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "aaアア".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "aaあアア".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "aaあ".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "aaああｱ".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
console.log if "aｄああｱ".match(/^[ア-ンガ-ボァ-ョヮッー]+$/) then true else false
###



###
# pub/sub
redis = require("redis")
client1 = redis.createClient()
client2 = redis.createClient()
client3 = redis.createClient()
client4 = redis.createClient()
msg_count = 0

redis.debug_mode = true

client1.on "psubscribe", (pattern, count)->
  console.log "client1 psubscribed to " + pattern.toString() + ", " + count.toString() + " total subscriptions"
  client2.publish "channeltwo", "Me!"
  client3.publish "channelthree", "Me too!"
  client4.publish "channelfour", "And me too!"

client1.on "punsubscribe", (pattern, count)->
  console.log "client1 punsubscribed from " + pattern.toString() + ", " + count.toString() + " total subscriptions"
  client4.end()
  client3.end()
  client2.end()
  client1.end()


client1.on "pmessage", (pattern, channel, message)->
  console.log "("+  pattern.toString() + ")" + " client1 received message on " + channel.toString() + ": " + message.toString()
  msg_count++
  if (msg_count == 3)
    client1.punsubscribe()
  

client1.psubscribe "channel*"
###


###
n="https://w.soundcloud.com/playr/ asfs><><af"
console.log n.match(/https:\/\/w.soundcloud.com\/player\//)
###

###
nodemailer = require 'nodemailer'
smtpTransport = require 'nodemailer-smtp-transport'

t = nodemailer.createTransport(smtpTransport(
  host : "localhost"
  port : 25))

mailOptions =
    from: ""
    to: ""
    subject: "subjeeect"
    text: "testeste"

t.sendMail mailOptions, (e, i)->
  if e
    console.log e
  else
    console.log i
    console.log i.response
###


###
nm = require "nodemailer"
t= nm.createTransport smtpTransport, {host : "localhost", post : 25}
# post?
mailOptions =
    from: ""
    to: ""
    subject: "subjeeect"
    text: "testeste"

t.sendMail mailOptions, (e, i)->
  if e
    console.log e
  else
    console.log i
    console.log i.response
###

###
# nodemailer
nm = require "nodemailer"
t= nm.createTransport
  service: "Gmail"
  auth: {user:"",pass:""}

"SMTP"
host:"localhost"
post:"25"

mailOptions =
    from: ""
    to: ""
    subject: "subusbu"
    text: "testeste"

t.sendMail mailOptions, (e, i)->
  if e
    console.log e
  else
    console.log i
    console.log i.response
###



# ホワイトリスト2
# target = "asoijdf.jpg"
# ngtarget = "asoijdf.abc"

# assertExtension = (val) ->
#   ["jpg","png"].some (i)-> i == val.match(/[.].*/)[0].slice(1)

# console.log assertExtension target
# console.log assertExtension ngtarget


# ホワイトリスト
# v = require "validator"
# allow = ["jpg","png"]

# target = "asoijdf.jpg"
# ngtarget = "asoijdf.abc"

# assertExtension = (val) ->
#   allow.filter((i)->i==val.match(/[.].*/)[0].slice(1)).length > 0

# console.log assertExtension target
# console.log assertExtension ngtarget


# 拡張子取得
# file = "asdf.abc"
# ext = file.match(/[.].*/)[0].slice 1
# console.log ext


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

# IVの鍵作成
hash = crypto.createHash 'md5'
hash.update 'randomToken'
ive = hash.digest()

text = '共通鍵暗号方式'

cipher = crypto.createCipheriv 'aes-256-cbc', "b52c96bea30646abf8170f333bbd42b9", ive
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

text = '共通鍵暗号方式'

cipher = crypto.createCipher 'aes-256-cbc', 'password'
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
# 日付→文字 日付変換
d = new Date()
s = d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2) + " " \
   + ("0" + d.getHours()).slice(-2) + ":" \
   + ("0" + d.getMinutes()).slice(-2) + ":" \
   + ("0" + d.getSeconds()).slice(-2)

console.log s

# 文字→日付(数値) 日付数値変換
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




