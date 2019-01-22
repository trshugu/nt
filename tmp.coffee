console.time "tmp"
puts = console.log
helper = require "./helper"
###
###









###
# まとめてから半分に分けるのはNG
ec = new require('elliptic').ec('secp256k1')

# 鍵生成
keygen = ->
  res = {}
  kp = ec.genKeyPair()
  res.pri = kp.priv.toString("hex")
  pk = kp.getPublic()
  res.pub = pk.x.toString("hex") + pk.y.toString("hex")
  res


# 署名
sign = (val, priv)->
  s = ec.keyFromPrivate(priv).sign val
  console.log "s:",s
  s.r.toString("hex") + s.s.toString("hex")


# 検証
verify = (val, pub, sign)->
  pk = ec.keyFromPublic
    x: pub.substr 0, Math.floor(pub.length/2)
    y: pub.substr Math.floor(pub.length/2)
  console.log pk
  console.log pk.pub.x.toString("hex").length
  console.log pk.pub.y.toString("hex").length
  
  sig = 
    r: sign.substr 0, Math.ceil(sign.length/2)
    s: sign.substr Math.ceil(sign.length/2)
  console.log sig
  pk.verify val, sig


val = "aeaaああいあいあおいうあ3ae"

# key = keygen()
# puts key

# sig = sign val, key.pri
# puts sig

# puts verify val, key.pub, sig
# puts verify val, key.pub, sign(val, key.pri)

# keygenで鍵作成
pri = '7912419654941b44c1e1ad66d6f0d06992548b1aae8794844479a08077400ab2'
pub = '2e4f7daa5832b61d0f54d8ce326a26a35464359941a190b2a33a16af8ab8e32dd457f9df18f4522a33d141cde4b383a7de81f4507fc43a1d68ae6b1c6298de3d'

key = keygen()
pri = key.pri
pub = key.pub
console.log pub
# クライアント側 平文とsigを送る
sig = sign val, pri
puts sig

# サーバー側 pubとsigで平文を検証
flg = verify val, pub, sig
puts flg
"out----------!!!!!!!!!!!!!!!!!!!!!!" if flg == false
###



###
val = "平文"
pri = ec.genKeyPair().priv.toString("hex")
puts "pri", pri

sig = sign val, pri
puts "sig", sig

pk = ec.keyFromPrivate(pri).getPublic()
pub = pk.x.toString("hex") + pk.y.toString("hex")
puts "pub", pub
###




###
ec = new require('elliptic').ec('secp256k1')

kp = ec.genKeyPair()
msg = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
msg = 111
msg = "111"
sig = kp.sign msg # 秘密鍵で署名されている

pub = kp.getPublic()
gen = {}
gen.x = pub.x.toString("hex")
gen.y = pub.y.toString("hex")

gensig = {}
gensig.r = sig.r.toString("hex")
gensig.s = sig.s.toString("hex")

# pubkey = ec.keyFromPublic(pub, 'hex') # pubそのものは必要
pubkey = ec.keyFromPublic gen, 'hex'
console.log gen.verify msg, gensig # 公開鍵で署名確認

# cry = pubkey.sign "aaa"
###

###
ec = new require('elliptic').ec('secp256k1')

# 秘密鍵作成
kp = ec.genKeyPair()
console.log "kp", kp # 全部
pub = kp.getPublic() # この時点ではpubがない
console.log "kp", kp # 全部

# console.log "kp", kp # 全部
# console.log "priv1", kp.priv
# console.log "priv2", kp.priv.toString()
console.log "priv3", kp.priv.toString("hex")
console.log "===="
# console.log "kppub", kp.pub
console.log "kppubx", kp.pub.x.toString("hex")
console.log "kppuby", kp.pub.y.toString("hex")

# console.log "pub", pub # xyのみ
console.log "pubx", pub.x.toString("hex")
console.log "puby", pub.y.toString("hex")

# 署名
msg = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
sig = kp.sign msg

# console.log sig
console.log sig.r.toString("hex")
console.log sig.s.toString("hex")
# console.log sig.recoveryParam

pubkey = ec.keyFromPublic(pub, 'hex')
# console.log "pubkey", pubkey
console.log "pubkeyx", pubkey.pub.x.toString("hex")
console.log "pubkeyy", pubkey.pub.y.toString("hex")

console.log "pubkey", pubkey
console.log "pub", pub

# console.log pubkey.verify(msg, sig)
###




###
# ec2では使えなかった
puts = console.log
NS_PER_SEC = 1e9

GPU = require "gpu.js"
gpu = new GPU()

gen_prime = (val)->
  ret = 1
  cnt = 0
  while  cnt < val
    ret = (ret * 2) + Math.floor(Math.random() * 2)
    cnt++
  return (ret * 2) + 1


p = 2 ** 10
# console.log p
gen_prime_gpu = gpu.createKernel gen_prime, output: [p]


nano = process.hrtime()
c = [0...p].map -> gen_prime 8
diff = process.hrtime(nano)
puts diff[0] * NS_PER_SEC + diff[1]

nano = process.hrtime()
d = gen_prime_gpu 8 # こっちは配列で返ってくる
diff = process.hrtime(nano)
puts diff[0] * NS_PER_SEC + diff[1]


# console.log c
# console.log d.length
###




###
# GPGPU
g = require "gpu.js"
gpu = new g()

fun = gpu.createKernel ->
  array2 = [0.08, 2]
  array2  

fun()
###



###
GPU = require "gpu.js"
gpu = new GPU()

suu = gpu.createKernel (a)-> a + a

matMul = gpu.createKernel (a)->
  sum = 0
  # console.log this.thread.x
  console.log this
  sum = Math.floor(Math.random() * this.thread.x)
  
  
  return sum
,
  output: [512]


a = []
[0..512].forEach (i)->
  a.push 1

c = matMul(a)
console.log c
###


###
bi = require "big-integer"
# 4738381338321616896通り
puts bi("4738381338321616896").divide(4).toString()
# →118,4595,3345,8040,4224

puts bi("218340105584896").divide(4).toString()
# → 54,5850,2639,6224

# ワンタイムパスワード

[1..6].forEach (i)->
  console.log i + "文字で" + (bi(10).pow(bi(i)).toString()) + "通り"
###




###
bi = require "big-integer"
[1..16].forEach (i)->
  console.log i + "文字で" + (bi(36).pow(bi(i)).toString()) + "通り"
###


###
ec = new require('elliptic').ec('secp256k1')

# 秘密鍵作成
kp = ec.genKeyPair()
pub = kp.getPublic()

# console.log "kp", kp
# console.log "pub", pub

# 署名
msg = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
sig = kp.sign msg

# console.log sig

pubkey = ec.keyFromPublic(pub, 'hex')
console.log pubkey
console.log pubkey.verify(msg, sig)

# kpでもいける
###



###
# こっちのライブラリはイマイチそう
secp256k1 = require('secp256k1')
cry = require("crypto")


# 32バイトじゃないとダメそう
msg = cry.randomBytes(32)

# 秘密鍵を何回か試行して作成する
loop
  pri = Buffer.from(cry.randomBytes(32))
  break if secp256k1.privateKeyVerify(pri)

console.log "pri", pri.toString("hex")

# 秘密鍵から公開鍵を作成
pub = secp256k1.publicKeyCreate(pri)
console.log "pub", pub.toString("hex")

# 秘密鍵で署名
sigObj = secp256k1.sign msg, pri
console.log "sigObj", sigObj.signature.toString("hex")

# sigとpubを送信する
console.log "==========="
console.log "msg:",msg.toString("hex")
console.log "sig:",sigObj.signature.toString("hex")
console.log "pub:",pub.toString("hex")
console.log "==========="

console.log secp256k1.verify(msg, sigObj.signature, pub)
###

###
# 楕円曲線
# console.log require("crypto").getCurves()

EC = require('elliptic').ec
ec = new EC('secp256k1')

key = ec.genKeyPair()

# 署名
msgHash = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
signature = key.sign msgHash
derSign = signature.toDER()

# console.log key.verify msgHash, derSign
# console.log derSign
# console.log derSign.map((i)-> helper.dec2hex(i))
# console.log derSign.map((i)-> ("00"+ helper.dec2hex(i)).slice(-2) ).join("")
# console.log signature
# console.log "key:",key

# 公開鍵
pubPoint = key.getPublic()
x = pubPoint.getX();
y = pubPoint.getY()

# console.log pubPoint
# console.log x
# console.log y

puba = pubPoint.encode('hex')
# console.log "encode:",pub
pubb = x: x.toString('hex'), y: y.toString('hex')
# console.log pub
pubc = x: x.toBuffer(), y: y.toBuffer()
# console.log pub
pubd = x: x.toArrayLike(Buffer), y: y.toArrayLike(Buffer)
# console.log pub



keya = ec.keyFromPublic(puba, 'hex')
keyb = ec.keyFromPublic(pubb, 'hex')
keyc = ec.keyFromPublic(pubc, 'hex')
keyd = ec.keyFromPublic(pubd, 'hex')

console.log keya.verify(msgHash, signature)
console.log keyb.verify(msgHash, signature)
console.log keyc.verify(msgHash, signature)
console.log keyd.verify(msgHash, signature)
###




###
# 還暦コンバート
convert_kanreki =(i)->
  switch i % 60
    when 0 then return "庚申"
    when 1 then return "辛酉"
    when 2 then return "壬戌"
    when 3 then return "癸亥"
    when 4 then return "甲子"
    when 5 then return "乙丑"
    when 6 then return "丙寅"
    when 7 then return "丁卯"
    when 8 then return "戊辰"
    when 9 then return "己巳"
    when 10 then return "庚午"
    when 11 then return "辛未"
    when 12 then return "壬申"
    when 13 then return "癸酉"
    when 14 then return "甲戌"
    when 15 then return "乙亥"
    when 16 then return "丙子"
    when 17 then return "丁丑"
    when 18 then return "戊寅"
    when 19 then return "己卯"
    when 20 then return "庚辰"
    when 21 then return "辛巳"
    when 22 then return "壬午"
    when 23 then return "癸未"
    when 24 then return "甲申"
    when 25 then return "乙酉"
    when 26 then return "丙戌"
    when 27 then return "丁亥"
    when 28 then return "戊子"
    when 29 then return "己丑"
    when 30 then return "庚寅"
    when 31 then return "辛卯"
    when 32 then return "壬辰"
    when 33 then return "癸巳"
    when 34 then return "甲午"
    when 35 then return "乙未"
    when 36 then return "丙申"
    when 37 then return "丁酉"
    when 38 then return "戊戌"
    when 39 then return "己亥"
    when 40 then return "庚子"
    when 41 then return "辛丑"
    when 42 then return "壬寅"
    when 43 then return "癸卯"
    when 44 then return "甲辰"
    when 45 then return "乙巳"
    when 46 then return "丙午"
    when 47 then return "丁未"
    when 48 then return "戊申"
    when 49 then return "己酉"
    when 50 then return "庚戌"
    when 51 then return "辛亥"
    when 52 then return "壬子"
    when 53 then return "癸丑"
    when 54 then return "甲寅"
    when 55 then return "乙卯"
    when 56 then return "丙辰"
    when 57 then return "丁巳"
    when 58 then return "戊午"
    when 59 then return "己未"

i = 1868
i = process.argv[2] if process.argv[2]?
console.log i + "年は" + convert_kanreki(i) + "戦争です"
###



###
# 干支コンバート
convert_eto =(i)->
  switch i % 12
    when 0 then return "申"
    when 1 then return "酉"
    when 2 then return "戌"
    when 3 then return "亥"
    when 4 then return "子"
    when 5 then return "丑"
    when 6 then return "寅"
    when 7 then return "卯"
    when 8 then return "辰"
    when 9 then return "巳"
    when 10 then return "午"
    when 11 then return "未"

i = 2019
i = process.argv[2] if process.argv[2]?
console.log i + "年は" + convert_eto(i) + "年です"
###


###
request = require("request")
cheerio = require("cheerio")

wget = (url)-> new Promise (f,re)->
  request url
  , (e,r,b)->
    if e?
      re e
    else
      res = {}
      res.headers = r.headers
      res.body = cheerio.load b
      res.raw = b
      f res

slackGetter = (uri)-> new Promise (f,r)->
  wget uri
  .then (v)->
    res = JSON.parse v.raw
    if res.ok
      slackcomment = res.messages.map (i)->
        obj = {}
        obj._id = helper.createHash(i.user + i.text + i.ts).substr(0,5)
        obj.value = i.text.replace(/\n/g," ")
        obj
      f slackcomment
    else
      r "errer"
  .catch (e)-> r e

slackGetter ""
.then (v)->
  v.forEach (i)-> console.log i
.catch (e)-> puts e
###





###
# スピードメーター
# 1秒間にいくつ作れるか
NS_PER_SEC = 1e9
# カンマで区切る
cm = (i)-> i.toString().split("").reverse().join("").match(/.{1,3}/g).join(",").split("").reverse().join("")

cnt = 0
arr = []
size = 0
looper = ->
  setTimeout ->
    arr.push helper.getHash()
    # cnt++
    looper()
  , 0

setInterval ->
  # puts cnt
  # cnt = 0
  size = arr.length - size
  puts size, arr.length
  size = arr.length
,1000

looper()
###





###
bi = require "big-integer"
sqrt = (x)->
  a = x
  [0..100].forEach ->
    x = x.minus(x.multiply(x).minus(a).divide(bi(2).multiply(x)))
  x.minus(1)

# puts sqrt bi 20000000
puts sqrt bi 366
###


###
nano = process.hrtime()
setTimeout ->
  helper.getHash()
  diff = process.hrtime(nano)
  puts cm diff[0] * NS_PER_SEC + diff[1]
,1000
###









###
# hmac2
crypto = require 'crypto'
enchmac = (val, pass)-> new Promise (f,r)->
  hmac = crypto.createHmac 'sha256', pass
  
  arrch = []
  hmac.on 'data', (d)-> arrch.push d
  hmac.on 'end', -> f Buffer.concat(arrch).toString("hex")
  hmac.on 'error', (e)-> r e
  
  hmac.write val
  hmac.end()

enchmac "iroiroo", "paspass"
.then (v)->
  puts v
.catch (e)-> puts e
###





###
# hmac
crypto = require 'crypto'
enchmac = (val, pass)-> new Promise (f,r)->
  hmac = crypto.createHmac 'sha256', pass
  
  arrch = []
  hmac.on 'data', (d)-> arrch.push d
  hmac.on 'end', -> f Buffer.concat(arrch)
  hmac.on 'error', (e)-> r e
  
  hmac.write val
  hmac.end()

enchmac "iroiro", "paspass"
.then (v)->
  puts v
  a = v.toString("hex")
  puts a
  puts Buffer.from a, "hex"
.catch (e)-> puts e
###




###
# キーソート(おおよそ要件が厳しい)
sortByKey = (arr, key)->
  return arr.sort (a, b)->
    x = a[key]
    y = b[key]
    if (x > y)
      return 1;
    else if (x < y)
      return -1
    else
      return 0

obj = [
    k:2,v:"aaa"
  ,
    k:9,v:"aaddda"
  ,
    k:2,v:"afaa"
  ,
    k:3,v:"aasdfa"
  ,
    k:15,v:"addaa"
]

puts sortByKey obj, "k"
puts sortByKey obj, "v"
###

###
# ソートファンクション(コンペアファンクション)の仕組み
suuji = [1,45,5,366,3,4,3,3,3,5]

puts "==="
puts suuji

puts "1" if 1
puts "-1" if -1
puts "0" if 0
puts "a<b" if "a" < "b"
puts "a>b" if "a" > "b"


suuji.sort (a,b)->
  # false if a < b
  # true if a > b
  # 0 if a > b
  # -1 if a < b # 負数と0はなにも返却されないと同義
  # undefined
  # null
  # return -1 if a - b
  # return null if a > b
  # return 0 if a == b
puts suuji


# 降順(大きいものが最初にくる)
puts "==="

# 1 45 -> 1 == bが先頭へ
suuji = [1,45,5,366,3,4,3,3,3,5]
suuji.sort (a,b)->
  # puts "a:",a, ",b:",b, a < b
  a < b
puts "1",suuji
# なにも返らないとfalse

# 全部負数なのでなにも変わらない
suuji = [1,45,5,366,3,4,3,3,3,5]
suuji.sort (a,b)-> true unless a > b
puts "2",suuji

suuji = [1,45,5,366,3,4,3,3,3,5]
suuji.sort (a,b)->
  return 1 if a < b
  return -1 if a > b
  return 0 if a == b
puts "3",suuji

# 引き算 正:変更の余地あり  負: aの方が大きい(どこをとっても否定)
suuji = [1,45,5,366,3,4,3,3,3,5]
suuji.sort (a,b)-> b - a
puts "4",suuji

# Infinityがあると部分的にソートされる
suuji = [1,45,5,366,3,4,3,Infinity,3,3,5]
suuji.sort (a,b)->
  # puts "a:",a, ",b:",b, a < b
  a < b
puts "5",suuji

suuji = [Infinity,1,45,5,366,3,4,3,3,3,5]
suuji.sort (a,b)-> a < b
puts "6",suuji

suuji = [1,45,5,366,3,4,3,3,3,5,Infinity]
suuji.sort (a,b)-> a < b
puts "7",suuji

# NaN
suuji = [1,45,5,366,3,4,3,NaN,3,3,5]
suuji.sort (a,b)-> a < b
puts "8",suuji

# Infinityと微妙に違う。なぜinfinityは正常にソートできないのか
# NaNはfalse Infinityはtrue
suuji = [NaN,1,45,5,366,3,4,3,3,3,5]
suuji.sort (a,b)-> a < b
puts "9",suuji

# 最後にあるとundeifnedになる。ソートは正常
suuji = [1,45,5,366,3,4,3,3,3,5,NaN]
suuji.sort (a,b)-> a < b
puts "10",suuji

# 引き算だとうまくいく
suuji = [1,45,5,366,3,4,3,Infinity,3,3,5]
suuji.sort (a,b)-> b - a
puts "11",suuji

# booleanで返したらダメ？
suuji = [1,45,5,366,3,4,3,Infinity,3,3,5]
suuji.sort (a,b)->
  if (b - a) > 0
    return 1 
  else
    return -1
puts "12",suuji

# aが大きければなにもしない
suuji = [1,45,5,366,3,4,3,Infinity,3,3,5]
suuji.sort (a,b)->
  # puts "a:",a, ",b:",b, b > a
  return 1 if b > a
  return -1 if b < a
puts "13",suuji

# あくまで数字を返さないといけない
suuji = [1,45,5,366,3,4,3,Infinity,3,3,5]
suuji.sort (a,b)->
  # puts "a:",a, ",b:",b
  return 1 if (b - a) > 0
  return -1 if (b - a) < 0
puts "14",suuji

# 負数を返さないとうまいかない
suuji = [1,45,5,366,3,4,3,3,3,5]
suuji.sort (a,b)->
  # puts "a:",a, ",b:",b, a < b
  return 1 if a < b
  return -1 if a > b
puts "15",suuji

suuji = [1,45,5,366,3,4,3,Infinity,3,3,5]
suuji.sort (a,b)->
  # puts "a:",a, ",b:",b, a < b
  return 1 if a < b
  return -1 if a > b
puts "16",suuji

# boolを返してもうまくいかない
# おそらく途中から文字列比較か逆転
suuji = [1,45,5,366,3,4,3,Infinity,3,3,5]
suuji.sort (a,b)->
  # puts "a:",a, ",b:",b, a < b
  return true if a < b
  return false if a > b
puts "17",suuji

# おそらくこれのせい
suuji = [1,45,5,366,3,4,3,Infinity,3,3,5]
suuji.sort()
puts "18",suuji

suuji = [1,45,5,366,3,4,3,Infinity,3,3,5]
suuji.sort (a,b)->a-b
puts "19",suuji


# 昇順
puts "==="

# 1 45 -> false == aが先頭へ
suuji = [1,45,5,366,3,4,3,3,3,5]
suuji.sort (a,b)->
  # puts "a:",a, ",b:",b, a > b
  a > b
puts "1",suuji

suuji = [1,45,5,366,3,4,3,3,3,5]
suuji.sort (a,b)-> return 1 if a > b
puts "2",suuji


suuji = [1,45,5,366,3,4,3,3,3,5]
suuji.sort (a,b)->
  return 1 if a > b
  return -1 if a < b
  return 0 if a == b
puts "3",suuji

# 引き算
suuji = [1,45,5,366,3,4,3,3,3,5]
suuji.sort (a,b)->
  # puts "a:",a, ",b:",b, a - b
  a - b
puts "4",suuji

# こうすると大なり小なりの意味がでてくる
suuji = [1,45,5,366,3,4,3,3,3,5]
suuji = suuji.map (i)-> i.toString()
suuji.sort (a,b)->
  # puts "a:",a, ",b:",b, a > b
  a > b
puts "5",suuji.map (i)-> parseInt i



# sortは破壊的
puts suuji
puts suuji.sort()
puts suuji
###


###
# 誕生日攻撃の安全圏
bi = require "big-integer"
cm = (i)-> i.toString().split("").reverse().join("").match(/.{1,3}/g).join(",").split("").reverse().join("")

[1..64].forEach (c)->
  n = bi(2).pow( bi(c).multiply(bi(4)) )
  bb = bi(2).pow(bi(c).multiply(bi(4)).divide(2))
  # console.log "2**" + c*4 + ":" + c + "文字：", cm n.toString()
  # console.log c + "文字：", cm(n.toString()) 
  # console.log cm(bb.toString())
  # console.log c + "文字で50%こえる回数：",  cm(bb.toString())
  console.log c + "文字の容量：", cm(n.multiply(c).toString()) + "バイト"
###



###
# birthday bound(2^n/2)
bi = require "big-integer"
cm = (i)-> i.toString().split("").reverse().join("").match(/.{1,3}/g).join(",").split("").reverse().join("")

factbi = (n)-> [bi(n)..bi.one].reduce (a,b)-> a.multiply(b)
bdabi = (i, cnt)-> parseInt(bi(100000).minus(factbi(bi(i).minus(1)).divide( factbi( bi(i).minus((bi.one)).minus(bi(cnt))) ).multiply(bi(100000)).divide( (bi(i).pow(bi(cnt))) )).toString()) / 1000

# console.log cm bi(2).pow(bi(64)).toString()
# console.log cm bi(2).pow(  bi(64).divide(bi(2))  ).toString()
# console.log cm bi(2).pow(  bi(256).divide(bi(2))  ).toString()
# console.log bdabi bi(2).pow(bi(64)), "23"

[1..16].forEach (i)->
  i = i * 4
  all = bi(2).pow(i).toString()
  bb = bi(2).pow(  bi(i).divide(bi(2)) ).toString()
  # sikou = bdabi all, bb
  # console.log all + " / " + bb


[1..11].forEach (j)->
  i = j * 4
  all = parseInt bi(2).pow(i).toString()
  bb = parseInt bi(2).pow(  bi(i).divide(bi(2)) ).toString()
  
  # 4かいやる→ bb/j回やる
  flg = "" 
  [1..8].forEach (n)->
  # m = Math.floor(bb/j)
  # [1..m].forEach (n)->
    arr = {}
    [1..bb].forEach (k)->
      arr[helper.getHash().substr(0,j)] = null
    
    flg = "失敗" if Object.keys(arr).length != bb
    
    # console.log j + "文字:" + "全" + all + "件:" + bb + "個生成:" + n + "回目" + (Object.keys(arr).length.toString()) + "個" + flg
    # console.log (Object.keys(arr).length.toString()) + ":" + bb
    # console.log Object.keys(arr).length +":"+ i
  
  if flg != ""
    # console.log m + "回試行" + j + "文字:" + "全" + all + "件:" + bb + "個生成" + flg
    console.log j + "文字:" + "全" + all + "件:" + bb + "個生成" + flg

# console.log [1..50].map (i)-> return i.toString() + ":" + bdabi(256, i)
###



###
bi = require "big-integer"

fact = (n)-> [n..1].reduce (a,b)-> a*b
bda = (i, cnt)-> 1-(  ( fact(i-1) / fact(i-1-cnt) ) / i**cnt  )

factbi = (n)-> [bi(n)..bi.one].reduce (a,b)-> a.multiply(b)
bdabi = (i, cnt)-> parseInt(bi(100000).minus(factbi(bi(i).minus(1)).divide( factbi( bi(i).minus((bi.one)).minus(bi(cnt))) ).multiply(bi(100000)).divide( (bi(i).pow(bi(cnt))) )).toString()) / 1000


lbda = (i, p)->
  cnt = 1
  res = 0
  # while cnt <= i - 2
  while res <= p
    res = bdabi i, cnt
    console.log cnt + ",", res
    
    cnt++
###


###
cnt = 1
lbdafif = (i, p)->
  res = 0
  while cnt <= i - 2
    res = bdabi i, cnt
    if res > p
      console.log i + "," + cnt + ",", res
      break
    
    cnt++
###



###
bun = bi.zero
lbdafifwari = (i, p)->
  cnt = bi(i).divide(bi(bun)) if bun.neq(bi.zero)
  res = 0
  while cnt <= i - 2
    res = bdabi i, cnt
    if res > p
      bun = bi(i).divide(bi(cnt))
      console.log i + "," + cnt + "," + bun + "分の1"
      break
    
    cnt++
###




# [1..32].forEach (n)->
#   lbdafifwari bi(2).pow(bi(n)), 50


# [1..(2**15)].forEach (n)->
#   lbdafifwari n, 50


# console.log bda 10, 2
# console.log bdabi 10, 2
# lbda 11
# console.log bdabi bi(2).pow(bi(10)), "23"
# lbda 365
# console.log bdabi 365, 23
# lbda 1000, 50
# n = bi(2).pow(bi(16))
# console.log bdabi n, 400
# console.log n.toString()

# [1..100].forEach (n)->
#   console.log bi(2).pow(bi(n)).toString()

# [1..(2**15)].forEach (n)->
#   lbdafif n, 50



###
if process.argv[2]?
  vit = process.argv[2]
  n = vit.toString()
  lbda n, 90
###



###
bi = require "big-integer"
# もじとおり
# 2文字、1バイト8ビット
# c = 16 # 1～64文字
# console.log c * 4 + "ビット"
# console.log bi(16).pow(bi(c)).toString()
# console.log bdabi bi(16).pow(bi(c)).toString(), "100"

cm = (i)-> i.toString().split("").reverse().join("").match(/.{1,3}/g).join(",").split("").reverse().join("")

[1..64].forEach (c)->
  n = bi(16).pow(bi(c))
  console.log "2**" + c*4 + ":" + c + "文字：", cm n.toString()
###



###
[1..32].forEach (c)->
  n = bi(16).pow(bi(c))
  console.log c + "文字：", n.toString()
  lbdafif n, 10
###

###
[1..32].forEach (c)->
  n = bi(16).pow(bi(c))
  console.log c + "文字：", n.toString(), bdabi(n,n.divide(bi(100)))
###



###
samebirthday = (i, cnt) ->  Math.floor(  (1 - ( ((i-1)**cnt) / (i**cnt) ))*1000)  /10
samebirthdaybi = (i, cnt) -> bi(100).minus(bi(i).minus(bi.one).pow(bi(cnt)).multiply(bi(100)).divide(bi(i).pow(cnt))).toString()
samebirthdaybi2 = (i, cnt) -> parseInt(bi(100000).minus(bi(i).minus(bi.one).pow(bi(cnt)).multiply(bi(100000)).divide(bi(i).pow(cnt))).toString())/1000

lsamebirthday = (i) ->
  cnt = 1
  res = 0
  # while cnt <= i
  while res <= 90
    res = samebirthdaybi2 i, cnt
    console.log cnt + ":", res
    
    cnt++

# lsamebirthday 10
# lsamebirthday 365
# console.log "10:", samebirthday 10, 10
# console.log "120:", samebirthdaybi 365, 120
###




###
# 末尾再帰
NS_PER_SEC = 1e9
# カンマで区切る
cm = (i)-> i.toString().split("").reverse().join("").match(/.{1,3}/g).join(",").split("").reverse().join("")


bi = require "big-integer"
runner = (n)->
  res = {}
  cnt = 0
  
  fib = (i)->
    cnt++
    return 0 if i == 0
    return 1 if i == 1
    fib(i-1) + fib(i-2)
  
  fibtl = (i, a=1, b=0)->
    cnt++
    return 0 if i == 0
    return a if i == 1
    return fibtl(i-1, a+b, a)
  
  fibtlbi = (i, a=bi(1), b=bi(0))->
    cnt++
    return bi.zero if i.eq(bi.zero)
    return a if i.eq(bi.one)
    return fibtlbi(i.minus(1), a.plus(b), a)


  nano = process.hrtime()
  res.fib = fibtlbi bi(n)
  diff = process.hrtime(nano)
  
  res.c = cnt
  res.t = cm (diff[0] * NS_PER_SEC + diff[1])
  
  res

# [1..8000].forEach (m)->
#   console.log m, runner m
###




###
sigma = (i)->
  return 1 if i == 1
  
  sigma(i-1) + i


sigmatl2 = (i, r = 1)->
  return r if i == 1
  
  sigmatl2(i-1, r+i)

sigmatl = (i, r = 1)->
  return r if i == 1
  a = sigmatl(i-1, r+i)
  return a
  

sigmatlbi = (i, r = bi.one)->
  return r if i.eq(bi.one)
  
  sigmatlbi(i.minus(bi.one), r.plus(i))

runner = (n)->
  res = {}
  
  # nano = process.hrtime()
  # res.sig = sigma n
  # diff = process.hrtime(nano)
  # res.sigt = cm (diff[0] * NS_PER_SEC + diff[1])
  
  nano = process.hrtime()
  res.tl = sigmatl n
  diff = process.hrtime(nano)
  res.tlt = cm (diff[0] * NS_PER_SEC + diff[1])
  
  res



console.log 12508, sigma 12508
console.log 8338, sigmatl 8338
console.log 8933, sigmatl2 8933
console.log 8336, sigmatlbi bi 8336

# [1..10000].forEach (m)->
#   console.log m, sigmatlbi bi(m)

factorial = (n)->
  return 1 if n == 0
  return n * factorial(n - 1)

factorial2 = (n)->
  factorialTailCall = (n, accum)->
    return accum if n == 0
    return factorialTailCall(n - 1, n * accum)
  
  result = factorialTailCall(n, 1)
  
  return result

console.log factorial 11370
console.log factorial2 10420


recursion = (num, limit)->
  return num if num == limit
  num++
  return recursion(num, limit)

console.log recursion(0, 2100)
###

###
rec = (i)->
  i-1


console.log rec 10
###


###
putsj = (v)->
  o = {}
  o.value = v
  o.timestamp = new Date().getTime()
  o.digest = helper.createHash(JSON.stringify(o))
  console.log o

putsj "noisruiow"
###

###
bi = require "big-integer"

int2base58btbi = (i, res="")->
  a = i.divide bi("58")
  m = i.mod bi("58")
  res = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".substr(m,1) + res
  # console.log i.toString(),"-->",a.toString()
  # console.log res,m.toString()
  # console.log m.toString()
  return res if a.eq(bi.zero)
  
  int2base58btbi a, res

# console.log int2base58btbi bi 12345
# console.log int2base58btbi bi 12346
# console.log int2base58btbi bi("12345678923234987233")
# console.log int2base58btbi bi("12345678923234987234")
# console.log int2base58btbi bi "12345678923498723497823498742398723" # 4rmwHMZR1XDWi5Sv9rLa
# console.log int2base58btbi bi "12345678923498723497823498742398724"  # 4rmwHMZR1XDWi5Sv9rLb

# base582int
# console.log "4rmwHMZR1XDWi5Sv9rLa".split("").map( (i)-> bi("123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".indexOf(i)) ).reduce( (a,b)-> a.multiply(58).plus(b) ).toString()
# console.log "4rmwHMZR1XDWi5Sv9rLb".split("").map( (i)-> bi("123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".indexOf(i)) ).reduce( (a,b)-> a.multiply(58).plus(b) ).toString()
###


###
int2base58bt = (i, res="")->
  a = Math.floor(i/58)
  m = i % 58
  res = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".substr(m,1) + res
  
  return res if a == 0
  
  int2base58bt a, res




console.log int2base58bt 1234567890 # 2t6V2H
console.log "2t6V2H".split("").map( (i)-> "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".indexOf(i) ).reduce( (a,b)-> a * 58 + b )

console.log int2base58bt 123456789 # BukQL
console.log "BukQL".split("").map( (i)-> "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".indexOf(i) ).reduce( (a,b)-> a * 58 + b )
###


###
# convert_base64なしで
arr = [65, 66, 67, 68, 69, 70, 71]
console.log Buffer.from(arr)
console.log Buffer.from("ABCDEFG")
# console.log Buffer.from(arr).toString("hex").split("").map( (i)-> ("000" + parseInt(i, 16).toString(2)).slice(-4) ).join("").match(/.{1,6}/g).map( (i)->   parseInt((i + "00000").slice(0,6),2)   ).join("").split().map((i)-> i + "=".repeat(i.length % 4))[0]
# console.log Buffer.from(arr).toString("hex").split("").map( (i)-> ("000" + parseInt(i, 16).toString(2)).slice(-4) ).join("").match(/.{1,6}/g).map( (i)-> "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789/+".substr(parseInt((i + "00000").slice(0,6),2),1) ).join("").split().map((i)-> i + "=".repeat(i.length % 4))[0]
# console.log Buffer.from(arr).toString("base64")
console.log Buffer.from("QUJDREVGRw==", "base64")
console.log Buffer.from("QUJDREVGRw==", "base64").map (i)-> i
console.log Buffer.from("QUJDREVGRw==", "base64").toString()
# console.log Buffer.from("44GCae+8kDBv", "base64").toString()

console.log Buffer.from(arr).toString("hex").split("").map( (i)-> ("000" + parseInt(i, 16).toString(2)).slice(-4) )

