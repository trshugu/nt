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
# jasmine �d����
describe('shi',->
  it('iiit',->
    expect(null).toEqual(1)
  )
)
###


###
# qunit �����Ȃ�
tmp = require "./tmp"

q = require("qunit")
qt = require("qunit-tap")
sys = require("sys")
qt(q, sys.puts)



with()


#test("a basic test example", -> 
#  ok( true, "���̃e�X�g�͐������܂����B" )
#  value = "hello"
#  equal( value, "hello", "hello�ƂȂ邱�Ƃ����҂��Ă��܂��B" )
#)
###


