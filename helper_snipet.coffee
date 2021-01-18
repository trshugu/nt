helper = @
uuid = require "uuid"
fs = require "fs"
zlib =  require "zlib"
crypto = require "crypto"
request = require("request")
cheerio = require("cheerio")

module.exports.getHash = -> 
  cry = crypto.createHash 'SHA256'
  cry.update uuid.v4(), "utf8"
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'

module.exports.createHash = (src)-> 
  cry = crypto.createHash 'SHA256'
  cry.update src, "utf8"
  cry.digest 'hex'

module.exports.getHash64 = -> 
  cry = crypto.createHash 'SHA512'
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'

module.exports.createHash64 = (src)-> 
  cry = crypto.createHash 'SHA512'
  cry.update src, "utf8"
  cry.digest 'hex'

module.exports.makeDir = (path)-> new Promise (f, r)->
  path = path[0...-1] if path.match("/$")
  fs.mkdir path, (e)->
    if e?
      if e.code == 'ENOENT'
        helper.makeDir path.split("/")[0...-1].join("/")
        .then (v)->
          helper.makeDir path
            .then (v)->
              f()
            .catch (e)->
              r e
        .catch (e)->
          r e
        
      else
        r e
    else
      f()

portDecider = -> Math.floor(Math.random() * (65536 - 1024) + 1024)

# 中央値を取る
module.exports.getMedian = (arr)->
  arr.sort (a, b) -> a - b
  if arr.length % 2 == 0
    return (arr[(arr.length/2) - 1] + arr[(arr.length/2)]) / 2
  else
    return arr[Math.floor(arr.length / 2)]

module.exports.appendCsv = (filename, val)-> new Promise (f,r)->
  fs.appendFile filename, val + "\r\n", (e)->
    if e?
      r e
    else
      f()

# limelight IPs
module.exports.llnw = (uri)-> new Promise (f,r)->
  helper.wget uri
  .then (v)->
    xml = cheerio.load v.raw,{ignoreWhitespace: true, xmlMode: true}
    content = cheerio.load xml("channel>item").children()[1].children[0].data
    ips = JSON.parse(content("pre").text())
    f ips
  .catch (e)-> r e

# ======================================
# epoch変換
# ======================================
module.exports.epoch2date = (d)->
  d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2) + " " \
   + ("0" + d.getHours()).slice(-2) + ":" \
   + ("0" + d.getMinutes()).slice(-2)  + ":" \
   + ("0" + d.getSeconds()).slice(-2)