console.log Buffer.from("QUJDREVGRw==".split("=").join("").split("").map( (i)-> ("00000" + ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789/+".indexOf(i)).toString(2)).slice(-6) ).join("").match(/.{1,4}/g).map(  (i)-> parseInt(i,2) ).join("").match(/.{1,2}/g).map( (i)-> parseInt(i, 16) )).toString()

# .map( (i)-> parseInt(i, 2).toString(16) ).join("").match(/.{1,2}/g)
###


###
convert_base58 = (i)->
  switch i
    when "0" then return "1"
    when "1" then return "2"
    when "2" then return "3"
    when "3" then return "4"
    when "4" then return "5"
    when "5" then return "6"
    when "6" then return "7"
    when "7" then return "8"
    when "8" then return "9"
    when "9" then return "A"
    when "10" then return "B"
    when "11" then return "C"
    when "12" then return "D"
    when "13" then return "E"
    when "14" then return "F"
    when "15" then return "G"
    when "16" then return "H"
    when "17" then return "J"
    when "18" then return "K"
    when "19" then return "L"
    when "20" then return "M"
    when "21" then return "N"
    when "22" then return "P"
    when "23" then return "Q"
    when "24" then return "R"
    when "25" then return "S"
    when "26" then return "T"
    when "27" then return "U"
    when "28" then return "V"
    when "29" then return "W"
    when "30" then return "X"
    when "31" then return "Y"
    when "32" then return "Z"
    when "33" then return "a"
    when "34" then return "b"
    when "35" then return "c"
    when "36" then return "d"
    when "37" then return "e"
    when "38" then return "f"
    when "39" then return "g"
    when "40" then return "h"
    when "41" then return "i"
    when "42" then return "j"
    when "43" then return "k"
    when "44" then return "m"
    when "45" then return "n"
    when "46" then return "o"
    when "47" then return "p"
    when "48" then return "q"
    when "49" then return "r"
    when "50" then return "s"
    when "51" then return "t"
    when "52" then return "u"
    when "53" then return "v"
    when "54" then return "w"
    when "55" then return "x"
    when "56" then return "y"
    when "57" then return "z"
###



###
convert_base64 = (i)->
  switch i
    when "000000" then return "A"
    when "000001" then return "B"
    when "000010" then return "C"
    when "000011" then return "D"
    when "000100" then return "E"
    when "000101" then return "F"
    when "000110" then return "G"
    when "000111" then return "H"
    when "001000" then return "I"
    when "001001" then return "J"
    when "001010" then return "K"
    when "001011" then return "L"
    when "001100" then return "M"
    when "001101" then return "N"
    when "001110" then return "O"
    when "001111" then return "P"
    when "010000" then return "Q"
    when "010001" then return "R"
    when "010010" then return "S"
    when "010011" then return "T"
    when "010100" then return "U"
    when "010101" then return "V"
    when "010110" then return "W"
    when "010111" then return "X"
    when "011000" then return "Y"
    when "011001" then return "Z"
    when "011010" then return "a"
    when "011011" then return "b"
    when "011100" then return "c"
    when "011101" then return "d"
    when "011110" then return "e"
    when "011111" then return "f"
    when "100000" then return "g"
    when "100001" then return "h"
    when "100010" then return "i"
    when "100011" then return "j"
    when "100100" then return "k"
    when "100101" then return "l"
    when "100110" then return "m"
    when "100111" then return "n"
    when "101000" then return "o"
    when "101001" then return "p"
    when "101010" then return "q"
    when "101011" then return "r"
    when "101100" then return "s"
    when "101101" then return "t"
    when "101110" then return "u"
    when "101111" then return "v"
    when "110000" then return "w"
    when "110001" then return "x"
    when "110010" then return "y"
    when "110011" then return "z"
    when "110100" then return "0"
    when "110101" then return "1"
    when "110110" then return "2"
    when "110111" then return "3"
    when "111000" then return "4"
    when "111001" then return "5"
    when "111010" then return "6"
    when "111011" then return "7"
    when "111100" then return "8"
    when "111101" then return "9"
    when "111110" then return "+"
    when "111111" then return "/"


console.log Buffer.from("ABCDEFG").toString("hex").split("").map( (i)-> ("000" + parseInt(i, 16).toString(2)).slice(-4) ).join("").match(/.{1,6}/g).map( (i)-> convert_base64((i + "00000").slice(0,6)) ).join("").split().map((i)-> i + "=".repeat(i.length % 4))[0]
###




###
arr = [65, 66, 67, 68, 69, 70, 71]
console.log Buffer.from(arr)
console.log Buffer.from(arr).toString("hex").split("").map( (i)-> ("000" + parseInt(i, 16).toString(2)).slice(-4) ).join("").match(/.{1,6}/g).map( (i)-> encodebase64((i + "00000").slice(0,6)) ).join("").split().map((i)-> i + "=".repeat(i.length % 4))[0]
console.log parseInt(Buffer.from(arr).toString("hex"), 16)
console.log parseInt(Buffer.from(arr).toString("hex"), 16).toString(2)
console.log Buffer.from(arr).toString("base64")

console.log "======"
console.log Buffer.from("ABCDEFG")
console.log Buffer.from("ABCDEFG").toString("hex")
console.log parseInt(Buffer.from("ABCDEFG").toString("hex"), 16)
console.log parseInt(Buffer.from("ABCDEFG").toString("hex"), 16).toString(2)
console.log Buffer.from("ABCDEFG").toString("base64")
###

###
arr = [10]
console.log Buffer.from(arr)
console.log Buffer.from(arr).toString("hex")
console.log Buffer.from(arr).toString("base64")
console.log Buffer.from(arr).toString()
console.log Buffer.from(arr).toString().toString(2)
console.log Buffer.from("010001")
console.log Buffer.from("010001").toString("base64")

console.log Buffer.from("ABCDEFG")
console.log Buffer.from("ABCDEFG").toString("base64")

###


###
bs58 = require "base58"
console.log Buffer.from("あi０0o").toString("hex")
console.log Buffer.from("あi０0o")

console.log bs58.int_to_base58(6857269519)
console.log bs58.base58_to_int('brXijP')
console.log bs58.int_to_base58(0)
console.log bs58.int_to_base58(1)
console.log bs58.int_to_base58(2)
console.log bs58.int_to_base58(33)
console.log "====="
console.log bs58.base58_to_int('1')
console.log bs58.base58_to_int('9')
console.log bs58.base58_to_int('a')
console.log bs58.base58_to_int('b')
console.log bs58.base58_to_int('z')
###

###
bs58 = require "base58"
console.log Buffer.from("あi０0o").toString("hex")
console.log Buffer.from("あi０0o")

bs58 = require "base58"
console.log bs58.int_to_base58(268419915)

convert_base58bt = (i)-> "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".substr(i,1)
convert_base58fl = (i)-> "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ".substr(i,1)
###


###
int2base58bt = (i, res="")->
  a = Math.floor(i/58)
  m = i % 58
  res = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".substr(m,1) + res
  
  return res if a == 0
  
  int2base58bt a, res

int2base58fl = (i, res="")->
  a = Math.floor(i/58)
  m = i % 58
  res = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ".substr(m,1) + res
  
  return res if a == 0
  
  int2base58fl a, res


bs58 = require "base58"
console.log bs58.int_to_base58 123456789

console.log int2base58bt 123456789
console.log int2base58fl 123456789
###

###
int2base58bt = (i, res="")->
  a = Math.floor(i/58)
  m = i % 58
  res = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".substr(m,1) + res
  
  return res if a == 0
  
  int2base58bt a, res

int2base58fl = (i, res="")->
  a = Math.floor(i/58)
  m = i % 58
  res = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ".substr(m,1) + res
  
  return res if a == 0
  
  int2base58fl a, res

console.log int2base58bt 268419915
console.log int2base58fl 268419915


bs58 = require "base58"
console.log bs58.int_to_base58(268419915)
###

###
console.log "====="
arr = [65, 66, 67, 68, 69, 70, 71]
# console.log Buffer.from("ABCDEFG")
# console.log Buffer.from("ABCDEFG").toString("hex")
console.log parseInt(Buffer.from("ABCDEFG").toString("hex"), 16) 
console.log Buffer.from("A").toString("hex") % 58
console.log parseInt(Buffer.from("A").toString("hex"), 16) % 58
# console.log parseInt(Buffer.from("ABCDEFG").toString("hex"), 16).toString(2)
# console.log Buffer.from("ABCDEFG").toString("base64")
console.log bs58.base58_to_int('A')
###



###
# 2/3くらいで失敗するレスポンス3.1
# ランダムではなく振り子時計のように
Koa = require('koa')
app = new Koa()
route = require('koa-route')

clockwork = false

setInterval ->
  clockwork = clockwork == false
, 2000 + Math.floor(Math.random() * 2000)

app.use route.get '/', (ctx)->
  ctx.set 'Content-Type': 'text/plain'
  
  if clockwork
    ctx.status = 404
    ctx.body = "missin"
  else
    ctx.status = 200
    ctx.body = "hell"

app.listen 3000, -> console.log "listen"

# 絶対にとってくるまで諦めない処理2
# telomereの概念を導入
getter = (uri, telomere=2)-> new Promise (f,r)->
  r "dead" if telomere == 0
  
  require("http").get uri
  , (res)->
    res.on "data", (c)->
      if res.statusCode == 200
        f res.statusCode
      else
        setTimeout ->
          getter uri, telomere - 1
          .then (tr)->
            f tr
          .catch (e)-> r e
        , 500
      
  .on "error", (e)-> r e


setInterval ->
  getter "http://localhost:3000"
  .then (v)->
    console.log v
  .catch (e)->
    console.log "e",e
    process.exit()
, 1000
###




###
# 2/3くらいで失敗するレスポンス3
# ランダムではなく振り子時計のように
Koa = require('koa')
app = new Koa()
route = require('koa-route')

clockwork = false

setInterval ->
  clockwork = clockwork == false
, 2000 + Math.floor(Math.random() * 2000)

app.use route.get '/', (ctx)->
  ctx.set 'Content-Type': 'text/plain'
  
  if clockwork
    ctx.status = 404
    ctx.body = "missin"
  else
    ctx.status = 200
    ctx.body = "hell"

app.listen 3000, -> console.log "listen"

# 絶対にとってくるまで諦めない処理
getter = (uri)-> new Promise (f,r)->
  require("http").get uri
  , (res)->
    res.on "data", (c)->
      if res.statusCode == 200
        f res.statusCode
      else
        setTimeout ->
          getter uri
          .then (tr)->
            f tr
        , 500
      
  .on "error", (e)-> r e


setInterval ->
  getter "http://localhost:3000"
  .then (v)->
    console.log v
  .catch (e)-> console.log "e",e
, 1000
###






###
# 2/3くらいで失敗するレスポンス2
Koa = require('koa')
app = new Koa()
route = require('koa-route')

app.use route.get '/', (ctx)->
  ctx.set 'Content-Type': 'text/plain'
  r = Math.floor(Math.random() * 10)
  switch r
    when 1,2,3,4,5,6
      ctx.status = 404
      ctx.body = "missin"
    else
      ctx.status = 200
      ctx.body = "hell"

app.listen 3000, -> console.log "listen"

get = -> new Promise (f,r)->
  require("http").get "http://localhost:3000"
  , (res)->
    res.on "data", (c)->
      # f [c.toString(), res.statusCode]
      f res.statusCode
      
  .on "error", (e)-> r e


setInterval ->
  get()
  .then (v)->
    console.log v
  .catch (e)-> console.log "e",e
, 1000
###



###
# 任意ビットの鍵をつくる
bi = require "big-integer"

# 高速指数演算
modular_exp = (a, b, n)->
  res = bi.one
  while b.neq(0)
    if b.and(1).neq(0)
      res = res.multiply(a).mod(n)
    
    a = a.multiply(a).mod(n)
    b = b.shiftRight(1)
  
  res

# ランダムな素数
gen_rand = (bit_length)->
  bits = [0...bit_length - 2].map -> bi.randBetween 0, 1
  ret = bi(1)
  bits.forEach (b)->
    ret = ret.multiply(2).plus(b)
  
  ret.multiply(2).plus(1)

# 素数確認
mr_primary_test = (n, k=100)->
  return false if n.eq 1
  return true if n.eq 2
  return false if n.mod(2).eq(0)
  
  d = n.minus(1)
  s = bi.zero
  while d.mod(2).neq(0)
    d = d.divide(2)
    s = s.plus(1)
  
  r = [0...k].map -> bi.randBetween 1, n.minus(1)
  res = r.some (a)->
    if modular_exp(a, d, n).neq(1)
      pl = [0...s].map (rr)-> 
        bi(2).pow(rr).multiply(d)
      
      flg = true
      
      pl.forEach (p)->
        if modular_exp(a, p, n).eq(1)
          flg = false
          return
      
      if flg
        return true
    
  return res == false

# 素数生成
gen_prime = (bit)->
  while true
    ret = gen_rand(bit)
    if mr_primary_test(ret)
      break
  
  return ret

# 拡張ユークリッド互除法
xeuclid = (aa, bb)->
  if bb.eq(0)
    uu = 1
    vv = 0
  else
    qq = aa.divide bb
    rr = aa.mod bb
    res = xeuclid(bb, rr)
    uu = res[1]
    vv = res[0].minus(qq.multiply(res[1]))
  
  [bi(uu), bi(vv)]

# 鍵生成
gen_d = (e, l)->
  x = xeuclid(e, l)[0]
  if x.sign
    x.plus l
  else
    x.mod l


# keygen
# gen_rsa = (bit_length)-> new Promise (f,r)->
gen_rsa = (bit_length)->
  bit = bi(bit_length).divide 2
  p = gen_prime(bit)
  q = gen_prime(bit)
  
  e = bi 65537
  
  n = p.multiply(q)
  d = gen_d e, p.minus(1).multiply(q.minus(1))
  
  res = {}
  
  res.pub = n.toString()
  res.pri = d.toString()
  
  res
  
###






###
message = bi 1492

# 鍵を作成
key = gen_rsa 64
# 暗号化
c = modular_exp message, bi(65537), bi(key.pub)
# 複合
m = modular_exp c, bi(key.pri), bi(key.pub)

console.log m.toString()
# console.log "cip", helper.dec2hex c.toString()
# console.log "pub", helper.dec2hex key.pub
# console.log "pri", helper.dec2hex key.pri


console.log helper.dec2hex(key.pub)
console.log Buffer.from(helper.dec2hex(key.pub)).toString("base64")
console.log Buffer.from(helper.dec2hex(key.pub)).toString("base64").length
###




###
# 64だと16文字
# 1024だと256桁になる
helper.deflate helper.dec2hex key.pub
.then (v)->
  console.log v
  console.log v.length
  console.log Buffer.from(v).toString("base64").length

# 圧縮すると
# 16文字が48文字
# 256文字が316文字
# baseb4だと
# 16文字が64
###

###
# dec2hexがいりそう
dec2hexsub = (req, res)->
  m = req.mod(16)
  if req.eq m
    return m.toString(16) + res
  else
    res = m.toString(16) + res
    dec2hexsub req.divide(16), res

dec2hex = (str)-> dec2hexsub bi(str), ""

console.log helper.dec2hex helper.hex2dec("9e89d78f789")

###




###
# ビットは指定していいけど、中身は半分にしないとダメ
rc = (di)->
  min64 = bi helper.hex2dec("1000000000000000") # 64
  max64 = bi helper.hex2dec "ffffffffffffffff" # 64
  return (min64.lt(di)) && (di.lt(max64))

# 秘密鍵が大きいとは限らない
checker = (n)->
  key = gen_rsa(n)
  console.log key
  unless rc(bi(key.pub))
    console.log "miss", n
    console.log helper.hex2dec("1000000000000000")
    console.log key.pub
    console.log helper.hex2dec "ffffffffffffffff"
    process.exit()

[0...1000].forEach ->
  checker 64
###




###
# ビットは指定していいけど、中身は半分にしないとダメ
key = gen_rsa(63)
console.log key


min64 = bi helper.hex2dec("1000000000000000") # 64
max64 = bi helper.hex2dec "ffffffffffffffff" # 64

console.log min64
console.log max64
console.log bi(key.pub)
console.log min64.lt bi(key.pub)
console.log bi(key.pub).lt max64

if min64.lt(bi(key.pub)) && bi(key.pub).lt(max64)
  console.log "pubOK"
else
  console.log "pubNG"

if min64.lt(bi(key.pri)) && bi(key.pri).lt(max64)
  console.log "priOK"
else
  console.log "priNG"
###



###
# hex2decはムダではなかった
console.log parseInt 10000000, 2 # 8

console.log parseInt 1000000000000000, 2 # 16
console.log parseInt 1111111111111111, 2 # 16
console.log helper.hex2dec "ffff" # 16
console.log parseInt "ffff", 16 # 16

console.log parseInt "10000000000000000000000000000000", 2 # 32
console.log parseInt "11111111111111111111111111111111", 2 # 32
console.log helper.hex2dec "ffffffff" # 32
console.log parseInt "ffffffff", 16 # 32

console.log parseInt "1000000000000000000000000000000000000000000000000000000000000000", 2 # 64
console.log parseInt "1111111111111111111111111111111111111111111111111111111111111111", 2 # 64
console.log helper.hex2dec "ffffffffffffffff" # 64
console.log parseInt "ffffffffffffffff", 16 # 64


console.log "64"
console.log helper.hex2dec "1000000000000000" # 64
console.log gen_prime(64).toString()
console.log helper.hex2dec "ffffffffffffffff" # 64

console.log "32"
console.log helper.hex2dec "10000000"
console.log gen_prime(32).toString()
console.log helper.hex2dec "ffffffff"

console.log "16"
console.log helper.hex2dec "1000"
console.log gen_prime(16).toString()
console.log helper.hex2dec "ffff"

console.log "8"
console.log helper.hex2dec "10"
console.log gen_prime(8).toString()
console.log helper.hex2dec "ff"


console.log "4"
console.log helper.hex2dec "1"
console.log gen_prime(4).toString()
console.log helper.hex2dec "f"

###





###
# bcミニ3.1
ch = (str)-> helper.createHash(JSON.stringify(str)).substr(0,16)

blocks = []

addblock = (ph, val)->
  block = 
    if blocks[0]
      index: blocks[blocks.length-1].block.index + 1
      timestamp: process.hrtime().join("")
      transaction: val
      prev_hash: ph
    else
      index: 1
      prev_hash: 1
  
  hash = ch block
  
  blocks.push
    hash: hash
    block: block

addblock 1, null
addblock blocks[blocks.length-1].hash, helper.getHash().substr(0,8)
addblock blocks[blocks.length-1].hash, helper.getHash().substr(0,8)
addblock blocks[blocks.length-1].hash, helper.getHash().substr(0,8)
addblock blocks[blocks.length-1].hash, helper.getHash().substr(0,8)
addblock blocks[blocks.length-1].hash, helper.getHash().substr(0,8)
addblock blocks[blocks.length-1].hash, helper.getHash().substr(0,8)
console.log blocks


isHash = (i)-> i.hash == ch i.block

# 特定のハッシュを持つノードが正しいか検証
isTruthChain = (h)->
  check = blocks.find (i)-> i.hash == h
  
  if isHash check
    if check.block.prev_hash == 1
      return true
    else
      isTruthChain check.block.prev_hash
  
  else
    return false

console.log isTruthChain blocks[blocks.length-1].hash
console.log blocks.filter((i)->i.block.transaction?).map (i)-> i.block.transaction
###


###
# bcミニ3
# やっぱhashはhashとして扱わないとしんどい
ch = (str)-> helper.createHash(JSON.stringify(str)).substr(0,16)

blocks = []

addblock = (ph)->
  block = 
    if blocks[0]
      index: blocks[blocks.length-1][ph].index + 1
      prev_hash: ph
    else
      index: 1
      prev_hash: 1
  
  hash = ch block
  obj = {}
  obj[hash] = block
  
  blocks.push obj

addblock 1
addblock Object.keys(blocks[blocks.length-1]).pop()
addblock Object.keys(blocks[blocks.length-1]).pop()
addblock Object.keys(blocks[blocks.length-1]).pop()
addblock Object.keys(blocks[blocks.length-1]).pop()
addblock Object.keys(blocks[blocks.length-1]).pop()
addblock Object.keys(blocks[blocks.length-1]).pop()
addblock Object.keys(blocks[blocks.length-1]).pop()
console.log blocks
###



###
# bcミニ2
blocks = []

block = 
  index:1
  prev_hash:1

ch = (str)-> helper.createHash(JSON.stringify(str)).substr(0,16)

hash = ch block

blocks.push
  hash: hash
  block: block

nex =
  index: blocks[blocks.length-1].block.index + 1
  prev_hash: blocks[blocks.length-1].hash

hs = ch nex

blocks.push
  hash: hs
  block: nex

console.log blocks
###




###
# bcミニ
# index,transaction,prev_hash,nonce
blocks = []
block = 
  index: 1
  timestamp: process.hrtime().join("")
  transaction: 
    sender: "send"
    recipient: "recipt"
    amount: 1
  prev_hash: 1

console.log helper.createHash(block.toString()).substr(0,16)
console.log helper.getHash().substr(0,16)
###




###
# 高速指数演算
modular_exp = (a, b, n)->
  res = 1
  while b != 0
    if (b & 1) != 0
      res = (res * a) % n
    
    a = (a * a) % n
    b = b >> 1
  
  res

modular_exp = (a, b, n)->
  result = 1
  for i in [0..b] # big rangeできない
    result *= a
    result = result % n
  
  result

# 再帰を使う
modular_exp = (a, b, n)->
  return 1 if b == 0
  if (b % 2) == 0
    return modular_exp( (a*a)%n, b/2, n)
  else
    return (a * modular_exp(a, b-1, n)) % n

# 2
console.log modular_exp 2, 11, 6

console.log modular_exp 16, 11, 133

###





###
euclid = (a,b)->
  return b if a%b == 0
  euclid b, a%b

# console.log euclid 18800, 37884
# console.log euclid 37884, 37884 - 18800
# console.log euclid 37884, 18800
# console.log euclid 89,144
###



###
m = 1071
n = 1029
console.log euclid m, n
###

###
# m * x + n * y
xeuc = (a, b)->
  if b == 0
    x = 1
    y = 0
  else
    q = Math.floor a/b
    m = a%b
    res = xeuc b, m
    x = res[1]
    y = res[0] - (q * res[1])
  
  [x,y]
  
# console.log xeuc 111, 30

p = 7
q =19
phi = (p-1)*(q-1)
###

###
x = xeuc 5, 
console.log x
if x[0] < 0
  console.log x[0] + 18
else
  # おそらくこちらはありえない
  console.log x[0] % 18
###







###
# ミラーラビン
is_prime = (q,k=1)->
  q = Math.abs q 
  
  return true  if q == 2
  return false if q < 2 or (q&1) == 0
  
  d = (q-1) >> 1
  while (d&1) == 0
    d >>= 1
  
  [0...q].forEach (i)->
    a = Math.floor(Math.random() * (q-1)) + 1
    t = d
    y = (a**t)%q
    while t != q-1 and y != 1 and y != q-1
      y = (y**2)%q
      t <<= 1
    
    return false if y != q-1 and (t&1) == 0
  
  return true
###



###
# フェルマー
is_prime = (q)->
  q = Math.abs q
  return true if q == 2
  return false if q < 2 or (q&1) == 0
  return ((3 ** (q-1)) % q) == 1
###


###
# フェルマー2
is_prime = (q)->
  q = Math.abs q
  return true if q == 2
  return false if q < 2 or (q&1) == 0
  flg = true
  i = 2
  while i < 100
    i++
    x = q
    y = i
    while y == 1
      x = y
      y = x % y
    
    if x != 1
      continue
    
    if (( (Math.floor(Math.random() * 1000) + 3)  ** (q-1)) % q) == 1
      flg = false
      break
  
  return flg
###


###
# ミラーラビン2
# →ほとんどミスしない
is_prime = (q,k=50)->
  q = Math.abs q
  
  # 計算するまでもなく判定できるものははじく
  return true if q == 2
  return false if q < 2 or (q&1) == 0
  
  # n-1=2^s*dとし（但しaは整数、dは奇数)、dを求める
  d = (q-1)>>1
  while (d&1) == 0
    d >>= 1
  
  flg = true
  # 判定をk回繰り返す
  [0...k].forEach (i)->
    a = Math.floor(Math.random() * (q-1)) + 2
    t = d
    y = (a**t)%q
    # [0,s-1]の範囲すべてをチェック
    while t != q-1 and y != 1 and y != q-1
      y = (y**2)%q
      t <<= 1
    
    flg = false if y != q-1 and (t&1) == 0
    
  
  return flg
###



###
console.log "1", is_prime 1
console.log "2", is_prime 2
console.log "3", is_prime 3
console.log "4", is_prime 4
console.log "5", is_prime 5
console.log "11", is_prime 11
console.log "12", is_prime 12
console.log "13", is_prime 13
console.log "127", is_prime 127
console.log "132", is_prime 132
console.log "133", is_prime 133
console.log "134", is_prime 134
###

###
# 疑素数
console.log "341", is_prime 341
console.log "561", is_prime 561
console.log "645", is_prime 645
console.log "1105", is_prime 1105
console.log "1387", is_prime 1387
console.log "1729", is_prime 1729
console.log "1905", is_prime 1905
console.log "2047", is_prime 2047
console.log "2465", is_prime 2465
console.log "2701", is_prime 2701
console.log "2821", is_prime 2821
console.log "3277", is_prime 3277
console.log "4033", is_prime 4033
console.log "4369", is_prime 4369
console.log "4371", is_prime 4371
console.log "4681", is_prime 4681
console.log "5461", is_prime 5461
console.log "6601", is_prime 6601
console.log "7957", is_prime 7957
console.log "8321", is_prime 8321
console.log "8481", is_prime 8481
console.log "8911", is_prime 8911
###


###
[0...100000].forEach ->
  if is_prime 8911
    console.log "miss!"
###




###
# ・crypto.randomBytes(16) とは
# →256**nの数字しか指定できない
cry = require "crypto"
bi = require "big-integer"

console.log parseInt cry.randomBytes(128).toString("hex"), 16
console.log cry.randomBytes(128).toString("hex")
console.log helper.hex2dec cry.randomBytes(128).toString("hex")

[0...100].forEach ->
  console.log parseInt cry.randomBytes(2).toString("hex"), 16
###




###
# ビット演算はカッコが必要そう
d = 132
console.log d&1
console.log d&1 == 0
console.log (d&1) == 0
while (d&1) == 0
  d >>= 1
  console.log d
###


###
sec = 'pwpw'
pass = new Buffer sec
loop
  string = Buffer.allocUnsafe(1024).toString()
  console.log string
  if /pw/.test string
    break
  sec = 'pwpw'
  pass = new Buffer sec


# console.log string


# console.log Buffer.allocUnsafe(1024).toString()
# console.log Buffer.allocUnsafe(1024).toString()
# console.log Buffer.allocUnsafe(1024).toString()
# console.log Buffer.allocUnsafe(1024).toString()
###



###
# sw
bi = require "big-integer"

# 高速指数演算
modular_exp = (a, b, n)->
  res = bi.one
  while b.neq(0)
    if b.and(1).neq(0)
      res = res.multiply(a).mod(n)
    
    a = a.multiply(a).mod(n)
    b = b.shiftRight(1)
  
  res

# 拡張ユークリッド互除法
xeuclid = (aa, bb)->
  if bb.eq(0)
    uu = 1
    vv = 0
  else
    qq = aa.divide bb
    rr = aa.mod bb
    res = xeuclid(bb, rr)
    uu = res[1]
    vv = res[0].minus(qq.multiply(res[1]))
  
  [bi(uu), bi(vv)]

# 鍵生成
gen_d = (e, l)->
  x = xeuclid(e, l)[0]
  if x.sign
    x.plus l
  else
    x.mod l


n = bi "114381625757888867669235779976146612010218296721242362562561842935706935245733897830597123563958705058989075147599290026879543541"
p = bi "3490529510847650949147849619903898133417764638493387843990820577"
q = bi "32769132993266709549961988190834461413177642967992942539798288533"
e = bi "9007"
d = gen_d e, p.minus(1).multiply(q.minus(1))

c = bi "96869613754622061477140922254355882905759991124574319874695120930816298225145708356931476622883989628013391990551829945157815154"

m = modular_exp(c, d, n).toString()

m2a = (str)->
  convert_swa = (i)->
    switch i
      when "00" then return " "
      when "01" then return "A"
      when "02" then return "B"
      when "03" then return "C"
      when "04" then return "D"
      when "05" then return "E"
      when "06" then return "F"
      when "07" then return "G"
      when "08" then return "H"
      when "09" then return "I"
      when "10" then return "J"
      when "11" then return "K"
      when "12" then return "L"
      when "13" then return "M"
      when "14" then return "N"
      when "15" then return "O"
      when "16" then return "P"
      when "17" then return "Q"
      when "18" then return "R"
      when "19" then return "S"
      when "20" then return "T"
      when "21" then return "U"
      when "22" then return "V"
      when "23" then return "W"
      when "24" then return "X"
      when "25" then return "Y"
      when "26" then return "Z"
  
  str.match(/.{1,2}/g).map((i)-> convert_swa i).join("")


console.log m
console.log m2a(m)
###




###
gen_rand = (bit_length)->
  bits = [0...bit_length - 2].map -> Math.floor Math.random() * 2
  # console.log bits
  ret = 1
  bits.forEach (b)->
    # console.log "b",b
    ret = ret * 2 + b
    # console.log "ret", ret
  
  ret * 2 + 1

# 16ビット 2バイト
# 32ビット 4バイト
p = gen_rand(32)
console.log p, p.toString(16), p.toString(2)

# fa 9e b2 fd→8*4 32ビット
# 1001101111011011011111001110100111101111000110101110000000000000→64ビット
# 9b db 7c e9 ef 1a e0 00→8*8→64
# f0 06 02 63 1c d8 26 2f→8*8→64
# 素数は32ビットであり、公開鍵が64ビットということ
###



###
# RSAbreaker
bi = require "big-integer"

# 高速指数演算
modular_exp = (a, b, n)->
  res = bi.one
  while b.neq(0)
    if b.and(1).neq(0)
      res = res.multiply(a).mod(n)
    
    a = a.multiply(a).mod(n)
    b = b.shiftRight(1)
  
  res

# 拡張ユークリッド互除法
xeuclid = (aa, bb)->
  if bb.eq(0)
    uu = 1
    vv = 0
  else
    qq = aa.divide bb
    rr = aa.mod bb
    res = xeuclid(bb, rr)
    uu = res[1]
    vv = res[0].minus(qq.multiply(res[1]))
  
  [bi(uu), bi(vv)]

# 鍵生成
gen_d = (e, l)->
  x = xeuclid(e, l)[0]
  if x.sign
    x.plus l
  else
    x.mod l

# 平方根を求める
sqrt = (x)->
  a = x
  [0..100].forEach ->
    x = x.minus(x.multiply(x).minus(a).divide(bi(2).multiply(x)))
  x.minus(1)

# SQUFOF v1.1
squfof = (N)->
  multiplier = [1, 3, 5, 7, 11, 3*5, 3*7, 3*11, 5*7, 5*11, 7*11, 3*5*7, 3*5*11, 3*7*11, 5*7*11, 3*5*7*11].map (i)-> bi i
  
  s = sqrt(N)
  if s.multiply(s).eq(N)
    return s
  
  while multiplier.length > 0
    k = multiplier.shift()
    D = k.multiply N
    Po = Pprev = P = sqrt D
    Qprev = bi.one
    Q = D.minus(Po.multiply(Po))
    L = bi(2).multiply(sqrt(bi(2).multiply(s)))
    B = bi(3).multiply(L)
    
    i = bi(2)
    while i.lt(B)
      b = (Po.plus(P)).divide(Q)
      P = b.multiply(Q).minus(P)
      q = Q
      Q = Qprev.plus(b.multiply(Pprev.minus(P)))
      r = sqrt Q
      
      if ((i.and(bi.one)).leq(bi.one) && r.multiply(r).eq(Q))
        break
      
      Qprev = q
      Pprev = P
      
      i = i.plus(bi.one)
    
    if (i.geq(B))
      continue
    
    b = (Po.minus(P)).divide(r)
    Pprev = P = b.multiply(r).plus(P)
    Qprev = r
    Q = (D.minus(Pprev.multiply(Pprev))).divide(Qprev)
    i = bi.zero
    
    loop
      b = (Po.plus(P)).divide(Q)
      Pprev = P
      P = b.multiply(Q).minus(P)
      q = Q
      Q = Qprev.plus(b.multiply(Pprev.minus(P)))
      Qprev = q
      i = i.plus(1)
      
      break unless (P.neq(Pprev))
    
    r = bi.gcd(N, Qprev)
    if (r.neq(1) && r.neq(N))
      return r
  
  return bi.zero

# 16進数文字を10進数に変換
hex2decsub = (req, res, ind)->
  s = req.pop()
  if s?
    i = bi(parseInt(s, 16))
    res = res.plus( i.multiply( bi(1).multiply(bi(16).pow(ind)) ) )
    hex2decsub req, res, ind.plus(1)
  else
    res.toString()

hex2dec = (str)->
  hex2decsub str.split(""), bi.zero, bi.zero

# 数字文字列を返す
str2bi = (str)->
  if str.match(/^\d*$/)
    # 全部数字
    return bi str
  else if str.match(/^[\d:a-fA-F]*$/)
    # 16進数っぽい
    return bi hex2dec str.split(":").join("")
  else
    null

# 秘密鍵生成v2.0 asnを生成
rsacrack = (pub)->
  q = squfof pub
  p = pub.divide(q)

  e = bi 65537

  n = p.multiply(q)
  d = gen_d e, p.minus(1).multiply(q.minus(1))

  console.log "asn1=SEQUENCE:rsa_key"
  console.log ""
  console.log "[rsa_key]"
  console.log "version=INTEGER:0"
  console.log "modulus=INTEGER:" + n.toString()
  console.log "pubExp=INTEGER:" + e.toString()
  console.log "privExp=INTEGER:" + d.toString()
  console.log "p=INTEGER:" + p.toString()
  console.log "q=INTEGER:" + q.toString()
  console.log "e1=INTEGER:" + d.mod(p.minus(1)).toString()
  console.log "e2=INTEGER:" + d.mod(q.minus(1)).toString()
  console.log "coeff=INTEGER:" + modular_exp(q, p.minus(2), p).toString()

rsacrack str2bi "01:50:4c:45:03:e8:0e:e3:6d"
rsacrack str2bi "01:9a:c6:86:47:6c:02:34:31"
###












###

# RSA暗号v2.0
bi = require "big-integer"

# 高速指数演算
modular_exp = (a, b, n)->
  res = bi.one
  while b.neq(0)
    if b.and(1).neq(0)
      res = res.multiply(a).mod(n)
    
    a = a.multiply(a).mod(n)
    b = b.shiftRight(1)
  
  res

# ランダムな素数
gen_rand = (bit_length)->
  bits = [0...bit_length - 2].map -> bi.randBetween 0, 1
  ret = bi(1)
  bits.forEach (b)->
    ret = ret.multiply(2).plus(b)
  
  ret.multiply(2).plus(1)

# 素数確認
mr_primary_test = (n, k=100)->
  return false if n.eq 1
  return true if n.eq 2
  return false if n.mod(2).eq(0)
  
  d = n.minus(1)
  s = bi.zero
  while d.mod(2).neq(0)
    d = d.divide(2)
    s = s.plus(1)
  
  r = [0...k].map -> bi.randBetween 1, n.minus(1)
  res = r.some (a)->
    if modular_exp(a, d, n).neq(1)
      pl = [0...s].map (rr)-> 
        bi(2).pow(rr).multiply(d)
      
      flg = true
      
      pl.forEach (p)->
        if modular_exp(a, p, n).eq(1)
          flg = false
          return
      
      if flg
        return true
    
  return res == false

# 素数生成
gen_prime = (bit)->
  while true
    ret = gen_rand(bit)
    if mr_primary_test(ret)
      break
  
  return ret

# 拡張ユークリッド互除法
xeuclid = (aa, bb)->
  if bb.eq(0)
    uu = 1
    vv = 0
  else
    qq = aa.divide bb
    rr = aa.mod bb
    res = xeuclid(bb, rr)
    uu = res[1]
    vv = res[0].minus(qq.multiply(res[1]))
  
  [bi(uu), bi(vv)]

# 鍵生成
gen_d = (e, l)->
  x = xeuclid(e, l)[0]
  if x.sign
    x.plus l
  else
    x.mod l


# keygen
gen_rsa = (bit_length)-> new Promise (f,r)->
  bit = bi bit_length
  p = gen_prime(bit)
  q = gen_prime(bit)
  
  e = bi 65537
  
  n = p.multiply(q)
  d = gen_d e, p.minus(1).multiply(q.minus(1))
  
  res = {}
  Promise.resolve()
  .then ->
    helper.deflate n.toString()
  .then (v)->
    res.pub = v
    helper.deflate d.toString()
  .then (v)->
    res.key = v
    f res
  .catch (e)-> console.log "e", e

# 64ビットの公開鍵→32ビットのp,qを作る
gen_rsa 32
.then (v)-> console.log v

# rsa暗号化
encode_rsa = (pub, value)-> new Promise (f,r)->
  e = bi 65537
  
  m = value
  a = m.split("").map (i)->bi i.charCodeAt()
  
  Promise.resolve()
  .then ->
    helper.inflate pub
  .then (pub)->
    c = a.map (i)-> modular_exp(i, e, pub)
    str = JSON.stringify c
    helper.deflate str
  .then (v)->
    f v
  .catch (e)-> console.log "e", e

# rsa複合
decode_rsa = (pub, key, crypto)-> new Promise (f,r)->
  req = {}
  Promise.resolve()
  .then ->
    helper.inflate pub
  .then (v)->
    req.pub = bi v
    helper.inflate key
  .then (v)->
    req.key = bi v
    helper.inflate crypto
  .then (v)->
    arr = JSON.parse(v)
    # console.log "arr",arr
    pt = arr.map (i)-> modular_exp(bi(i), bi(req.key), bi(req.pub))
    f pt.map((i)-> String.fromCharCode i).join("")
  .catch (e)-> console.log "e", e
###






###
# 平方根を求める
sqrt = (x)->
  a = x
  [0..100].forEach ->
    x = x.minus(x.multiply(x).minus(a).divide(bi(2).multiply(x)))
  x.minus(1)

# フェルマー法
is_square = (n)->
  flg = [0, 1, 4, 9, 16, 25, 33, 36].some (i)-> n.mod(48).eq(i)
  
  if flg==false
    return false 
  else
    x = sqrt(n)
    return x.multiply(x).eq(n)

fermat = (n)->
  a = sqrt(n)
  b2 = (a.multiply(a)).minus(n)
  
  while is_square(b2) == false
    a = a.plus(1)
    b2 = a.multiply(a).minus(n)
  
  a.minus( sqrt(b2) )
  # p = fermat n
  # console.log n.toString(), "→", p.toString(), ",", n.divide(p).toString()

# 16進数文字を10進数に変換
hex2decsub = (req, res, ind)->
  s = req.pop()
  if s?
    i = bi(parseInt(s, 16))
    res = res.plus( i.multiply( bi(1).multiply(bi(16).pow(ind)) ) )
    hex2decsub req, res, ind.plus(1)
  else
    res.toString()

hex2dec = (str)->
  hex2decsub str.split(""), bi.zero, bi.zero

# 数字文字列を返す
str2bi = (str)->
  if str.match(/^\d*$/)
    # 全部数字
    return bi str
  else if str.match(/^[\d:a-fA-F]*$/)
    # 16進数っぽい
    return bi hex2dec str.split(":").join("")
  else
    null



# SQUFOF v1.0
squfof_method = (N)->
  multiplier = [1, 3, 5, 7, 11, 3*5, 3*7, 3*11, 5*7, 5*11, 7*11, 3*5*7, 3*5*11, 3*7*11, 5*7*11, 3*5*7*11].map (i)-> bi i
  
  s = sqrt(N)
  if s.multiply(s).eq(N)
    return s
  
  while multiplier.length > 0
    k = multiplier.shift()
    D = k.multiply N
    Po = Pprev = P = sqrt D
    Qprev = bi.one
    Q = D.minus(Po.multiply(Po))
    L = bi(2).multiply(sqrt(bi(2).multiply(s)))
    B = bi(3).multiply(L)
    
    i = bi(2)
    while i.lt(B)
      b = (Po.plus(P)).divide(Q)
      P = b.multiply(Q).minus(P)
      q = Q
      Q = Qprev.plus(b.multiply(Pprev.minus(P)))
      r = sqrt Q
      
      if ((i.and(bi.one)).leq(bi.one) && r.multiply(r).eq(Q))
        break
      
      Qprev = q
      Pprev = P
      
      i = i.plus(bi.one)
    
    if (i.geq(B))
      continue
    
    b = (Po.minus(P)).divide(r)
    Pprev = P = b.multiply(r).plus(P)
    Qprev = r
    Q = (D.minus(Pprev.multiply(Pprev))).divide(Qprev)
    i = bi.zero
    
    loop
      b = (Po.plus(P)).divide(Q)
      Pprev = P
      P = b.multiply(Q).minus(P)
      q = Q
      Q = Qprev.plus(b.multiply(Pprev.minus(P)))
      Qprev = q
      i = i.plus(1)
      
      break unless (P.neq(Pprev))
    
    r = bi.gcd(N, Qprev)
    if (r.neq(1) && r.neq(N))
      return r
  
  return bi.zero

squfof = (N)->
  res = {}
  N = bi N
  p = squfof_method N
  q = N.divide(p)
  
  res.n = N.toString()
  res.p = p.toString()
  res.q = q.toString()
  
  res
###





###
# 秘密鍵生成v1.1 フェルマーからsqufofへ
rsacrack = (pub)->
  console.log "attack ", pub.toString()
  
  q = squfof_method pub
  p = pub.divide(q)

  e = bi 65537

  n = p.multiply(q)
  d = gen_d e, p.minus(1).multiply(q.minus(1))

  console.log "modulus:", n.toString()
  console.log "publicExponent:", e.toString()
  console.log "privateExponent:", d.toString()

  console.log "prime1:", p.toString()
  console.log "prime2:", q.toString()

  console.log "exponent1", d.mod(p.minus(1)).toString()
  console.log "exponent2", d.mod(q.minus(1)).toString()
  console.log "coefficient", modular_exp(q, p.minus(2), p).toString()



rsacrack str2bi "01:50:4c:45:03:e8:0e:e3:6d"
rsacrack str2bi "01:9a:c6:86:47:6c:02:34:31"
###



###
# pubstr="17772938775798494671"
# pubstr="12868808658646729003"
# pubstr="17295514043671914031"
# pubstr="15994946381146356007"
# pubstr="1486935533"
# pubstr= hex2dec "0332c178b4cb87f881"

# console.log hex2dec "01:50:4c:45:03:e8:0e:e3:6d".split(":").join("")
# pubstr = hex2dec "01:9a:c6:86:47:6c:02:34:31".split(":").join("")

# rsacrack pubstr
###


###
# 秘密鍵生成v1.0
rsacrack = (pubstr)->
  console.log "attack ", pubstr
  pub = bi pubstr

  q = bi fermat pub
  p = bi pub.divide(q)

  e = bi 65537

  n = p.multiply(q)
  d = gen_d e, p.minus(1).multiply(q.minus(1))

  console.log "modulus:", n.toString()
  console.log "publicExponent:", e.toString()
  console.log "privateExponent:", d.toString()

  console.log "prime1:", p.toString()
  console.log "prime2:", q.toString()

  console.log "exponent1", d.mod(p.minus(1)).toString()
  console.log "exponent2", d.mod(q.minus(1)).toString()
  console.log "coefficient", modular_exp(q, p.minus(2), p).toString()
###



###
# pubstr="17772938775798494671"
# pubstr="12868808658646729003"
# pubstr="17295514043671914031"
# pubstr="15994946381146356007"
# pubstr="1486935533"
# pubstr= hex2dec "0332c178b4cb87f881"

# console.log hex2dec "01:50:4c:45:03:e8:0e:e3:6d".split(":").join("")
# pubstr = hex2dec "01:9a:c6:86:47:6c:02:34:31".split(":").join("")

# rsacrack pubstr

# console.log squfof hex2dec "00:c3:c4:33:0f:7b:1c:d0:4f:65:db:6e:34:81:94:3e:36:a8:35:b5:67:6c:1e:b5:68:e2:c5:50:e4:ce:02:90:2a:f0:98:6a:df:bc:6c:9a:6e:a8:c3:7f:d0:b9:21:29:a8:3a:46:ab:2e:f9:aa:f4:32:de:7a:48:06:42:05:4a:3d:80:46:15:14:b9:4f:3e:c3:c4:5e:21:a2:a7:a8:cc:38:ec:c1:56:58:cd:03:9f:9b:1b:cf:54:4f:1d:14:9f:aa:ed:97:93:64:19:b5:db:28:db:94:6c:1b:e3:b1:2e:1c:12:e2:0a:b5:5e:c5:1d:3e:4f:3f:fa:5f:5f:64:94:45".split(":").join("")
# console.log hex2dec "00:c3:c4:33:0f:7b:1c:d0:4f:65:db:6e:34:81:94:3e:36:a8:35:b5:67:6c:1e:b5:68:e2:c5:50:e4:ce:02:90:2a:f0:98:6a:df:bc:6c:9a:6e:a8:c3:7f:d0:b9:21:29:a8:3a:46:ab:2e:f9:aa:f4:32:de:7a:48:06:42:05:4a:3d:80:46:15:14:b9:4f:3e:c3:c4:5e:21:a2:a7:a8:cc:38:ec:c1:56:58:cd:03:9f:9b:1b:cf:54:4f:1d:14:9f:aa:ed:97:93:64:19:b5:db:28:db:94:6c:1b:e3:b1:2e:1c:12:e2:0a:b5:5e:c5:1d:3e:4f:3f:fa:5f:5f:64:94:45".split(":").join("")
###




###
# console.log squfof_method bi 133

# console.log sqrt bi 133
# console.log sqrt bi 144
# console.log squfof bi 133
# console.log squfof bi 11111
# modustr="17772938775798494671"
# console.log squfof modustr
###

###
console.time "a"
console.log squfof "17772938775798494671"
console.timeEnd "a"

console.time "a"
console.log squfof "12868808658646729003"
console.timeEnd "a"

console.time "a"
console.log squfof "17295514043671914031"
console.timeEnd "a"

console.time "a"
console.log squfof "15994946381146356007"
console.timeEnd "a"

console.time "a"
console.log squfof "1486935533"
console.timeEnd "a"

console.time "a"
console.log squfof hex2dec "0332c178b4cb87f881"
console.timeEnd "a"

console.time "a"
console.log squfof "15994946381146356007"
console.timeEnd "a"

console.time "a"
console.log squfof hex2dec "01:50:4c:45:03:e8:0e:e3:6d".split(":").join("")
console.timeEnd "a"

console.time "a"
console.log squfof "1578095031515398957"
console.timeEnd "a"

console.time "a"
console.log squfof hex2dec "01:9a:c6:86:47:6c:02:34:31".split(":").join("")
console.timeEnd "a"
###




###
i = bi(2)
B = bi(10)
while i.lt(B)
  console.log i
  i = i.plus 1
###




###
console.log str2bi "1234567"
console.log str2bi "23:12:f2:23"
console.log str2bi "error"
###

###
# SQUFOF v0.1
# 平方根を求める(小さい数)
sqrts = (x)->
  a = x
  x = x - ((x*x-a)/2) * x
  x - 1

squfof = (N)->
  multiplier = [1, 3, 5, 7, 11, 3*5, 3*7, 3*11, 5*7, 5*11, 7*11, 3*5*7, 3*5*11, 3*7*11, 5*7*11, 3*5*7*11]
  # D, Po, P, Pprev, Q, Qprev, q, b, r, s
  # L, B, i
  
  # 平方根をとる
  s = Math.ceil Math.sqrt N
  console.log s, N
  if s * s == N
    console.log "saisyo"
    return s
  
  # マルチプライヤー分繰り返す
  # multiplier.forEach (k)->
  while multiplier.length > 0
    k = multiplier.shift()
    console.log "k is",k
    D = k*N
    Po = Pprev = P = Math.ceil Math.sqrt D
    Qprev = 1
    Q = D - Po * Po
    L = 2 * Math.ceil Math.sqrt(2 * s)
    B = 3 * L
    
    console.log "i = 2"
    i = 2
    while i < B
      console.log "i is ", i
      b = (Po + P)/Q
      P = b * Q - P
      q = Q
      Q = Qprev + b * (Pprev - P)
      r = Math.ceil Math.sqrt Q
      console.log "Q,r", Q,r
      # iの下一桁が1でなく、rがQの平方だった場合抜ける
      if (!(i & 1) && r * r == Q)
        break
      
      console.log "break ato"
      
      Qprev = q
      Pprev = P
      
      i = i + 1
    
    console.log "continue mae"
    # ここがうまくいくかあやしい
    # iがB以上だったら次のマルチプライヤ―へ行くということ
    if (i >= B)
      continue
    
    console.log "continue ato"
    b = (Po - P)/r
    Pprev = P = b * r + P
    Qprev = r
    Q = (D - Pprev * Pprev) / Qprev
    i = 0
    
    console.log "loop mae"
    loop
      console.log "loop nai"
      b = (Po + P) / Q
      Pprev = P
      P = b * Q - P
      q = Q
      Q = Qprev + b * (Pprev - P)
      Qprev = q
      i++
      
      break unless (P != Pprev)
    
    r = bi.gcd(N, Qprev).value
    console.log "kiteru?", r
    if (r != 1 && r != N)
      return r
  
  return r



console.log squfof 144
console.log squfof 11111
# console.log Math.sqrt 144
###



###
hai = [1,2,4,5,6].map (i)-> bi i

while hai.length > 0
  a = hai.shift()
  console.log a
  if a.eq(4)
    continue
  console.log a,"にかいめ"
###



###
console.log hex2dec "8000000000000000"
console.log hex2dec "10000000000000000"
console.log hex2dec "1504c4503e80ee36d"
console.log hex2dec "20000000000000000"
###


###
# 秘密鍵生成
pubstr="17772938775798494671"
pubstr="1486935533"
pubstr= hex2dec "0332c178b4cb87f881"

console.log "attack ", pubstr
pub = bi pubstr

q = bi fermat pub
p = bi pub.divide(q)

e = bi 65537

n = p.multiply(q)
d = gen_d e, p.minus(1).multiply(q.minus(1))

console.log "modulus:", n.toString()
console.log "publicExponent:", e.toString()
console.log "privateExponent:", d.toString()

console.log "prime1:", p.toString()
console.log "prime2:", q.toString()

console.log "exponent1", d.mod(p.minus(1)).toString()
console.log "exponent2", d.mod(q.minus(1)).toString()
console.log "coefficient", modular_exp(q, p.minus(2), p).toString()


# exponent1: 200729035 (0xbf6e1cb)
# e1 = privExp mod (p - 1)

# exponent2: 2121898481 (0x7e7999f1)
# e2 = privExp mod (q - 1)

# coefficient: 693493053 (0x2955dd3d)
# coeff = q^-1 mod p

# sympy.factorint(1578095031515398957)
###




###
# 365が衝突する可能性
[1..100].forEach (ninzu)->
  kaku = 0
  loo = 2000

  [0...loo].forEach ->
    conflg = false
    p = []
    [0..ninzu].forEach ->
      n = Math.floor(Math.random()*365)
      flg = p.some((i)-> n == i)
      if flg
        # console.log "conf", n
        conflg = true
      else
        p.push n
        # console.log p
    
    if conflg
      kaku++
  
  console.log ninzu, "人のとき", Math.ceil(kaku/loo*100), "%重複する"
###


###
# 素因数分解 まだダメ
primefactorization = (n)->
  p = bi(2)
  
  # まず2で割れるだけ割る
  output = ""
  while n == n.divide(p).multiply(p) and n.gt(p)
    output += p.toString() + ' * '
    n = n.divide(p)
  
  # 次に3以上の奇数で割り続ける
  p = p.plus(1)
  while n.geq(p.multiply(p))
    if n.neq(n.divide(p).multiply(p))
      p = p.plus(2)
    else
      output += p.toString() + ' * '
      n = n.divide(p)
    
  
  output += n.toString()

console.log primefactorization bi "133"
console.log primefactorization bi "17772938775798494671"
###


###
n = bi "133"
# n = 1578095031515398957

i = bi 2
while i.leq(n)
  # console.log i
  while n.mod(i).eq 0
    console.log i.toString()
    n = n.divide i
  
  i = i.plus 1
###





###
# 素因数分解 bi版 いまいち
bi = require "big-integer"

# 平方根を求める
sqrt = (x)->
  a = x
  [0..100].forEach ->
    x = x.minus(x.multiply(x).minus(a).divide(bi(2).multiply(x)))
  x.minus(1)


primeFactorizationbi = (n)->
  s = sqrt n
  r = bi.zero
  result = []
  
  # i = bi("4143585130")
  i = bi("2")
  while i.leq(s)
    console.log i
    if (n.mod(i)).eq(0)
      console.log "cong!!!", i
      result.push i.toString()
      result.push n.divide(i).toString()
      break
    
    # インクリメントではなく素数を増やしていく
    while true
      i = i.plus(1)
      console.log i
      if i.isPrime()
      # if mr_primary_test(i)
        console.log i,"isprime"
        break
      else
        console.log i,"isntprime"
        # if mr_primary_test(s)
        continue
    
    # i = i.plus(1)
    
  
  result

# console.log sqrt bi "17772938775798494671"
# console.log primeFactorizationbi bi 133
# console.log primeFactorizationbi bi "17772938775798494671"

n = bi "17772938775798494671"
# console.log gen_prime(1024).bitLength()
###





###
# フェルマー法
# console.log sqrt bi 36
# console.log sqrt bi 133
# console.log sqrt bi 14884

is_square = (n)->
  flg = [0, 1, 4, 9, 16, 25, 33, 36].some (i)-> n.mod(48).eq(i)
  
  if flg==false
    return false 
  else
    x = sqrt(n)
    return x.multiply(x).eq(n)

# console.log is_square bi 36
# console.log is_square bi 133
# console.log is_square bi 14884




fermat = (n)->
  a = sqrt(n)
  b2 = (a.multiply(a)).minus(n)
  
  while is_square(b2) == false
    a = a.plus(1)
    b2 = a.multiply(a).minus(n)
  
  a.minus( sqrt(b2) )

getPrime = (n)->
  p = fermat n
  console.log n.toString(), "→", p.toString(), ",", n.divide(p).toString()

getPrime bi "133"
getPrime bi "17772938775798494671"
###




###
str = "21f" # 512+16+15=543
arr = str.split("")

res = bi.zero
console.log res
res = res.plus( bi(parseInt(arr.pop(), 16)).multiply( bi(1).multiply(  bi(16).pow(0)  ) ) )
console.log res
res = res.plus( bi(parseInt(arr.pop(), 16)).multiply( bi(1).multiply(  bi(16).pow(1)  ) ) )
console.log res
res = res.plus( bi(parseInt(arr.pop(), 16)).multiply( bi(1).multiply(  bi(16).pow(2)  ) ) )
console.log res
###





###
# console.log "", hex2dec "21f23987234fdaefafdfe"

console.log "17772938775798494671", hex2dec "f6a629a6ca3c35cf"
console.log "65537", hex2dec "10001"
console.log "7332960987984909313", hex2dec "65c3e92ab8a35401"
console.log "4289265983", hex2dec "ffa9013f"
console.log "4143585137", hex2dec "f6fa1771"
console.log "200729035", hex2dec "bf6e1cb"
console.log "2121898481", hex2dec "7e7999f1"
console.log "693493053", hex2dec "2955dd3d"
###




###
# hex2dec
str = "21f" # 512+16+15=543
arr = str.split("")

res = bi.zero
console.log res
res = res.plus( bi(parseInt(arr.pop(), 16)).multiply( bi(1).multiply(  bi(16).pow(0)  ) ) )
console.log res
res = res.plus( bi(parseInt(arr.pop(), 16)).multiply( bi(1).multiply(  bi(16).pow(1)  ) ) )
console.log res
res = res.plus( bi(parseInt(arr.pop(), 16)).multiply( bi(1).multiply(  bi(16).pow(2)  ) ) )
console.log res
###


###
# hex2dec
str = "1f" # 16+15=31
arr = str.split("")

res = bi.zero
console.log res
res = res.plus( bi(parseInt(arr.pop(), 16)).multiply(bi(1)) )
console.log res
res = res.plus( bi(parseInt(arr.pop(), 16)).multiply( bi(1).multiply(16) ) )
console.log res
###




###
# 自分が素数かどうか
lprime = []

# [2...120].forEach (i)->

# n = bi(120)
n = bi("65535")

i = bi 2
while i.leq(n)
  flg = lprime.some (j)-> i % j == 0
  if flg == false
    lprime.push i.toString()
    console.log i.toString(), lprime.length
  
  i = i.plus 1

console.log lprime
###




###
# 8bit (23)
# i = bi 128
# n = bi 255

# 16bit (3030)
# i = bi 32768
# n = bi 65535

# 32 bits is 2147483648 ～ 4294967295 range
# このへんからしんどい
i = bi "2147483648"
n = bi "4294967295"
# 64 bits is 9223372036854775808 ～ 18446744073709551615 range


lprime = []
while i.leq(n)
  # 途中からなのでエラトステネスの篩は使えない
  # flg = lprime.some (j)-> i % j == 0
  # if flg == false
  if i.isProbablePrime()
    lprime.push i.toString()
    console.log i.toString(), lprime.length
  
  i = i.plus 1

console.log lprime, lprime.length
###



###
[1...10].forEach (r)->
  # console.log r,"ビットのとき",2**r,"個"
  console.log 2**r, "bits is", 2** ( (2**r)-1 )
  # console.log r, "bits is", parseInt "1" + "0".repeat(r-1), 2, "count"
###


###
i = bi 1
while i.leq("10")
  bit = bi(2).pow(i).toString()
  count = bi(2).pow( (bi(2).pow(i).minus(1)) ).toString()
  console.log bit, "bits is", count
  i = i.plus 1

# 64 bits is 9223372036854775808
###

###
i = bi 1
while i.leq("10")
  bit = bi(2).pow(i).toString()
  start = bi(2).pow( (bi(2).pow(i).minus(1)) ).toString()
  end = bi(2).pow( (bi(2).pow(i)) ).minus(1).toString()
  console.log bit, "bits is", start, "～", end, "range"
  i = i.plus 1

# 8 bits is 128 ～ 255 range
# 16 bits is 32768 ～ 65535 range
# 32 bits is 2147483648 ～ 4294967295 range
# 64 bits is 9223372036854775808 ～ 18446744073709551615 range

###


###
i = bi 1
while i.leq("10")
  console.log i
  i = i.plus 1
###

###
r = bi 2
[1...10].forEach ->
  console.log r, "bits is", parseInt "1" + "0".repeat(r-1), 2, "count"
  r = r.multiply(2)
###

###
cntter = (b)->
  bits = b
  range = parseInt "1" + "0".repeat(16-1), 2
  range - 1
  

bits = 16
ab = cntter bits
console.log bits, "bits is", ab, "count"
###



###
while true
  p = sqrt(gen_prime(64))
  console.log p
  if n.mod(p) == 0
    console.log p
    break
# console.log sqrt(gen_prime(64))
###




###
# Eratosthenes
eratosthenes = (n)->
  s = Math.floor Math.sqrt n
  arr = [2..n].filter (i)-> 
    i % 2 != 0
  .filter (i)->
    i % 3 != 0
  .filter (i)->
    i % 5 != 0
  .filter (i)->
    i % 7 != 0
  .filter (i)->
    i % 9 != 0
  .filter (i)->
    i % 11 != 0

console.log eratosthenes 120
###



###
a = 133
x = 133
x = x - (x * x - a) / (2 * x)
console.log x
x = x - (x * x - a) / (2 * x)
console.log x
x = x - (x * x - a) / (2 * x)
console.log x
###

###
sqrt = (x)->
  a = x
  [0..1000].forEach ->
    x = x - (x * x - a) / (2 * x)
  x
###


###
# 平方根を求める
sqrt = (x)->
  a = x
  [0..100].forEach ->
    x = x.minus(x.multiply(x).minus(a).divide(bi(2).multiply(x)))
  x

console.log sqrt bi 133
console.log sqrt bi 12394873
###

###
n = 133
r = sqrt n, n
console.log r

r = sqrt n,r
console.log r
r = sqrt n,r
console.log r
r = sqrt n,r
console.log r
r = sqrt n,r
console.log r
r = sqrt n,r
console.log r
###

###
n = bi "133"
# n = bi "17772938775798494671"

i = bi(2)
while i.leq(11)
  if n.mod(i).eq(0)
    console.log "zzzz", i.toString()
  console.log i.toString()
  
  i = i.plus(1)
###


###
console.log "検算"
i = bi(2)
while i.leq(5)
  console.log i.toString()
  i = i.plus(1)
###


###
# 素因数分解
primeFactorization = (n)->
  s = Math.floor(Math.sqrt(n))
  r = 0
  result = []
  
  [2..s].forEach (i)->
    if (n % i) == 0
      r = 0
      while ((n % i) == 0)
        r++
        n = n / i
      
      result.push
        num: i
        r: r
  
  if (n > s) 
    result.push
      num: n
      r: 1
  
  result

# console.log primeFactorization 17772938775798494671
# console.log primeFactorization 1486935533
###




###
str = """
MCQwDQYJKoZIhvcNAQEBBQADEwAwEAIJANsBMrNYoNXtAgMBAAE=
"""


console.log Buffer.from(str, "base64")
console.log Buffer.from(str, "base64").toString("utf8")
console.log Buffer.from(str, "base64").toString("hex")
###



###
# base64変換 Bufferはfromが推奨
str = Buffer.from("もじれつ").toString 'base64'
console.log str
console.log Buffer.from(str, "base64").toString()
###


###
# 検算
xeuclid_si = (a, b)->
  if b == 0
    u = 1
    v = 0
  else
    q = Math.floor(a / b)
    r = a % b
    console.log "qr", q, r
    res = xeuclid_si(b, r)
    u = res[1]
    v = res[0] - (q * res[1])
    console.log "uv", u, v
  
  [u,v]


# console.log xeuclid_si 65537, 108
# console.log xeuclid_si 5, 108

gen_d = (e, l)->
  x = xeuclid(e, l)[0]
  if x.sign
    x.plus l
  else
    x.mod l

modular_exp = (a, b, n)->
  res = 1
  while b != 0
    if (b & 1) != 0
      res = (res * a) % n
    
    a = (a * a) % n
    b = b >> 1
    console.log "res,ab",res,a,b
  
  res

# console.log modular_exp 123, 65537, 133
# console.log modular_exp 93, 17, 133

# console.log modular_exp 123, 5, 133
console.log modular_exp 16, 65, 133
###


###
# RSA暗号v1.3 正整数eは65537で固定
bi = require "big-integer"

# 高速指数演算
modular_exp = (a, b, n)->
  res = bi.one
  while b.neq(0)
    if b.and(1).neq(0)
      res = res.multiply(a).mod(n)
    
    a = a.multiply(a).mod(n)
    b = b.shiftRight(1)
  
  res

# ランダムな素数
gen_rand = (bit_length)->
  bits = [0...bit_length - 2].map -> bi.randBetween 0, 1
  ret = bi(1)
  bits.forEach (b)->
    ret = ret.multiply(2).plus(b)
  
  ret.multiply(2).plus(1)

# 素数確認
mr_primary_test = (n, k=100)->
  return false if n.eq 1
  return true if n.eq 2
  return false if n.mod(2).eq(0)
  
  d = n.minus(1)
  s = bi.zero
  while d.mod(2).neq(0)
    d = d.divide(2)
    s = s.plus(1)
  
  r = [0...k].map -> bi.randBetween 1, n.minus(1)
  res = r.some (a)->
    if modular_exp(a, d, n).neq(1)
      pl = [0...s].map (rr)-> 
        bi(2).pow(rr).multiply(d)
      
      flg = true
      
      pl.forEach (p)->
        if modular_exp(a, p, n).eq(1)
          flg = false
          return
      
      if flg
        return true
    
  return res == false

# 素数生成
gen_prime = (bit)->
  while true
    ret = gen_rand(bit)
    if mr_primary_test(ret)
      break
  
  return ret

# 拡張ユークリッド互除法
xeuclid = (aa, bb)->
  if bb.eq(0)
    uu = 1
    vv = 0
  else
    qq = aa.divide bb
    rr = aa.mod bb
    res = xeuclid(bb, rr)
    uu = res[1]
    vv = res[0].minus(qq.multiply(res[1]))
  
  [bi(uu), bi(vv)]

# 鍵生成
gen_d = (e, l)->
  x = xeuclid(e, l)[0]
  if x.sign
    x.plus l
  else
    x.mod l



gen_rsa = (byte_length)-> new Promise (f,r)->
  byt = bi byte_length
  p = gen_prime(byt)
  q = gen_prime(byt)
  
  e = bi 65537
  
  n = p.multiply(q)
  d = gen_d e, p.minus(1).multiply(q.minus(1))
  
  res = {}
  Promise.resolve()
  .then ->
    helper.deflate n.toString()
  .then (v)->
    res.pub = v
    helper.deflate d.toString()
  .then (v)->
    res.key = v
    f res
  .catch (e)-> console.log "e", e

encode_rsa = (pub, value)-> new Promise (f,r)->
  e = bi 65537
  
  m = value
  a = m.split("").map (i)->bi i.charCodeAt()
  
  Promise.resolve()
  .then ->
    helper.inflate pub
  .then (pub)->
    c = a.map (i)-> modular_exp(i, e, pub)
    str = JSON.stringify c
    helper.deflate str
  .then (v)->
    f v
  .catch (e)-> console.log "e", e

decode_rsa = (pub, key, crypto)-> new Promise (f,r)->
  req = {}
  Promise.resolve()
  .then ->
    helper.inflate pub
  .then (v)->
    req.pub = bi v
    helper.inflate key
  .then (v)->
    req.key = bi v
    helper.inflate crypto
  .then (v)->
    arr = JSON.parse(v)
    # console.log "arr",arr
    pt = arr.map (i)-> modular_exp(bi(i), bi(req.key), bi(req.pub))
    f pt.map((i)-> String.fromCharCode i).join("")
  .catch (e)-> console.log "e", e
###



###
pub = null
key = null
Promise.resolve()
.then ->
  gen_rsa 16
.then (v)->
  console.log v
  pub = v.pub
  key = v.key
  encode_rsa v.pub, "てすと"
.then (v)->
  console.log v
  decode_rsa pub, key, v
.then (v)->
  console.log v
###




###
# これじゃない感
gen_rsa = (byte_length, value)-> new Promise (f,r)->
  byt = bi byte_length
  p = gen_prime(byt)
  q = gen_prime(byt)
  e = bi 65537
  
  n = p.multiply(q)
  d = gen_d e, p.minus(1).multiply(q.minus(1))
  
  m = value
  a = m.split("").map (i)->bi i.charCodeAt()
  
  c = a.map (i)-> modular_exp(i, e, n)
  str = JSON.stringify c
  
  # 暗号文配列を圧縮
  res = {}
  Promise.resolve()
  .then ->
    helper.deflate n.toString()
  .then (v)->
    res.pub = v
    helper.deflate d.toString()
  .then (v)->
    res.key = v
    helper.deflate str
  .then (v)->
    res.crypted = v
    f res
  .catch (e)-> console.log "e", e

decode_rsa = (pub, key, crypto)-> new Promise (f,r)->
  req = {}
  Promise.resolve()
  .then ->
    helper.inflate pub
  .then (v)->
    req.pub = bi v
    helper.inflate key
  .then (v)->
    req.key = bi v
    helper.inflate crypto
  .then (v)->
    arr = JSON.parse(v)
    # console.log "arr",arr
    pt = arr.map (i)-> modular_exp(bi(i), bi(req.key), bi(req.pub))
    f pt.map((i)-> String.fromCharCode i).join("")
  .catch (e)-> console.log "e", e

gen_rsa 16, "てすと"
.then (v)->
  console.log v
  decode_rsa v.pub, v.key, v.crypted
  .then (v)->
    console.log v
###


###
# 配列のオブジェクトを文字列にして伸張
arr = [1,2,4,5]
str = JSON.stringify arr
helper.deflate str
.then (v)->
  console.log v
  helper.inflate v
.then (v)->
  console.log v
  obj = JSON.parse v
  console.log "o", obj[3]
###


###
# RSA暗号v1.2 成型
bi = require "big-integer"

# 高速指数演算
modular_exp = (a, b, n)->
  res = bi.one
  while b.neq(0)
    if b.and(1).neq(0)
      res = res.multiply(a).mod(n)
    
    a = a.multiply(a).mod(n)
    b = b.shiftRight(1)
  
  res

# ランダムな素数
gen_rand = (bit_length)->
  bits = [0...bit_length - 2].map -> bi.randBetween 0, 1
  ret = bi(1)
  bits.forEach (b)->
    ret = ret.multiply(2).plus(b)
  
  ret.multiply(2).plus(1)

# 素数確認
mr_primary_test = (n, k=100)->
  return false if n.eq 1
  return true if n.eq 2
  return false if n.mod(2).eq(0)
  
  d = n.minus(1)
  s = bi.zero
  while d.mod(2).neq(0)
    d = d.divide(2)
    s = s.plus(1)
  
  r = [0...k].map -> bi.randBetween 1, n.minus(1)
  res = r.some (a)->
    if modular_exp(a, d, n).neq(1)
      pl = [0...s].map (rr)-> 
        bi(2).pow(rr).multiply(d)
      
      flg = true
      
      pl.forEach (p)->
        if modular_exp(a, p, n).eq(1)
          flg = false
          return
      
      if flg
        return true
    
  return res == false

# 素数生成
gen_prime = (bit)->
  while true
    ret = gen_rand(bit)
    if mr_primary_test(ret)
      break
  
  return ret

# 拡張ユークリッド互除法
xeuclid = (aa, bb)->
  if bb.eq(0)
    uu = 1
    vv = 0
  else
    qq = aa.divide bb
    rr = aa.mod bb
    res = xeuclid(bb, rr)
    uu = res[1]
    vv = res[0].minus(qq.multiply(res[1]))
  
  [bi(uu), bi(vv)]

# 鍵生成
gen_d = (e, l)->
  x = xeuclid(e, l)[0]
  if x.sign
    x.plus l
  else
    x.mod l


byt = bi 16
p = gen_prime(byt)
q = gen_prime(byt)
e = gen_prime(byt)

n = p.multiply(q)
d = gen_d e, p.minus(1).multiply(q.minus(1))

m = "nanrakano hirabunあ　漢字"
a = m.split("").map (i)->bi i.charCodeAt()

c = a.map (i)-> modular_exp(i, e, n)

# 暗号文配列を圧縮
str = JSON.stringify c
helper.deflate str
.then (v)->
  console.log v
  helper.inflate v
.then (v)->
  arr = JSON.parse(v)
  console.log "arr",arr
  pt = arr.map (i)-> modular_exp(bi(i), d, n)
  console.log pt.map((i)-> String.fromCharCode i).join("")

# pt = c.map (i)-> console.log i.toString(16);modular_exp(i, d, n)
# console.log pt.map((i)-> String.fromCharCode i).join("")

helper.deflate e.toString()
.then (v)->
  console.log "適当な正整数e",e.toString()
  console.log "適当な正整数e",v

helper.deflate d.toString()
.then (v)->
  console.log "秘密鍵",d.toString()
  console.log "秘密鍵",v

helper.deflate n.toString()
.then (v)->
  console.log "公開鍵",n.toString()
  console.log "公開鍵",v
###




###
# RSA暗号v1.1
bi = require "big-integer"

# 高速指数演算
modular_exp = (a, b, n)->
  res = bi.one
  while b.neq(0)
    if b.and(1).neq(0)
      res = res.multiply(a).mod(n)
    
    a = a.multiply(a).mod(n)
    b = b.shiftRight(1)
  
  res

# ランダムな素数
gen_rand = (bit_length)->
  bits = [0...bit_length - 2].map -> bi.randBetween 0, 1
  ret = bi(1)
  bits.forEach (b)->
    ret = ret.multiply(2).plus(b)
  
  ret.multiply(2).plus(1)

# 素数確認
mr_primary_test = (n, k=100)->
  return false if n.eq 1
  return true if n.eq 2
  return false if n.mod(2).eq(0)
  
  d = n.minus(1)
  s = bi.zero
  while d.mod(2).neq(0)
    d = d.divide(2)
    s = s.plus(1)
  
  r = [0...k].map -> bi.randBetween 1, n.minus(1)
  res = r.some (a)->
    if modular_exp(a, d, n).neq(1)
      pl = [0...s].map (rr)-> 
        bi(2).pow(rr).multiply(d)
      
      flg = true
      
      pl.forEach (p)->
        if modular_exp(a, p, n).eq(1)
          flg = false
          return
      
      if flg
        return true
    
  return res == false

# 素数生成
gen_prime = (bit)->
  while true
    ret = gen_rand(bit)
    if mr_primary_test(ret)
      break
  
  return ret

# 拡張ユークリッド互除法
xeuclid = (aa, bb)->
  if bb.eq(0)
    uu = 1
    vv = 0
  else
    qq = aa.divide bb
    rr = aa.mod bb
    res = xeuclid(bb, rr)
    uu = res[1]
    vv = res[0].minus(qq.multiply(res[1]))
  
  [bi(uu), bi(vv)]

# 鍵生成
gen_d = (e, l)->
  x = xeuclid(e, l)[0]
  if x.sign
    x.plus l
  else
    x.mod l


byt = bi 16
p = gen_prime(byt)
q = gen_prime(byt)
e = gen_prime(byt)

n = p.multiply(q)
d = gen_d e, p.minus(1).multiply(q.minus(1))


# m=bi("1010101")

m = "nanrakano hirabunあ　漢字"
a = m.split("").map (i)->bi i.charCodeAt()
# console.log a

c = a.map (i)-> modular_exp(i, e, n)

cstr = c.map (i)-> i.toString()
console.log cstr.toString()

pt = c.map (i)-> modular_exp(i, d, n)


console.log pt.map((i)-> String.fromCharCode i).join("")

# c = modular_exp(m, e, n)
# pt = modular_exp(c, d, n)

# 必要なものはe,d,n
# console.log "m",m
# console.log "c",c
# console.log "pt",pt


###


###
# RSA暗号v0.1.3
bi = require "big-integer"

byt = bi 10
p = gen_prime(byt)
q = gen_prime(byt)
n = p * q

l = bi.lcm( p.minus(1), q.minus(1) )

pub = bi 0
pubcnt = bi 2
while pubcnt.leq l
  if bi.gcd(pubcnt, l).eq(1)
    pub = pubcnt
    break
  
  pubcnt = pubcnt.plus(1)

pri = bi 0
pricnt = bi 2
while pricnt.leq l
  if pub.multiply(pricnt).mod(l).eq(1)
    pri = pricnt
    break
  
  pricnt = pricnt.plus(1)

m = "nanrakano hirabunあ　漢字"
a = m.split("").map (i)-> bi i.charCodeAt()

c = a.map (i)-> i.pow(pub).mod(n)
deco = c.map (i)-> i.pow(pri).mod(n)

console.log m
# console.log p
# console.log c
console.log deco.map((i)-> String.fromCharCode i).join("")
###




###
# RSA暗号v0.1.2 成型
bi = require "big-integer"

m = "nanrakano hirabunあ　"
a = m.split("").map (i)-> bi i.charCodeAt()
# console.log a
# p = bi 7
# q = bi 19

p = gen_prime(bi 8)
q = gen_prime(bi 8)

n = p * q

# gcd = (x, y)->
#   while(y) 
#     t = y
#     y = x % y
#     x = t
#   
#   x

# lcm = (x, y)-> Math.abs((x * y) / gcd(x, y))
# console.log lcm 6, 18 
# console.log bi.lcm( bi(6), bi(18) ) 

l = bi.lcm( p.minus(1), q.minus(1) )
console.log "l",l
pub = bi 0
pubcnt = bi 2
while pubcnt.leq l
  # console.log pubcnt
  if bi.gcd(pubcnt, l).eq(1)
    pub = pubcnt
    break
  
  pubcnt = pubcnt.plus(1)

console.log "pub", pub

pri = bi 0
pricnt = bi 2
while pricnt.leq l
  # console.log pricnt
  if pub.multiply(pricnt).mod(l).eq(1)
    pri = pricnt
    break
  
  pricnt = pricnt.plus(1)

console.log "pri",pri

# console.log a
c = a.map (i)-> i.pow(pub).mod(n)
console.log c

deco = c.map (i)-> i.pow(pri).mod(n)
console.log deco
console.log deco.map((i)-> String.fromCharCode i).join("")
console.log a.map((i)-> String.fromCharCode i).join("")
###



###
# RSA暗号v1.0
bi = require "big-integer"

# 高速指数演算
modular_exp = (a, b, n)->
  res = bi.one
  while b.neq(0)
    if b.and(1).neq(0)
      res = res.multiply(a).mod(n)
    
    a = a.multiply(a).mod(n)
    b = b.shiftRight(1)
  
  res

# ランダムな素数
gen_rand = (bit_length)->
  bits = [0...bit_length - 2].map -> bi.randBetween 0, 1
  ret = bi(1)
  bits.forEach (b)->
    ret = ret.multiply(2).plus(b)
  
  ret.multiply(2).plus(1)

# 素数確認
mr_primary_test = (n, k=100)->
  return false if n.eq 1
  return true if n.eq 2
  return false if n.mod(2).eq(0)
  
  d = n.minus(1)
  s = bi.zero
  while d.mod(2).neq(0)
    d = d.divide(2)
    s = s.plus(1)
  
  r = [0...k].map -> bi.randBetween 1, n.minus(1)
  res = r.some (a)->
    if modular_exp(a, d, n).neq(1)
      pl = [0...s].map (rr)-> 
        bi(2).pow(rr).multiply(d)
      
      flg = true
      
      pl.forEach (p)->
        if modular_exp(a, p, n).eq(1)
          flg = false
          return
      
      if flg
        return true
    
  return res == false

# 素数生成
gen_prime = (bit)->
  while true
    ret = gen_rand(bit)
    if mr_primary_test(ret)
      break
  
  return ret

# 拡張ユークリッド互除法
xeuclid = (aa, bb)->
  if bb.eq(0)
    uu = 1
    vv = 0
  else
    qq = aa.divide bb
    rr = aa.mod bb
    res = xeuclid(bb, rr)
    uu = res[1]
    vv = res[0].minus(qq.multiply(res[1]))
  
  [bi(uu), bi(vv)]

# 鍵生成
gen_d = (e, l)->
  x = xeuclid(e, l)[0]
  if x.sign
    x.plus l
  else
    x.mod l


byt = bi 256
p = gen_prime(byt)
q = gen_prime(byt)
e = gen_prime(byt)

n = p.multiply(q)
d = gen_d e, p.minus(1).multiply(q.minus(1))


m=bi("1010101")
c = modular_exp(m, e, n)
pt = modular_exp(c, d, n)

# 必要なものはe,d,n
console.log "m",m
console.log "c",c
console.log "pt",pt
###



###
# big-integerでRSA
bi = require "big-integer"


m = "ひらぶん。たいばばやしにトッキッキ"

a = m.split("").map (i)->i.charCodeAt()
# console.log a
p = 3559
q = 3571
n = p * q

l = bi.lcm(p-1, q-1).value
console.log l


pub = [2..l].find (i)-> bi.gcd(i, l).value == 1
console.log pub
pri = [2..l].find (i)-> (pub * i)  % l == 1
console.log pri

c = a.map (i)-> bi(i.toString()).pow( bi(pub.toString()) ).mod( n.toString() ).value
deco = c.map (i)-> bi(i.toString()).pow( bi(pri.toString()) ).mod( n.toString() ).value

console.log a
console.log c
console.log deco
console.log deco.map((i)-> String.fromCharCode i).join("")
###




###
bi = require "big-integer"

# 高速指数演算
modular_exp = (a, b, n)->
  # console.log "=================="
  # console.log a,b,n
  res = bi.one
  while b.neq(0)
    if b.and(1).neq(0)
      res = res.multiply(a).mod(n)
    
    a = a.multiply(a).mod(n)
    b = b.shiftRight(1)
  
  res

# console.log modular_exp bi(13), bi(11), bi(141)


# ランダムな素数
gen_rand = (bit_length)->
  bits = [0...bit_length - 2].map -> bi.randBetween 0, 1
  ret = bi(1)
  bits.forEach (b)->
    ret = ret.multiply(2).plus(b)
  
  ret.multiply(2).plus(1)

# [0...5].forEach -> console.log Math.floor(Math.random() * 2)

# console.log gen_rand 128

# 素数確認
mr_primary_test = (n, k=100)->
  return false if n.eq 1
  return true if n.eq 2
  return false if n.mod(2).eq(0)
  
  d = n.minus(1)
  s = bi.zero
  while d.mod(2).neq(0)
    d = d.divide(2)
    # console.log "d",d
    s = s.plus(1)
  
  r = [0...k].map -> bi.randBetween 1, n.minus(1)
  res = r.some (a)->
    # console.log a
    # console.log modular_exp(a, d, n)
    if modular_exp(a, d, n).neq(1)
      # console.log "==="
      # console.log s
      pl = [0...s].map (rr)-> 
        bi(2).pow(rr).multiply(d)
      
      flg = true
      
      # console.log "pl"
      # console.log pl
      pl.forEach (p)->
        console.log "plnaibu"
        if modular_exp(a, p, n).eq(1)
          flg = false
          return
      
      if flg
        # 本来ならここに入って終了
        # console.log "kokoha?"
        return true
    
    
  return res == false
  

console.log mr_primary_test bi 1 # f
console.log mr_primary_test bi 2 # t
console.log mr_primary_test bi 3 # t
console.log mr_primary_test bi 4 # f

console.log mr_primary_test bi 9007199254740991 # f

console.log mr_primary_test bi 9007199254740993 # f

console.log mr_primary_test bi 12 # f
console.log mr_primary_test bi 13 # t
console.log mr_primary_test bi 141 # f
console.log mr_primary_test bi 142 # f



# 素数生成
gen_prime = (bit)->
  while true
    ret = gen_rand(bit)
    if mr_primary_test(ret)
      break
  
  return ret

# console.log gen_prime 18





byt = bi 256
# p = gen_prime(byt)
# q = gen_prime(byt)
# e = gen_prime(byt)

p = bi "195531435739008959673282737963575264469"
q = bi "242779475795881938335203689155820874691"
e = bi "188952817630177726230187917619251142649"

# 鍵生成
euclid = (ee, ll)->
  if ee.eq(0)
    ll
  else
    euclid ll.mod(ee), ee

xeuclid = (aa, bb)->
  if bb.eq(0)
    uu = 1
    vv = 0
  else
    qq = aa.divide bb
    rr = aa.mod bb
    res = xeuclid(bb, rr)
    uu = res[1]
    vv = res[0].minus(qq.multiply(res[1]))
  
  [bi(uu), bi(vv)]


gen_d = (e, l)->
  x = xeuclid(e, l)[0]
  if x.sign
    x.plus l
  else
    x.mod l

# l = bi.lcm p.minus(1), q.minus(1)
# console.log "l",l
# console.log "x", bi.gcd e, l
# console.log "euclid", xeuclid(e, l)

l = p.minus(1).multiply(q.minus(1))
d = gen_d e, l

# d = e.mod l
# d = bi.gcd e, p.minus(1).multiply(q.minus(1))


# console.log xeuclid(bi(22), bi(45))

# xx = xeuclid(e, l)[0]
# console.log "x", xx
# console.log "l", l
console.log "d", d
# console.log euclid bi(6), bi(18)
# console.log bi.gcd bi(6), bi(18)


# console.log xx == xx.mod(l)
# console.log "========"
# console.log p
# console.log q
# console.log e
# console.log "========"

n = p.multiply(q)

m=bi("1010101")

c = modular_exp(m, e, n)
# console.log "c",c
# console.log "d",d
# console.log "n",n

pt = modular_exp(c, d, n)

# console.log "m",m
console.log "pt",pt
###



###
aa = ->
  flg = [0..3].some (p)->
    console.log p
    if p == 2
      console.log "kiteru", p
      flg = false
      return
    
    console.log "dokokaeru"
  
  if flg
    console.log "11"
    return false
    console.log "222"
  
  console.log "3333"
  return true


console.log aa()
###





###
# 9007199254740991
bi = require "big-integer"

# console.log bi(10**10) * bi(10**10)

###



###
# 数字も無理だったんでいちもぢづつやる ng
m = "12345678"
a = m.split("").map (i)->i.charCodeAt()
# console.log a
p = 7
q = 19
n = p * q

gcd = (x, y)->
  while(y) 
    t = y
    y = x % y
    x = t
  
  x

lcm = (x, y)-> Math.abs((x * y) / gcd(x, y))

l = lcm p-1, q-1

pub = [2..l].find (i)-> gcd(i, l) == 1
console.log pub
pri = [2..l].find (i)-> (pub * i)  % l == 1
console.log pri

# 暗号化(5乗)はできたけど複合ができない
c = a.map (i)-> i ** pub % n
deco = c.map (i)-> i ** pri % n

console.log a
console.log c
console.log deco.map((i)-> String.fromCharCode i).join("")

# console.log a.map((i)-> String.fromCharCode i).join("")
###




###
# 文字は無理なんで数字で ng
m = "234567"

p = 7
q = 19
n = p * q

gcd = (x, y)->
  while(y) 
    t = y
    y = x % y
    x = t
  
  x

lcm = (x, y)-> Math.abs((x * y) / gcd(x, y))

l = lcm p-1, q-1

pub = [2..l].find (i)-> gcd(i, l) == 1
console.log pub
pri = [2..l].find (i)-> (pub * i)  % l == 1
console.log pri

c = m ** pub % n
deco = c ** pri % n

console.log m
console.log c
console.log deco
###








###
m = "nanrakano hirabunあ　"
a = m.split("").map (i)->i.charCodeAt()
# console.log a
p = 7
q = 19
n = p * q

gcd = (x, y)->
  while(y) 
    t = y
    y = x % y
    x = t
  
  x

lcm = (x, y)-> Math.abs((x * y) / gcd(x, y))

l = lcm p-1, q-1

pub = [2..l].find (i)-> gcd(i, l) == 1
console.log pub
pri = [2..l].find (i)-> (pub * i)  % l == 1
console.log pri

# 暗号化(5乗)はできたけど複合ができない
c = a.map (i)-> i ** pub % n
deco = c.map (i)-> i ** pri % n

console.log a
console.log c
console.log deco.map((i)-> String.fromCharCode i).join("")

# console.log a.map((i)-> String.fromCharCode i).join("")
###


###
m.split("").forEach (i)->
  console.log i.charAt()
  console.log i.charCodeAt()
  # コードポイント値全体の取得
  console.log i.codePointAt()
###



###
zeta = (a, p, mod, q=1)->
  q = (a*q) % mod
  console.log a + " ** " + p + "≡" + " " + q  + " mod " + mod
  
  if p < 126
    zeta a, p+1, mod, q


zeta 3, 1, 19
###

###
# 3**100%19
c = 1
mm = (i)->
  mod =  3 * i % 19
  console.log "3**" + c + "≡" + " " + mod + " mod 19"
  c++
  if c <= 100
    mm mod

mm 1
###


###
# sha1sum
# 衝突がみつかったのにsha1を使い続けるのは微妙では
crypto = require "crypto"

hashtest = (v,ha)-> 
  cry = require("crypto").createHash ha
  # cry.update uuid.v4(), "utf8"
  cry.update v, "utf8"
  cry.digest 'hex'



crypto.getHashes().forEach (ha)->
  hash = hashtest("v", ha)
  console.log ha + " : " +  hash + " (" + hash.length +  ")"
###


###
console.log hashtest "a", "SHA"
console.log hashtest "a", "SHA1"
console.log hashtest "a", "sha1WithRSAEncryption"
###


###
text = "1234567890123456789012345678901212345678901234567890123456789012"

Promise.resolve()
.then ->
  helper.lock text, "pass"
.then (cry)->
  console.log "圧縮あり", cry
  helper.unlock cry, "pass"
.then (pt)->
  console.log pt
.catch (e)->
  console.log "e",e
###


###
# 圧縮・解凍promisify
zlib =  require "zlib"

deflate = (pt)-> new Promise (f,r)->
  zlib.deflate pt, (e,d)->
    if e?
      r e
    else
      f d.toString("hex")

inflate = (comp)-> new Promise (f,r)->
  zlib.inflate new Buffer(comp, "hex"), (e,d)->
    if e?
      r e
    else
      f d.toString()
###


###
deflate "あのくたらさんみゃくだんぼだい"
.then (c)->
  console.log new Buffer("あのくたらさんみゃくだんぼだい").toString("binary")
  console.log c.toString("binary")
.catch (e)-> console.log e
###

###
Promise.resolve()
.then ->
  deflate "あのくたらさんみゃくだんぼだい"
.then (c)->
  console.log c
  inflate c
.then (p)->
  console.log p
.catch (e)->
  console.log "e",e
###

###
crypto = require("crypto")

creageIV = (pass)->
  hash = crypto.createHash 'md5'
  hash.update pass
  hash.digest().toString("hex").substr(16,16)

creageKeyHash = (pass)->
  hash = crypto.createHash 'md5'
  hash.update pass
  hash.digest().toString("hex")


lock = (val, pass)-> new Promise (f,r)->
  deflate val
  .then (comp)->
    cipher = crypto.createCipheriv 'aes-256-cbc', creageKeyHash(pass), creageIV(pass)
    crypted = cipher.update comp, 'utf-8', 'hex'
    crypted += cipher.final 'hex'
    f crypted
  .catch (e)-> r e

unlock = (cry, pass)-> new Promise (f,r)->
  decipher = crypto.createDecipheriv 'aes-256-cbc', creageKeyHash(pass), creageIV(pass)
  decode = decipher.update cry, 'hex', 'utf-8'
  decode += decipher.final "utf-8"
  inflate decode
  .then (pt)->
    f pt
  .catch (e)-> r e


nocomplock = (val, pass)-> new Promise (f,r)->
  cipher = crypto.createCipheriv 'aes-256-cbc', creageKeyHash(pass), creageIV(pass)
  crypted = cipher.update val, 'utf-8', 'hex'
  crypted += cipher.final 'hex'
  f crypted

nocompunlock = (cry, pass)-> new Promise (f,r)->
  decipher = crypto.createDecipheriv 'aes-256-cbc', creageKeyHash(pass), creageIV(pass)
  decode = decipher.update cry, 'hex', 'utf-8'
  decode += decipher.final "utf-8"
  f decode


# 半角32文字で同等
text = "12345678901234567890123456789012"

# 半角64文字で圧縮の効果が表れる
text = "1234567890123456789012345678901212345678901234567890123456789012"

Promise.resolve()
.then ->
  nocomplock text, "pass"
.then (cry)->
  console.log "圧縮なし", cry
  nocompunlock cry, "pass"
.then (pt)->
  # console.log pt
.catch (e)->
  console.log "e",e



Promise.resolve()
.then ->
  lock text, "pass"
.then (cry)->
  console.log "圧縮あり", cry
  unlock cry, "pass"
.then (pt)->
  # console.log pt
.catch (e)->
  console.log "e",e
###


###
zlib =  require "zlib"

# 圧縮する術
zlib.deflate "teanokusatarannmaukudanbodaixt", (e,d)->
  if e?
    console.log e
  else
    # console.log d.toString()
    # 解凍する術
    zlib.inflate d, (e,data)->
      if e?
        console.log e
      else
        console.log data.toString()
###




###
# cbcとctrはどちらがよいか
# Use Cipheriv for counter mode of aes-256-ctrとでた
# aes-256-cbcは64文字 固定長の様子
# aes-256-ctrは42文字 可変だけど推測されそう
# パス32文字
crypto = require("crypto")

# https://kido0617.github.io/js/2016-08-17-aes/
# cbcの鍵は256bit→32文字
# IVは128bit→16文字

creageIV = (pass)->
  hash = crypto.createHash 'md5'
  hash.update pass
  hash.digest().toString("hex").substr(16,16)

# console.log creageIV "aa"

creageKeyHash = (pass)->
  hash = crypto.createHash 'md5'
  hash.update pass
  hash.digest().toString("hex")

lock = (val, pass)->
  cipher = crypto.createCipheriv 'aes-256-cbc', creageKeyHash(pass), creageIV(pass)
  crypted = cipher.update val, 'utf-8', 'hex'
  crypted += cipher.final 'hex'

unlock = (cry, pass)->
  decipher = crypto.createDecipheriv 'aes-256-cbc', creageKeyHash(pass), creageIV(pass)
  decode = decipher.update cry, 'hex', 'utf-8'
  decode += decipher.final "utf-8"



cry = lock new Buffer("てきすとてきすと"), "pass"
console.log cry
console.log unlock cry, "pass"
###


###
# ダメな気がするのでふかぼり
# iv
hash = crypto.createHash 'md5'
hash.update 'randomToken'
ive = hash.digest()
# console.log "ive is", ive.toString("hex") # 526b0e737e7ad6e3344da44e56559ce5 (32文字)

text = '共通鍵暗号方式'

# 526b0e737e7ad6e3344da44e56559ce5
# IVは16桁をbufferにすればいいっぽい 5xWAzpRh6TgybfGd
# console.log new Buffer('5xWAzpRh6TgybfGd', 'utf8').toString("hex")
# 32桁 b52c96bea30646abf8170f333bbd42b0
# ive is 526b0e737e7ad6e3344da44e56559ce5

# key = "526b0e737e7ad6e3344da44e56559ce5"
# key = "00000000000000000000000000000000"
# key = "0000000000000000000000000000000"
# key = ive.toString("hex")
# keyは32文字だったらなんでもよい。
# bufferにしてもよい

# 5xWAzpRh6TgybfGd 16文字
# ive = new Buffer("5xWAzpRh6TgybfGd")
# ive = new Buffer("0000000000000000")
# ive = "0000000000000000"
ive = "zx000000000000aa"


# cipher = crypto.createCipheriv 'aes-256-ctr', new Buffer(key), new Buffer(ive)
# cipher = crypto.createCipheriv 'aes-256-cbc', new Buffer(key), new Buffer(ive)
# cipher = crypto.createCipheriv 'aes-256-cbc', key, ive
cipher = crypto.createCipheriv 'aes-256-ctr', key, ive
crypted = cipher.update text, 'utf-8', 'hex'
crypted += cipher.final 'hex'

console.log crypted
###

###
decipher = crypto.createDecipheriv 'aes-256-ctr', "b52c96bea30646abf8170f333bbd42b0", ive
# decipher.update crypted, 'hex', 'utf-8'
decode = decipher.update crypted, 'hex', 'utf-8'
decode += decipher.final "utf-8"

console.log decode
###








###
# cc = (c,t)->  Math.ceil(((c**t - (c-1)**t) / c**t) * 100000) / 1000
cc = (c,t)->  ((c**t - (c-1)**t) / c**t)

[1..10].forEach (i)->
  [1..100].forEach (j)->
    if j % 10 == 0
      console.log i + "文字" + j + "回試行：", cc 16**i,j
###


###
# 実用的な形にすると・・・
lock = (val, pass)->
  hash = crypto.createHash 'md5'
  hash.update pass
  ive = hash.digest()
  
  cipher = crypto.createCipheriv 'aes-256-cbc', "b52c96bea30646abf8170f333bbd42b0", ive
  crypted = cipher.update val, 'utf-8', 'hex'
  crypted += cipher.final 'hex'
  crypted

unlock = (pub, pass)->
  hash = crypto.createHash 'md5'
  hash.update pass
  ive = hash.digest()
  
  decipher = crypto.createDecipheriv 'aes-256-cbc', "b52c96bea30646abf8170f333bbd42b0", ive
  decode = decipher.update pub, 'hex', 'utf-8'
  decode += decipher.final "utf-8"
  decode


pub = lock "nantoka", "passa"
console.log pub, unlock pub, "passa"

pub = lock "nantoka", "pass"
console.log pub, unlock pub, "pass"


pub = lock "nantokakantoka", "pass"
console.log pub, unlock pub, "pass"

pub = lock "nantokakantokanantokakantokanantokakantokanantokakantokanantokakantokanantokakantokanantokakantokanantokakantoka", "pass"
console.log pub, unlock pub, "pass"
###


###
# iv
hash = crypto.createHash 'md5'
hash.update 'randomToken'
ive = hash.digest()
console.log "ive is", ive.toString("hex")

text = '共通鍵暗号方式'

cipher = crypto.createCipheriv 'aes-256-ctr', "b52c96bea30646abf8170f333bbd42b0", ive
crypted = cipher.update text, 'utf-8', 'hex'
crypted += cipher.final 'hex'

console.log crypted


decipher = crypto.createDecipheriv 'aes-256-ctr', "b52c96bea30646abf8170f333bbd42b0", ive
# decipher.update crypted, 'hex', 'utf-8'
decode = decipher.update crypted, 'hex', 'utf-8'
decode += decipher.final "utf-8"

console.log decode
###





###
# 微妙なやつらしい
algorithm = 'aes-256-ctr'
passphrase = "paas"

encrypt = (text)->
  cipher = crypto.createCipher algorithm, passphrase
  crypted = cipher.update text, 'utf8', 'base64'
  console.log crypted
  crypted += cipher.final 'base64'
  console.log crypted
  crypted


decrypt = (text)->
  decipher = crypto.createDecipher algorithm, passphrase
  dec = decipher.update text,'base64','utf8'
  console.log dec
  dec += decipher.final 'utf8'
  console.log dec
  dec

t = "てすとてすとてすとてすとてすとてすとてすとてすとてすとてすとてすとてすとてすとてすと"
console.log encrypt t
console.log decrypt encrypt t
###



###
# 同じものが生成される確率は
[1..64].forEach (i)->
  console.log i + "文字：", (1 / 16 ** i) * 100
###


###
# n回目が衝突する確率は試行するごとに上がっていきます。v2
# 6文字目まではいける。
[7..64].forEach (m)->
  bo = 16 ** m
  console.log m + "文字、" + bo + "通りが衝突する試行回数"

  q=false
  h=false
  qh=false

  i = 1
  loop
    cnt = Math.ceil((1 / (bo / i)) * 100)
    console.log i,cnt
    
    if cnt >= 25 and q == false
      console.log  i + "回:", cnt + "%"
      q = true
      
    if cnt >= 50 and h == false
      console.log  i + "回:", cnt + "%"
      h = true
      
    if cnt >= 75 and qh == false
      console.log  i + "回:", cnt + "%"
      qh = true
    
    
    if cnt >= 100
      console.log  i + "回:", cnt + "%"
      break
    
    i++
###




###
# n回目が衝突する確率は試行するごとに上がっていきます。
bo = 4026
console.log bo + "通りが衝突する試行回数"

q=false
h=false
qh=false

i = 1
loop
  cnt = Math.ceil((1 / (bo / i)) * 100)
  # console.log i,cnt
  
  if cnt >= 25 and q == false
    console.log  i + "回:", cnt + "%"
    q = true
    
  if cnt >= 50 and h == false
    console.log  i + "回:", cnt + "%"
    h = true
    
  if cnt >= 75 and qh == false
    console.log  i + "回:", cnt + "%"
    qh = true
  
  
  if cnt >= 100
    console.log  i + "回:", cnt + "%"
    break
  
  i++
###

###
# ハッシュ何通りか
# 0-f 16文字
[1..64].forEach (i)->
  console.log i + "文字：",16 ** i
###


###
# twGetter v0.01
request = require("request")
cheerio = require("cheerio")

wget = (url)-> new Promise (f,re)->
  request url
  , (e,r,b)->
    if e?
      re e
    else
      res = {}
      res.headers = r.headers
      res.body = cheerio.load b
      f res
  



twGetter = (q)-> new Promise (f,r)->
  wget "https://twitter.com/search?f=tweets&q=" + "@asdlkjdfefe OR " + encodeURI q
  .then (v)->
    scr = v.body(".tweet-text")
    tws = [0...scr.length].map (i)-> cheerio.load(scr[i]).text().replace("\n"," ")
    
    jo = tws.map (i)->
      obj = {}
      obj._id = helper.createHash(i).substr(0,8)
      obj.value = i
      obj
    
    f jo
  .catch (e)-> r e


# なければ処理Aをし登録し、あったらしない。
ids = []
tws = []

[0..3].map ->
  twGetter "ウサギ"
  .then (v)->
    # console.log "done", v
    v.forEach (i)->
      if (ids.some (j)-> j == i._id)
        # あった
        console.log "atta"
      else
        # なかった
        console.log "nakatta"
        ids.push i._id
        tws.push i.value
    
    ids
  .catch (e)-> console.log "e", e


setTimeout ->
  console.log tws
, 5000
# console.log ids
# console.log tws
###



###
# twGetter v0.1
request = require("request")
cheerio = require("cheerio")

wget = (url)-> new Promise (f,re)->
  request url
  , (e,r,b)->
    if e?
      re e
    else
      res = {}
      res.headers = r.headers
      res.body = cheerio.load b
      f res
  


q = "ウサギ"


# wget "http://yahoo.co.jp"
wget "https://twitter.com/search?f=tweets&q=" + "@asdlkjdfefe OR " + encodeURI q
.then (v)->
  scr = v.body(".tweet-text")
  tws = [0...scr.length].map (i)->
    cheerio.load(scr[i]).text().replace("\n"," ")
  
  # console.log tws
  jo = tws.map (i)->
    console.log "------------"
    console.log i
    console.log helper.createHash(i).substr(0,6)
  
  
.catch (e)-> console.log "e",e
###





###
# デバッグ時のみログを出すスタイル
production = false
production = true if process.argv[2]?

console.log "dev" if production
console.log "pro"
###




###
# 最終系
# とりあえずたんぱつなら8文字で十分かと
# →統計的には4文字(0.0015%)でもよさげでは
cpu = 1
cpu = process.argv[2] if process.argv[2]?

digit = 1
digit = process.argv[3] if process.argv[3]?

NS_PER_SEC = 1e9

cluster = require "cluster"
if cluster.isMaster
  
  for i in [1..cpu]
    w = cluster.fork()
    
    # console.log "forked", "pid:",w.process.pid
    w.send digit
  
  
  result = []
  cluster.on 'message', (w, msg)->
    # console.log "res", "pid:", w.process.pid, msg
    result.push msg
  
  cluster.on 'exit',(w, c, sig)->
    # console.log "exit", "pid:", w.process.pid, c
  
  process.on "exit", (a,b,c,d)->
    # console.log "deach", a, result
    pt_med = helper.getMedian result.map((i)-> i.pt)
    count_med = helper.getMedian result.map((i)-> i.cnt)
    console.log digit, ",", pt_med, ",", count_med
    
  
else
  process.on "message", (msg)->
    # console.log "check digit is", msg
    
    obj = {}
    nano = process.hrtime()
    loop
      i = Object.keys(obj).length
      h = helper.getHash().substr(0,msg)
      obj[h] = undefined
      
      break if i == Object.keys(obj).length
    
    diff = process.hrtime(nano)
    
    res = {}
    res.pt = diff[0] * NS_PER_SEC + diff[1]
    res.cnt = Object.keys(obj).length
    
    process.send res
    process.exit()
###



###
# ハッシュのセットを分散して生成して衝突をチェックするには
# ・フルセットを大量に作ってソートする→ソートがむり
# 複数コアあるなら、並列で4つくらいやらせればよい。
obj = {}
cnt = 1
loop
  loop
    i = Object.keys(obj).length
    h = helper.getHash().substr(0,cnt)
    obj[h] = undefined
    
    if i == Object.keys(obj).length
      console.log h, "is duplex", Object.keys(obj).length, "count"
      break
  
  cnt++
###


###
obj = {}
con = {}

obj["a"] = undefined

obj[helper.getHash()] = undefined
con[helper.getHash()] = undefined
con[helper.getHash()] = undefined
con[helper.getHash()] = undefined
con[helper.getHash()] = undefined
con["a"] = undefined

for k of con
  i = Object.keys(obj).length
  obj[k] = undefined
  if i == Object.keys(obj).length
    console.log k,"is duplex"

console.log obj

###

###
# マルチコアハッシュ生成器
# 文字数を送る
# 任意のタイミングで終了通知を送る
cluster = require "cluster"
if cluster.isMaster
  arr=[]

  # for i in [1..require("os").cpus().length]
  for i in [1..4]
    w = cluster.fork()
    console.log "pid:",w.process.pid
    
    w.on 'message', (msg,w)->
      # console.log msg
      # arr.push msg
      arr = arr.concat msg
      
      
      # n個以上になったら終了
      # if arr.length >= 1000000
      #   w.process.kill()
        # process.exit()
      # else
        arr.push msg
      
    
    w.on 'exit',(w, c, sig)->
      console.log "exit", w,c,sig
  
  hikaku = 0
  setInterval ->
    size = arr.length
    console.log "ひかく", size - hikaku
    hikaku = size
    console.log size
  , 1500
  
  
else
  # セットをおくる感じで
  i = 0
  recursive = (list)->
    i++
    
    # 処理
    if list.length >= 50000
      process.send list
      list = []
    else
      list.push helper.getHash()
      
    if i % 10000000 == 0
      console.log "p:",i
    
    process.nextTick ->
      recursive list
  
  li = []
  recursive li
  
  # [0...50139474].forEach (i)->
  #   process.send helper.getHash()
  
  # setInterval ->
  #   process.send helper.getHash()
  # , 1500
###







###
# 一つの処理の最大速度
NS_PER_SEC = 1e9

# 速度の計測
# 都度送るのはダメ
# n件のセットにする
# 5回やって中央値を取る
# 調査の結果、loopのほうがスコアがたかかった
# 250000件くらいのセットなら実用的

# プロトタイプ v1.0
cluster = require "cluster"
if cluster.isMaster
  arr=[]

  # for i in [1..require("os").cpus().length]
  for i in [1..8]
    w = cluster.fork()
    console.log "pid:",w.process.pid
    
    w.on 'message', (msg,w)->
      # console.log msg,w
      # arr.push msg
      arr = arr.concat msg
      
      
      # n個以上になったら終了
      if arr.length >= 10000000
        console.timeEnd "tmp"
        process.exit()
      else
        arr.push msg
      
    
    w.on 'exit',(w, c, sig)->
      console.log "exit", w,c,sig
  
  hikaku = 0
  setInterval ->
    size = arr.length
    console.log "現在：", size, "ひかく：", size - hikaku if size - hikaku != 0
    hikaku = size
  , 1000
  
  
else
  setInterval ->
    k = 1
    arr = []
    while k < 250000
      arr.push helper.getHash()
      k++
    
    process.send arr
  , 1
###




###
# ループ
# 何件までやるか
n = 50000000
# 何件試行して精度を高めるか(中央値)
m = 4000

looper = (cnt=1)->
  if n >= cnt
    # m回試行して中央値をとる
    records = []
    [0...m].forEach (i)->
      nano = process.hrtime()
      k = 0
      arr = []
      while k < cnt
        arr.push helper.getHash()
        k++
      
      diff = process.hrtime(nano)
      records.push diff[0] * NS_PER_SEC + diff[1]
      
    result = helper.getMedian records
    console.log cnt + "件は" + result + "ナノ秒かかる"
    
    helper.appendCsv "loop.csv", cnt + "," + result
    .then -> looper cnt + 1
    .catch (e)-> console.log "e",e

looper()
###

###
# 配列
# 何件までやるか
# n = 50000000
n = 10000
# 何件試行して精度を高めるか(中央値)
# m = 4000
m = 1000

arraySender = (cnt=1)->
  if n >= cnt
    # m回試行して中央値をとる
    records = []
    [0...m].forEach ->
      nano = process.hrtime()
      
      # 処理
      arr = [0...cnt].map -> helper.getHash()
      # console.log arr.length
      
      diff = process.hrtime(nano)
      records.push diff[0] * NS_PER_SEC + diff[1]

    result = helper.getMedian records
    console.log cnt + "件は" + result + "ナノ秒かかる"
    
    helper.appendCsv "arraysend.csv", cnt + "," + result
    .then -> arraySender cnt + 1
    .catch (e)-> console.log "e",e

arraySender()
###









###
fs = require "fs"

# 何文字目までやるか
n = 50
# 何件試行して精度を高めるか(中央値)
m = 5000

# n件までやる
runner = (cnt=1)->
# [1..n].forEach (j)->
  if n >= cnt
    # console.log cnt
    # m回試行して中央値をとる
    records = []
    [0...m].forEach (i)->
      nano = process.hrtime()
      k = 0
      arr = []
      while k < cnt
        arr.push k + helper.getHash() + helper.getHash()
        k++
      
      diff = process.hrtime(nano)
      records.push diff[0] * NS_PER_SEC + diff[1]
      
    result = helper.getMedian records
    # console.log records.sort (a, b) -> a - b
    console.log cnt + "件は" + result + "ナノ秒かかる"
    # fs.appendFile "test.csv", j + "," + result + "\r\n", (e)-> console.log "e",e
    
    appendCsv "test.csv", cnt + "," + result
    .then -> runner cnt + 1
    .catch (e)-> console.log "e",e

runner()
###



###
fs = require "fs"

# j件までやる
[1..100].forEach (j)->
  # i回試行して中央値をとる
  records = []
  [0...2000].forEach (i)->
    nano = process.hrtime()
    k = 0
    arr = []
    while k < j
      arr.push k + helper.getHash() + helper.getHash()
      k++
    
    # console.log arr
    
    diff = process.hrtime(nano)
    records.push diff[0] * NS_PER_SEC + diff[1]
  result = helper.getMedian records
  # console.log records.sort (a, b) -> a - b
  console.log j + "件は" + result + "ナノ秒かかる"
  fs.appendFile "test.csv", j + "," + result, val + "\r\n", (e)-> console.log "e",e
###









###
# 中央値を取る(時間)
NS_PER_SEC = 1e9


records = []
[0...10].forEach (i)->
  nano = process.hrtime()
  [0..10000].forEach (i)->
    a = i + helper.getHash() + helper.getHash() + helper.getHash()
  
  diff = process.hrtime(nano)
  records.push diff[0] * NS_PER_SEC + diff[1]

console.log records
console.log helper.getMedian records
console.log helper.getMedian [1,1,1,1,1,1,2,2,2,3,3,5,11]
###

###
# 中央値を取る
getMedian = (arr)->
  arr.sort (a, b) -> a - b
  if arr.length % 2 == 0
    return (arr[(arr.length/2) - 1] + arr[(arr.length/2)]) / 2
  else
    return arr[Math.floor(arr.length / 2)]

# console.log getMedian [1,2,3,4,5] # 3
# console.log getMedian [1,2,3,4,5,100] # 3.5

arr = []
[0...5].forEach (i)->
  console.log Math.floor(Math.random() * 6) + 1
  arr.push Math.floor(Math.random() * 6) + 1

console.log getMedian arr
###



###
i = 0
recursive = (list)->
  i++
  
  # 処理
  if list.length >= 200000
    console.timeEnd "rec"
    console.log list.length
    list = []
    console.time "rec"
  else
    list.push helper.getHash()
    
  if i % 10000000 == 0
    console.log "p:",i
  
  process.nextTick ->
    recursive list

li = []
recursive li
###






###
# コードストリッパー
# 行を読む
# 255桁まで
# →要件がいまいちだった
rs = require("fs").createReadStream("tmp.java")

ws = ->
  r = new require('stream').Readable()
  
  r._read = (ch,enc,cb)->
    console.log "aaa"
    r.push ch
    # cb null, "cbcb"
  
  return r

tf = ->
  t = new require('stream').Transform()
  t._transform = (ch,enc,cb)->
    console.log "aaa"
    t.push ch
    # cb null, "cbcb"
  
  return t

rl = require("readline").createInterface(rs, ws)

# rl.on "line", (l)->
#   console.log "======="
#   console.log l
#   console.log "======="

# tf().pipe process.stdout





# rs.pipe(tf()).pipe(process.stdout)

# codeStripper = (is)->
###


###
# 文字列を抜き出す
st1 = "asdf@asdfasdf@ddsf"
st2 = "asdfsdaf@asdfs@asdf@sdf@asdfsd"
###


###
# getHashは平均n文字で重複し始めるver2
# 一件ずつpush
# 重複したら終了
# をくりかえし
# 1文字～n文字
[1..7].forEach (i)->
  console.log i,"start"
  [1..60].forEach (m)->
  
###








###
# 1から一億のデータを処理する
# 適当なデータを出力するモデルもどき
modelModoki = (end)->
  cnt = 0
  loop
    return if cnt >= end
    
    yield helper.getHash()
    cnt++

modelModokiInfinity = ->
  loop
    yield helper.getHash()

modelModokiInfinityNogen = -> helper.getHash()

# hashGenelator = modelModoki 2
# console.log hashGenelator.next()
# console.log hashGenelator.next()
# console.log hashGenelator.next()

countOfDeath = ->
  count = 0
  return ->
    count++
    if count >= 5
      console.log "death",count
      process.exit()

# cod = countOfDeath()
# cod()
# cod()
# cod()
# cod()
# cod()
# cod()
###



###
# maxValue = 100
# maxValue = 50139474
# maxValue = 75209225

createOutputStream = (gen)->
  r = new require('stream').Readable()
  r.setEncoding('UTF-8')
  
  r._read = ->
    o = gen.next()
    if o.done == false
      r.push o.value
    else
      console.log "done"
  
  return r


createOutputStreamNogen = ->
  r = new require('stream').Readable()
  r.setEncoding('UTF-8')
  
  r._read = ->
    r.push modelModokiInfinityNogen()
  
  return r


i = 0
w = new require('stream').Writable()

w.write = (ch)->
  # 処理
  i++
  a = ch + helper.getHash() + helper.getHash()
  
  # console.log "p:",i
  if i % 10000000 == 0
    console.log "p:",i
  

# createOutputStream(modelModoki maxValue).pipe w
# createOutputStream(modelModokiInfinity()).pipe w

# createOutputStreamNogen().pipe w



i = 0
recursiveNogen = ()->
  o = modelModokiInfinityNogen()
  i++ 
  # 処理
  a = o + helper.getHash() + helper.getHash()
  
  if i % 10000000 == 0
    console.log "p:",i
  
  process.nextTick ->
    recursiveNogen()


recursiveNogen()
###



###
eventDriven = (gen)->

  o = gen.next()
  i++ 


eventDriven modelModoki maxValue 
###





###
# maxValue = 50139474
maxValue = 75209225

i = 0
recursive = (gen)->
  o = null
  o = gen.next()
  i++ 
  if o.done == false
    # 処理
    a = null
    a = o.value + helper.getHash() + helper.getHash()
    
    if i % 10000000 == 0
      console.log "p:",i
    
    process.nextTick ->
      recursive gen
  else
    console.log "done"


recursive modelModoki (maxValue + 100000)
# recursive modelModokiInfinity() 
###




###
console.log [0...10].pop()
a = [0...10]
console.log a
console.log a.pop()
console.log a

console.log [0...75209230].pop()
###


###
# そもそもforEachってどこまでいけるんよ？verN2
# forEachで展開してみる
# cnt = 75209225
# 展開すると50139474で終了

# cnt = 34420000
cnt = 50139474
bool = false
loop
  console.log [0...cnt].length
  [0...cnt].forEach (i)->
    a = i.toString() + helper.getHash() + helper.getHash()
    if i % 10000000 == 0
      console.log "p:",i
  cnt = cnt + 1
###


###
# そもそもforEachってどこまでいけるんよ？ver1
# rangeをみる
cnt = 75209225
bool = false
loop
  console.log [0...cnt].length
  
  # [0...cnt].forEach (i)->
  #   if i > 49999999
  #     console.log i
  
  cnt = cnt + 1
###



###
# ハッシュ某01
NS_PER_SEC = 1e9

# h = helper.getHash()


# 1..64
# n=1
# h.substr(0,n)

[1..5].map (i)->
  console.time "hash"
  # =========================================
  lhashes = [0...10].map (j)-> helper.getHash().substr(0,i)
  
  fil = lhashes.filter (v,ind,s)-> s.indexOf(v) != ind
  console.log lhashes
  console.log "fil",fil
  # =========================================
  console.timeEnd "hash"
###






###
# getHashは平均n文字で重複し始めるver
# 1文字～n文字
[9..20].forEach (i)->
  console.log i,"start"
  
  avr = []
  [0...4].forEach (o)->
    broken = false
    [1..1000].forEach (m)->
      return if broken
      
      # m件作成
      p = 2000 * m
      console.log o, "回目", i, "文字", p, "件作成"
      arr = {}
      [0...p].forEach (j)->
        arr[helper.getHash().substr(0,i)] = j
      
      if p != Object.keys(arr).length
        # console.log i + "文字では" + p + "件で" + (p - Object.keys(arr).length) + "個重複"
        avr.push p
        broken = true
    
  console.log i + "文字は平均", Math.floor((avr.reduce (a,b)->a+b) / avr.length), "個まで耐えられる。"
###




###
# hashは何文字目まで信頼性がどうなのか(1回でも重複したら次の文字ver2)

# 1文字～n文字
[1..17].forEach (i)->
  console.log i,"start"
  
  avr = []
  [0...4].forEach (o)->
    broken = false
    [1..60].forEach (m)->
      return if broken
      
      # m件作成
      p = 2000 * m
      arr = {}
      [0...p].forEach (j)->
        arr[helper.getHash().substr(0,i)] = j
      
      if p != Object.keys(arr).length
        console.log i + "文字では" + p + "件で" + (p - Object.keys(arr).length) + "個重複"
        avr.push p
        broken = true
    
    console.log (avr.reduce (a,b)->a+b) / avr.length
###


###
# hashは何文字目まで信頼性がどうなのか(1回でも重複したら次の文字ver)

# 1文字～n文字
[10..20].forEach (i)->
  console.log i,"start"
  broken = false
  
  # くりかえし
  [0...5].forEach (o)->
    console.log o+1,"かいめ"
    [1..5000].forEach (m)->
      return if broken
      
      # m件作成
      # m = 30
      arr = {}
      [0...m].forEach (j)->
        arr[helper.getHash().substr(0,i)] = j
      
      if m != Object.keys(arr).length
        console.log i + "文字では" + m + "件で" + (m - Object.keys(arr).length) + "個重複"
        broken = true
###




###
# xorshift
xor=->
  y = 2463534242
  loop
    y = y ^ (y << 13)
    y = y ^ (y >> 17)
    yield y = y ^ (y << 15)

r32 = xor()
# console.log [0...10].map -> r32.next().value

xor64=->
  x = 88172645463325252
  loop
    x = x ^ (x << 13)
    x = x ^ (x >> 7)
    yield x = x ^ (x << 17)

r64 = xor64()
# console.log [0...10].map -> r64.next().value


xor96=->
  x = 123456789
  y = 362436069
  z = 52128862
  t = undefined
  loop
    t = (x ^ (x << 3)) ^ (y ^ (y >> 19)) ^ (z ^ (z << 6))
    x = y
    y = z
    yield z = t

r96 = xor96()
# console.log [0...10].map -> r96.next().value

xor128=->
  x = 123456789
  y = 362436069
  z = 521288629
  w = 88675123 
  t
  loop
    t = x ^ (x << 11)
    x = y
    y = z
    z = w
    yield w = (w ^ (w >> 19)) ^ (t ^ (t >> 8))

r128 = xor128()
# console.log [0...10].map -> r128.next().value

xorshift=(seed = 114514)->
  x = 123456789
  y = 362436069
  z = 521288629
  w = seed
  
  loop
    t = x ^ (x << 11)
    x = y
    y = z
    z = w
    yield w = (w ^ (w >>> 19)) ^ (t ^ (t >>> 8))



xs1 = xorshift()
console.log [0...10].map -> xs1.next().value

xs2 = xorshift(141421356)
console.log [0...10].map -> xs2.next().value
###


###
# 最大値と最小値を保持する
class highpass
  val: null
  post: (i)->
    if @val? == false || i > @val
      @val = i

class lowpass
  val: null
  post: (i)->
    if @val? == false || i < @val
      @val = i

class bandpass
  max: null
  min: null
  post: (i)->
    if @max? == false || i > @max
      @max = i
    
    if @min? == false || i < @min
      @min = i
  cen: ->
    (@max + @min) / 2

bp = new bandpass()
###


###
bp.post 6
bp.post 9
bp.post 9
bp.post 10
bp.post 10
bp.post 10
bp.post 100
console.log bp.cen()
###



###
bp = new bandpass

console.log bp.max
console.log bp.min
bp.post 5
bp.post 7
bp.post 3
bp.post 4
console.log bp.max
console.log bp.min
bp.post 6
bp.post 5
bp.post 5
console.log bp.max
console.log bp.min

console.log bp.cen()
###

###
lp = new lowpass()

console.log lp.val
lp.post 1
console.log lp.val
lp.post 2
console.log lp.val
lp.post 1
console.log lp.val
###

###
hp = new highpass()

console.log hp.val
hp.post 1
console.log hp.val
hp.post 2
console.log hp.val
hp.post 1
console.log hp.val
hp.post 5
console.log hp.val
hp.post 1
console.log hp.val
hp.post 5
console.log hp.val
hp.post 5
console.log hp.val
###







###
json = [['1の画面',['1-1','1-3','1-2']],['2の画面',['2-1','2-2','2-3']],['5の画面',['5-1','5-2','5-3']],['4の画面',['4-1','4-2','4-3']],['8の画面',['8-1','8-2','8-3']]];

msort = (a,b)->
  gamen = json.map (i)-> i[0]
  
  if gamen.indexOf(a[0]) > gamen.indexOf(b[0])
    return 1
  if gamen.indexOf(a[0]) < gamen.indexOf(b[0])
    return -1
  
  if json[gamen.indexOf(a[0])][1].indexOf(a[1]) > json[gamen.indexOf(b[0])][1].indexOf(b[1])
    return 1
  if json[gamen.indexOf(a[0])][1].indexOf(a[1]) < json[gamen.indexOf(b[0])][1].indexOf(b[1])
    return -1
  else
    return 0


t = """
|画面メイ | 小画面 | 日付１            |  日付２              |人ID |
| 1の画面 | 1-1 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Aさん|
| 1の画面 | 1-2 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Aさん|
| 1の画面 | 1-3 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Aさん|
| 2の画面 | 2-1 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Aさん|
| 2の画面 | 2-2 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Aさん|
| 2の画面 | 2-3 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Aさん|
| 1の画面 | 1-1 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Bさん|
| 1の画面 | 1-2 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Bさん|
| 1の画面 | 1-3 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Bさん|
| 5の画面 | 5-1 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Aさん|
| 4の画面 | 4-1 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Bさん|
| 4の画面 | 4-3 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Bさん|
| 4の画面 | 4-2 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Bさん|
| 1の画面 | 1-1 |　yyyy-mm-dd hh:mm:ss |　yyyy-mm-dd hh:mm:ss |Aさん|
"""

console.log json
s = t.split("\n")
s.shift()
db = s.map (l)->
  line = l.split("|")
  line.shift()
  line.pop()
  line.map (i)-> i.trim()


console.log db.sort(msort)
###


###
# ・1024から65536ランダムな値を返却する
# ※同じ値を返さないようにしなくてはならない
portDecider = ()->
  # Math.floor(Math.random() * 65536 - 1024 + 1)
  Math.floor(Math.random() * (65536 - 1024) + 1024)
###



###
[0...1000000].forEach ->
  p = portDecider()
  if p < 1023
    console.log p
###



###
# リクエストがあったらアクションを増やす2
# →できなかった
konopath = (path, action)->
  console.log "a"
  route = require('koa-route')
  Koa = require('koa')
  app = new Koa()
  
  console.log "b",path,action
  app.use route.get path, action
  
  console.log "c"
  # port = portDecider()
  port = 80
  s = app.listen port, ->
    console.log "listen", s._connectionKey
    process.send port



cluster = require "cluster"
if cluster.isMaster
  o = {}
  o.path = "/create/:path" 
  o.act = (ctx)->
    ctx.set 'Content-Type': 'text/plain'
    ctx.body = "done:" + process.pid
  
  
  w = cluster.fork()
  console.log o
  w.send o
  
  cluster.on 'message',(w,msg)->
    console.log "meg:", msg
    c = cluster.fork()
    c.send msg
  
  
  # 終了したら通知
  cluster.on 'exit',(worker, code, signal)->
    console.log worker.process.pid + ' exit:' + worker.id

else
  
  process.on "message", (msg,a,b)->
    console.log "kiteruiuu", msg
    konopath msg.path, msg.act
###




###
# こうじゃない
# リクエストがあったらアクションを増やす
cluster = require "cluster"
if cluster.isMaster
  # for i in [1..require("os").cpus().length]
  #   cluster.fork()
  route = require('koa-route')
  Koa = require('koa')
  app = new Koa()
  
  app.use route.get '/:path', (ctx, path)->
    ctx.set 'Content-Type': 'text/plain'
    w = cluster.fork()
    w.send path
    ctx.body = "done:" + process.pid
  
  s = app.listen 80, -> console.log "listen", s._connectionKey
  
  cluster.on 'message',(w,msg)->
    console.log "port", msg
    
    
  # 終了したら通知
  cluster.on 'exit',(worker, code, signal)->
    console.log worker.process.pid + ' exit:' + worker.id

else
  process.on "message", (msg,a,b)->
    console.log "kiteru", msg
  
    route = require('koa-route')
    Koa = require('koa')
    app = new Koa()
    
    path = "/" + msg + "/path"
    
    app.use route.get path, (ctx)->
      console.log "ktiemasikane"
      ctx.set 'Content-Type': 'text/plain'
      ctx.body = "done:" + process.pid
    
    port = portDecider()
    s = app.listen port, ->
      console.log "listen", s._connectionKey
      process.send port
  
  console.log "hajimari"

###


###

cluster = require "cluster"
if cluster.isMaster
  for i in [1..require("os").cpus().length]
    cluster.fork()
else
  route = require('koa-route')
  Koa = require('koa')
  app = new Koa()

  app.use route.get '/', (ctx)->
    ctx.set 'Content-Type': 'text/plain'
    ctx.body = "done:" + process.pid

  s = app.listen 80, -> console.log "listen", s._connectionKey

###


###
cluster = require "cluster"
cpu_count = require("os").cpus().length
      
if cluster.isMaster
  console.log "cpu_count:" + cpu_count
  for i in [1..cpu_count]
    w = cluster.fork()
    console.log "fork:" + w.process.pid
  
  cluster.on 'message', (w, msg)->
    console.log w.id, w.process.pid
    console.log 'Mmsg:' + msg
  
  # 終了を受け取って再起動する
  cluster.on 'exit',(worker, code, signal)->
    console.log worker.process.pid + ' exit:' + worker.id
    cluster.fork()
else
  route = require('koa-route')
  Koa = require('koa')
  app = new Koa()

  app.use route.get '/', (ctx)->
    console.log "1kita"
    process.send "1kita"
    ctx.set 'Content-Type': 'text/plain'
    # ctx.render "index", dp
    # ctx.body = "mojiretudesu:" + dir + "/" + file
    ctx.body = "done:" + process.pid

  s = app.listen 80, -> console.log "listen", s._connectionKey
  # s = app.listen portDecider(), -> console.log "listen", s._connectionKey
###

###
# サーバーひとつふたつ
route = require('koa-route')
Koa = require('koa')
app = new Koa()

app.use route.get '/', (ctx)->
  console.log "1kita"
  ctx.set 'Content-Type': 'text/plain'
  # ctx.render "index", dp
  # ctx.body = "mojiretudesu:" + dir + "/" + file
  ctx.body = "done"

s = app.listen portDecider(), -> console.log "listen", s._connectionKey

app2 = new Koa()

app2.use route.get '/', (ctx)->
  console.log "2kita"
  ctx.set 'Content-Type': 'text/plain'
  # ctx.render "index", dp
  # ctx.body = "mojiretudesu:" + dir + "/" + file
  ctx.body = "done2"

s2 = app2.listen portDecider(), -> console.log "listen", s2._connectionKey
###




###
# マイクロなAPI
app = new (require 'koa')()
app.use require("koa-logger")()

# routes
route = require('koa-route')
app.use route.get '/api/:action/:value', (ctx, action, value)->
  dp = {}
  # dp.api = id
  if action == "aaa"
    dp.aaa = value
  else
    dp.other = "other action"
  
  ctx.body = dp


app.listen 3000, -> console.log "start"
###


###
console.log ch: helper.createHash("test")
console.log gh: helper.getHash()
console.log gh64: helper.getHash64()
###


###
# 並列フォーク
spawn = require('child_process').spawn
ec = spawn "c:\\coffee.cmd", ["echoer.coffee", "ebs"]
# ec = spawn "coffee", ["echoer.coffee", "ebs"]

ec.stdout.on 'data', (d)-> console.log "out", d.toString()
ec.stderr.on 'data', (d)-> console.log "err", d.toString()
ec.on 'close', (code)-> console.log "code", code

ef = spawn "c:\\coffee.cmd", ["echoer.coffee", "efs"]

ef.stdout.on 'data', (d)-> console.log "out", d.toString()
ef.stderr.on 'data', (d)-> console.log "err", d.toString()
ef.on 'close', (code)-> console.log "code", code
###




###
# カウントアップなrunner
runner = (i, exec, c=1)-> new Promise (f,r)->
  if i >= c
    exec(c)
    runner i, exec, c + 1
  else
    f()

func = (c)->
  console.log "run", c

runner 30, func
.then ->
  console.log "done"
.catch (e)->
  console.log "e",e
###


###
# カウントダウンなrunner
runner = (i, exec)-> new Promise (f,r)->
  if i > 0
    exec()
    runner i - 1, exec
  else
    f()

func = ->
  console.log "run"

runner 3, func
.then ->
  console.log "done"
.catch (e)->
  console.log "e",e
###

###
@a = "adesu"
console.log @

func = ->
  console.log "===="
  # console.log @, "cool"
  # console.log @a.toString()
  # console.log @a.length
  # console.log this.replace /n/g, "k"
  # console.log @a
  console.log @()
  console.log "===="


# func()
# func.bind(this)()
# func.bind("nanigoto")()
func.bind(->console.log "kog")()
###


###
# ファイル名を取得
n = process.argv[2]
console.log n
console.log n.split("\\")
console.log n.split("\\").pop()
console.log n.split("\\").slice(-1)[0]

setInterval ->
  console.log 100
, 10000
###



###
y = 1930
while y % 4 != 0
  console.log y
  console.log y % 4
  y += 4


console.log y
###




###
# 機械的に学習

q = [
    k: 1
  ,
    k: 2
  ,
    k: 3
  ,
    k: 4
]

sample = q


ml = (i)->
  sample.filter (j)-> j.k == i


# test
console.log ml(q[0].k)
console.log ml(q[0].k)
console.log ml(q[0].k) == 0
console.log ml(q[1].k) == 1
console.log ml(q[2].k) == 0
console.log ml(q[3].k) == 1
###







###
a = -> ""
b = -> ""

# ccc = undefined
# ccc = if a() != "" then a() else if b() != "" then b() else null
# ccc = a() != "" && b() != "" 

ccc = null
ccc = a() || ccc = b()

console.log ccc
###




###
q = undefined
q |= 1
q |= 2
console.log q
###



###
# cookie
# require("https").get "https://httpbin.org/cookies/set/fooo/baaaa" , (res)-> res.on "data", (c)->  console.log res.headers["set-cookie"]
require("https").get "https://httpbin.org/cookies/set/fooo/baaaa"
  , (res)->
    res.on "data", (c)->
      # f [c.toString(), res.statusCode]
      console.log res.headers["set-cookie"]
###





###
request = require("request")
j = request.jar()
j.setCookie request.cookie("vooo=beee"), "http://httpbin.org/cookies"

request
  url: "http://httpbin.org/cookies"
  jar: j
  , ->
    request "http://httpbin.org/cookies"

    request.get
      uri: "http://httpbin.org/cookies"
      , (e,r,b)->
        if e?
          console.log "e:",e
        else
          console.log "b:",b


require("request").get
  uri: "https://httpbin.org/cookies/set/node/jjss"
  # headers: cookie: "asdf=asdf"
  , (e,r,b)->
    if e?
      console.log "e:",e
    else
      console.log "b:",b
      console.log "r:",r.headers
      # console.log "r:",r
###


###
# tdd説明資料向け
zip = [
  "北海道"
  "青森県"
  "岩手県"
  "宮城県"
  "秋田県"
  "山形県"
  "福島県"
  "茨城県"
  "栃木県"
  "群馬県"
  "埼玉県"
  "千葉県"
  "東京都"
  "神奈川県"
  "新潟県"
  "富山県"
  "石川県"
  "福井県"
  "山梨県"
  "長野県"
  "岐阜県"
  "静岡県"
  "愛知県"
  "三重県"
  "滋賀県"
  "京都府"
  "大阪府"
  "兵庫県"
  "奈良県"
  "和歌山県"
  "鳥取県"
  "島根県"
  "岡山県"
  "広島県"
  "山口県"
  "徳島県"
  "香川県"
  "愛媛県"
  "高知県"
  "福岡県"
  "佐賀県"
  "長崎県"
  "熊本県"
  "大分県"
  "宮崎県"
  "鹿児島県"
  "沖縄県"
]


zipobj = [
  {j:"北海道",e:"hokkaido"}
  {j:"青森県",e:"aomori"}
  {j:"岩手県",e:"iwate"}
  {j:"宮城県",e:"miyagi"}
  {j:"秋田県",e:"akita"}
  {j:"山形県",e:"yamagata"}
  {j:"福島県",e:"fukushima"}
  {j:"茨城県",e:"ibaraki"}
  {j:"栃木県",e:"tochigi"}
  {j:"群馬県",e:"gunma"}
  {j:"埼玉県",e:"saitama"}
  {j:"千葉県",e:"chiba"}
  {j:"東京都",e:"tokyo"}
  {j:"神奈川県",e:"kanagawa"}
  {j:"新潟県",e:"niigata"}
  {j:"富山県",e:"toyama"}
  {j:"石川県",e:"ishikawa"}
  {j:"福井県",e:"fukui"}
  {j:"山梨県",e:"yamaguchi"}
  {j:"長野県",e:"nagano"}
  {j:"岐阜県",e:"gifu"}
  {j:"静岡県",e:"shizuoka"}
  {j:"愛媛県",e:"aichi"}
  {j:"三重県",e:"mie"}
  {j:"滋賀県",e:"shiga"}
  {j:"京都府",e:"kyoto"}
  {j:"大阪府",e:"osaka"}
  {j:"兵庫県",e:"hyogo"}
  {j:"奈良県",e:"nara"}
  {j:"和歌山県",e:"wakayama"}
  {j:"鳥取県",e:"tottori"}
  {j:"島根県",e:"shimane"}
  {j:"岡山県",e:"okayama"}
  {j:"広島県",e:"hiroshima"}
  {j:"山口県",e:"yamanashi"}
  {j:"徳島県",e:"tokushima"}
  {j:"香川県",e:"kagawa"}
  {j:"愛知県",e:"ehime"}
  {j:"高知県",e:"kochi"}
  {j:"福岡県",e:"fukuoka"}
  {j:"佐賀県",e:"saga"}
  {j:"長崎県",e:"nagasaki"}
  {j:"熊本県",e:"kumamoto"}
  {j:"大分県",e:"oita"}
  {j:"宮崎県",e:"miyazaki"}
  {j:"鹿児島県",e:"kagoshima"}
  {j:"沖縄県",e:"okinawa"}
]

zipobjusa = [
  {j:"アラバマ",e:"Alabama"}
  {j:"アラスカ",e:"Alaska"}
  {j:"アリゾナ",e:"Arizona"}
  {j:"アーカンソー",e:"Arkansas"}
  {j:"カリフォルニア",e:"California"}
  {j:"コロラド",e:"Colorado"}
  {j:"コネチカット",e:"Connecticut"}
  {j:"デラウェア",e:"Delaware"}
  {j:"フロリダ",e:"Florida"}
  {j:"ジョージア",e:"Georgia"}
  {j:"ハワイ",e:"Hawaii"}
  {j:"アイダホ",e:"Idaho"}
  {j:"イリノイ",e:"Illinois"}
  {j:"インディアナ",e:"Indiana"}
  {j:"アイオワ",e:"Iowa"}
  {j:"カンザス",e:"Kansas"}
  {j:"ケンタッキー",e:"Kentucky"}
  {j:"ルイジアナ",e:"Louisiana"}
  {j:"メーン",e:"Maine"}
  {j:"メリーランド",e:"Maryland"}
  {j:"マサチューセッツ",e:"Massachusetts"}
  {j:"ミシガン",e:"Michigan"}
  {j:"ミネソタ",e:"Minnesota"}
  {j:"ミシシッピ－",e:"Mississippi"}
  {j:"ミズーリ",e:"Missouri"}
  {j:"モンタナ",e:"Montana"}
  {j:"ネブラスカ",e:"Nebraska"}
  {j:"ネバダ",e:"Nevada"}
  {j:"ニューハンプシャー",e:"New Hampshire"}
  {j:"ニュージャージー",e:"New jersey"}
  {j:"ニューメキシコ",e:"New Mexico"}
  {j:"ニューヨーク",e:"New York"}
  {j:"ノースカロライナ",e:"North Carolina"}
  {j:"ノースダコタ",e:"North Dakota"}
  {j:"オハイオ",e:"Ohio"}
  {j:"オクラホマ",e:"Oklahoma"}
  {j:"オレゴン",e:"Oregon"}
  {j:"ペンシルバニア",e:"Pennsylvania"}
  {j:"ロードアイランド",e:"Rhode Island"}
  {j:"サウスカロライナ",e:"South Carolina"}
  {j:"サウスダコタ",e:"South Dakota"}
  {j:"テネシー",e:"Tennessee"}
  {j:"テキサス",e:"Texas"}
  {j:"ユタ",e:"Utah"}
  {j:"バーモント",e:"Vermont"}
  {j:"バージニア",e:"Virginia"}
  {j:"ワシントン",e:"Washington"}
  {j:"ウェストバージニア",e:"West Virginia"}
  {j:"ウィスコンシン",e:"Wisconsin"}
  {j:"ワイオミング",e:"Wyoming"}
]
###


###
nottdd1 = (i) ->
  zip[i-1]

console.log nottdd1 1 # 北海道
console.log nottdd1 47 # 沖縄県


nottdd2 = (i) ->
  # zip[i+1]
  obj = zipobj[i-1]
  obj.e

console.log nottdd2 1 # hokkaido
console.log nottdd2 47 # okinawa


nottdd4 = (i, region) ->
  if region == "ja"
    obj = zipobj[i-1]
    obj.e
  else
    obj = zipobjusa[i-1]
    obj.e

console.log nottdd4 1, "ja" # hokkaido
console.log nottdd4 47, "ja" # okinawa

console.log nottdd4 1, "us" # Alabama
console.log nottdd4 47, "us" # Washington

nottdd5 = (i, region, language) ->
  if region == "jp"
    obj = zipobj[i-1]
    if language == "us"
      obj.e
    else
      obj.j
  else
    obj = zipobjusa[i-1]
    if language =="us"
      obj.e
    else
      obj.j


console.log nottdd5 1, "jp", "ja" # 北海道
console.log nottdd5 47, "jp", "ja" # 沖縄県

console.log nottdd5 1, "us", "ja" # アラバマ
console.log nottdd5 47, "us", "ja" # ワシントン
###


###
# v0
module.exports.tdd = ->
  "北海道"
###


###
# v1
module.exports.tdd = (i)->
  zip[i-1]
###

###
# v2
module.exports.tdd = (i, lang="ja")->
  switch lang
    when "ja"
      zipobj[i-1].j
    when "us"
      zipobj[i-1].e
###



###
# v4 / v5
zip_jp = (i, lang="ja")->
  switch lang
    when "ja"
      zipobj[i-1].j
    when "us"
      zipobj[i-1].e

zip_us = (i, lang="ja")->
  switch lang
    when "ja"
      zipobjusa[i-1].j
    when "us"
      zipobjusa[i-1].e


module.exports.tdd = (i, lang="ja", region="jp")->
  switch region
    when "jp"
      zip_jp i,lang
    when "us"
      zip_us i,lang
###




###
rs = require("fs").createReadStream "read.txt", encoding: "utf8", bufferSize: 1

rs.on "data", (d)->
  console.log "chun: "
  console.log d
rs.on "end", (d)-> console.log "end",d
rs.pipe(process.stdout)
###


###
# tcp wiki
net = require 'net'
server = net.createServer  (stream)->
  stream.write 'hello\r\n'
  
  stream.on 'data', (data)->
    console.log data.toString()
  
  stream.on 'end', ->
    console.log 'end'

server.listen 3000, 'localhost', -> console.log "bound"
###

###
# http wiki
http = require 'http'
http.createServer (request, response)->
  response.writeHead 200, 'Content-Type': 'text/plain'
  response.end 'Hello World\n'
.listen 3000

console.log 'Server running at http://127.0.0.1:3000/'
###

###
# ポート変えたサーバ同士で通信
# process.argv[2]

koa = require "koa"
new koa()
  .use (ctx)->
    console.log ctx.header.host
    
    setTimeout ->
      req = require("http").request
        host: "localhost"
        port: 3001
        method: "get"
        , (res)->
          res.on "data", (c)->
            console.log "res1:", c.toString()
      
      req.on "error", (e)-> console.log e
      # req.write JSON.stringify 
      req.end()
            
      console.log "done1"
    , 1000
    
    ctx.body = "test1 " + ctx.header.host
  .listen 3000


new koa()
  .use (ctx)->
    console.log ctx.header.host
    
    setTimeout ->
      req = require("http").request
        host: "localhost"
        port: 3000
        method: "get"
        , (res)->
          res.on "data", (c)->
            console.log "res2:", c.toString()
      
      req.on "error", (e)-> console.log e
      # req.write JSON.stringify 
      req.end()
            
      console.log "done2"
    , 1000
    
    ctx.body = "test2 " + ctx.header.host
  .listen 3001
###



###
# objectの中身が[object]とかなので展開
o = {}

o.b = {}
o.b.j = [1,3,5,{a:1}]
console.log JSON.stringify o
###






###
arr = [1,3,4,5,6,7,8,9]
console.log arr.includes
console.log arr.includes 1
console.log arr.includes 8, -1

Array.prototype.includes = null

if !Array.prototype.includes
  Object.defineProperty Array.prototype, 'includes',
    value: (s, index)->
      throw new TypeError '"this" is null or not defined' if this == null
      
      o = Object this
      len = o.length >>> 0
      
      return false if (len == 0)
      
      n = index | 0
      k = Math.max( (if n >= 0 then n else len - Math.abs(n)) , 0)
      
      while (k < len)
        return true if o[k] == s
        
        k++
      
      false

console.log arr.includes
console.log arr.includes 1
console.log arr.includes 8, -1
###






# console.log helper.getHash64()


###
# モジュロ演算にて→NG 閏年自信の計算に難あり
convert_dow = (i)->
  switch i
    when 0 then return "日"
    when 1 then return "月"
    when 2 then return "火"
    when 3 then return "水"
    when 4 then return "木"
    when 5 then return "金"
    when 6 then return "土"

y = 1982
m = 8
d = 2

one = d - m

two = switch m
  when 1,3,5,7,9,11 then 3
  when 2,4,6,8,10,12 then 0

thr = switch m
  when 1,2 then 2
  when 9,11 then 1
  else 0

four = y % 20
five = switch four
  when 0,1,2,3 then 1
  when 4,5,6,7 then 2
  when 8,9,10,11 then 3
  when 12,13,14,15 then 4
  when 16,17,18,19 then 5

dow = (one + two + thr + four + five + 4) % 7
console.log convert_dow dow
###


###
# ツェラーの公式2
convert_dow = (i)->
  switch i
    when 0 then return "日"
    when 1 then return "月"
    when 2 then return "火"
    when 3 then return "水"
    when 4 then return "木"
    when 5 then return "金"
    when 6 then return "土"


y = 1982
m = 1
d = 2

if m == 1 || m == 2 
  m = 13 if m == 1
  m = 14 if m == 2
  y = y - 1

dow = (y + Math.floor(y / 4) - Math.floor(y / 100) +  Math.floor(y / 400) + Math.floor((m * 13 + 8) / 5) + d) % 7

console.log "あなたの誕生日は" + convert_dow(dow) + "曜日でした"
###




###
# ツェラーの公式
convert_dow = (i)->
  switch i
    when 0 then return "日"
    when 1 then return "月"
    when 2 then return "火"
    when 3 then return "水"
    when 4 then return "木"
    when 5 then return "金"
    when 6 then return "土"

y = 1982
m = 8
d = 2

one = y + Math.floor(y / 4)
console.log one
two = one - Math.floor(y / 100)
console.log two
three = two +  Math.floor(y / 400)
console.log three
four = Math.floor((m * 13 + 8) / 5)
console.log four
dow = (three + four + d) % 7
console.log dow

console.log "あなたの誕生日は" + convert_dow(dow) + "曜日でした"
###







###
[1..10].forEach ->
  console.log Math.floor(Math.random() * 10 + 1) # ゼロなし
  console.log Math.floor(Math.random() * 10) # ゼロあり
###


###
# 2/3くらいで失敗するレスポンス
fs = require("fs")

appendfile = (i)-> new Promise (f,r)->
  fs.appendFile "sanbunnoni.csv", i + "\n", (e)->
    if e?
      r e
    else
      f "end"

get = -> new Promise (f,r)->
  require("http").get "http://localhost:3000"
  , (res)->
    res.on "data", (c)->
      # f [c.toString(), res.statusCode]
      f res.statusCode
      
  .on "error", (e)-> r e


controller = (ctx)->
  r = Math.floor(Math.random() * 10)
  console.log "r", r
  switch r
    when 1,2,3,4,5,6
      ctx.status = 404
  
  ctx.body = "hell"

new (require 'koa')().use( controller ).listen 3000

cnt = 0
[1..100].forEach (i)->
  get()
  .then (v)->
    # console.log i,v
    if v == 404
      cnt++
    console.log cnt
    # appendfile v
  .catch (e)-> console.log i,e
###



###

# csvつくる
require("fs").appendFile "hhash.csv", "moj,iretu"+"\n", (e)->
  if e?
    console.log e
  else
    console.log "end"

###



###
# 無限ハッシュ
i = 0
noroi = (h)->
  h2 = helper.getHash h
  console.log i,h2
  ++i
  noroi h2

noroi helper.getHash()
###


###
# 0101から1231の365個の配列作成
cal = [1..12]
  .map (i)->
    switch i
      when 4,6,9,11
        [1..30].map((j)->i.toString() + ("0" + j.toString()).slice(-2))
      when 2
        [1..28].map((j)->i.toString() + ("0" + j.toString()).slice(-2))
      else
        [1..31].map((j)->i.toString() + ("0" + j.toString()).slice(-2))

calarr = Array.prototype.concat.apply [],cal


# 0～10000人マイミクがいた場合の特定の日が非誕生日な割合
unbirthday = [0...10000].map (index)->
  console.log index
  mymiku = [0...index].map -> calarr[Math.floor(Math.random() * calarr.length)]

  # 一万回試行して精度を高める
  n = 10000
  sample = [0...n]
    .map -> mymiku.findIndex (i)-> i == calarr[Math.floor(Math.random() * calarr.length)]
    .filter (i)-> i == -1
    .length

  Math.floor((sample / n) * 100)


# csvにする
require("fs").appendFile "mymikuubd.csv", unbirthday.join("\n"), (e)->
  if e?
    console.log e
  else
    console.log "end"
###



###
# 0101から1231の366個の配列作成
cal = [1..12]
  .map (i)->
    switch i
      when 4,6,9,11
        [1..30].map((j)->i.toString() + ("0" + j.toString()).slice(-2))
      when 2
        [1..28].map((j)->i.toString() + ("0" + j.toString()).slice(-2))
      else
        [1..31].map((j)->i.toString() + ("0" + j.toString()).slice(-2))

calarr = Array.prototype.concat.apply [],cal


unbirthday = [0...20].map ->
  mymiku = [0...1000].map -> calarr[Math.floor(Math.random() * calarr.length)]

  # 一万回試行して割合を求める
  n = 10000
  sample = [0...n]
    .map -> mymiku.findIndex (i)-> i == calarr[Math.floor(Math.random() * calarr.length)]
    .filter (i)-> i == -1
    .length

  Math.floor((sample / n) * 100)

console.log unbirthday
###




###

# Arrayにprototypeがでてしまう場合
Ins = (name)-> @name = name
Ins.prototype =
  # medo: -> console.log @name, "emdo"
  doro: -> console.log @name, "dorojii"


Object.defineProperty Ins.prototype, "medo",
  writable:true
  enumerable:true
  configurable:true
  value:-> console.log @name, "emdohodheo"

tans = new Ins "namae"

# tans.medo()
# tans.doro()

# console.log Object.keys tans
# console.log tans
# console.log tans.medo



Object
.keys tans
.forEach (n)->
  console.log tans[n]

# coffeeではfor-inは (i = 0, len = tans.length; i < len; i++) に書き換わる
for k in tans
  console.log "kottiha?"
  console.log tans[k]
###





###
# temperature-humidity index thidx
temp = 35
humi = 0



thidx = (t, h)-> 0.81 * t + 0.01 * h * (0.99 * t - 14.3) + 46.3

dc = thidx temp, humi

console.log dc
if 75 > dc && dc >= 60 
  console.log "t"
  
else
  console.log "f"
###


###
# ナノ秒計測
NS_PER_SEC = 1e9
nano = process.hrtime()

process.nextTick ->
  diff = process.hrtime(nano)
  console.log diff[0] * NS_PER_SEC + diff[1]
###




###
# json 配列
a = [
  aa : 1
  bb : 2
,
  aa : 1
  bb : 2
]

console.log a
###

###
# objectにobjectを入れる
j = 
  aa : 1
  kore :
    asdf : "dhi"
    fewf : "can"
  bb : 2


console.log j
###

###
helper.makeDir "po/bag/asdf/asdf/fe/fe/asdf/efe/sasdf/efda/sdfe/fa/"
.then (v)-> console.log v
.catch (e)-> console.log e
###



###
# ディレクトリ構造解析
dir = "./asdf/jjiji/dkjd"

# fs = require "fs"

console.log dir.split("/")[0...-1].join("/")
###



###
# callbackmethod
console.log "start"

cb = ->
  console.log "cb"

asyn = new Promise (f,r) ->
  f()

asynrap = -> new Promise (f,r) ->
  f()


console.log "1"
cb()
console.log "2"
asyn.then -> console.log "asyn"
console.log "3"
asynrap().then -> console.log "asynrap"
console.log "4"
console.log "5"

console.log "end"
###

###
deleteEs = (idx)-> new Promise (f,r)->
  req = require("https").request
    host: "com"
    path: "/" + idx
    method: "DELETE"
    headers:
      "content-type": "application/json"
    , (res)->
      res.on "data", (c)->
        f c.toString()
        # f()
  
  req.on "error", (e)-> r e
  # req.write JSON.stringify 
  req.end()

idx = "influenzatmosphere-2017.12.19"
deleteEs idx
.then (v)-> console.log v
.catch (e)-> console.log e
###


###
# influenzatmosphere
# https://

logstashdateformat = ->
  d = new Date()
  d.getFullYear() + "." \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "." \
   + ("0" + d.getDate()).slice(-2) + ""

sendEs = (obj)-> new Promise (f,r)->
  # indexはYYYY.MM.DD
  idx = "-" + logstashdateformat()
  # console.log "idx:", idx
  
  req = require("https").request
    host: "localhost"
    path: "/" + idx + "/logs"
    method: "POST"
    headers:
      "content-type": "application/json"
    , (res)->
      res.on "data", (c)->
        # f c.toString()
        f()
  
  req.on "error", (e)-> r e
  req.write JSON.stringify obj
  req.end()


obj = {}
obj["@timestamp"] = new Date()
obj.temperature = 40
obj.humidity = 30
obj.wva = 6
console.log obj

sendEs obj
.then (v)-> console.log v
.catch (e)-> console.log e



getEs = -> new Promise (f,r)->
  require("https").get "https://"
  , (res)->
    res.on "data", (c)-> f JSON.parse c.toString()
  .on "error", (e)-> r e


# getEs()
# .then (v)-> console.log v
# .catch (e)-> console.log e
###




###
a = require("https").get "https://"

a.on "response", (res)->
  console.log "kiteru"
  res.on "data", (c)->
    console.log c.toString()
###


###
a =
  aaa: ->
    get: ->3,
    set: ->

console.log a.aaa
a.aaa=5;
console.log a.aaa
console.log a
###



###
fun = ->
ob = {fun}

console.log ob.fun.name
console.log((->).name)
###



###
foo = "astai"
obj = {foo}
console.log obj


siym = 1e5
jet = {siym}
console.log jet

lit = {}
lit[1e5]="a"
console.log lit
###

###
# Proxy
target = {}
obj = new Proxy target, get: (target, name, receiver)-> name


console.log obj.foo
console.log obj['あいうえお']

obj.name = "Mary Sue"
console.log obj.name
console.log target.name
###


###
gen=(w)->
  console.log yield* [1,2,3]

g = gen(9)
console.log g.next(90)
console.log g.next(900)
console.log g.next()
console.log g.next()
console.log g.next()
###


###
gen=(w)->
  try
    console.log('w:', w)
    x = yield
    console.log('x:', x)
    y = yield
    console.log('y:', y)
    z = yield
    console.log('z:', z)
  catch e
    yield -1


console.log "1"
g = gen(1)
console.log g.next(10)
console.log g.throw(new Error("erata"))
console.log g.return(1000)
###


###
gen=(w)->
  console.log "3"
  console.log('w:', w)
  console.log "4"
  x = yield
  console.log "6"
  console.log('x:', x)
  console.log "7"
  y = yield
  console.log "9"
  console.log('y:', y)
  console.log "10"
  z = yield
  console.log "-"
  console.log('z:', z)
  console.log "-"


console.log "1"
g = gen(1)
console.log "2"
g.next(10)
console.log "5"
g.next(100)
console.log "8"
g.next(1000)
console.log "11"
###


###
gen=(x)->
  console.log "3"
  console.log('x:', x)
  console.log "4"
  y = yield
  console.log "6"
  console.log('y:', y)
  console.log "7"
  z =yield
  console.log "9"
  console.log('z:', z)
  console.log "10"


console.log "1"
g = gen 10
console.log "2"
g.next()
console.log "5"
g.next(100)
console.log "8"
g.next(1000)
console.log "11"
###

###
gen = ->
  yield "bo"
  y = yield "bb"
  x = yield "aa"
  console.log "yy", yield "i-rudo"
  return "ret"


g = gen()
console.log "a", g.next("a")
console.log "b", g.next("b")
console.log "c", g.next("c")
console.log "d", g.next("d")
console.log "e", g.next("e")
###

###
gen = ->
  console.log "gen1"
  yield "bo"
  console.log "gen2"
  y = yield
  console.log "gen3"
  console.log "y", y
  console.log "gen4"
  x = yield
  console.log "gen5"
  console.log "x", x
  console.log "gen6"


console.log "g1"
g = gen()
console.log "g2"
console.log "a", g.next("a")
console.log "g3"
console.log "b", g.next("b")
console.log "g4"
console.log "c", g.next("c")
console.log "g5"
console.log "d", g.next("d")
console.log "g6"
console.log "e", g.next("e")
console.log "g7"
###


###
# 封印・凍結
obj = foo: 'let'
console.log Object.isExtensible(obj)
Object.freeze(obj)
console.log Object.isExtensible(obj)
console.log Object.isSealed(obj)

obj.bar = 3
obj.foo = "beee"
console.log obj.bar
console.log 'bar' in obj
console.log 'foo' in obj
console.log 'bar' of obj
console.log 'foo' of obj
console.log obj.foo?
console.log obj.foo
###



###
# 封印・凍結
obj = foo: 'let'
console.log Object.isExtensible(obj)
Object.seal(obj)
console.log Object.isExtensible(obj)
console.log Object.isSealed(obj)

obj.bar = 3
obj.foo = "beee"
console.log obj.bar
console.log 'bar' in obj
console.log 'foo' in obj
console.log 'bar' of obj
console.log 'foo' of obj
console.log obj.foo?
console.log obj.foo
###

###
# 封印・凍結
'use strict'
obj = foo: 'let'
console.log Object.isExtensible(obj)
Object.preventExtensions(obj)
console.log Object.isExtensible(obj)

obj.bar = 3
obj.foo = "beee"
console.log obj.bar
console.log 'bar' in obj
console.log 'foo' in obj
console.log 'bar' of obj
console.log 'foo' of obj
console.log obj.foo?
console.log obj.foo
###




###
# 真打
messageValues = {}
messageValues.temperature = 20
messageValues.humidity = 64

# 水蒸気圧の計算
august = (t)-> Math.ceil(6.1078 * 10 ** ( (7.5 * t) / (t + 237.3) ) * 1000, 2) / 1000
# 飽和水蒸気量の計算
tetens = (t)-> Math.ceil(  (217 * august(t)) / (t + 273.15) * 1000, 2) / 1000

checkInfluenza = (t, h)->
  res = {}
  wm = tetens t
  wa = wm * (h / 100)
  hm =  Math.ceil((11 / wm) * 100)
  hn = hm - h
  msg = ""
  
  if wa >= 11
    status = "安全"
  else
    status = "危険"
    msg = hn + "%不足しています"
  
  res.wm = Math.floor(wm)
  res.wa = Math.floor(wa)
  res.hm = hm
  res.hn = hn
  res.status = status
  res.msg = msg
  res


param = checkInfluenza messageValues.temperature, messageValues.humidity

string = param.status + "です\n"
string += "温度:" + messageValues.temperature + "/湿度:" + messageValues.humidity + "\n"
string += "水分量:" + param.wa + "/" + param.wm + "→" + "必要湿度:" + param.hm + "%"
string += "\n" + param.msg if param.msg != "" 

console.log string
###










###
# 水蒸気圧の計算
august = (t)-> Math.ceil(6.1078 * 10 ** ( (7.5 * t) / (t + 237.3) ) * 1000, 2) / 1000
# 飽和水蒸気量の計算
tetens = (t)-> Math.ceil(  (217 * august(t)) / (t + 273.15) * 1000, 2) / 1000

# console.log august(20) 
# console.log tetens(20)
# console.log august(20.1)
# console.log tetens(20.1)

checkInfluenza = (t, h)->
  wm = tetens t
  
  wa =wm * (h / 100)
  
  if wa >= 11
    console.log "安全"
  else
    console.log "危険"
  
  hm =  Math.ceil((11 / wm) * 100)
  hn = hm - h
  
  console.log "MAX水分量:", wm
  console.log "現在の水分量:", wa
  console.log "必要湿度:", hm
  console.log "不足湿度:", hn
  

# checkInfluenza 20, 50
# checkInfluenza 20, 62
# checkInfluenza 20, 63
# checkInfluenza 20, 64
# checkInfluenza 20, 65
###





###
# asyncの利用方法。awaitがあれば自動判別される
Koa = require('koa')
app = new Koa()

# ctx is the context for one request
app.use (ctx, next)->
  console.log "kiteru"
  next()

app.use (ctx, next) ->
  start = Date.now()
  await next()
  ms = Date.now() - start
  console.log ctx.method, ctx.url, ms

app.use (ctx)->
  ctx.body = "hell"

app.listen 3000, -> console.log "start"
###




###
# 最小koa2
new (require 'koa')().use((ctx)-> ctx.body = "hell").listen 3000

# app = new (require 'koa')()
# app.use (ctx)-> ctx.body = "hell"
# app.listen 3000, -> console.log "start"

# deprecate
# new (require('koa'))().use(->@body = yield ["hell" + @url]).listen 3000
###

###
# koa2
Koa = require('koa')
app = new Koa()

app.use (ctx, next)->
  console.log "kiteru"
  next()

app.use (ctx)->
  ctx.body = "hell"

app.listen 3000, -> console.log "start"
###






###
# expressでviewをhtmlに
app = require("express")()
app.set "views", __dirname
app.engine('html', require('pug').renderFile)
app.get "/", (req, res)->
  res.render "expressviewhtml.html", {key:"value", bun:"あああ<br>iii"}

app.set 'port', 3000
server = require("http").createServer(app).listen app.get('port'), ->
  console.log "Express server listening on portee " + server.address().port
###





###
# メモリ使用量の確認
i=require('iconv').Iconv
c=new i("SHIFT_JIS","utf-8")

doit = ->
  a = require("child_process").execSync("systeminfo")
  b = c.convert a
  d = b.toString()
  arr = d.split("\r\n")
  # console.log arr[24]
  # console.log arr[25]
  # console.log arr[26] # 仮想メモリ: 最大サイズ
  # console.log arr[27] # 仮想メモリ: 利用可能
  e = arr[24].split(":")[1].trim()
  f = arr[25].split(":")[1].trim()
  all = parseInt e.split(" ")[0].replace(/,/g,"")
  free = parseInt f.split(" ")[0].replace(/,/g,"")
  console.log free + "/" + all
  # console.log 100 - (Math.floor(free / all * 100)) + "%利用中"
  setTimeout ->
    doit()
  , 1
  

doit()
###




###
# ディスク容量の確認
i=require('iconv').Iconv
c=new i("SHIFT_JIS","utf-8")

doit = ->
  a = require("child_process").execSync("fsutil volume diskfree c:")
  b = c.convert a
  # console.log b.toString()
  # 配列に変換
  d = b.toString()
  arr = d.split("\r\n")
  # console.log arr[1]
  # console.log arr[2]
  # console.log arr[1].split(": ")
  # console.log arr[2].split(": ")
  all = parseInt arr[1].split(": ")[1]
  free = parseInt arr[2].split(": ")[1]
  console.log all
  console.log free
  console.log 100-Math.floor((free / all) * 100) + "%使えます"
  
  
  setTimeout ->
    doit()
  , 1000
  

doit()
###


###
# console.log require("child_process").execSync("git status").toString()
console.log require("child_process").execSync("echo %windir%").toString()
echo = require("child_process").execSync("echo %windir%").toString()
console.log echo
###


###
# シェルコマンド実行spawn
spawn = require("child_process").spawn
git = spawn "git",["status"]
git.stdout.setEncoding('utf8')

git.stdout.on "data", (data)->
  console.log "d", data
git.stdout.on "exit", -> process.exit(0)
###




###
# シェルコマンド実行sync
es = require("child_process").execSync
res = es "git status"
console.log res.toString()
###


###
# シェルコマンド実行
exec = require("child_process").exec

# exec "echo 'so' >&2", (e,so,se)->
exec "git status", (e,so,se)->
  if e?
    console.log "e",e
    throw e
  else
    if so?
      console.log "t"
      if so == ""
        console.log "kara"
      else
        console.log "karadenai"
      
    else
      console.log "f"
    
    console.log "so:",so
    console.log "se:",se

###





###
net = require('net')
HOST = ''
PORT = 80

client = new net.Socket()
client.connect PORT, HOST, ->
  console.log('conn: ' + HOST + ':' + PORT)
  # client.write "GET http://www. HTTP/1.1\n"
  client.write "GET http://www. HTTP/1.1\n"
  client.write "HOST: \n"
  # client.write "SERVER_ADDR: 192.168.1.100\n"
  # client.write "REMOTE_ADDR: 106.169.173.29\n"
  
  client.write "\n\n"

client.on 'data', (data)->
  console.log('DAT: ' + data)
  # client.destroy()

client.on 'close', -> console.log('Conn close)
###




###
# 827文字くらいいける
text = """
"""

console.log text.length
require("qrcode").toFile "qrc.png", text, (e)-> if e? then console.log e else console.log "ok"
###



###
foo = require "./foo"
obj = new foo.Foo()
console.log obj.methodA()
###



###
# 乱数*数字の範囲/最大値
# console.log Math.random()
# console.log Math.floor(Math.random() * (100 + 1))
r = Math.floor(Math.random() * (100 + 1))
console.log "r", r
console.log r * 12
console.log r / 100
console.log r * 12 / 100
console.log 12 / (r * 12 / 100)
###


###
j = 0
[200..1000].forEach (i)->
  j += i 

console.log j
###


###
# その他関数
shuffle = (arr) ->
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


# 配列ソート
arr = []

dynamock = ->
  shuffle [
      prev: "root", id: "a", val: "あ"
    ,
      prev: "a", id: "b", val: "い"
    ,
      prev: "b", id: "c", val: "う"
    ,
      prev: "c", id: "d", val: "え"
    ,
      prev: "d", id: "e", val: "お"
    ,
      prev: "e", id: "f", val: "か"
  ]

seqsort = (list)->
  li = []
  li.push list.find (i)-> i.prev == "root"
  
  for cnt in [0...list.length]
    # console.log cnt
    if li[cnt]?.id?
      li.push list.find (i)-> i.prev == li[cnt].id
  
  li
    .filter (i)-> i
    .map (i)-> i
  

sor = (list, before, after)->
  arr = []
  
  # eをcの位置へ
  e = list.find (i)-> i.id == before

  # 1.自分のprevを次のに渡す
  arr = list.map (i)->
    if i.prev == e.id
      i.prev = e.prev
    i

  # 2.次の場所のprevをもらう
  arr = arr.map (i)->
    if i.id == after
      e.prev = i.prev
      # 3.もらったら自分を入れる
      i.prev = e.id
    i
  
  arr

list1 = seqsort dynamock()
list2 = seqsort sor list1, "e", "c"
console.log list2
arr = list2.map (i)-> i.val

# チェック
chk = ["あ","い","お","う","え","か"]

if arr.toString() == chk.toString()
  console.log "OK"
else
  console.log "NG", arr
###


###
# その他関数
shuffle = (arr) ->
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


# 配列ソート
arr = []

dynamock = ->
  shuffle [
      prev: "root", id: "a", val: "あ"
    ,
      prev: "a", id: "b", val: "い"
    ,
      prev: "b", id: "c", val: "う"
    ,
      prev: "c", id: "d", val: "え"
    ,
      prev: "d", id: "e", val: "お"
    ,
      prev: "e", id: "f", val: "か"
  ]


# console.log dynamock()
arr = dynamock()
# o = arr.find (i)-> i.prev == "root"
# console.log o.id
# n = arr.find (i)-> i.prev == (arr.find (i)-> i.prev == "root").id
# console.log n


# findnextobj = (list, previd = "root")->
#   list.find (i)-> i.prev == previd

# console.log findnextobj arr

li = []
li.push arr.find (i)-> i.prev == "root"

for cnt in [0...arr.length]
  # console.log cnt
  if li[cnt]?.id?
    li.push arr.find (i)-> i.prev == li[cnt].id 

# console.log li

arr = li
  .filter (i)-> i
  .map (i)-> i

console.log arr

# eをcの位置へ
e = arr.find (i)-> i.id == "e"

# 1.自分のprevを次のに渡す
arr = arr.map (i)->
  if i.prev == e.id
    i.prev = e.prev
  i

# console.log arr

# 2.次の場所のprevをもらう
arr = arr.map (i)->
  if i.id == "c"
    e.prev = i.prev
    # 3.もらったら自分を入れる
    i.prev = e.id
  i

# console.log arr
# console.log e


li2 = []
li2.push arr.find (i)-> i.prev == "root"

for cnt in [0...arr.length]
  # console.log cnt
  if li2[cnt]?.id?
    li2.push arr.find (i)-> i.prev == li2[cnt].id 

console.log li2
arr = li2
  .filter (i)-> i?
  .map (i)-> i.val


#  .sort (a,b)->
#    if a.prev == "root"
#      return -1
#    
#    if b.prev == "root"
#      return 1
#    return -1
#  .map (i)->
#    o = {}
#    o[i.id] = i
#    o





# チェック
chk = ["あ","い","お","う","え","か"]

if arr.toString() == chk.toString()
  console.log "OK"
else
  console.log "NG", arr
###





###
# sort is
arr = ["a","b","c"]

arr.sort (f,s)->
  console.log "f=",f,",s=",s
  
  return true
  #if s == "c"
  #  return 0
  #else
  #  return 1

console.log "res", arr
###



###
# sort num
arr = [3,5,3,26,69,7,4,6]

arr.sort (f,s)->
  console.log "f=",f,",s=",s
  if f == 3
    return 0
  if s == 6
    return 1
  else
    return 0
  
  #return f - s # 左-右=昇順
  #return s - f # 右-右=降順
  #if s == "c"
  #  return 0
  #else
  #  return 1

console.log "res", arr
###



###
# オブジェクトの配列を記述する方法(カンマとインデントに注意)
obj = [
    "name" : "tom"
    "age"  : 30
  ,
    "name" : "bob"
    "age"  : 24
  ,
    "name" : "wan"
    "age"  : 29
]
console.log obj
###



###
# 指定回数分文字を繰り返す
str = ""
if process.argv[2]?
  [0...process.argv[2]].forEach ->
    str += "abc"

  console.log str
###

###
suff = (entries) -> 
  random = entries.map(Math.random)
  i = 0
  idx = entries.map ()->i++
  
  idx.sort (a, b) -> random[a] - random[b]
  
  res = idx.map (i)-> entries[i]
  
  return res

obj = [0...100]

console.log suff obj
###


###
redis = require "redis"
cli = redis.createClient()

cli.set "tt", obj, (e,d)->
  if e?
    console.log e
  else
    console.log d
###



###
cli.get id, (e,d)->
  if e?
    console.log e
  else
    # console.log d
    cli.end()
    cb JSON.parse d
###


###
b.sort (a,b)->
  if a.toString().length > 1
    if a.toString() > b.toString()
      return 1
    if a.toString() < b.toString()
      return -1
  
    if a.toString().length > 2
      if a.toString() < b.toString()
        return 1
      if a.toString() > b.toString()
        return -1
  
  
  if a.toString() > b.toString()
    return 1
  if a.toString() < b.toString()
    return -1
  
  return 0

console.log b,"b"
console.log a,"a"
###




###
buf = new Buffer([1, 256])
console.log buf
# str = buf.readUInt32LE(0)
str = buf.readUInt8(0) + 8
console.log str
###

###
[0...100].forEach (i)->
  a = createHash i.toString(), "SHA256"
  b = createFujitsuHash i.toString(), "SHA256"
  if a != b
    console.log i
###


###
j = JSON.parse('');
arr=[]
for k,v of j
  arr.push [k,parseInt(v)]

console.log arr

obj = {}
for k,v of j
  obj[k] = parseInt(v)

console.log obj
###




###
# NG
j2y = require "json2yaml"

rs = require("fs").createReadStream("ndjson.json")
ws = require("fs").createWriteStream("ndjson.yaml")

through2 = require("through2")
stm = through2 (c,e,n)->
  console.log "kiteru"
  console.log c,e
  @push c
  n()


rl = require("readline").createInterface rs, stm


# 逐次処理ではなくストリームで変換しないと
# rl.on "line", (l)->
#   y = j2y.stringify JSON.parse(l)
#   console.log y
###





###
i = 1024 * 1024
while true
  console.time "tmp"
  [1...i].reduce (p,q)-> p * q
  console.timeEnd "tmp"
###


###
cluster = require "cluster"
if cluster.isMaster
  [0...32].forEach ->
    w = cluster.fork()
    w.on "exit", (a)->
      console.log "dead:", a
      cluster.fork()
  
else
  i = 1024 * 1024
  while true
    [1...i].reduce (p,q)-> p * q
###


###
# re bunyan2
bunyan = require('bunyan')
log = bunyan.createLogger
  name: 'buunyan'
  src: true

log.trace('trace log')
log.debug('debug log')

log.info('info log')
log.warn('warn\n log')
log.error('error log')
log.fatal('fatal log')
###


###
# re bunyan
bunyan = require('bunyan')
log = bunyan.createLogger
  name: 'buunyan'
  # stream: process.stdout
  # stream: process.stderr
  # stream: require("fs").createWriteStream 'nyan.log'
  # level: 'trace'
  streams:[
    level:"error"
    path: "./path.log"
  ,
    level:"trace"
    path: "./pathtrace.log"
  ,
    # ログローテーションも可能
    type: 'rotating-file',
    path: './rota.log',
    period: '1d',
    count: 3
  ]
  

# log.info 'hi'
# log.warn lang: 'fr', balbal:"valval", 'au revoir'

log.trace('trace log')
log.debug('debug log')

log.info('info log')
log.warn('warn\n log')
log.error('error log')
log.fatal('fatal log')

# [0...1000].forEach ->
#   log.info 'hi'
###


###
# y2j
y = require("yaml2json")
###

###
# WeakSet
key = {aa:"dondno"}
ws = new WeakSet()

console.log ws.has(key)
ws.add key

console.log ws.has(key)
console.log ws.has({})
###


###
# Weakmap
wm = new WeakMap()
aa={aa:"dfdf"}
wm.set(aa, "198")

console.log wm.get aa
console.log wm
for a,b of wm
  console.log a,b
###


###
exec = require('child_process').exec
exec "ping -c 3 yahoo.co.jp", (e, out, err) -> console.log new Buffer(out)
###



###
ping = require ("net-ping")

session = ping.createSession()

session.pingHost "yahoo.co.jp", (error, target)->
  if error
    console.log target + ": " + error.toString()
  else
    console.log target + ": Alive"
###

###
# ping
ping = require "ping"

Iconv = require('iconv').Iconv
sjis_utf8 = new Iconv('utf-8', 'shift-jis')

jschardet = require('jschardet');

console.time "ping"
ping.promise.probe "yahoo.co.jp"
.then (a)->
  console.log a
  require("fs").writeFileSync "aa.txt", a.output
  console.log jschardet.detect(a)
  console.log sjis_utf8.convert(new Buffer(a.output))
  console.timeEnd "ping"
###

###
# やっぱり規格倒れ
isNishimuku = (m)->
  switch m
    when 2,4,6,9,11
      true
    else
      false

isUruu = (y)-> ( ( y % 4 == 0 && y % 100 != 0) || y % 400 == 0)

wdCounter = ->
  cnt = 0
  return ->
    cnt = cnt + 1
    if cnt > 7
      cnt = 1
    
    return cnt

[2017..2017].forEach (y)->
  [1..12].forEach (m)->
    [1..31].forEach (d)->
      return if (m == 2 && d >= 29) && isUruu(y) == false
      return if d >= 31 && isNishimuku m
      
      date = y + "/" + ("0" + m).slice(-2) + "/" + ("0" + d).slice(-2)
      console.log date + "(" +  '日月火水木金土'[new Date(date).getDay()] + ")," +  new Date(date).getDay()
###


###
five = require('johnny-five')
board = new five.Board()
 
board.on 'ready', ->
  led = new five.Led(13)
  led.blink(500)
###

###
# 日本語reverse
full2half = (ch)->
  switch ch
    when "あ" then "a"
    when "い" then "i"
    when "う" then "u"
    when "え" then "e"
    when "お" then "o"
    when "か" then "ka"
    when "き" then "ki"
    when "く" then "ku"
    when "け" then "ke"
    when "こ" then "ko"
    when "さ" then "sa"
    when "し" then "si"
    when "す" then "su"
    when "せ" then "se"
    when "そ" then "so"
    when "た" then "ta"
    when "ち" then "ti"
    when "つ" then "tu"
    when "て" then "te"
    when "と" then "to"
    when "な" then "na"
    when "に" then "ni"
    when "ぬ" then "nu"
    when "ね" then "ne"
    when "の" then "no"
    when "は" then "ha"
    when "ひ" then "hi"
    when "ふ" then "hu"
    when "へ" then "he"
    when "ほ" then "ho"
    when "ま" then "ma"
    when "み" then "mi"
    when "む" then "mu"
    when "め" then "me"
    when "も" then "mo"
    when "や" then "ya"
    when "ゆ" then "yu"
    when "よ" then "yo"
    when "ゃ" then "ya"
    when "ゅ" then "yu"
    when "ょ" then "yo"
    when "ら" then "ra"
    when "り" then "ri"
    when "る" then "ru"
    when "れ" then "re"
    when "ろ" then "ro"
    when "わ" then "wa"
    when "ゐ" then "wi"
    when "ゑ" then "we"
    when "を" then "wo"
    when "が" then "ga"
    when "ぎ" then "gi"
    when "ぐ" then "gu"
    when "げ" then "ge"
    when "ご" then "go"
    when "ざ" then "za"
    when "じ" then "zi"
    when "ず" then "zu"
    when "ぜ" then "ze"
    when "ぞ" then "zo"
    when "だ" then "da"
    when "ぢ" then "di"
    when "づ" then "du"
    when "で" then "de"
    when "ど" then "do"
    when "ば" then "ba"
    when "び" then "bi"
    when "ぶ" then "bu"
    when "べ" then "be"
    when "ぼ" then "bo"
    when "ぱ" then "pa"
    when "ぴ" then "pi"
    when "ぷ" then "pu"
    when "ぺ" then "pe"
    when "ぽ" then "po"
    else ""

half2full = (ch)->
  switch ch
    when "a" then "あ"
    when "ka" then "か"
    when "sa" then "さ"
    else ""

rConvert = (str)->
  arrHalf = str.split("").map((i)-> full2half i)
  rHalf = arrHalf.join("").split("").reverse().join("")
  return  rHalf
  

str = "いいいしゃらぶす"
console.log rConvert str

###



###
c = require = "canvas"
i = c.Image
# conc = new i(200,200)
# ctx =  conc.getContext("2d")
###



###
# node-yaml
yaml = require 'node-yaml'

yaml.read './tmp.yml',
  encoding: 'utf8'
  schema: yaml.schema.defaultSafe,
  (err, data) ->
    if err
      throw err
    console.log data


yaml.readPromise './tmp.yml'
.then (data)->
  console.log data
  # yaml.write './ny2.yaml', data, 'utf8', (err) -> throw err if err
  yaml.writePromise './ny3.yaml', data
  .then ->
    console.log "done"
  .catch (e)->
    console.log "e1:",e
.catch (e)->
  console.log "e2:",e


data =
  "root":
    "foo": "foo"
    "bar": "bar"

yaml.write './ny.yaml', data, 'utf8', (err) -> throw err if err

console.log "kiteru"
data = """
  foo: foo
  bar: bar
"""

console.log yaml.parse(data).foo

datam =
  root:
    foo: "foo"
    bar: "bar"

console.log yaml.dump datam
###



###
# yamljs
Yaml = require("yamljs")

console.log Yaml.parseFile("./tmp.yml")
console.log Yaml.parse require("fs").readFileSync("./tmp.yml").toString()

require("fs").readFile "./tmp.yml", (e,d)->
  # console.log d.toString()
  y = Yaml.parse d.toString()
  console.log y
  console.log Yaml.stringify(y, 4)
  require("fs").writeFileSync "./test.yml", Yaml.stringify(y, 4)

Yaml.load "./tmp.yml", (res)->
  console.log res

###







###
# spooky2
Spooky = require('spooky')

spooky = new Spooky
  child:
    transport: 'http'
    command: "./node_modules/casperjs/bin/casperjs"
  , (e)->
    if e?
      console.log "e:",e
    else
      console.log "dooo"    
      spooky.start 'https://qiita.com/', ->
        console.log "done"
      
      console.log "doooo2"
      spooky.then ->
        console.log "done"
        # @emit 'p', @getTitle()
      
      console.log "d00003"
      spooky.run()

spooky.on 'p', (msg)-> console.log msg
spooky.on 'error', (msg)-> console.log msg
###

###
# casper
Spooky = require('spooky')

spooky = new Spooky
  child:
    command: "./node_modules/casperjs/bin/casperjs"
    transport: 'http'
  casper:
    logLevel: 'error'
    verbose: true
    waitTimeout : 3000
  , (e)->
    if e?
      console.log "e:", e
    
    spooky.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36 ')
    spooky.start "http://www.yahoo.co.jp", ->
      this.evaluate (searchTxt)->
        document.querySelector('#srchtxt').value = searchTxt
        document.querySelector("#srchbtn").click()
      , "cspark"
    
    spooky.on 'complete', (a,b)->
      console.log a,b
    
    spooky.on 'error', (a,b)->
      console.log "error:", a,b
    
    
    spooky.then ->
      text = this.evaluate ->
        return __utils__.getElementByXPath('//*[@id="WS2m"]/div[1]/div[1]/h3/a').innerHTML
      
      this.emit('complete',text)
    
    spooky.run()
###




###
ws = require "webshot"

# console.log require("phantomjs").path
ws 'http://localhost:3000/spa', 'lh.png',
  windowSize: {width : 200 , height: 100}
  # phantomPath: require("phantomjs").path
  # phantomPath: "C:\gh\nt\node_modules\phantomjs\lib\phantom\bin\phantomjs.exe"
  # phantomPath: "C:\Program Files\phantomjs-2.1.1-windows\bin\phantomjs.exe"
  defaultWhiteBackground: true
  # renderDelay: 10000
  , (e)->
    if e?
      console.log "e:", e
    else
      console.log "done"
###



###
# phatntom 3
phantom= require 'phantom'

ph = null
page = null
phantom.create()
  .then (i)->
    ph = i
    ph.outputEncoding = 'utf8' 
    i.createPage()
  .then (p)-> 
    page = p
    page.viewportSize = {width : 200 , height: 100}
    page.clipRect = {
      left: 456,
      top: 123,
      width : 201,
      height: 101}
    page.open 'http://localhost:3000/spa'
    # page.open 'http://github.com/'
  .then (s)->
    console.log s
    setTimeout ->
      page.render("gc01.png")
      ph.exit()
    , 5000
  .catch (e)->
    console.log "e:", e
    ph.exit()
###




###
# phatntom 2
phantom= require 'phantom'

ph = null
page = null
phantom.create()
  .then (i)->
    ph = i
    i.createPage()
  .then (p)-> 
    page = p
    page.viewportSize = width : 200 , height: 100
    page.open 'http://github.com/'
  .then (s)->
    console.log s
    page.render("gp3.png", width : 200 , height: 100)
    ph.exit()
  .catch (e)->
    console.log "e:", e
    ph.exit()
###


###
# phatntom 1
phantom= require 'phantom'

ph = null
page = null
phantom.create()
  .then (i)->
    ph = i
    i.createPage()
  .then (p)-> 
    page = p
    p.open 'http://github.com/'
  .then (s)->
    if s == "success"
      console.log "done"
      page.render("gp.png")
    else
      throw new Error("error")
    ph.exit()
  .catch (e)->
    console.log "e:", e
    ph.exit()
###

###
require('webpage') 'http://github.com/', (a,b)->
  console.log a,b
  # page.render('github.png')
  # phantomjs.exit();
###


###
ws = require "webshot"

hardcopy = (url, name, option)-> new Promise (f,r)->
  # ws url, name + ".png", siteType:'html', (e)->
  ws url, name + ".png", option, (e)->
    if e?
      console.log "e",e
      r e
    else 
     f "done"

hardcopy "http://localhost:3000/spa", "spa", 
  screenSize: { width: 320, height: 480}
  shotSize: { width: 320, height: 'all'}
  defaultWhiteBackground: true
  renderDelay: 7000
  onLoadFinished: -> console.log "finnn"
.then (v)-> console.log "v:",v
.catch (e)-> console.log "e:",e
###


###
# なぜか画像サイズが小さい
rs = ws "http://localhost:3000/spa"
file = require("fs").createWriteStream 'spaspa.png', encoding: 'binary'
rs.on 'data', (data)-> file.write(data.toString('binary'), 'binary')
###

###
hardcopy "http://localhost:3000/spa", "spa"
.then (v)-> console.log "v:",v
.catch (e)-> console.log "e:",e
###

###
hardcopy "google.com", "test"
.then (v)-> console.log "v:",v
.catch (e)-> console.log "e:",e
###

###
html = "<html><body>Hell World</body></html>"
hardcopy html, "html"
.then (v)-> console.log "v:",v
.catch (e)-> console.log "e:"
###


###
fs = require "fs"

kakikomi = (msg)-> new Promise (f, r)->
  fs.appendFile "xidy.csv", msg, (e)->
    if e?
      console.log e
      r e
    else
      f()

require("co") ->
  yield kakikomi "件数" + "," + "バイト" + "," + "CU" + "\r\n"
  yield kakikomi "untarakanntara" + "\r\n"
  yield kakikomi "untarakanntara" + "\r\n"
  yield kakikomi "untarakanntara" + "\r\n"
  yield kakikomi "untarakanntara" + "\r\n"
###


###
# async NG
Main = async ->
  console.log("a");
  await new Promise (resolve)=> setTimeout(resolve,2000)
  console.log("b");
  await new Promise (resolve)=> setTimeout(resolve,1000)
  console.log("c");

Main()
###


###
# async(koa内部でも使えそう)
Main = (g)->
  p = g.next()
  return if(p.done)
  p.value.then =>
    Main(g)

Gen = ->
  console.log "a"
  
  yield new Promise (resolve)=>
    setTimeout(resolve,2000)
  
  console.log "b"
  
  yield new Promise (resolve)=>
    setTimeout(resolve,1000)
     
  console.log "c"

Main Gen()
###



###
xml2js = require "xml2js"

xml = """
"""

ps = xml2js.parseString
ps xml, (e,d)->
  console.log d.entry.content[0].$.src
  console.log d.entry.content[0].$.thumbnail
###




###
text = """
ichitanokuta  
nisannmyaku
sansannogai
shi
go
"""
console.log text.split("\n")[0].trim()
console.log text.split("\n")[1..2]
console.log text.split("\n")[1...2]
# console.log text.split("\n")[1..].join("\n")
###



###
# atompub
rtend = ""
username = ""
password = ""

wsse = require 'wsse'
xml2js = require 'xml2js'

token = new wsse.UsernameToken "username":username, "password": password
header =
  'Authorization': 'WSSE profile="UsernameToken"'
  'X-WSSE': token.getWSSEHeader(nonceBase64: true)
  "Content-Type": "image/jpeg"



require("request").post
  uri: rtend + "/image"
  body: new Buffer("00")
  headers: header
  , (e,r,b)->
    if e?
      console.log "e:",e
    else
      console.log "b:",b
###








###
'X-WSSE': 'UsernameToken ' \
  + 'Username="' + token.getUsername() + '", ' \
  + 'PasswordDigest="' + token.getPasswordDigest() + '", ' \
  + 'Nonce="' + token.getNonceBase64() + '", ' \  
  + 'Created="' + token.getCreated() + '"'
###







###


# console.log header
# console.log token.getWSSEHeader(nonceBase64: true)

param = {}
param.title = "test"
param.content = "ctest"
param.updated = new Date()

builder = new xml2js.Builder(rootName : "entry")
xml = builder.buildObject param
console.log xml

require("request").post
  uri: rtend + "/article"
  body: xml
  headers: header
  , (e,r,b)->
    if e?
      console.log "e:",e
    else
      console.log "b:",b
###





###
# i = 100000000000000000
# i = 8639977849199000
# i = 8639977849099000
# i = 8639997849199000
i = 8639999999699000
while true
  console.log "dat", i, Date.parse(new Date(i))
  # console.log typeof Date.parse(i)
  if isNaN(Date.parse(new Date(i)))
    break
  
  i++

console.log i
###






###
# node-canvas
Canvas = require "canvas"
i = Canvas.Image
c = new Canvas(200,200)
ctx = c.getContext('2d')

ctx.font = '30px Impact'
ctx.rotate(.1)
ctx.fillText("Awesome!", 50, 100)

te = ctx.measureText('Awesome!')
ctx.strokeStyle = 'rgba(0,0,0,0.5)'
ctx.beginPath()
ctx.lineTo(50, 102)
ctx.lineTo(50 + te.width, 102)
ctx.stroke()

console.log c.toDataURL()
###




###
pg = require "pg"

createClient = -> new Promise (f,r)->
  cli = new pg.Client "postgres://localhost/postgres"
  
  cli.connect (e)->
    if e?
      console.log "createClient", e
      r e
    else
      f cli

query = (sql)-> new Promise (f,r)->
  createClient()
  .then (cli)->
    cli.query sql, (e,res)->
      if e?
        console.log "query", e
        r e
      else
        cli.end (e)->
          if e?
            console.log "query:end", e
        
        f res.rows
  .catch (e)->
    r e

query """
  SELECT NOW() AS "theTime"
"""
.then (v)->
  console.log v[0].theTime
.catch (e)->
  console.error 'error running query'
###


###
# cron
cj = require("cron").CronJob

new cj
  cronTime: "* * * * *"
  onTick: ->
    console.log "tiiiick", new Date()
  start: true
  timeZone: "Asia/Tokyo"

new cj
  cronTime: "* * * * *"
  onTick: ->
    console.log "tznasi", new Date()
  start: true

new cj
  cronTime: "* * * * *"
  onTick: ->
    console.log "suta--tonasi"

# new require("cron").CronJob({cronTime: "* * * * *", start: true, onTick: (-> console.log("riki"))})

# new cron({cronTime: "* * * * *", start: true, onTick: (-> console.log("jitu"))})
###


###
# botkit
botkit = require("botkit").slackbot()
bot = botkit.spawn(token:"ng").startRTM (e,b,p)->
  if e?
    console.log "eee",e


botkit.hears ["testreq"], ["direct_message","direct_mention","mention"], (bot,message) ->
  bot.reply(message, 'testres')
###




###
# ファイル名文字列ぬきだす
#  0123456789012345678901234567890
# "/23/12323/1 2 323/file.jpaa"
p = "/23/12323/1 2 323/file.jpaa"

# 最後のスラッシュと最後のドットの位置を割り出しスライス
console.log p.slice p.lastIndexOf("/")+1,p.lastIndexOf(".")
###



###
# 2016 12 31 23 59 59 日付はこのようにわたってくる
param = "20161232235959"

# 文字列をSQL用に変換
convertSqlDatetime = (queryDate)->
  year = queryDate[0..3]
  month = queryDate[4..5]
  day = queryDate[6..7]
  hour = queryDate[8..9]
  minite = queryDate[10..11]
  second = queryDate[12..13]
  "#{year}-#{month}-#{day} #{hour}:#{minite}:#{second}"


# エポック秒をAPI形式に変換
epoch2apidate = (d)->
  # console.log d
  d.getFullYear() \
   + ("0" + (d.getMonth() + 1)).slice(-2) \
   + ("0" + d.getDate()).slice(-2) \
   + ("0" + d.getHours()).slice(-2) \
   + ("0" + d.getMinutes()).slice(-2) \
   + ("0" + d.getSeconds()).slice(-2)

# パース可能になる
sql = convertSqlDatetime param
console.log "sql:", sql
console.log "date parse sql:", Date.parse sql

# もとにもどす
api1 = epoch2apidate new Date(Date.parse(sql))
console.log "apipd:", api1

api2 = epoch2apidate new Date(sql)
console.log "api:", api2
###


###
# 関数言語的なIF式
a = 2
ihu =
  if a == 1
    "truee"
  else
    "falseee"

console.log ihu
###


###
# 配列をsplitして空文字があるか判定する
strArr = "asdfsa,a,asdffa,adf,asd,,fsda,asd,asdffe"
arr = strArr.split ","

console.log arr


# 一部空？→true
console.log arr.some (i)-> i == ""

# 全部空？→false
console.log arr.every (i)-> i == ""

# 一部空でない？→true
console.log arr.some (i)-> i != ""

# 全部空でない？→false
console.log arr.every (i)-> i != ""

# 正常系
strArr2 = "asdfsa,a,asdffa,adf,asd,fsda,asd,asdffe"
arr2 = strArr2.split ","
console.log arr2

# 一部空？→false→○空があるかどうかチェック(採用)
console.log arr2.some (i)-> i == ""

# 全部空？→false→×これだとダメ。値があったらfalse
console.log arr2.every (i)-> i == ""

# 一部空でない？→true→×値が入っていたらtrueに
console.log arr2.some (i)-> i != ""

# 全部空でない？→true→○空がないかどうかチェック
console.log arr2.every (i)-> i != ""
###




###
createHash = (src) ->
  md5 =  require("crypto").createHash 'SHA256'
  md5.update src, 'utf8'
  # md5.digest('hex').substr(5,5).toUpperCase()
  md5.digest('hex').toUpperCase()


h = createHash "aaa"

console.log new Buffer(h, "hex")
console.log h
console.log "length", h.length
console.log h.substr(5,5)
console.log h[6]
console.log h[8]
console.log h[0]
console.log h[63]

hash = ""

b = new Buffer(h, "hex")
b.forEach (i)->
  hash += i.toString(16)
console.log hash
###


###
i = 64
j = 0
for i in [63..0].filter((j)->j%2==0)
  # console.log i
  console.log h[i]
  if h[i] == "0"
    console.log i,"ばんめゼロです"
    h = h
###



###
# idなしなどのn番目の特定タグのテキストを取得
# urlをハッシュ化してキーとする
# 変更される値を保持。比較して変更を抽出
# 保持した値に日付を持ち前回更新日としてタグ付けする
# 同じものを抽出するもuri毎にによってロジックをcase分けできるようにする

# 格納するデータは urihash, 更新日付, tagのロケート

http = require "http"
cheerio = require "cheerio"
d = require("dirty")("d.log")

getHash = (src)-> 
  cry = require("crypto").createHash 'SHA256'
  cry.update src, "utf8"
  cry.digest 'hex'

epoch2date = (d)->
  # console.log d
  d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2) + " " \
   + ("0" + d.getHours()).slice(-2) + ":" \
   + ("0" + d.getMinutes()).slice(-2)  + ":" \
   + ("0" + d.getSeconds()).slice(-2)


url_hash = getHash url

http.get(url).on 'response',(res)->
  # res.setEncoding("utf8")
  console.log res.statusCode
  
  buff = ""
  res.on 'data', (d)->
    buff += d
  
  res.on "end",->
    scr = cheerio.load buff
    
    # console.log scr.html()
    console.log scr("title").eq(0).text()
    # console.log scr("th").eq(0).text()
    require("fs").writeFileSync "dump_sjis.txt", scr("title").eq(0).text(), {encoding: "sjis"}
    
    # console.log scr("body").get()
    # console.log scr("body").get()[0].children[1].children[0].data
    
    # target = scr("body").get()[0].children[1].children[0].data
    
###

###
# string reverse2
console.log "abcd".split("").reverse().join("")
###


###
# string reverse
rev01 = (s)->
  rv = []
  for i in[0..s.length]
    rv[i] = s[s.length - i - 1]

  return rv.join("")

console.log rev01 ""
###


###
url = "http://localhost:3000"
url_hash = getHash url

http.get(url).on 'response',(res)->
  res.setEncoding("utf8")
  console.log res.statusCode
  
  buff = ""
  res.on 'data', (d)->
    buff += d
  
  res.on "end",->
    scr = cheerio.load buff
    
    console.log scr.html()
    console.log scr("body").eq(0).text()
    console.log scr("body").get()
    console.log scr("body").get()[0].children[1].children[0].data
    
    target = scr("body").get()[0].children[1].children[0].data
    
    if d.get(url_hash).value == target
      console.log "同じだった"
      
    else
      console.log "ちがった"
      d.set url_hash,
        value: target
        update: new Date().getTime()
    
    
    # console.log $("result").eq(0).text()
    # console.log $("result").get().length
    # console.log $("message").is("message")
    # console.log $("tracks").find("result").text()
    # console.log $("tracks").find("result").eq(0).text()
    # console.log $("tracks").find("result").eq(1).text()
    
    $("tracks").find("result").each (i,el)->
      console.log $(this).text()
      if $(this).text() is "success"
        console.log $(this).parent().find("code").is("code")
        console.log $(this).parent().find("message").is("message")
        console.log $(this).parent().find("id").is("id")
        console.log $(this).parent().find("undelivery").is("undelivery")
        console.log $(this).parent().find("type").is("type")
        console.log $(this).parent().find("title").is("title")
        console.log $(this).parent().find("display_artist_name").is("display_artist_name")
        console.log $(this).parent().find("recochoku_artist_name").is("recochoku_artist_name")
        console.log $(this).parent().find("recochoku_artist_id").is("recochoku_artist_id")
        console.log $(this).parent().find("exceptional_artist").is("exceptional_artist")
        console.log $(this).parent().find("music_name").is("music_name")
        console.log $(this).parent().find("mg_music_id").is("mg_music_id")
        console.log $(this).parent().find("company_cd").is("company_cd")
        console.log $(this).parent().find("company_name_short").is("company_name_short")
        console.log $(this).parent().find("trial_public").is("trial_public")
        console.log $(this).parent().find("md_artist_ids").is("md_artist_ids")
        console.log $(this).parent().find("md_artist_id").is("md_artist_id")
      else if $(this).text() is  "failure"
        console.log $(this).parent().find("code").is("code")
        console.log $(this).parent().find("message").is("message")
        console.log $(this).parent().find("id").is("id")
        console.log $(this).parent().find("undelivery").is("undelivery")
        console.log $(this).parent().find("type").is("type")
        console.log $(this).parent().find("title").is("title")
        console.log $(this).parent().find("display_artist_name").is("display_artist_name")
        console.log $(this).parent().find("recochoku_artist_name").is("recochoku_artist_name")
        console.log $(this).parent().find("recochoku_artist_id").is("recochoku_artist_id")
        console.log $(this).parent().find("exceptional_artist").is("exceptional_artist")
        console.log $(this).parent().find("music_name").is("music_name")
        console.log $(this).parent().find("mg_music_id").is("mg_music_id")
        console.log $(this).parent().find("company_cd").is("company_cd")
        console.log $(this).parent().find("company_name_short").is("company_name_short")
        console.log $(this).parent().find("trial_public").is("trial_public")
        console.log $(this).parent().find("md_artist_ids").is("md_artist_ids")
        console.log $(this).parent().find("md_artist_id").is("md_artist_id")
      else
        throw "reigai"


    # viewにわたすもの
    val = d.get(url_hash)
    console.log "前回更新日", epoch2date(new Date(parseInt(val.update)))

###




###
# 通常のコンソール出力はパイプに渡すと表示されない
console.log "logudesuyo"
console.error "era-desuyos"
###



###
bunyan = require('bunyan')
Elasticsearch = require('bunyan-elasticsearch')
esStream = new Elasticsearch
  indexPattern: '[logstash-]YYYY.MM.DD'
  type: 'logs'
  host: 'localhost:9200'

esStream.on 'error', (err)-> console.log('Elasticsearch Stream Error:', err.stack)

logger = bunyan.createLogger
  name: "hellbunyan"
  streams: [
    {stream: process.stdout},
    {stream: esStream}
  ],
  serializers: bunyan.stdSerializers


logger.info "dea\nth"
logger.error "hell"
logger.fatal "hell"
logger.info new Error("stta").stack
logger.info new Error("stta").stack.replace(/\r|\n/g,"")

# logger.info "ininininnnii"
# logger.error "era-desu"
###



###
# bunyan
b = require "bunyan"
l = b.createLogger name: "tmp"

l.info "dea\nth"
l.error "hell"
l.fatal "hell"
l.info new Error("stta").stack
l.info new Error("stta").stack.replace(/\r|\n/g,"")

# console.log "lolo"
# console.error "errr"
###




###
speakSlackBot = (msg)-> new Promise (f,r)->
  require("request").post
    uri: "slack.com"
    body: msg
    , (e,r,b)->
      console.log b
      f b

speakSlackBot "localから"
.then (v)-> console.log b
###


###
require("request").post
  uri: 'amazonaws.com/'
  json:
    title : "tukuru"
    body  : "nari"
    url   : "tongariiiii"
, (e,r,b)->
  console.log b
###


###
# requestの場合
require("request").post
  uri: 'http://localhost:9200/test/entry'
  json:
    title : "taitoru"
    body  : "nakami"
    url   : "https://noinio.oijoij"
, (e,r,b)->
  console.log b
###




###
require("request")
  uri: 'http://localhost:9200/test/entry/_search'
  json:
    query:
      text:
        body: "naka"
, (e,r,b)->
  console.log b.error.failed_shards
###



###
client = new require('elasticsearch').Client
  host: 'localhost:9200'
  log: 'trace'
###

###
client.index
  index: 'myindex'
  type: 'newtype'
  id: 3
  body:
    title: 'foo'
.then (v)-> console.log "v",v
###



###
# ng
client.get 'myindex', 'newtype',
  id: 3
.then (v)-> console.log "v",v._source.title
.catch (e)-> console.log "e",e
###

###
client.get
  index: 'myindex'
  type: 'newtype'
  id: 3
.then (v)-> console.log "v",v._source.title
###

###
client.cat.master()
client.cat.nodes()
client.cat.nodeattrs()
###


###
client.cat.nodes
  v: true
.then (v)-> console.log "v",v
.catch (e)-> console.log "e",e
###

###
client.get
  local: false
  index: 'testindex'
  type: 'newtype'
  id: '1',
.then (v)-> console.log "v",v
.catch (e)-> console.log "e",e
###




###
client.exists
  index: 'testindex',
  type: 'newtype',
  id: '2',
.then (v)-> console.log "v",v
.catch (e)-> console.log "e",e
###


###
client.create
  index: 'testindex',
  type: 'newtype',
  id: '1',
  body:
    title: 'Test 1'
    tags: ['y', 'z']
    published: true
    published_at: '2013-01-01'
    counter: 1
.then (v)-> console.log v
.catch (e)-> console.log e
###



###
client.bulk
  body: [
    index:
      _index: 'myindex'
      _type: 'mytype'
      _id: 1
    title: 'foo'
    update:
      _index: 'myindex'
      _type: 'mytype'
      _id: 2
    doc:
      title: 'foo'
    delete:
      _index: 'myindex'
      _type: 'mytype'
      _id: 3
  ]
.then (v)-> console.log v
.catch (e)-> console.log e
###


###
client.search
  index: 'twitter'
  type: 'tweets',
  body:
    query:
      match:
        body: 'elasticsearch'
.then (resp) ->
  hits = resp.hits.hits
.catch (e)->
  console.log e
###

###
client.search
  q: 'pants'
.then  (body) ->
  hits = body.hits.hits
.catch (e)->
  console.log e.message
###


###
client.ping
  # ping usually has a 3000ms timeout
  requestTimeout: Infinity

  # undocumented params are appended to the query string
  hello: "elasticsearch!"
  , (e) ->
    if e
      console.log 'elasticsearch cluster is down!', e
    else
    console.log 'All is well'
###


###
a = []
# [0...1000000].forEach (i)->
for i in [0...1000000]
  # a.push i
  a[i] = i

console.timeEnd "tmp"
###

###
console.time "fe"
stm = require("through2")( (c,e,n)->
    # console.log c
    this.push c
    n()
  )


ws = require('fs').createWriteStream "aaa.txt", "utf-8"

ws.on "close", (d)->
  console.log "endddd"
  console.timeEnd "fe"

stm.pipe(ws)


j=""
# [0...1000000].forEach (i)->
for i in [0...10000000]
  stm.write new Buffer i.toString()

stm.end()
console.timeEnd "fe"
# console.log j
###


###
console.time "fe"
j=""
# [0...1000000].forEach (i)->
for i in [0...10000000]
  j += i
console.timeEnd "fe"
# console.log j

require('fs').writeFile 'death.txt', j, (err)->
  throw err if(err)
  console.timeEnd "fe"
###

###
console.time "fe"
j=0
# [0...1000000].forEach (i)->
for i in [0...100000000]
  j += i
console.timeEnd "fe"
###


###
# coはPromiseの配列を渡すだけで並列に回る
sleeper = (ms)->
  new Promise (f)->
    setTimeout (->
      console.log ms, "::end::"
      f()
    ), ms

co = require "co"

co ->
  console.log "1"
  console.timeEnd "tmp"
  yield sleeper(1000)
  console.log "2"
  console.timeEnd "tmp"
  yield sleeper(1000)
  console.log "3"
  console.timeEnd "tmp"
  yield [sleeper(1000),sleeper(1000),sleeper(1000)]
  console.log "4"
  console.timeEnd "tmp"
  yield [sleeper(2000),sleeper(3000),sleeper(4000)]
  console.log "5"
  console.timeEnd "tmp"
  yield sleeper(1000)
  console.log "6"
  console.timeEnd "tmp"
###




###
# naught
process.on "msg", (m)->
  console.log "kitayo", m

process.emit "msg", "okuri"

###


###
from = "201a0808103200"

console.log "length", from.length
fromYear = from[0..3]
fromMonth = from[4..5]
fromDay = from[6..7]
fromHour = from[8..9]
fromMinite = from[10..11]
fromSecond = from[12..13]

console.log fromYear
# console.log isNaN(fromYear)
console.log fromMonth
console.log fromDay
console.log fromHour
console.log fromMinite
console.log fromSecond
###



###
options =
  year: "2-digit"
  month: "2-digit"
  day: "2-digit"
  hour: "2-digit"
  minute: "2-digit"
  second: "2-digit"
  # timeZoneName: "short"


msPerDay = 24 * 60 * 60 * 1000
july172014 = new Date(msPerDay * (44 * 365 + 11 + 197))

console.log "msPerDay",msPerDay
console.log "july172014",july172014

americanDateTime = new Intl.DateTimeFormat("en-US", options).format
console.log "americanDateTime",americanDateTime()

console.log americanDateTime(july172014)
###

###
# sleepasync
sleep = (ms)-> new Promise (f)-> setTimeout (-> f()), ms

console.log "start"
console.timeEnd "tmp"
sleep(2000).then ->
  console.log "end"
  console.timeEnd "tmp"
###

###
# sleep
sleep = (ms)-> (done)-> setTimeout(done, ms)

console.log "start"
console.timeEnd "tmp"
sleep(2000)  ->
  console.log "end"
  console.timeEnd "tmp"
###

###
# speakslackbot
speakSlackBot = (msg)-> new Promise (f,r)->
  req = require("https").request
    host: "slack.com"
    path: "/"
    method: "POST"
    , (res)->
      res.on "data", (c)-> f c.toString()
  
  req.on "error", (e)-> r e
  req.write msg
  req.end()
###


###
# oxy
parse = require('koa-body')
require('koa')()
  .use(
    require('koa-body')(formidable: uploadDir: __dirname)
  
  )
  .use(->
    console.log @request
    console.log @request.body
    console.log process.env
    a= parse(@)
    console.log a()
    @body = yield ["hell" + @url]
  ).listen 3000
###


###
# sql文字列返す奴
findNantoke2 = (moid)->
  return """
    noi 
      soi
      soid
      moid = #{moid}
  """

findNantoke = (moid)->
  s = ""
  s += "noi "
  s += "  soi"
  s += "  soid"
  s += "  moid = " + moid
  return s

# console.log findNantoke "momomo"
console.log findNantoke2 "momomo"
###




###
# redisを使ってチェック2
# ローカルではもう限界
crypto = require("crypto")
uuid = require("node-uuid")
getHash = ->
  cry = crypto.createHash 'SHA256'
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'
l = require "lodash"

cluster = require "cluster"
if cluster.isMaster
  [0...2].forEach ->
    w = cluster.fork()
    
    w.on "message", (msg)->
      process.exit()
    
    w.on "exit", (a)->
      console.log "exitest", a
  
  # dbsizeもためす
  i = 0
  rc = require("co-redis")(require('redis').createClient())
  fs = require("fs")
  co = require("co")
  setInterval ->
    co ->
      cnt = yield rc.dbsize()
      i += 1
      console.log i, cnt
      fs.appendFile "redidb.csv", i + "," + cnt + "\r\n", (e)->
        console.log e if e?
  , 1000
  
  
  
else
  rc = require("co-redis")(require('redis').createClient())
  require("co") ->
    console.time "arr"
    i = 0
    # while i < 14800000
    while i < 20000000
      h = getHash().substr 0, 13
      
      console.log i if i % 100000 == 0
      console.timeEnd "arr" if i % 100000 == 0
      
      if yield rc.get h
        console.log i, "find"
        console.log yield rc.info "keyspace"
        process.send "found"
        break
      
      yield rc.set h, i
      i += 1
    
    console.timeEnd "arr"
    # yield rc.flushall()
    yield rc.quit()
    process.exit()
###




###
# カリー化
csum = (a)-> return (b) -> a + b

# おおもと
sum = (a,b)-> a + b

console.log sum 2,3
console.log csum(2)(3)
###



###
# redisを使ってチェック
rc = require("co-redis")(require('redis').createClient())
require("co") ->
  console.time "arr"
  i = 0
  # while i < 14800000
  while i < 20000000
    h = getHash().substr 0, 12
    
    console.log i if i % 100000 == 0
    console.timeEnd "arr" if i % 100000 == 0
    
    if yield rc.get h
      console.log i, "find"
      console.log yield rc.info "keyspace"
      break
    
    yield rc.set h, i
    i += 1
  
  console.timeEnd "arr"
  # yield rc.flushall()
  yield rc.quit()
###



###
rc = require("co-redis")(require('redis').createClient())
require("co") ->
  console.log yield rc.set "tetete", 3983
  console.log yield rc.get "tetete"
  # console.log yield rc.flush()
  # console.log yield rc.end()
  console.log yield rc.quit()
###


###
# クラスターでgethashを集める黒魔法
# 増やせば増やすほど重く
crypto = require("crypto")
uuid = require("node-uuid")
getHash = ->
  cry = crypto.createHash 'SHA256'
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'
l = require "lodash"

cluster = require "cluster"
if cluster.isMaster
  console.time "arr"
  arr = []
  warehouse = (item)->
    arr.push item
    console.log arr.length if arr.length % 10000 == 0
    # console.timeEnd "tmp" if arr.length % 1000 == 0
    if arr.length >= 100000
      console.log "end!!!!!!!"
      console.timeEnd "arr"
      process.exit()
  
  # 1:15秒 
  [0...3].forEach ->
    w = cluster.fork()
    w.on "message", (msg)->
      # console.log msg
      warehouse msg
    
    w.on "exit", ->
      console.log "exited", arr.length
    
    setTimeout ->
      w.send "death"
    , 120000
  
else
  process.on "message", (msg)->
    if msg == "death"
      console.log "memento"
      process.exit()
  
  i = 1
  while i <= 14800000
    # console.log process.pid
    process.send getHash()
    i += 1
###


###
# 結局UUIDは何文字まで信頼性が高いのか 2
# 9文字ではどうか→485451 'find'
crypto = require("crypto")
uuid = require("node-uuid")
getHash = ->
  cry = crypto.createHash 'SHA256'
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'

l = require "lodash"
arr = []
j = 0
while j < 2000
  i = 0
  while i < 14800000
    console.log j, i if i % 100000 == 0
    console.timeEnd "tmp" if i % 100000 == 0
    
    h = getHash().substr 0, 9
    
    if l.indexOf(arr, h) >= 0
      console.log j, i, "find"
      break
    
    arr.push h
    i += 1
  j += 1
###





###
# 作って検索 vs 全部作ってあとから検索
# 全部作って検索したほうが速いっぽい？
# 目的が違うので比較できない
crypto = require("crypto")
uuid = require("node-uuid")
getHash = ->
  cry = crypto.createHash 'SHA256'
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'

l = require "lodash"

i = 800000
m = 10

console.time "soku"
soku = []
s = 0
while s < i
  h = getHash().substr 0, m
  
  if l.indexOf(soku, h) >= 0
    console.log s, "sokufind"
    break
  
  soku.push h
  s += 1

console.timeEnd "soku"

console.time "atoo"
atoo = []

a = 0
while a < i
  h = getHash().substr 0, m
  atoo.push h
  
  a += 1

console.timeEnd "atoo"

n = 0
while n < atoo.length
  if l.indexOf(atoo, atoo[n]) >= 0
    console.log "atoofind"
    break
  
  n += 1

console.timeEnd "atoo"
###



###
# もうwhileでやるしかない
kensakutime = (arr)->
  console.time "for"
  for i in arr
    if i == "nothing"
      break
  console.timeEnd "for"

  console.time "in"
  if arr.indexOf("nothing") >= 0
    console.log "find"
  console.timeEnd "in"

  console.time "in2"
  arr.indexOf("nothing")
  console.timeEnd "in2"

  console.time "fi"
  arr.find((i)->i=="nothing")?
  console.timeEnd "fi"


  l = require "lodash"
  console.time "loin"
  l.indexOf(arr, "nothing")
  console.timeEnd "loin"

  console.time "lofi"
  l.find(arr,(i)->i=="nothing")?
  console.timeEnd "lofi"

  console.timeEnd "tmp"

console.time "arr"
arr = []
j = 0
while j < 2 # 二回目は耐えられないもよう
  i = 0
  while i < 14800000
    console.log j, i if i % 100000 == 0
    console.timeEnd "arr" if i % 100000 == 0
    arr.push getHash()
    i += 1
  
  kensakutime arr
###



###
console.time "arr"
arr = []

i = 0
# 14800000
while i < 14800000
  console.log i if i % 100000 == 0
  console.timeEnd "arr" if i % 100000 == 0
  arr.push getHash()
  i += 1

console.timeEnd "arr"

kensakutime arr
###

###
# catchできるかどうか→できない
i = 0
try
  # while i < 75197499
  while i < 76000000
    console.log i if i % 1 == 0 && i > 75197400
    arr.push i
    i += 1
catch e
  console.log "catch!", arr.length
  kensakutime arr

###

# [0...75000000].forEach (i)->
#   arr.push i

###
# 数字の境界は 75197498 と思ったら変動した
i = 0
while i < 75197499
  console.log i if i % 1 == 0 && i > 75197400
  arr.push i
  i += 1
###


###
# 結局UUIDは何文字まで信頼性が高いのか
# 8文字では2万行く前に重複する

# モジュールは先に読んだほうが速かった
crypto = require("crypto")
uuid = require("node-uuid")
getHash = ->
  cry = crypto.createHash 'SHA256'
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'

# 75200000万個生成を2000回して重複の有無のチェック
l = require "lodash"
arr = []
# for i in [0...75200000]
for j in [0...2000]
  # console.log j if j % 2 == 0
  for i in [0...75200000]
    console.log j, i if i % 10000000 == 0
    h = getHash().substr 0, 9
    if l.indexOf(arr, h) >= 0
      console.log j, i, "find"
      break
    
    arr.push h


# console.timeEnd "tmp"
###


###
# いくつまでリストできるか。何秒かかるか。2 ng
# まとめる処理で死んでしまう
console.time "tmp"

crypto = require("crypto")
uuid = require("node-uuid")
getHash = ->
  cry = crypto.createHash 'SHA256'
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'

console.time "arr"

Promise.resolve()
  .then ->
    # Promise.all [0.75200000].map (i)->
    Promise.all [0...1000000].map (i)->
      new Promise (f,r)->
        console.log i if i % 100000 == 0
        console.timeEnd "arr" if i % 100000 == 0
        f getHash()
  .then (arr)->
    # console.log arr
    console.timeEnd "arr"
    
    console.log "kensaku str"
    console.time "for"
    for i in arr
      if i == "nothing"
        break
    console.timeEnd "for"
    
    console.time "in"
    if arr.indexOf("nothing") >= 0
      console.log "find"
    console.timeEnd "in"
    
    console.time "in2"
    arr.indexOf("nothing")
    console.timeEnd "in2"
    
    console.time "fi"
    arr.find((i)->i=="nothing")?
    console.timeEnd "fi"
    
    
    l = require "lodash"
    console.time "loin"
    l.indexOf(arr, "nothing")
    console.timeEnd "loin"
    
    console.time "lofi"
    l.find(arr,(i)->i=="nothing")?
    console.timeEnd "lofi"
    
    console.timeEnd "tmp"

console.timeEnd "tmp"
###





###
# いくつまでリストできるか。何秒かかるか。
# lodashのindexOfの勝ち
console.time "tmp"
# 100000000はダメだった
crypto = require("crypto")
uuid = require("node-uuid")
getHash = ->
  cry = crypto.createHash 'SHA256'
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'

console.time "arr"
arr = []

# [0...75200000].forEach ->
#   arr.push getHash()

for i in [0...10000000]
  console.log i if i % 100000 == 0
  console.timeEnd "arr"  if i % 100000 == 0
  arr.push getHash()

console.log arr.length
console.timeEnd "arr"


console.time "for"
for i in arr
  if i == "nothing"
    break
console.timeEnd "for"

console.time "in"
if arr.indexOf("nothing") >= 0
  console.log "find"
console.timeEnd "in"

console.time "in2"
arr.indexOf("nothing")
console.timeEnd "in2"

console.time "fi"
arr.find((i)->i=="nothing")?
console.timeEnd "fi"


l = require "lodash"
console.time "loin"
l.indexOf(arr, "nothing")
console.timeEnd "loin"

console.time "lofi"
l.find(arr,(i)->i=="nothing")?
console.timeEnd "lofi"

console.timeEnd "tmp"
###


###
# 重複チェック for
a=[]
a.push "cc"
a.push "bb"
a.push "aa"
console.log "start"
for i in a
  if i == "bb"
    console.log "brea"
    break
  else
    console.log "cont"

console.log "end"
###



###
# 重複チェック lodash
l = require "lodash"
a=[]
a.push "aa"
console.log l.indexOf(a, "aa")
console.log l.indexOf(a, "bb")

console.log l.find(a,(i)->i=="aa")?
console.log l.find(a,(i)->i=="bb")?
###



###
# 重複チェック find
a=[]
a.push "aa"

console.log a.find((i)->i=="aa")?
console.log a.find((i)->i=="bb")?
###

###
# 重複チェック indexOf
a=[]
[0...3].forEach ->
  if a.indexOf("aa") >= 0
    console.log "t"
  else
    console.log "e"
  a.push "aa"
###


###
# 全角スペースもいける
a="as df"
console.log　 a.match　 /\　/
###


###
# parseして一行ごとのobjにしてくれる
nd = require "ndjson"
require("fs").createReadStream("t.json")
  .pipe(nd.parse())
  .on "data", (o)->
    console.log "================================"
    console.log o
    console.log "--------------------------------"
    
    # if o.date?.N?
    #   console.log o.date.N
###

###
# ndjsonに関する
nd = require "ndjson"
console.log nd.parse "asdf":12
###



###
n = "ye"

if (n == "no" || n == "nono") == false
  console.log "t"
else
  console.log "f"
###

###
# -Fオプション
parse = require('koa-body')
require('koa')()
  .use(
    require('koa-body')(formidable: uploadDir: __dirname)
  
  )
  .use(->
    console.log @request
    console.log @request.body
    a= parse(@)
    console.log a()
    @body = yield ["hell" + @url]
  ).listen 3000
###




###
tp = 1
pp =  999999
gp = 1000000

console.log (tp + pp) / gp
if (tp + pp) / gp >= 1
  console.log "OK"
else
  console.log "NG"
###


###
# 無言プロミス
fin = (o)-> new Promise (f, r)->
  console.log "naka"
  f ""

fin "noi"
###

###
# finally ない。NG
fin = (o)-> new Promise (f, r)->
  console.log "naka"
  f ""

fin "noi"
  .finally (v)->
    console.log "asdf", v
###



###
# cheerio-httpcliがよくわかってないので再習
ch = require "cheerio-httpcli"
ch.fetch 'http://www.google.com/search',
  q: 'node.js'
.then (v) ->
  console.log v.response.headers
  # console.log v.response
  console.log v.$('title').text()
  v.$('a').each (idx) ->
    # console.log $(this).attr('href')
.catch (e)-> console.log e
###


###
ch.fetch 'http://www.google.com/search',
  q: 'node.js'
  , (err, $, res) ->
    console.log res.headers
    console.log $('title').text()
    $('a').each (idx) ->
      # console.log $(this).attr('href')
###




###
# promiseの直列処理に於けるreduce2
list = [1,2,4,5,3]
list.reduce (p, i)->
  console.log "p", p
  console.log "i", i
  
  p.then (v)-> new Promise (f)->
    console.log "kokohairani", i
    setTimeout ->
      f "end"
    , 1000
, Promise.resolve()
.then (v)-> console.log "v", v
.catch (e)-> console.log "e", e
###


###
# promiseの直列処理に於けるreduce
list = [1,2,4,5,3]

list.reduce (m,p)->
  m.then (v)->new Promise (f,r)-> console.log "p"
  , Promise.resolve(1)
###



###
# child_process
w = require('child_process').fork "a.coffee"

w.on "message", (msg)->
  console.log "msg", msg
  console.timeEnd "tmp"
  

console.timeEnd "tmp"
# execはOSでの実行。forkはnodeの実行
###




###
# リスト処理内でいくつかエラーがあった場合の挙動
# リスト処理
randomer = -> if Math.floor(Math.random() * 1000) > 500 then true else !true
list = ["aa","bb","cc"]

Promise.all list.map (i)->
  new Promise (f,r)->
    setTimeout ->
      console.log "kos"
      if randomer()
        console.log "raise"
        throw new Error "asdf"
      
      if randomer()
        console.log "tt:", i
        f i + "done"
      else
        console.log "rr:", i
        r i + "reje"
    , Math.floor(Math.random() * 1000)
  .then (v)->
    console.log "kov", v
    v
  .catch (e)->
    console.log "koe", e
    e
.then (v)->
  # 個別の方の最後がリストとなる
  console.log "v:",v
.catch (e)->
  # rejectがきた瞬間にこちらに入る
  # 個別に返却した場合普通にエラーハンドリング
  console.log "e:",e
###


###
Promise.all arr
.then (v)->
  console.log v.length
  console.timeEnd "tmp"
.catch (e)-> console.log e

tadatukuru = (n)-> new Promise (f, r)->
  require("fs").mkdir n, (e)->
    console.log e.code if e?
    f "owata"
###



###
# OSコマンドの実行
exec = require('child_process').exec
exec "ls -l",
  encoding: "utf8"
  env: process.env
  ,(e,o,s)->
    if e?
      console.log e
    else
      console.log o
      console.log s
###

###
bun = require "./Bungu"

b = bun.Bungu
b.use()
console.log b.live

p = bun.pen
p.use()
console.log p.live

g = bun.gum
g.use()
console.log g.live
###





###
# リスコフの置換原則とTDD
class Bungu
  @live: false
  
  @use: ->
    console.log "naniyara"

class pen extends Bungu
  @use: ->
    console.log "this is"

class gum extends Bungu
  @live: true
  
  @use: ->
    console.log "gomgom"
###

###
b = new Bungu
b.use()
console.log b.live

p = new pen
p.use()
console.log p.live

g = new gum
g.use()
console.log g.live
###




###
# 最小サーバーkoa
require('koa')().use(->@body = yield ["hell" + @url]).listen 3000
###



###
# 存在確認しなくていいのではないか
tadatukuru = (n)-> new Promise (f, r)->
  require("fs").mkdir n, (e)->
    console.log e.code if e?
    f "owata"

require('koa')().use(->@body = yield tadatukuru("dtada")).listen 3000
###

###
tadatukuru = (n)-> new Promise (f, r)->
  console.timeEnd "tmp"
  require("fs").mkdir n, (e)->
    console.log e.code if e?
    console.timeEnd "tmp"
  console.log "owri"
  f "owata"

app = require('koa')()
app.use ->
  console.log "1"
  yield []
  console.log "2"
  @body = tadatukuru("dtada")


app.listen 3000
###



###
# promisifyの先にあるもの
tadatukuru = (n)-> new Promise (f, r)->
  console.timeEnd "tmp"
  require("fs").mkdir n, (e)->
    console.log e.code if e?
    console.timeEnd "tmp"
    f "owata"

console.log "start"
require("co") ->
  console.log "1"
  re = yield tadatukuru "tadaco"
  console.log "2"
  console.log re
  console.log "3"
.then (v)->
  console.log "v", v
.catch (e)->
  console.log "e", e

console.log "end"
###



###
# promisify
console.timeEnd "tmp"
# rは使わず
tadatukuru = (n)-> new Promise (f, r)->
  console.timeEnd "tmp"
  require("fs").mkdir n, (e)->
    console.log e.code if e?
    console.timeEnd "tmp"
    f()
console.timeEnd "tmp"
tadatukuru("tada").then ->
  console.log "ちゃんと終わった"
  console.timeEnd "tmp"
console.timeEnd "tmp"
###


###
# cb
console.timeEnd "tmp"
tadatukuru = (n, cb)-> require("fs").mkdir n, -> cb()
console.timeEnd "tmp"
tadatukuru "tada", ->
  console.log "ちゃんと終わった"
  console.timeEnd "tmp"
console.timeEnd "tmp"
###


###
# 投げっぱなしパターン
console.timeEnd "tmp"
tadatukuru = (n)-> require("fs").mkdir n, ->
console.timeEnd "tmp"
tadatukuru "tada"
console.timeEnd "tmp"
###



###
console.timeEnd "tmp"
require("fs").mkdir "siren", (a,b,c,d)->
  console.log "1",a,":",b,":",c,":",d
  require("fs").mkdir "siren", (a,b,c,d)->
    console.log "2",a,":",b,":",c,":",d
console.timeEnd "tmp"
require("fs").mkdir "siren", (a,b,c,d)->
  console.log "3",a,":",b,":",c,":",d
  require("fs").mkdir "siren", (a,b,c,d)->
    console.log "4",a,":",b,":",c,":",d
console.timeEnd "tmp"
###

###
# syncではエラーに
console.timeEnd "tmp"
require("fs").mkdirSync("siren")
console.timeEnd "tmp"
require("fs").mkdirSync("siren")
console.timeEnd "tmp"
###



###
# こう書くべきであった
# nulob
# a= "asdf"
# a= null
# a={b:2}
# a={}
# console.log a.b
# console.log a?.b
###


###
# passport
p = require "passport"
console.log p.authenticate()(statusCode:1)
###



###
get = -> new Promise (f, r)->
  console.log "re1"
  require("request") 'http://localhost:3000', (e, res)->
    if e?
      r res
    else
      f res

arr = []
[0...1000].forEach ->
  arr.push get().then (v)-> console.log v.statusCode

Promise.all arr
.then (v)->
  console.log v.length
  console.timeEnd "tmp"
.catch (e)-> console.log e
###



###
gun = (i)->
  if i < 1000
    console.log "i",i
    get()
      .then (v)->
        console.log v.statusCode
        gun i + 1
      .catch (e)-> console.log e
  else
    console.log "endne"
    console.timeEnd "tmp"

# gun 0
###

###
[0...1000].forEach ->
  get()
    .then (v)->
      console.log v.statusCode
      # gun i + 1
      console.timeEnd "tmp"
    .catch (e)-> console.log e
###


###
obj = {asdf:"asdlfkj"}
obj.jimae = process.versions
console.log obj
console.log JSON.stringify(obj)
console.log encodeURIComponent(JSON.stringify(obj))
###



###
# beacon
getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update require("node-uuid").v4(), "utf8"
  cry.digest 'hex'

require("bleacon").startAdvertising(getHash(), 0, 0, -59)
###


###
# 文字数の判定
a="abcde"
b="あいうえい"
c="あいeef"

console.log a.length
console.log b.length
console.log c.length

# 特殊文字でも一文字
# console.log d.length
###

###
# asc descの反転
li = [6,1,3,4,3,2,2,3,4,4,3]

narave = (desc=false)-> 
  k = if desc then -1 else 1
  return (a,b)->
    if a > b
      return 1 * k
    if a < b
      return -1 * k
    return 0

console.log li.sort narave()
console.log li.sort narave(true)

# というかreverseすればいいだけのこと
console.log li.sort(narave()).reverse()

a = li
console.log a
li.sort narave()
console.log a
# sortもreverseも破壊的メソッド
li.sort(narave()).reverse()
console.log a
###




###
# switchもとがない場合->エラーになる
switch nani
 when 1
   console.log "kkoko"
 else
   console.log "else"
###


###
# promisifyに於けるコールバックの挙動
randomer = -> if Math.floor(Math.random() * 1000) > 500 then true else !true

ranfan = (cb)->
  cb null, "normal" if randomer()
  cb new Error("eratta")

fun = -> new Promise (f,r)-> ranfan (e,d)->
  r e if e?
  f d

fun().then (v)->
  console.log "seijodu1", v
.catch (e)-> console.log "eraa1", e

# こんなのでもいける
fun2 = -> new Promise (f,r)-> ranfan (e,d)-> if e? then r e else f d

fun2().then (v)->
  console.log "seijodu2", v
.catch (e)-> console.log "eraa2", e
###



###
ranfan (e,d)->
  if e?
    console.log "era-desu", e
  else
    console.log "seijoudesu", d
###







###
pub = "true"

if (pub? && pub == "true") == false
  console.log "りだいれくと"
else
  console.log "ee"

bbb = null
console.log typeof bbb
###


###
d = require("dirty")("d.db")
# d.set "gugu", "jijioj" + Math.floor(Math.random() * 1000).toString()
# console.log d.get "gugu"
# d.rm "gugu"
d.set "gugu", [1,2,3,4]
###


###
# 条件によって処理しない
randomer = ->
  seed = Math.floor(Math.random() * 1000)
  if seed > 500 then true else !true

fun = -> new Promise (f,r)->
  console.log "fun done"
  f()

Promise.resolve(1)
  .then ->
    console.log "1"
    fun() if randomer()
  .then ->
    console.log "end"
###

###
# generator中のエラーの場合
randomer = ->
  seed = Math.floor(Math.random() * 1000)
  if seed > 500 then true else !true

# console.log randomer()
pro = -> new Promise (f)->
  console.log "pro"
  if randomer()
    f "pdone"
  else
    throw new Error()

# throw new Error()

fun = -> new Promise (f, r)->
  console.log "fun"
  if randomer()
    f "fdone"
  else
    throw new Error()
    r "fail"
    throw new Error()


pro()
  .then (v)-> console.log "pv",v
  .catch (e)-> console.log "pe",e
  
fun()
  .then (v)-> console.log "fv",v
  .catch (e)-> console.log "fe",e


require("co") ->
  pro()
  fun()
.then (v)-> console.log "v", v
.catch (e)-> console.log "e",e
###





###
# Promise.allの挙動チェック
p1 = new Promise (f)-> f 1
p2 = new Promise (f)-> f 2
p3 = new Promise (f)-> f 3


Promise.all [
  p1
    .then (v)->
      p3
  p2
]
.then (v)->
  console.log v
###



###
# if式
b = 1

a =
  if b == 1
    "ttt"
  else
    "fff"

console.log a
###

###
# Promise.all のエラーハンドリング2
p1 = new Promise (f)-> f 1
p2 = new Promise (f)->
  # throw new Error
  f 2

Promise.all [
  p1
  p2
]
  .then (v)-> console.log "v", v
  .catch (e)-> console.log "e", e.stack
###


###
# Promise.all のエラーハンドリング ng
Promise.all [
  new Promise (f,r)->
    r 4
    1.pop()
    f 1
      .then (v)->
        console.log "v1",v
        v
      .catch (e)->
        cosole.log "e1",e
        e
  new Promise (f)->
    throw new Error
    f 2
      .then (v)->
        console.log "v2",v
        v
      .catch (e)->
        cosole.log "e2",e
        e
]
.then (v)-> console.log "v",v
.catch (e)-> cosole.log "e",e
###

###
# spreadはない
Promise.all [
  new Promise (f)-> f 1
  new Promise (f)-> f 2
]
.spread (a,v)-> console.log "v",v
.catch (e)-> cosole.log "e",e
###



###
# 再帰的なロジックのpromisify4 reduce
rex = (list)-> new Promise (f,r)->
  f list.reduce (p,i)->
    p.then (v)-> new Promise (fu)->
      setTimeout ->
        console.log "v", v
        fu i + "done"
      , 1000
  , Promise.resolve()
  .then (v)->
    console.log "all", v
    f v
  .catch (e)-> console.log "uti", e

rex ["a","b"]
.then (v)->
  console.log "soto", v
.catch (e)-> console.log "soto", e
###



###
# reduce is?
[1,2,3].reduce (a,b)->
  console.log "=start="
  console.log "a", a
  console.log "b", b
  99
, 88
###

###
[1,2,3].reduceRight (a,b)->
  console.log "=start="
  console.log "a", a
  console.log "b", b
  ""
###


###
# req,resを渡さない3
# 並列で値の直列 よくないアイデア
req = {}
req.end = ->
  console.log "finish"

mod = (req)->
  d=""
  e=""
  f=""
  Promise.resolve(1)
    .then ->
      fun1()
    .then (a)->
      console.log "1", a
      d = a
      fun2()
    .then (b)->
      console.log "2", b
      e = b
      render()
    .then (c)->
      console.log "3", c
      f = c
      console.log "aaa", d,e,f
      req.end()
    .catch (e)-> console.log "e",e
  .then (v)->
    console.log "soto", v
  .catch (e)-> console.log "e",e

fun1 = (r)-> new Promise (f)->
  f "kicoichi"

fun2 = (r)-> new Promise (f)->
  f "senni"

render= (r)-> new Promise (f)->
  f "dpp"


# origin
mod req
###


###
# req,resを渡さない2
req = {}
req.end = ->
  console.log "finish"

mod = (req)->
  Promise.resolve(1)
    .then ->
      fun1()
    .then (hu,ku)->
      console.log hu[1]
      console.log hu[2]
      fun2()
      ""
    .then ->
      render()
    .then ->
      req.end()

fun1 = (r)-> new Promise (f)->
  f 1:"su", 2:"u"

fun2 = (r)-> new Promise (f)->
  f()

render= (r)-> new Promise (f)->
  f()


# origin
mod req
###


###
# req,resを渡さない
req = {}
req.end = ->
  console.log "finish"

mod = (req)->
  fun1 req

fun1 = (r)->
  fun2 r

fun2 = (r)->
  render r

render= (r)->
  r.end()

mod req
###




###
# promise chain -> coを使わないと難しいかも
p = ->
  console.log "a"
  # f "ppp"

Promise.resolve(1)
  .then p
  .then p
  .then p
###

###
# 再koa
app = require('koa')()

g = (n)->
  i = 0
  while i < 3
    console.log "kiteru"
    i += 1
    yield n

app.use (next)->
  start = new Date
  yield next
  ms = new Date - start
  console.log '%s %s - %s', @method, @url, ms

app.use g

# app.use ->
#   @body = 'Hello World'
#   yield []

render = -> new Promise (f)->
  f 'Hello World'

app.use ->
  @body = yield render()
  # yield render


app.listen 3000
###



###
# stream再度2
g = do->
  i = 0
  while i < 10
    i += 1
    yield i

rs = require('stream').Readable()
rs._read = ->
  y = g.next()
  @push y.value.toString() if !y.done

rs.pipe(process.stdout)
###


###
# stream再度
g = ->
  i = 0
  while i < 10
    i += 1
    yield i

Readable = require('stream').Readable
rs = Readable()
gg = g()

rs._read = ->
  setTimeout =>
    y = gg.next()
    # console.log y
    if !y.done
      @push y.value.toString()
  , 1000

rs.pipe(process.stdout)
###



###
# genとco
sync = -> new Promise (f,r)->
  f "syn"

console.log "1"
require("co")->
  console.log "2"
  i = 0
  while i < 3
    console.log "3", i
    yield [i]
    console.log "4"
    i += 1
  
  console.log "5"
###



###
console.log "s"
g = ->
  console.log "1"
  i = 0
  while i < 3
    console.log "2"
    i += 1
    yield i
  
  ""


console.log "4"
Readable = require('stream').Readable;
rs = Readable()
gg = g()

console.log "5"
rs._read = ->
  console.log "6"
  setTimeout =>
    console.log "7"
    c = gg.next().value
    console.log "ccc", c
    @push c.toString()
  , 100

console.log "8"
rs.pipe(process.stdout)
console.log "e"
###


###
# for of gen NG
g = ->
  console.log "1"
  i = 0
  while i < 3
    console.log "2"
    yield i
    console.log "3"
    i += 1

# console.log g().next()
console.log "a"
for a in g()
  console.log a.next()
console.log "b"
###


###
console.log "s"
f = require("co").wrap (v)->
  console.log "1"
  yield Promise.resolve v

console.log "3"
f(true)
.then (v)->
  console.log "4"
  console.log v

console.log "e"
###




###
# coはpromiseを返す
console.log "s"
require("co") ->
  console.log "1"
  re = yield Promise.resolve true
  console.log "2"
  re
  console.log "3"
.then (v)->
  console.log "v", v
.catch (e)->
  console.log "e", e

console.log "e"
###



###
sleep = (ms)-> (cb)-> setTimeout(cb, ms)

console.log "a"
sleep(10000) -> console.log "sdf"
console.log "b"
###


###
require("co") (fn)->
  console.log fn

console.log "1"
co = (fn)-> 
  console.log fn
  console.log "2"
  
  done = (val)->
    console.log "3"
    gen.next val
  
  console.log "4"
  gen = fn done
  
  console.log "5"
  gen.next()
  console.log "6"

console.log "7"

co (done)->
  console.log "4-s"
  console.log "4-1"
  val = yield setTimeout ->
    console.log "4-2"
    done("qq")
  , 500
  
  console.log "4-3"
  console.log 'val:', val
  
  console.log "4-e"
###



###
s = -> new Promise (f)-> f "p"
w = -> new Promise (f)->
  yield 1
  f 2

x = -> yield new Promise (f)->
  # yield 1
  f 2
y = -> yield 1
z = -> 1

require("co") ->
  console.log "a"
  # yy = y()
  # console.log yield yy.next()
  # console.log yield yy.next()
  # console.log yield [z()]
  # console.log yield x().next()
  console.log "b"
###




###
s = -> new Promise (f)-> f "p"
require("co") -> console.log yield s()
###


###
console.log "start"

s = ->
  console.log "1"
  new Promise (f)->
    console.log "2"
    f "p"

console.log "3"
require("co") ->
  console.log "4"
  console.log yield s()
  console.log yield s()
  console.log "5"

console.log "end"
###

###
# 142a6 35
console.log "1"

s = ->
  console.log "2"
  new Promise (f)->
    console.log "a"
    setTimeout ->
      console.log "3"
      f "p"
    ,100

console.log "4"

s().then (v)->
  console.log "5"
  console.log v

console.log "6"
###


###
# 14236 5
console.log "1"

s = ->
  console.log "2"
  new Promise (f)->
    console.log "3"
    f "p"

console.log "4"

s().then (v)->
  console.log "5"
  console.log v

console.log "6"
###


###
console.log "1"

require("co") ->
  console.log "a"
  setTimeout (-> ""), 100
  console.log "b"
  
console.log "2"
###



###
f = -> yield 1

console.log typeof f
console.log typeof f()
console.log typeof f().next()
###

###
# gen new しなくてもいける
console.log "1"
g = ->
  console.log "2"
  i = 0
  while i < 3
    console.log "3", i
    yield i
    console.log "4"
    i += 1
  
  console.log "5"

console.log "6"
a = g()
console.log "7"
console.log "nexco", a.next()
console.log "nexco", a.next()
console.log "nexco", a.next()
console.log "nexco", a.next()
console.log "nexco", a.next()
console.log "8"
###


###
var http = require('http');
var express = require("express");
var RED = require("node-red");

// Create an Express app
var app = express();

// Add a simple route for static content served from 'public'
app.use("/",express.static("public"));

// Create a server
var server = http.createServer(app);

// Create the settings object - see default settings.js file for other options
var settings = {
    httpAdminRoot:"/red",
    httpNodeRoot: "/api",
    userDir:"/home/nol/.nodered/",
    functionGlobalContext: { }    // enables global context
};

// Initialise the runtime with a server and settings
RED.init(server,settings);

// Serve the editor UI from /red
app.use(settings.httpAdminRoot,RED.httpAdmin);

// Serve the http nodes UI from /api
app.use(settings.httpNodeRoot,RED.httpNode);

server.listen(8000);

// Start the runtime
RED.start();
###





###
src = "asdf"

aa = if src? src then else "noi"

console.log aa
console.log src?
console.log src
console.log src? src
###



###
# cocat ng
cat = require "co-cat"
twice = (str)->
  console.log "str", str
  i = 0
  return (end)->
    console.log "q", i, str, end
    return "nanika" if end
    console.log "w", i, str, end
    return str if ++i < 3
    console.log "e", i, str, end

require("co") ->
  console.log "1"
  read = cat(twice('foo'), twice('bar'), twice('baz'))
  console.log "2"
  data = undefined
  
  console.log "a"
  while data = yield read()
    console.log "b"
    console.log data
###


###
rc = require("co-redis")(require('redis').createClient())
require("co") ->
  console.log yield rc.set "tetete", 3983
  console.log yield rc.get "tetete"
  console.log yield rc.end()
###

###
# 謎
gh = require "hash-stream"
gh "README.md", "sha256", (e,h)->
  if e?
    console.log e
  else 
    console.log h.toString("hex")
###





###
require("fs").readFile "66076821.mp4", (e,b)->
  if e?
    console.log e
  else
    console.log b
    console.log require("file-type") b
###



###
# promistream
rs = require("fs").createReadStream("deka.txt")
bl = require("byline").createStream(rs)

t = new require("stream").Transform()

t._transform = (c, e, cb)->
  # @push c
  cb(null, c)

bl.pipe(t).pipe(process.stdout)
###


###
t = new require("stream")
t._transform = (chunk, encoding, callback)->
  this.push chunk
  callback()

t._flush = (cb)->
  cb()

t.on = (cb)->
  console.log cb

t.once = (cb)->
  console.log cb

t.emit = (cb)->
  console.log cb

t.pipe = (cb)->
  console.log cb

t.write = (cb)->
  console.log cb

t.end = (cb)->
  console.log cb
###



###
# dataStrageからのpromisify3
mocDy = (d = [], next=true)-> new Promise (f,r)->
  setTimeout ->
    d.push "@"
    console.log "naibu", d
    
    if next
      # recursive
      # console.log "re"
      seed = Math.floor(Math.random() * 1000)
      
      nt = if seed > 200 then true else !true
      mocDy d, nt
        .then (v)->f v
    else
      # end
      # console.log "ed"
      f d
  , 1000

mocDy().then (d)->
  console.log "end", d
###






###
# promise reduce ng
arr = [1,3,5,3,2,4,3]

arr.reduce (p,i)->
  new Promise (f)->
    console.log "asdf", i
    f i
  .then (v)->
    console.log v
    v
.then (v)->
  console.log v
  v
###





###
# dataStrageからのpromisify2
mocDy = (d = [], next=true)-> new Promise (f,r)->
  setTimeout ->
    d.push "@"
    console.log "naibu", d
    
    if next
      # recursive
      # console.log "re"
      seed = Math.floor(Math.random() * 1000)
      
      nt = if seed > 200 then true else !true
      mocDy d, nt
        .then (v)->f v
    else
      # end
      # console.log "ed"
      f d
  , 1000

mocDy().then (d)->
  console.log "end", d
###





###
# dataStrageからのpromisify
mocDy = (cb, d = [], next=true)-> 
  setTimeout ->
    d.push "@"
    console.log "naibu", d
    
    if next
      # recursive
      seed = Math.floor(Math.random() * 1000)
      
      nt = if seed > 100 then true else !true
      mocDy cb, d, nt
    else
      # end
      cb d
  , 100

mocDy (d)->
  console.log "end", d
###


###
# AがあればA, なければB
con = asdf ? "jijiji"
console.log con
###


###
# 再帰的なロジックのpromisify3
rec = (list, d=[])-> new Promise (f,r)->
  if list.length != 0
    target = list.shift()
    setTimeout ->
      d.push target + "done" 
      
      rec list, d
        .then (v)->
          f v
    , 100
  else
    f d

rec ["a","b"]
.then (v)->
  console.log v

rex = (list)-> new Promise (f,r)->
  Promise.all list.map (i)->
    new Promise (f,r)->
      setTimeout ->
        setTimeout ->
          f i + "done"
        , 100
      , 1000
  .then (v)->
    # console.log v
    f v

rex ["a","b"]
.then (v)->
  console.log v
###



###
# 実は並列parallel
console.log "=start="

re = (i)-> new Promise (f,r)->
  cnt = Math.floor(Math.random() * 1000)
  # console.log "st", i, cnt
  setTimeout ->
    # console.log "ed", i, cnt
    f i.toString() + "done"
  , cnt

arr = [0...10]
# Promise.all arr.map (i)->
v = arr.map (i)->
  re(i).then (d)->
    console.timeEnd "tmp"
    # console.log "a", i
    Promise.resolve d
    console.log d
    return d
# .then (v)->
#   console.log v
#   console.timeEnd "tmp"

console.log v

console.log "=end="
###



###
# 再帰的なロジックのpromisify3 pre
rec = (list, d=[])-> new Promise (f,r)->
  if list.length != 0
    target = list.shift()
    setTimeout ->
      d.push target + "done" 
      
      rec list, d
        .then (v)->
          f v
    , 100
  else
    f d

rec ["a","b"]
.then (v)->
  console.log v
###


###
# 再帰的なロジックのpromisify2 非同期
stabScan = (i, cb)->
  console.log i
  cb "s", i+1


console.log "st"
rec = (n, d=[])-> new Promise (f,r)->
  stabScan n, (v,i)->
    d.push v
    
    console.log i
    console.log v
    if i < 10
      setTimeout ->
        rec i, d
          .then (q)->
            console.log "q", q
            f q
      ,100
    else
      console.log "enddd"
      f d

rec(0).then (d)->
  console.log "rec end"
  console.log d

console.log "ed"
###

###
# 再帰的なロジックのpromisify
console.log "st"
rec = (list, d=[])-> new Promise (f,r)->
  if list.length != 0
    t = list.shift()
    d.push t + 1
    
    rec list, d
      .then (v)-> f v
  else
    f d

rec([1,2,3]).then (d)->
  console.log "rec end"
  console.log d

console.log "ed"
###

###
rec = (list, cb, d=[])->
  if list.length != 0
    t = list.shift()
    d.push t + 1
    rec list, cb, d
  else
    cb d

rec [1,2,3], (d)->
  console.log d
###



###
# rx.Observable.fromPromise
bidiceAsync = -> new Promise (f,r)->
  i = Math.floor(Math.random() * 5)
  console.log i
  setTimeout ->
    if i > 0
      f "nanigasi" + i
    else
      # rejectを返すとそのまま止まる
      r "error"
  , Math.floor(Math.random() * 1000)

rx = require "rx"
rx.Observable.fromPromise bidiceAsync()
  .subscribe(
    (x)->
      console.log "xx",x
    , (e)->
      console.log "ee", e
    , ->
      console.log "c")
###


###
console.log "start"
co = require 'co'
views = require 'co-views'

render = views('.', map: html: 'jade')

tobi =
  name: 'tobi',
  species: 'ferret'

loki =
  name: 'loki',
  species: 'ferret'
 
luna =
  name: 'luna',
  species: 'cat'
 
co ->
  console.log "coですよ"
  
  # a = render 'index', user: tobi
  b = render 'index.jade', user: loki
  # c = render 'index.ejs', user: luna
  
  console.log "yieldの前ですよ"
  html = yield [ b]
  console.log "yieldの後ですよ"
  
  html = html.join ''
  console.log html

co()
console.log "end"
###








###
# 差異のあるDB返却2 平均値を求める
# a = [1,2,3,4,5,6]
# a = [1...1001]
# a = [1...700]
# a = [1..6]
# console.log a.reduce((a,b)->a+b) / a.length

farDb = -> new Promise (f)->
  i = Math.floor(Math.random() * 2000)
  # console.log i
  setTimeout ->
    f i
  , i


racer = -> new Promise (f)-> 
  arr = []
  [0...32].forEach ->
    arr.push farDb()
  
  Promise.race arr
  .then (v)->
    f v

cyc = (n)-> new Promise (f)-> 
  si = []
  [0...n].forEach ->
    si.push new Promise (f)->
      racer().then (v)->
        f v
  
  Promise.all si
  .then (v)->
    f v
  

cyc(2000).then (v)->
  # console.log v
  console.log v.reduce((a,b)->a+b) / v.length
###





###
# ng
a = []
n = [0...10]
avl = -> new Promise (f)->
  n.forEach ->
    Promise.race [
      farDb()
      farDb()
      ]
    .then (v)->
      console.log v
      # console.timeEnd "tmp"
      a.push v
  
  f a


console.log a
###


###
# 差異のあるDB返却 Promise.race
farDb = -> new Promise (f)->
  i = Math.floor(Math.random() * 600)
  console.log i
  setTimeout ->
    f "nanigasi" + i
  , i


# farDb().then (v)-> console.log v

Promise.race [
  farDb()
  farDb()
  ]
.then (v)->
  console.log v
  console.timeEnd "tmp"
###










###
# 平均がxだった場合のlength
# n = 2x-1
x = 10
console.log 2 * x - 1
###



###
# nまでの総数の平均を得る2
# 1足して割る
n = 1000
console.log (n + 1) /2
###

###
# nまでの総数の平均を得る
# 偶数の場合
even = (n)-> new Promise (f)->
  f (n/2 * (1+n)) / n

# even(6).then (d)-> console.log d

# 奇数の場合
odd = (n)-> new Promise (f)->
  f ((Math.floor(n/2) * (1+n)) + Math.ceil(n/2)) / n

# odd(6).then (d)-> console.log d
# odd(7).then (d)-> console.log d

# n = 1000
n = 19

if n % 2 == 0
  even(n).then (d)-> console.log d
else
  odd(n).then (d)-> console.log d
###


###
# bruebirdによるpromisify2
eo = {}
eo.sync = (cb)->
  cb null, "syn"

eo.async = (cb)->
  setTimeout ->
    cb null, "asyn"
  , 1000

bb = require "bluebird"
bb.promisifyAll eo


render = (d)->
 console.log d

i = Math.floor(Math.random() * 3)
console.log i
if i > 0
  eo.syncAsync().then (r)->
    render r
else
  eo.asyncAsync().then (r)->
    render r
###


###
# bruebirdによるpromisify
bb = require "bluebird"
fs = require "fs" 
bb.promisifyAll fs

# fs.readFileAsync("index.jade", "utf-8").then (v)-> console.log v
require("co") ->
  v = yield fs.readFileAsync("index.jade", "utf-8")

  console.log v
###


###
# 分岐させた結果のrenderと非同期同期処理の混合3
# co:これが一番スマートだがまだ使えない
sync = -> new Promise (f,r)->
  f "syn"

async = -> new Promise (f,r)->
  setTimeout ->
    f "asyn"
  , 1000


render = (d)->
  console.log d


i = Math.floor(Math.random() * 3)
console.log i
require("co") ->
  if i > 0
    render yield sync()
  else
    render yield async()
###


###
# 分岐させた結果のrenderと非同期同期処理の混合2
# promise化
sync = -> new Promise (f,r)->
  f "syn"

async = -> new Promise (f,r)->
  setTimeout ->
    f "asyn"
  , 1000


render = (d)->
 console.log d

# console.log sync()
# console.log async() ng


i = Math.floor(Math.random() * 3)
console.log i
if i > 0
  sync().then (r)->render r
else
  async().then (r)->render r
###


###
# 分岐させた結果のrenderと非同期同期処理の混合1
# 全部cbを定義:renderはまとまったがコールバック地獄である
sync = (cb)->
  cb "syn"

async = (cb)->
  setTimeout ->
    cb "asyn"
  , 1000


render = (d)->
 console.log d

i = Math.floor(Math.random() * 3)
console.log i
if i > 0
  sync (r)->
    render r
else
  async (r)->
    render r
###


###
# 分岐させた結果のrenderと非同期同期処理の混合0
# これでは処理は実現できるがrenderがバラバラに
sync = ->
  "syn"

async = ->
  setTimeout ->
    render "asyn"
  , 1000


render = (d)->
 console.log d

# console.log sync()
# console.log async() ng


i = Math.floor(Math.random() * 3)
console.log i
if i > 0
  r = sync()
  render r
else
  async()
###






###
# console.log(process.versions.v8)

vm = require "vm"

localVar = 'initial value'

vmResult = vm.runInThisContext 'localVar = "vm";'
console.log 'vmResult: ', vmResult
console.log 'localVar: ', localVar

evalResult = eval 'localVar = "eval";'
console.log 'evalResult: ', evalResult
console.log 'localVar: ', localVar
###


###
# coによるpromise直列処理2 直列はthenチェインでもいい
bidiceAsync = -> new Promise (f,r)->
  i = Math.floor(Math.random() * 5)
  console.log i
  setTimeout ->
    if i > 0
      f "nanigasi" + i
    else
      # rejectを返すとそのまま止まる
      r "error"
  , Math.floor(Math.random() * 1000)


require("co") ->
  res1 = yield bidiceAsync()
  res2 = yield bidiceAsync()
  res3 = yield bidiceAsync()
  res4 = yield bidiceAsync()
  
  console.log "result1:", res1
  console.log "result2:", res2
  console.log "result3:", res3
  console.log "result4:", res4
.catch (e)->
  # co下でcatch
  console.log "eeee", e
###


###
# coによるpromise直列処理
bidiceAsync = -> new Promise (f,r)->
  i = Math.floor(Math.random() * 3)
  console.log i
  setTimeout ->
    if i > 0
      f "nanigasi"
    else
      # rejectを返すとそのまま止まる
      r "error"
  , Math.floor(Math.random() * 1000)


require("co") ->
  res1 = yield bidiceAsync()
  
  console.log "result1:", res1
  
  if res1
    console.log "res1"
  
  if res1?
    console.log "存在する"
  
  
  if res1 == ""
    console.log "からである"
  
  if res1 != ""
    console.log "からでない"
  
  
  if res1 == null
    console.log "nullである"
  
  if res1 != null
    console.log "nullでない"
  
  if res1 == undefined
    console.log "未定義である"
  
  if res1 != undefined
    console.log "未定義でない"
  

###





###
# 下記をPromise化2 async
bidiceAsync = -> new Promise (f,r)->
  i = Math.floor(Math.random() * 3)
  console.log i
  setTimeout ->
    if i > 0
      f "nanigasi"
    else
      r "error"
  , Math.floor(Math.random() * 1000)


bidiceAsync()
  .then (d)->
    console.log "d", d
    bidiceAsync()
  .then (d)->
    console.log "d", d
    bidiceAsync()
  .catch (e)->
    console.log "erorr", e

Promise.all [
  bidiceAsync()
    .then (d)->
      console.log "1d", d
      d + "1"
    .catch (e)->
      console.log "1erorr", e
      e + "1"
  bidiceAsync()
    .then (d)->
      console.log "2d", d
      d + "2"
    .catch (e)->
      console.log "2erorr", e
      e + "2"
  bidiceAsync()
    .then (d)->
      console.log "3d", d
      d + "3"
    .catch (e)->
      console.log "3erorr", e
      e + "3"
  bidiceAsync()
    .then (d)->
      console.log "4d", d
      d + "4"
    .catch (e)->
      console.log "4erorr", e
      e + "4"
  bidiceAsync()
    .then (d)->
      console.log "5d", d
      d + "5"
    .catch (e)->
      console.log "5erorr", e
      e + "5"
]
.then (d)->
  console.log "all!", d
.catch (e)->
  console.log "allllerorr", e
###




###
# 下記をPromise化
bidice = -> new Promise (f,r)->
  if Math.floor(Math.random() * 2) == 0
    f "nanigasi"
  else
    r "error"


bidice()
  .then (d)->
    console.log "d", d
    bidice()
  .then (d)->
    console.log "d", d
    bidice()
  .catch (e)->
    console.log "erorr", e
###




###
# So genannte Callback -Hölle
bidice = (cb)->
  if Math.floor(Math.random() * 2) == 0
    cb "error", ""
  else
    cb null, "nanigasi"


bidice (e,d)->
  if e?
    console.log "erorr", e
  else
    console.log "d", d
    bidice (e,d)->
      if e?
        console.log "erorr", e
      else
        console.log "d", d
###




###
# 二分の一の分岐
if Math.floor(Math.random() * 2) == 0
  console.log "ttt"
else
  console.log "fff"
###



###
# promiseのチェイン4 非同期 NG
waka = (str)-> new Promise (f,r)->
  setTimeout ->
    console.log "waka", str
    f "wakakaka"
  ,1000

ne = (str)-> new Promise (f,r)->
  setTimeout ->
    console.log "mono", str
    f "voi"
  , 100

console.log "sdf"
waka("daiiti")
  .then (v)->
    setTimeout ->
      console.log "v", v
      return ne "nekusuko"
    , 1000
  .then (v)->
    setTimeout ->
      console.log "222", v
    , 100
  .catch (e)->
    console.log "e", e
###


###
# promiseのチェイン3 非同期
waka = (str)-> new Promise (f,r)->
  setTimeout ->
    console.log "waka", str
    f "wakakaka"
  ,1000

ne = (str)-> new Promise (f,r)->
  setTimeout ->
    console.log "mono", str
    f "voi"
  , 100

console.log "sdf"
waka("daiiti")
  .then (v)->
    console.log "v", v
    ne "nekusuko"
  .then (v)->
    console.log "222", v
  .catch (e)->
    console.log "e", e
###



###
# promiseのチェイン2
waka = (str)-> new Promise (f,r)->
  console.log "waka", str
  f "wakakaka"

ne = (str)-> new Promise (f,r)->
  console.log "mono", str
  f "voi"

console.log "sdf"
waka("daiiti")
  .then (v)->
    console.log "v", v
    ne "nekusuko"
  .then (v)->
    console.log "222", v
  .catch (e)->
    console.log "e", e
###

###
# promiseのチェイン
waka = (next)-> new Promise (f,r)->
  console.log "waka"
  f next("tugi")

ne = (str)-> new Promise (f,r)->
  console.log "mono", str
  f "voi"

console.log "sdf"
waka(ne)
  .then (v)->
    console.log "v", v
  .catch (e)->
    console.log "e", e
###




###
# promiseの連結
waka = (aaa)-> new Promise (f,r)->
  console.log "waka", aaa
  f mono(aaa + "tugi")

mono = (aaa)-> new Promise (f,r)->
  console.log "mono", aaa
  f "voi"


waka("renmnnn").then (v)->
  console.log "v", v
###




###
# promise化するfuncton
wakamono = (aaa)-> new Promise (f,r)->
  console.log aaa
  f "dondon"

wakamono("asoij")
  .then (v)->
    console.log "v", v
  .catch (e)->
    console.log "e", e

app = require("koa")()
app.use wakamono
# app.use ->
#   console.log yield wakamono("bobo")
#   console.log "done"

app.listen 3000
###




###
# array
app = require("koa")()

p = (v)->
  new Promise (f)->
    setTimeout ->
      console.log "siteru", v
      f "vin " + v
    , 500

vs =["efef","fef","feffee","dfd"]

app.use (n)->
  console.log "koma"
  # 同期の場合はここ
  ps = vs.map((n,i)-> "#{i}":p(n) )
  console.log "toma"
  # 非同期の場合はここ
  res = yield ps
  console.log "teru"
  
  @body = "result "
  @body += "add "
  console.log res
  res.forEach (i)=>
    console.log "kokohaatnoanoka"
    @body += "anibu "
    console.log i
    @body += i.toString()
  
  # @body += res.map (i)-> i
  #   .join()
  
  @body += "enndnd "
  console.log "end"
  

app.listen 3000
###



###
# thenable
p = (v)->
  new Promise (f, r)->
    # r new Error "dee end"
    f v + "wrapped"

onerror = (err) ->
  console.log "errr"
  console.log err
  console.log err.stack

doin = (u) ->
  return p(u).then (v)->
      return v
    .catch onerror

thena = (u)->
  return p u

app = require("koa")()

app.use (n)->
  console.log "kiteru"
  r = yield thena("thena")
  @body = "is " + r

app.listen 3000
###



###
# 通常のコールバック
ccbb = (num,cb)->
  setTimeout ->
    cb null, num * num
  , 500

# ccbb 3, (r)->console.log r

# ラップしてthunkに
ccbbt = (num)->
  (cb)-> ccbb num, cb

# ccbbt(3) (r)->console.log r

# gen
gengen = (num)->
  console.log "g"
  s = yield ccbbt num
  console.log "e"
  ss = yield ccbbt s
  console.log "n"
  yield ccbbt ss

app = require("koa")()

# thunkを使ったyield(deprecate)
app.use (n)->
  console.log "kiteru"
  # s = yield ccbbt(4)
  # genを出力するgen
  s = yield gengen(4)
  # yield [@body = "is "]
  @body = "is " + s

app.listen 3000
###



###
p = (v)->
  new Promise (f, r)->
    r new Error "dee end"
    # f v + "wrapped"

onerror = (err) ->
  console.log "errr"
  console.log err
  console.log err.stack

p("don")
  .then (v)->
    console.log v
  .catch onerror
###



###
app = require("koa")()
r = require('co-views')(".", map: html: 'jade')

app.use (n)->
  console.log "kiteru"
  @body = yield r "index.jade"

app.listen 3000
###



###
yi = (n)->
  console.log n
  i = 1
  console.log yield "bon"
  i++
  yield i
  i++
  yield "don"
  i++
  yield i
  i++
  yield 99
  i++
  console.log yield i
  ++i

console.log typeof yi()
console.log yi()

yy = yi(88)

console.log typeof yy
console.log yy

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
# 再yield
x = ->
  yield 0
  yield 1
  yield 2

gen = x() # generatorを生成
console.log gen.next()
console.log gen.next().value
console.log gen.next()
console.log gen.next()
###



###
cbhell_org = (str, cb)->
  console.log "a", str
  setTimeout ->
    console.log "b", str
    cb "back" + str
  , Math.floor(Math.random() * 5000)
  
  console.log "c", str

cbhell = require("co").wrap cbhell_org

require("co") ->
  console.log "1"
  yield cbhell "wan", (d)-> ei = d
  console.log "2"
  yield cbhell "tuu", (d)-> bi = d
  console.log "3"
  yield cbhell "suri", (d)-> si = d
  console.log "4"
  
  console.log "kitra"
  return ei + ":" + bi + ":" + si
  console.log "binbin"
.then (v)->
  console.log "ebd", v
###


###
require("co") ->
  console.log "st"
  arr = [1,2,3]
  a = yield arr.map (i)->
    console.log "yt"
    new Promise (f)-> f i
  
  console.log "et"
  yield a
.then (v)->
  console.log "ebd", v
###



###
cbhell = (str)->
  new Promise (f)->
    console.log "a", str
    setTimeout ->
      console.log "b", str
      f "back" + str
    , Math.floor(Math.random() * 5000)
    
    console.log "c", str
###


###
cbhell "ichi", (a)->
  # console.log a
  cbhell "ni", (b)->
    cbhell "san", (c)->
      console.log a,b,c
###


###
require("co") ->
  a =yield [
    ei: cbhell("wan")
    bi: cbhell "tuu"
    si: cbhell "suri"
  ]
  
  console.log "kitra"
  # return ei + ":" + bi + ":" + si
  return a
.then (v)->
  console.log "ebd", v
###


###
require("co") ->
  console.log "1"
  ei = yield cbhell("wan")
  console.log "2"
  bi = yield cbhell "tuu"
  console.log "3"
  si = yield cbhell "suri"
  console.log "4"
  
  console.log "kitra"
  return ei + ":" + bi + ":" + si
  console.log "binbin"
.then (v)->
  console.log "ebd", v
###



###
p1 = new Promise (f)->
  setTimeout ->
    console.log "owattenda1"
    f ("p1nari")
  , 1000

p2 = new Promise (f)->
  setTimeout ->
    console.log "owattenda2"
    f ("p2nari")
  , 10

require("co")( ->
  res = yield 
    a: p1
    b: Promise.resolve(1)
    c: Promise.resolve(2)
    d: Promise.resolve(3)
    e: p2
  
  console.log(res)
).catch(onerror)

# require("co")( ->
#   res = yield [
#     p1
#     Promise.resolve(1)
#     Promise.resolve(2)
#     Promise.resolve(3)
#     p2
#   ]
#   console.log(res)
# ).catch(onerror)


onerror = (err) -> console.log err.stack
###


###
# 再co
co = require("co")

console.log "s"

co ->
  console.log "a"
  yield [1]
  console.log "b"
  # return [2]
  yield [4]
  console.log "c"
  [3]
.then (v)->
  console.log "ebd", v


console.log "e"
###




###
app = require("koa")()

app.use ->
  console.log @request.url
  console.log @response.body
  console.log @body
  console.log @res.body
  console.log @response
  # console.log @res
  console.log @status
  yield [@body = "asdf"]
  console.log @response
  console.log @request
  # yield ->
  # yield =>
  # yield {}
  # yield []
  # yield new Promise (f)-> f()

app.listen 3000
###



###
# koaのcascading
app = require("koa")()

# x-response-time
app.use (next)->
  start = new Date
  console.log "1 response time s"
  yield next
  console.log "1 response time e"
  ms = new Date - start
  this.set('X-Response-Time', ms + 'ms')

# logger
app.use (next)->
  start = new Date
  console.log "2 logger s"
  yield next
  console.log "2 logger e"
  ms = new Date - start
  console.log this.method, this.url, ms

# response
app.use ->
  console.log "3 response s" 
  yield [this.body = 'Hell World']
  console.log "3 response e"

app.listen 3000
###


###
# expressのcascading
app = require("express")()

# 1. response time の記録モジュール
app.use (req, res, next)->
  start = new Date
  
  # resのheaderイベントを受け取り、startから現在時刻を引いた値を設定する。
  res.on "header", ->
    console.log "1ban"
    duration = new Date - start
    cosole.log duration
    res.setHeader('X-Response-Time', duration + 'ms')
  
  
  # res.on = (type, lintener)->
  #   console.log "this type is", type
  #   if type == "header"
  #     return this
  #   addListener.apply this, arguments
  
  console.log "1 response time s"
  next()
  console.log "1 response time e"
  console.log "1:", new Date - start

# 2. loggerモジュール
app.use (req, res, next)->
    start = new Date;
    
    res.on 'header', ->
      console.log "2ban"
      cosole.log duration
      duration = new Date - start
      console.log "2logger header event", req.method, req.url, duration
    
    # 次のモジュールに委譲 
    console.log "2 logger s"
    next()
    console.log "2 logger e"
    console.log "2:", new Date - start

# 3. response
app.use (req, res, next)->
  res.on "header", ->
    console.log "3ban"
    duration = new Date - start
    cosole.log duration
  
  console.log "3 response s"
  res.status(200).send("Hell World")
  console.log "3 response e"

app.listen 3000
###



###
epoch2date = (d)->
  # console.log d
  d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2) + " " \
   + ("0" + d.getHours()).slice(-2) + ":" \
   + ("0" + d.getMinutes()).slice(-2)  + ":" \
   + ("0" + d.getSeconds()).slice(-2)

ltime = []
ltime.push 1457403601325
ltime.push 1457410226404
ltime.push 1457410810955
ltime.push 1457840431074
ltime.push 1456735499648
ltime.push 1456319912090
ltime.push 1457410782969
ltime.push 1458614732951
ltime.push 1458020040629
ltime.push 1458021071130
ltime.push 1457710844621
ltime.push 1456734061563
ltime.push 1456735193147
ltime.push 1458020699776

ltime.sort()

ltime.forEach (i)->
  console.log epoch2date(new Date i)
###


###
a = require('koa')()

fs = require 'co-fs'

cofs = ->
  paths = yield fs.readdir('.')
  
  files = yield paths.map (path) ->
    return fs.readFile('co-view.js', 'utf8')
  
  this.type = 'co-view.js'
  this.body = files.join('')

a.use cofs

a.listen 3000, -> console.log "in"
###

###
a = require('koa')()

mw = (n)->
  console.log "aria"
  yield n

r = (n)->
  console.log "routen"
  yield n

ender = (n)->
  console.log "ender"
  # console.log @
  yield [@res.end("ender")]

a.use mw
a.use require("koa-route").get "/rrr" ,r
a.use ender

a.listen 3000, (a,b,c)->
  console.log "in"
###




###
a = require("connect")()

mw = (q,s,n)->
  console.log "aria"
  # console.log q
  # console.log s
  # console.log n
  n()

r = (q,s,n)->
  console.log "routen"
  n()

ender = (q,s,n)->
  console.log "ender"
  s.end "ender"

a.use mw
a.use "/rrr" ,r
a.use ender

a.listen 3000, (a,b,c)->
  console.log "in"
  console.log a
  console.log b
  console.log c
###



###
Aaa = "asdfef"
ABCD = "fefe"
console.log Aaa
console.log ABCD

Aaa = "change"
ABCD = "the rule"
console.log Aaa
console.log ABCD
###


###
a = require('koa')()

# a.use -> yield [@body="koa hell"]
a.use require("koa-route").get "/views", (next)->
  yield [@body = "bbb"]


a.use (next)->
  start = new Date
  console.log("1 response time")
  yield next
  console.log("1 response time")
  ms = new Date - start
  this.set('X-Response-Time', ms + 'ms')

a.use (next)->
  start = new Date
  console.log("2 logger")
  yield next
  console.log("2 logger") 
  ms = new Date - start
  console.log('%s %s - %s', this.method, this.url, ms)

a.use (next)->
  console.log("3 response") 
  yield [this.body = 'Hell logger']
  console.log("3 response")  



a.listen 3000
###


###
# koaに於けるエラーハンドリング2
a.use (n)->
  try
    yield n
  catch e
    @status = 500
    @body = e.message
    # errorイベント
    @app.emit "error", e, @

a.use (n)->
  if @url == "/_err"
    throw new Error "errrrrorror"
  
  yield n

a.on "error", (e)->
  console.log e
  console.log e.stack


a.listen 3000
###

###
# koaに於けるエラーハンドリング1
a.use (n)->
  try
    yield n
  catch e
    console.log e
    console.log e.stack
    @status = 500
    @body = e.message

a.use (n)->
  if @url == "/_err"
    throw new Error "sended error"
  
  yield n

a.listen 3000
###




###
# rangeを一件ずつ処理できるのか3
disposeRange = (list, cb, cnt=0)->
  if list.length != 0
    target = list.shift()
    # console.log target
    cnt = cnt + 1
    console.log cnt
    console.log cnt if cnt % 1000000 == 0
    setTimeout ->
      disposeRange list, cb, cnt
    ,0
  else
    cb cnt


list = [0...75200465]
console.log list.length
disposeRange list, (cnt)-> console.log "done:", cnt
###





###
# list = [0...75200465]
list = [0...2]
console.log list.length

stdt=new Date()
Promise.all list.map (i)->
  new Promise (f,r)->
    # console.log "start", i
    cnt = cnt + 1
    console.log cnt if cnt % 1000000 == 0
    console.log "end", i
    throw new Error("asdf")
    f i.toString() + ":" + (new Date() - stdt).toString()
.then (v)->
  console.log v
.catch (e)->
  console.log "erorroro"
  console.log e if e?
###



###
# rangeを一件ずつ処理できるのか2
list = [0...75200465] # 2016/03/16 18:14現在の閾値
cnt = 0
list.forEach (i)->
  cnt = cnt + 1

console.log cnt
###

###
# rangeを一件ずつ処理できるのか
disposeRange = (list, cb, cnt=0)->
  if list.length != 0
    target = list.shift()
    # console.log target
    cnt = cnt + 1
    console.log cnt if cnt % 1000000 == 0
    setTimeout ->
      disposeRange list, cb, cnt
    ,0
  else
    cb cnt


list = [0...75200465]
console.log list.length
disposeRange list, (cnt)-> console.log "done:", cnt
###



###
# rdsチェック2
s = require "sequelize"

c = new s "tmp", "root", "12121212",
  host: "localhost"
  dialect: "mariadb"


tm = c.define "tmp_table"

tm.sync()

tm.findAll(where: "_id":"niij"
  ).then (r)->
    console.log "kita"
    console.log r[0].dataValues
  , (e)->
    console.log e


console.log "end"
###




###
# rdsチェック
s = require "sequelize"

c = new s "tmp", "root", "12121212",
  host: "localhost"
  dialect: "mariadb"

tm = c.define "tmp_table",
  _id: s.STRING
  date: s.INTEGER
  nakami: s.STRING

tm.sync()

tm.findAll(where: "_id":"niij"
  ).then (r)->
    console.log "kita"
    console.log r[0].dataValues
  , (e)->
    console.log e


console.log "end"
###




###
Sequelize = require('sequelize')
sequelize = new Sequelize('tmp', 'root', '12121212')

User = sequelize.define('User', 
  username: Sequelize.STRING,
  birthday: Sequelize.DATE
)

sequelize.sync().then( ->
  User.create(
    username: 'sdepold',
    birthday: new Date(1986, 6, 28)
  ).then( (sdepold)->
    console.log(sdepold.values)
  )
)

###




###
Client = require "mariasql"

c = new Client(
      host:"localhost"
      user:"root"
      password:"12121212"
      db:"tmp"
    )

c.query "select * from tmp_table", (e,r)->
  if e?
    console.log e
  else
    console.log r
  
  c.end()
###


###
# tsvの操作
require("fs").readFile "tsv.tsv", (e,d)->
  console.log "================"
  console.log d.toString()
  d.toString().split("\r\n").map((i)->i.split("\t")).map((i)->i[2]).filter((i)->i!=undefined).forEach (i)->
    require("fs").appendFile "bon.txt", i+"\r\n", (e)->
      console.log e if e?

###


###
# 配列の中から該当のものを検出
a=["asdf","fefe","gaitou","fefe","asf","fefe"]

# console.log a

b={}
b.nanigasi = 
  name:"nnnn"
  name_en:"eee"
b.doiud = 
  name:"namaeee"
  name_en:"eigooo"

console.log b
###



###
# if式？
a = if 1==2
    "noi"
  else
    "elara"
console.log a
###



###
# 改行をなくす
tsv = ""
o = []
[0...10].forEach (i)->
  o.push
    a: S: i.toString() + "asdf"
    b: S: "f\nfed"
    c: S: "fee\rfefe"
    d: S: "改\r行\r\nなりfe\r\n"
    e: N: "eefe"
    f: S: "fe"

o
  # 改行を削除
  .map (i)->
    Object.keys(i)
      .map((k)-> j={}; j[k] = (if i[k].S? then i[k].S = i[k].S.replace(/\r\n/g,"").replace(/\n/g,"").replace(/\r/g,""); i[k] else i[k]); j)
      .reduce((a,b)-> Object.keys(b).forEach((l)-> a[l] = b[l]);a)
  .forEach (i)->
    # console.log i
    tsv += i.a.S
    tsv += "\t"
    tsv += i.b.S
    tsv += "\t"
    tsv += i.c.S
    tsv += "\t"
    tsv += i.d.S
    tsv += "\t"
    tsv += i.e.N
    tsv += "\t"
    tsv += i.f.S
    
    tsv += "\n"

console.log tsv
###




###
# オブジェクト→配列→オブジェクト
o =
  a: "asdf"
  b:"ffed"
  c:"feefefe"
  d:"改行\r\nなりfe\r\n"
  e:"eefe"
  f:"fe"

console.log o

a = Object.keys(o)
  .map (k)-> i={}; i[k] = o[k]; i
  .reduce (a,b)-> Object.keys(b).forEach((k)-> a[k] = b[k]); a

console.log a
###

###
# object2TSV
# tsv = "asdf\tasdflkj\tsdfasdf\nsdfsdf\tasdfad\t"
tsv = ""
tsv += "a"
tsv += "b"
tsv += "c"

d = []
d.push
  sadf: "あああ"

d.push
  sadf: "fefe"

d.push
  sadf: "fe3fe"

d.forEach (i)->
  tsv += i.sadf + "\t"
  tsv += "\n"

console.log tsv
###

###
# 末尾再帰 ならない
rf = (n)->
  ftc = (n, a)->
    if n == 0
      return a
    return ftc(n-1, n*a)
  
  r = ftc n, 1
  
  return r

console.log rf 100000
###



###
f=(x)->s x,x
s=(a,b)->a+b
console.log f 1000000
###



###
# 末尾呼び出し最適化
sSum = (x)->
  xs = sq x
  rs = sm xs
  return rs

sq=(n)->n*n
sm=(n)->n+n

console.log sSum 0

# fの結果はgの結果そのもの
# f = -> g()
###


###
# recursive function調査
# 発生しない
rf = (n)->
  r = 1
  [1..n].forEach (i)->
    r = r * i
  
  return r

console.log rf 10000000
###


###
# スタックオーバーフロー
rf = (n)->
  if n == 0
    return 1
  
  return n * rf(n - 1)

console.log rf 10000
###


###
# 自分自身を再帰的呼び出す3 不可
sss = (list, cb, data=[])->
  if list.length != 0
    target = list.shift()
    data.push target + ".add"
    
    # console.log arguments.callee
    
    sss list, cb, data
  else
    # self = @
    # Object.keys(self).forEach (k)->
    #   console.log k
    # Object.keys(this).forEach (k)->
    #   console.log k
    # console.log @.global
    console.log this
    # console.log module
    # console.log module.exports
    # console.log sss in process
    cb data


li = [
  "aa"
  "bbb"
  "dcd"
  "wer"
  ]
sss.call "gagaga", li, (d)->
  console.log d
###




###
# 自分自身を再帰的呼び出す2
sss = (list, cb, data=[])->
  if list.length != 0
    target = list.shift()
    data.push target + ".add"
    
    self = @
    # Object.keys(self).forEach (k)->
    #   console.log k
    # console.log arguments.callee
    
    # ヘルパーで使うとうまくいかないケースあり
    arguments.callee list, cb, data
  else
    cb data


li = [
  "aa"
  "bbb"
  "dcd"
  "wer"
  ]
sss li, (d)->
  console.log d
###



###
# 自分自身を再帰的呼び出す
sss = (self, list, cb, data=[])->
  if list.length != 0
    target = list.shift()
    data.push target + ".add"
    
    # console.log arguments
    self self, list, cb, data
  else
    cb data

li = [
  "aa"
  "bbb"
  "dcd"
  "wer"
  ]
# 自分自身を渡すことによって一応は可能
sss sss, li, (d)->
  console.log d
###


###
# 配列3つが同じlengthであること
a = [1,2,4]
b = [3,4,2]
c = [5,6,2]

if (a.length == b.length == c.length) == false
  console.log "同じでない"
else
  console.log "同じである"
###



###
if 1==1==2
  console.log "tt"
else
  console.log "f"
###



###
# 差分抽出
a = [1,2,3,4,5,6,7,8,9]
b = [1,2,3,5,5,6,7,9,9]

c = []
for i in [0...a.length]
  if a[i] != b[i]
    c.push i

console.log c
###

###
# スコープ
a = "aaa"
if true
  b = "bbbb"

if false
  c = "cccc"



console.log a
console.log b
console.log c

if b?
  console.log "bari"

if c?
  console.log "cari"
###



###
lstrs = []


lstrs.push {suuji:"9" , moji: "09"}
lstrs.push {suuji:"1" , moji: "01"}
lstrs.push {suuji:"9" , moji: "09"}
lstrs.push {suuji:"5" , moji: "02"}
lstrs.push {suuji:"9" , moji: "09"}
lstrs.push {suuji:"1" , moji: "01"}
lstrs.push {suuji:"9" , moji: "09"}
lstrs.push {suuji:"5" , moji: "07"}
lstrs.push {suuji:"9" , moji: "09"}
lstrs.push {suuji:"1" , moji: "01"}
lstrs.push {suuji:"9" , moji: "09"}
lstrs.push {suuji:"5" , moji: "03"}
lstrs.push {suuji:"9" , moji: "09"}
lstrs.push {suuji:"1" , moji: "01"}
lstrs.push {suuji:"9" , moji: "09"}
lstrs.push {suuji:"5" , moji: "08"}
lstrs.push {suuji:"9" , moji: "09"}
lstrs.push {suuji:"1" , moji: "01"}
lstrs.push {suuji:"9" , moji: "09"}

# console.log lstrs
# console.log lstrs.sort (a,b)-> b.suuji - a.suuji
# 文字の昇順
li= lstrs
  .sort (a,b)->
    if a.moji == b.moji
      return 0
    if a.moji < b.moji # 降順
      return 1
    else
      return -1
  .sort (a,b)->
    if a.suuji == b.suuji
      return 0
    if a.suuji > b.suuji # 昇順
      return 1
    else
      return -1

console.log li
###

###
# 文字列のソート
lstrs = []

lstrs.push {suuji:1 , moji: "aabc"}
lstrs.push {suuji:2 , moji: "babc"}
lstrs.push {suuji:3 , moji: "cabc"}
lstrs.push {suuji:4 , moji: "dabc"}
lstrs.push {suuji:9 , moji: "tabc"}
lstrs.push {suuji:1 , moji: "aabc"}
lstrs.push {suuji:8 , moji: "sabc"}
lstrs.push {suuji:7 , moji: "rabc"}
lstrs.push {suuji:6 , moji: "qabc"}
lstrs.push {suuji:5 , moji: "pabc"}

# console.log lstrs
# console.log lstrs.sort (a,b)-> b.suuji - a.suuji
# 文字の昇順
console.log lstrs.sort (a,b)-> a.moji > b.moji
###




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
strage = "strage"
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




