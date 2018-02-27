# ヘルパーメソッド
helper = @
stdt = new Date

# helperlorder
helperlorder = (mod)->
  for k, v of mod
    module.exports[k] = v

# ======================================
# snipet
# ======================================
helperlorder require "./helper_snipet"


