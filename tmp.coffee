###
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




