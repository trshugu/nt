helper = @
uuid = require "uuid"
fs = require "fs"
zlib =  require "zlib"
crypto = require "crypto"


module.exports.getHash = -> 
  cry = require("crypto").createHash 'SHA256'
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'

module.exports.createHash = (src)-> 
  cry = require("crypto").createHash 'SHA256'
  cry.update src, "utf8"
  cry.digest 'hex'

module.exports.getHash64 = -> 
  cry = require("crypto").createHash 'SHA512'
  cry.update uuid.v4(), "utf8"
  cry.digest 'hex'

module.exports.createHash64 = (src)-> 
  cry = require("crypto").createHash 'SHA512'
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


# 暗号化
creageIV = (pass)->
  hash = crypto.createHash 'md5'
  hash.update pass
  hash.digest().toString("hex").substr(16,16)

creageKeyHash = (pass)->
  hash = crypto.createHash 'md5'
  hash.update pass
  hash.digest().toString("hex")

module.exports.lock = (val, pass)-> new Promise (f,r)->
  deflate val
  .then (comp)->
    cipher = crypto.createCipheriv 'aes-256-cbc', creageKeyHash(pass), creageIV(pass)
    crypted = cipher.update comp, 'utf-8', 'hex'
    crypted += cipher.final 'hex'
    f crypted
  .catch (e)-> r e

module.exports.unlock = (cry, pass)-> new Promise (f,r)->
  decipher = crypto.createDecipheriv 'aes-256-cbc', creageKeyHash(pass), creageIV(pass)
  decode = decipher.update cry, 'hex', 'utf-8'
  decode += decipher.final "utf-8"
  inflate decode
  .then (pt)->
    f pt
  .catch (e)-> r e

