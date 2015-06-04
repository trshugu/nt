module.exports = (req, res)->
  disp = {}
  disp.titl = "crypt!"
  disp.crypt_url = ""
  
  # //s3-ap-northeast-1.amazonaws.com/mfm-test/source/cb653edc8dd1b4708ed2ae64eae92a21.mp3
  
  
  
  
  
  res.render 'crypt', disp
