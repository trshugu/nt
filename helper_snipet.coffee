helper = @
uuid = require "uuid"
fs = require "fs"
zlib =  require "zlib"
crypto = require "crypto"

# bi:nが導入されるまでの間利用
bi = require "big-integer"

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

# 圧縮、解凍
module.exports.deflate = (pt)-> new Promise (f,r)->
  zlib.deflate pt, (e,d)->
    if e?
      r e
    else
      f d.toString("hex")

module.exports.inflate = (comp)-> new Promise (f,r)->
  zlib.inflate new Buffer(comp, "hex"), (e,d)->
    if e?
      r e
    else
      f d.toString()


# 暗号化
createKeyHash = (pass)->
  hash = crypto.createHash 'sha256'
  hash.update pass
  hash.digest().toString("hex").substr(0,32)

createIV = (pass)->
  hash = crypto.createHash 'sha256'
  hash.update pass
  hash.digest().toString("hex").substr(32,16)

module.exports.lock = (val, pass)-> new Promise (f,r)->
  deflate val
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
  inflate decode
  .then (pt)->
    f pt
  .catch (e)-> r e


# 16進数文字を10進数に変換
hex2decsub = (req, res, ind)->
  s = req.pop()
  if s?
    i = bi(parseInt(s, 16))
    res = res.plus( i.multiply( bi(1).multiply(bi(16).pow(ind)) ) )
    hex2decsub req, res, ind.plus(1)
  else
    res.toString()

module.exports.hex2dec = (str)-> hex2decsub str.split(""), bi.zero, bi.zero


# 10進数文字を16進数文字に変換
dec2hexsub = (req, res)->
  m = req.mod(16)
  if req.eq m
    return m.toString(16) + res
  else
    res = m.toString(16) + res
    dec2hexsub req.divide(16), res

module.exports.dec2hex = (str)-> 
  bis = bi(str)
  if bis.sign
    bis = dec2hexsub bis.abs(), ""
    "-" + bis
  else
    dec2hexsub bis.abs(), ""


# 高速指数演算
module.exports.modular_exp = (a, b, n)->
  res = bi.one
  while b.neq(0)
    if b.and(1).neq(0)
      res = res.multiply(a).mod(n)
    
    a = a.multiply(a).mod(n)
    b = b.shiftRight(1)
  
  res

# ランダムな素数生成
module.exports.gen_rand = (bit_length)->
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
    if helper.modular_exp(a, d, n).neq(1)
      pl = [0...s].map (rr)-> 
        bi(2).pow(rr).multiply(d)
      
      flg = true
      
      pl.forEach (p)->
        if helper.modular_exp(a, p, n).eq(1)
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


# 楕円曲線計算
# 2倍(2G=G+G)
doublePt = (g,p)->
  res = {}
  if g.y.eq(bi.zero)
    res.x = 0
    res.y = 0
    return res
  else
    nu = bi(3).multiply( helper.modular_exp(g.x,bi(2),p) ).multiply(  helper.modular_exp( bi(2).multiply(g.y), p.minus(bi(2)), p ))
    x3 = helper.modular_exp(nu, bi(2), p).minus(bi(2).multiply(g.x))
    y3 = nu.multiply( g.x.minus(x3) ).minus(g.y)
    res.x = x3.mod(p)
    res.y = y3.mod(p)
    return res

# たし算(G+G)
addPt = (g1,g2,p)->
  res = {}
  
  return g2 if g1.x.eq(0) && g1.y.eq(0)
  return g1 if g2.x.eq(0) && g2.y.eq(0)
  
  if g1.x.eq(g2.x)
    if (g1.y.plus(g2.y)).mod(p).eq(0)
      res.x = bi(0)
      res.y = bi(0)
      return res
    else
      return doublePt(g1,p)
  
  # lm = (g1y-g2y) * ( (g1x-g2x)**p-2 % p )
  lm = (g1.y.minus(g2.y)).multiply( helper.modular_exp(g1.x.minus(g2.x), p.minus(bi(2)), p) )
  
  # x3 = (lm**2%p) - (g1x+g2x)
  x3 = helper.modular_exp(lm,bi(2),p).minus(g1.x.plus(g2.x))
  
  # y3 = lm*(g1x-x3)-g1y
  y3 = lm.multiply(g1.x.minus(x3)).minus(g1.y)
  
  res.x = x3.mod(p)
  res.y = y3.mod(p)
  return res

