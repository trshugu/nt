###
###

# tmp = require "./tmp"




###
# mocha async doneを利用する
describe "userr",->
  describe "sabee",->
    it "without erre",(done)->
      setTimeout ->
        console.log "parallel done."
        require("chai").assert.equal 1,2
        done()
      , 1000
###

###
# mocha sync
require("chai").should()
describe "arr",->
  describe "inde",->
    it "should return -1",->
      [1,2,3].indexOf(5).should.equal(-1)
      [1,2,3].indexOf(0).should.equal(-1)
###

###
# mocha
s = (require 'chai').should()
describe 'a',->
  it 'death',(d)->
    'aaa'.should.equal 'aaa'
    d()
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


