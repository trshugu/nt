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

if process.argv[2]?
  str = process.argv[2]
  rsacrack str2bi str

