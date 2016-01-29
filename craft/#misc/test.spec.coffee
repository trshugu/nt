###
###

tmp = require "./tmp"


# jasmine
describe('shi',->
  it('iiit',->
    expect(null).toEqual(null)
  )
)



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


