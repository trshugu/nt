###
###

# tmp = require "./tmp"




# 入れ子XMLの取得と判別
chai = require "chai"
cheerio = require "cheerio"

# xml作成
builder = require "xmlbuilder"

root = builder.create "root"
ids = root.ele "ids"
ids.ele "id", "gen1"
ids.ele "id", "gen2"

# console.log root.end({pretty: true})
xml = root.end({pretty: true})


describe "01:", ->
  it "01",->
    $ = cheerio.load xml, {ignoreWhitespace: true, xmlMode: true}
    chai.assert.ok $("root").find("id").eq(0).text()
    chai.assert.equal $("root").find("id").eq(0).text(), "gen1"
    chai.assert.notOk $("root").find("nasi").eq(0).text()
    chai.assert.ok $("root").find("ids").eq(0).text()
    chai.assert.ok $("root")
    chai.assert.ok $("root ids")
    chai.assert.ok $("root ids id")
    chai.assert.ok $("root").is("root")
    chai.assert.notOk $("nasi").is("nasi")
    chai.assert.ok $("root").find("ids")
    chai.assert.ok $("root").find("nasi")
    chai.assert.notOk $("root").find("nasi").text()
    chai.assert.notOk $("root").find("nasi").is("nasi")
    chai.assert.ok  $("root").find("ids").is("ids")
    chai.assert.notOk  $("root").find("nasi").is("nasi")




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