module.exports.epoch2utc = (d)->
  d.getUTCFullYear() + "/" \
   + ("0" + (d.getUTCMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getUTCDate()).slice(-2) + " " \
   + ("0" + d.getUTCHours()).slice(-2) + ":" \
   + ("0" + d.getUTCMinutes()).slice(-2)  + ":" \
   + ("0" + d.getUTCSeconds()).slice(-2)

module.exports.epoch2jst = (d)->
  d = new Date(d.getTime() + (1000 * 60 * 60 * 9))
  d.getUTCFullYear() + "/" \
   + ("0" + (d.getUTCMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getUTCDate()).slice(-2) + " " \
   + ("0" + d.getUTCHours()).slice(-2) + ":" \
   + ("0" + d.getUTCMinutes()).slice(-2)  + ":" \
   + ("0" + d.getUTCSeconds()).slice(-2)

# ======================================
# 圧縮、解凍
# ======================================
module.exports.deflate = (pt)-> new Promise (f,r)->
  zlib.deflate pt, (e,d)->
    if e?
      r e
    else
      f d.toString("hex")

module.exports.inflate = (comp)-> new Promise (f,r)->
  zlib.inflate Buffer.from(comp, "hex"), (e,d)->
    if e?
      r e
    else
      f d.toString()


# ======================================
# 暗号化
# ======================================
createKeyHash = (pass)->
  hash = crypto.createHash 'sha256'
  hash.update pass
  hash.digest().toString("hex").substr(0,32)

createIV = (pass)->
  hash = crypto.createHash 'sha256'
  hash.update pass
  hash.digest().toString("hex").substr(32,16)

module.exports.lock = (val, pass)-> new Promise (f,r)->
  helper.deflate val
  .then (comp)->
    cipher = crypto.createCipheriv 'aes-256-cbc', createKeyHash(pass), createIV(pass)
    crypted = cipher.update comp, 'utf-8', 'hex'
    crypted += cipher.final 'hex'
    f crypted
  .catch (e)-> r e

module.exports.unlock = (cry, pass)-> new Promise (f,r)->
  decipher = crypto.createDecipheriv 'aes-256-cbc', createKeyHash(pass), createIV(pass)
  decode = decipher.update cry, 'hex', 'utf-8'
  decode += decipher.final "utf-8"
  helper.inflate decode
  .then (pt)->
    f pt
  .catch (e)-> r e

# ======================================
# HEX<->DEC
# ======================================
# 16進数文字を10進数に変換
hex2decsub = (req, res, ind)->
  s = req.pop()
  if s?
    i = BigInt(parseInt(s, 16))
    res = res + i * 1n * 16n ** ind
    hex2decsub req, res, ind + 1n
  else
    res.toString()

module.exports.hex2dec = (str)-> hex2decsub str.split(""), 0n, 0n

# 10進数文字を16進数文字に変換
dec2hexsub = (req, res)->
  m = req % 16n
  if req == m
    return m.toString(16) + res
  else
    res = m.toString(16) + res
    dec2hexsub req / 16n, res

module.exports.dec2hex = (str)-> 
  bis = BigInt(str)
  
  if bis < 0n
    bis = bis * -1n
    bis = dec2hexsub bis, ""
    "-" + bis
  else
    dec2hexsub bis, ""

# ======================================
# 公開鍵暗号計算
# ======================================
# 高速指数演算
module.exports.modular_exp = (a, b, n)->
  res = 1n
  while b != 0n
    if (b & 1n) != 0n
      res = (res * a) % n
    
    a = (a ** 2n) % n
    b = b >> 1n
  
  res

# ランダムな素数生成
module.exports.gen_rand = (bit_length)->
  bits = [0...bit_length - 2].map -> Math.floor(Math.random() * 2)
  ret = 1n
  bits.forEach (b)->
    ret = ret * 2n + BigInt(b)
  
  ret * 2n + 1n

# 素数判定
mr_primary_test = (n, k=100)->
  return false if n == 1n
  return true if n == 2n
  return false if (n % 2n) == 0n
  
  d = n - 1n
  s = 0n
  while (d % 2n) != 0n
    d = d / 2n
    s = s + 1n
  
  # nのビット数
  nb = n.toString(2).length
  r = [0...k].map -> gen_rand nb-1
  res = r.some (a)->
    if helper.modular_exp(a, d, n) != 1n
      pl = [0...s].map (rr)->  (2n ** rr) * d
      flg = true
      
      pl.forEach (p)->
        if helper.modular_exp(a, p, n) == 1n
          flg = false
          return
      
      if flg
        return true
    
  return res == false

# 素数生成
module.exports.gen_prime = (bit)->
  while true
    ret = @gen_rand(bit)
    if mr_primary_test(ret)
      break
  
  return ret

# ======================================
# 楕円曲線計算
# ======================================
# 2倍(2G=G+G)
doublePt = (g,p)->
  res = {}
  if g.y == 0n
    res.x = 0n
    res.y = 0n
    return res
  else
    nu = 3n * helper.modular_exp(g.x, 2n, p) * helper.modular_exp(2n * g.y, p - 2n, p)
    x3 = helper.modular_exp(nu, 2n, p) - (2n * g.x)
    y3 = (nu * (g.x - x3)) - g.y
    res.x = x3 % p
    res.y = y3 % p
    return res

# たし算(G+G)
addPt = (g1,g2,p)->
  res = {}
  
  return g2 if g1.x == 0n && g1.y == 0n
  return g1 if g2.x == 0n && g2.y == 0n
  
  if g1.x == g2.x
    if (g1.y + g2.y) % p == 0n
      res.x = 0n
      res.y = 0n
      return res
    else
      return doublePt(g1,p)
  
  # lm = (g1y-g2y) * ( (g1x-g2x)**p-2 % p )
  lm = (g1.y-g2.y) * ( helper.modular_exp((g1.x-g2.x), p-2n, p) )
  
  # x3 = (lm**2%p) - (g1x+g2x)
  x3 = helper.modular_exp(lm,2n,p) - (g1.x+g2.x)
  
  # y3 = lm*(g1x-x3)-g1y
  y3 = lm * (g1.x-x3) - g1.y
  
  res.x = x3 % p
  res.y = y3 % p
  return res

# スカラーかけ算(n-1G)
scalarmult = (g,e,p)->
  res = {}
  if e == 0n
    res.x = 0n
    res.y = 0n
    return res
  
  res = scalarmult(g, e/2n, p)
  res = addPt(res, res, p)
  res = addPt(res, g, p) if (e & 1n) == 1n
  
  return res

ccv = (g,e,p)->
  res = scalarmult g, e, p
  
  # biライブラリがBIGNUM化されて符号(sign)が消えたので書き直し
  res.x = res.x + p if res.x < 0n
  res.y = res.y + p if res.y < 0n
  
  res

module.exports.keyFromPrivate = (pri)->
  e = BigInt helper.hex2dec pri
  
  # ポイントG(x,y)
  g = {}
  g.x = BigInt helper.hex2dec "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798"
  g.y = BigInt helper.hex2dec "483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8"
  
  # 素数 p(modする)
  p = BigInt helper.hex2dec "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"
  
  res = ccv g, e, p
  res.x = ("00" + (helper.dec2hex(res.x.toString()))).slice(-64)
  res.y = ("00" + (helper.dec2hex(res.y.toString()))).slice(-64)
  res

module.exports.sign = (value, pri)->
  res = {}
  BN = require "BN.js"
  dech = BigInt new BN(value, 16).toString()
  
  # ポイントG(x,y)
  g = {}
  g.x = BigInt helper.hex2dec "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798"
  g.y = BigInt helper.hex2dec "483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8"
  
  # 素数 p(modする)
  p = BigInt helper.hex2dec "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"
  
  # 著名用
  n = BigInt helper.hex2dec "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141"
  
  # nonce = helper.gen_rand(64)
  nonce = 4n
  r = ccv(g,nonce,p).x % n
  s = helper.modular_exp(nonce, n-2n, n) * ( dech + r * BigInt(helper.hex2dec(pri)) ) % n
  
  res.r = ("00" + (helper.dec2hex(r.toString()))).slice(-64)
  res.s = ("00" + (helper.dec2hex(s.toString()))).slice(-64)
  
  res

module.exports.verify = (value, sig, pub)->
  BN = require "BN.js"
  dech = BigInt new BN(value, 16).toString()
  
  # 公開鍵も署名もhexでくるのでキャストが必要だった
  bipub = {}
  bipub.x = BigInt helper.hex2dec pub.x
  bipub.y = BigInt helper.hex2dec pub.y
  
  bir = BigInt helper.hex2dec sig.r.toString()
  bis = BigInt helper.hex2dec sig.s.toString()
  
  # ポイントG(x,y)
  g = {}
  g.x = BigInt helper.hex2dec "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798"
  g.y = BigInt helper.hex2dec "483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8"
  
  # 素数 p(modする)
  p = BigInt helper.hex2dec "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"
  
  # 著名用
  n = BigInt helper.hex2dec "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141"
  
  si = helper.modular_exp(bis, n-2n, n)
  u1 = (dech * si) % n
  u2 = bir * si % n
  p1 = scalarmult(g, u1, p)
  p2 = scalarmult(bipub, u2, p)
  v = addPt(p1, p2, p)
  v.x = (v.x + p) if v.x < 0n
  v.y = (v.y + p) if v.y < 0n
  (v.x - bir) % n == 0n

# compress形式からyを算出
module.exports.ccvuncompress = (val, bleo)-> 
  p = BigInt helper.hex2dec "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"
  x = BigInt helper.hex2dec(val)
  a = (helper.modular_exp(x, 3n, p) + 7n) % p
  y = helper.modular_exp(a, (p+1n)/4n, p)
  # y座標プレフィックスの偶奇を判断
  y = (y * -1n + p) if ((y % 2n) == 0n) != bleo
  ("00" + (helper.dec2hex(y))).slice(-64)

# wget
module.exports.wget = (url)-> new Promise (f,re)->
  request
    url: url
    headers:
      'User-Agent': 'request'
      'Accept': 'text/html'
  , (e,r,b)->
    if e?
      re e
    else
      res = {}
      res.headers = r.headers
      res.body = cheerio.load b
      res.raw = b
      f res


# ======================================
# SQUFOF v1.0
# ======================================

# 平方根を求める
# 数字文字列を返す
# 拡張ユークリッド互除法
# 鍵生成



