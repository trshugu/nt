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


