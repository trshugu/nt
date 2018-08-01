helper = @
uuid = require "uuid"
fs = require "fs"

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