# スカラーかけ算(n-1G)
scalarmult = (g,e,p)->
  res = {}
  if e.eq(0)
    res.x = bi(0)
    res.y = bi(0)
    return res
  
  res = scalarmult(g, e.divide(2),p)
  res = addPt(res, res, p)
  res = addPt(res, g, p) if e.and(1).eq(1)
  
  return res


ccv = (g,e,p)->
  res = scalarmult g, e, p
  
  # biライブラリがBIGNUM化されて符号(sign)が消えたので書き直し
  res.x = res.x.plus(p) if res.x.lt(0)
  res.y = res.y.plus(p) if res.y.lt(0)
  
  res

module.exports.keyFromPrivate = (pri)->
  e = bi helper.hex2dec pri
  
  # ポイントG(x,y)
  g = {}
  g.x = bi helper.hex2dec "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798"
  g.y = bi helper.hex2dec "483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8"
  
  # 素数 p(modする)
  p = bi helper.hex2dec "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"
  
  res = ccv g, e, p
  res.x = ("00" + (helper.dec2hex(res.x.toString()))).slice(-64)
  res.y = ("00" + (helper.dec2hex(res.y.toString()))).slice(-64)
  res

module.exports.sign = (value, pri)->
  res = {}
  BN = require "BN.js"
  dech = bi new BN(value, 16).toString()
  
  # ポイントG(x,y)
  g = {}
  g.x = bi helper.hex2dec "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798"
  g.y = bi helper.hex2dec "483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8"
  
  # 素数 p(modする)
  p = bi helper.hex2dec "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"
  
  # 著名用
  n = bi helper.hex2dec "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141"
  
  # nonce = helper.gen_rand(64)
  nonce = bi(4)
  r = ccv(g,nonce,p).x.mod(n)
  s = helper.modular_exp(nonce, n.minus(2), n).multiply( bi(dech).plus(r.multiply(bi(helper.hex2dec(pri)))) ).mod(n)
  
  res.r = ("00" + (helper.dec2hex(r.toString()))).slice(-64)
  res.s = ("00" + (helper.dec2hex(s.toString()))).slice(-64)
  
  res

module.exports.verify = (value, sig, pub)->
  BN = require "BN.js"
  dech = bi new BN(value, 16).toString()
  
  # 公開鍵も署名もhexでくるのでキャストが必要だった
  bipub = {}
  bipub.x = bi helper.hex2dec pub.x
  bipub.y = bi helper.hex2dec pub.y
  
  bir = bi helper.hex2dec sig.r.toString()
  bis = bi helper.hex2dec sig.s.toString()
  
  # ポイントG(x,y)
  g = {}
  g.x = bi helper.hex2dec "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798"
  g.y = bi helper.hex2dec "483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8"
  
  # 素数 p(modする)
  p = bi helper.hex2dec "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"
  
  # 著名用
  n = bi helper.hex2dec "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141"
  
  si = helper.modular_exp(bis, n.minus(2), n)
  u1 = dech.multiply(si).mod(n)
  u2 = bir.multiply(si).mod(n)
  p1 = scalarmult(g, u1, p)
  p2 = scalarmult(bipub, u2, p)
  v = addPt(p1, p2, p)
  v.x = v.x.plus(p) if v.x.lt(0)
  v.y = v.y.plus(p) if v.y.lt(0)
  v.x.minus(bir).mod(n).eq(0)

# compress形式からyを算出
module.exports.ccvuncompress = (val, bleo)-> 
  p = bi helper.hex2dec "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"
  x = bi helper.hex2dec(val)
  a = helper.modular_exp(x, bi(3), p).plus(7).mod(p)
  y = helper.modular_exp(a, p.plus(1).divide(4), p)
  # y座標プレフィックスの偶奇を判断
  y = y.multiply(-1).plus(p) if y.mod(2).eq(0) != bleo
  ("00" + (helper.dec2hex(y))).slice(-64)


