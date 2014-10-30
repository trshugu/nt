###
###

tmp = require "./tmp"



###
# mocha
s = (require 'chai').should()
describe 'a',->
  it 'death',->
    'aaa'.should.equal 'aaa'
###

###
# assert
a = require "assert"
a(true,"bom")
###

###
# jasmine 重すぎ
describe('shi',->
  it('iiit',->
    expect(null).toEqual(1)
  )
)
###


###
# qunit 動かない
tmp = require "./tmp"

q = require("qunit")
qt = require("qunit-tap")
sys = require("sys")
qt(q, sys.puts)



with()


#test("a basic test example", -> 
#  ok( true, "このテストは成功しました。" )
#  value = "hello"
#  equal( value, "hello", "helloとなることを期待しています。" )
#)
###


