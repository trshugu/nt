# cryptkeyì¬
getMD5Hash = -> 
  hash = require("crypto").createHash 'MD5'
  hash.update "randomToken", "utf8"
  hash.digest 'hex'

# IV‚ÌŒ®ì¬
makeIV = ->
  iv = require("crypto").createHash 'md5'
  iv.update 'randomToken'
  iv.digest()

module.exports = (req, res)->
  disp = {}
  disp.titl = "crypt!"
  
  # —LŒøŠúŒÀ5•ª
  text = "cb653edc8dd1b4708ed2ae64eae92a21.mp3?para=meta" + "," + (new Date().getTime() + (5 * 60 * 1000))
  
  # ˆÃ†
  cipher = require("crypto").createCipheriv 'aes-256-cbc', getMD5Hash(), makeIV()
  crypted = cipher.update text, 'utf-8', 'hex'
  crypted += cipher.final 'hex'
  
  console.log crypted
  disp.crypt_url = crypted
  
  
  
  res.render 'crypt', disp
