###
###

# tmp = require "./tmp"


chai = require "chai"
tmp = require "./tmp"



###
＃v1
describe "数字を入れて都道府県を返す",->
  it "北海道チェック", (done)->
    chai.assert.equal "北海道", tmp.tdd 1
    done()

  it "沖縄県チェック", (done)->
    chai.assert.equal "沖縄県", tmp.tdd 47
    done()
###

###
# v2
describe "数字を入れて都道府県を返す",->
  it "北海道チェック", (done)->
    chai.assert.equal "北海道", tmp.tdd 1
    done()

  it "沖縄県チェック", (done)->
    chai.assert.equal "沖縄県", tmp.tdd 47
    done()

describe "ローマ字で返ってくるようにする",->
  it "hokkaidoチェック", (done)->
    chai.assert.equal "hokkaido", tmp.tdd 1, "us"
    done()

  it "okinawaチェック", (done)->
    chai.assert.equal "okinawa", tmp.tdd 47, "us"
    done()
###



###
# rev3
describe "数字を入れて都道府県を返す",->
  it "北海道チェック", (done)-> chai.assert.equal "北海道", tmp.tdd 1; done()
  it "沖縄県チェック", (done)-> chai.assert.equal "沖縄県", tmp.tdd 47; done()

  it "北海道チェック", (done)-> chai.assert.equal "北海道", tmp.tdd 1; done()
  it "青森県チェック", (done)-> chai.assert.equal "青森県", tmp.tdd 2; done()
  it "岩手県チェック", (done)-> chai.assert.equal "岩手県", tmp.tdd 3; done()
  it "宮城県チェック", (done)-> chai.assert.equal "宮城県", tmp.tdd 4; done()
  it "秋田県チェック", (done)-> chai.assert.equal "秋田県", tmp.tdd 5; done()
  it "山形県チェック", (done)-> chai.assert.equal "山形県", tmp.tdd 6; done()
  it "福島県チェック", (done)-> chai.assert.equal "福島県", tmp.tdd 7; done()
  it "茨城県チェック", (done)-> chai.assert.equal "茨城県", tmp.tdd 8; done()
  it "栃木県チェック", (done)-> chai.assert.equal "栃木県", tmp.tdd 9; done()
  it "群馬県チェック", (done)-> chai.assert.equal "群馬県", tmp.tdd 10; done()
  it "埼玉県チェック", (done)-> chai.assert.equal "埼玉県", tmp.tdd 11; done()
  it "千葉県チェック", (done)-> chai.assert.equal "千葉県", tmp.tdd 12; done()
  it "東京都チェック", (done)-> chai.assert.equal "東京都", tmp.tdd 13; done()
  it "神奈川県チェック", (done)-> chai.assert.equal "神奈川県", tmp.tdd 14; done()
  it "新潟県チェック", (done)-> chai.assert.equal "新潟県", tmp.tdd 15; done()
  it "富山県チェック", (done)-> chai.assert.equal "富山県", tmp.tdd 16; done()
  it "石川県チェック", (done)-> chai.assert.equal "石川県", tmp.tdd 17; done()
  it "福井県チェック", (done)-> chai.assert.equal "福井県", tmp.tdd 18; done()
  it "山梨県チェック", (done)-> chai.assert.equal "山梨県", tmp.tdd 19; done()
  it "長野県チェック", (done)-> chai.assert.equal "長野県", tmp.tdd 20; done()
  it "岐阜県チェック", (done)-> chai.assert.equal "岐阜県", tmp.tdd 21; done()
  it "静岡県チェック", (done)-> chai.assert.equal "静岡県", tmp.tdd 22; done()
  it "愛知県チェック", (done)-> chai.assert.equal "愛知県", tmp.tdd 23; done()
  it "三重県チェック", (done)-> chai.assert.equal "三重県", tmp.tdd 24; done()
  it "滋賀県チェック", (done)-> chai.assert.equal "滋賀県", tmp.tdd 25; done()
  it "京都府チェック", (done)-> chai.assert.equal "京都府", tmp.tdd 26; done()
  it "大阪府チェック", (done)-> chai.assert.equal "大阪府", tmp.tdd 27; done()
  it "兵庫県チェック", (done)-> chai.assert.equal "兵庫県", tmp.tdd 28; done()
  it "奈良県チェック", (done)-> chai.assert.equal "奈良県", tmp.tdd 29; done()
  it "和歌山県チェック", (done)-> chai.assert.equal "和歌山県", tmp.tdd 30; done()
  it "鳥取県チェック", (done)-> chai.assert.equal "鳥取県", tmp.tdd 31; done()
  it "島根県チェック", (done)-> chai.assert.equal "島根県", tmp.tdd 32; done()
  it "岡山県チェック", (done)-> chai.assert.equal "岡山県", tmp.tdd 33; done()
  it "広島県チェック", (done)-> chai.assert.equal "広島県", tmp.tdd 34; done()
  it "山口県チェック", (done)-> chai.assert.equal "山口県", tmp.tdd 35; done()
  it "徳島県チェック", (done)-> chai.assert.equal "徳島県", tmp.tdd 36; done()
  it "香川県チェック", (done)-> chai.assert.equal "香川県", tmp.tdd 37; done()
  it "愛媛県チェック", (done)-> chai.assert.equal "愛媛県", tmp.tdd 38; done()
  it "高知県チェック", (done)-> chai.assert.equal "高知県", tmp.tdd 39; done()
  it "福岡県チェック", (done)-> chai.assert.equal "福岡県", tmp.tdd 40; done()
  it "佐賀県チェック", (done)-> chai.assert.equal "佐賀県", tmp.tdd 41; done()
  it "長崎県チェック", (done)-> chai.assert.equal "長崎県", tmp.tdd 42; done()
  it "熊本県チェック", (done)-> chai.assert.equal "熊本県", tmp.tdd 43; done()
  it "大分県チェック", (done)-> chai.assert.equal "大分県", tmp.tdd 44; done()
  it "宮崎県チェック", (done)-> chai.assert.equal "宮崎県", tmp.tdd 45; done()
  it "鹿児島県チェック", (done)-> chai.assert.equal "鹿児島県", tmp.tdd 46; done()
  it "沖縄県チェック", (done)-> chai.assert.equal "沖縄県", tmp.tdd 47; done()


describe "ローマ字で返ってくるようにする",->
  it "hokkaidoチェック", (done)-> chai.assert.equal "hokkaido", tmp.tdd 1, "us"; done()
  it "aomoriチェック", (done)-> chai.assert.equal "aomori", tmp.tdd 2, "us"; done()
  it "iwateチェック", (done)-> chai.assert.equal "iwate", tmp.tdd 3, "us"; done()
  it "miyagiチェック", (done)-> chai.assert.equal "miyagi", tmp.tdd 4, "us"; done()
  it "akitaチェック", (done)-> chai.assert.equal "akita", tmp.tdd 5, "us"; done()
  it "yamagataチェック", (done)-> chai.assert.equal "yamagata", tmp.tdd 6, "us"; done()
  it "fukushimaチェック", (done)-> chai.assert.equal "fukushima", tmp.tdd 7, "us"; done()
  it "ibarakiチェック", (done)-> chai.assert.equal "ibaraki", tmp.tdd 8, "us"; done()
  it "tochigiチェック", (done)-> chai.assert.equal "tochigi", tmp.tdd 9, "us"; done()
  it "gunmaチェック", (done)-> chai.assert.equal "gunma", tmp.tdd 10, "us"; done()
  it "saitamaチェック", (done)-> chai.assert.equal "saitama", tmp.tdd 11, "us"; done()
  it "chibaチェック", (done)-> chai.assert.equal "chiba", tmp.tdd 12, "us"; done()
  it "tokyoチェック", (done)-> chai.assert.equal "tokyo", tmp.tdd 13, "us"; done()
  it "kanagawaチェック", (done)-> chai.assert.equal "kanagawa", tmp.tdd 14, "us"; done()
  it "niigataチェック", (done)-> chai.assert.equal "niigata", tmp.tdd 15, "us"; done()
  it "toyamaチェック", (done)-> chai.assert.equal "toyama", tmp.tdd 16, "us"; done()
  it "ishikawaチェック", (done)-> chai.assert.equal "ishikawa", tmp.tdd 17, "us"; done()
  it "fukuiチェック", (done)-> chai.assert.equal "fukui", tmp.tdd 18, "us"; done()
  it "yamanashiチェック", (done)-> chai.assert.equal "yamanashi", tmp.tdd 19, "us"; done()
  it "naganoチェック", (done)-> chai.assert.equal "nagano", tmp.tdd 20, "us"; done()
  it "gifuチェック", (done)-> chai.assert.equal "gifu", tmp.tdd 21, "us"; done()
  it "shizuokaチェック", (done)-> chai.assert.equal "shizuoka", tmp.tdd 22, "us"; done()
  it "aichiチェック", (done)-> chai.assert.equal "aichi", tmp.tdd 23, "us"; done()
  it "mieチェック", (done)-> chai.assert.equal "mie", tmp.tdd 24, "us"; done()
  it "shigaチェック", (done)-> chai.assert.equal "shiga", tmp.tdd 25, "us"; done()
  it "kyotoチェック", (done)-> chai.assert.equal "kyoto", tmp.tdd 26, "us"; done()
  it "osakaチェック", (done)-> chai.assert.equal "osaka", tmp.tdd 27, "us"; done()
  it "hyogoチェック", (done)-> chai.assert.equal "hyogo", tmp.tdd 28, "us"; done()
  it "naraチェック", (done)-> chai.assert.equal "nara", tmp.tdd 29, "us"; done()
  it "wakayamaチェック", (done)-> chai.assert.equal "wakayama", tmp.tdd 30, "us"; done()
  it "tottoriチェック", (done)-> chai.assert.equal "tottori", tmp.tdd 31, "us"; done()
  it "shimaneチェック", (done)-> chai.assert.equal "shimane", tmp.tdd 32, "us"; done()
  it "okayamaチェック", (done)-> chai.assert.equal "okayama", tmp.tdd 33, "us"; done()
  it "hiroshimaチェック", (done)-> chai.assert.equal "hiroshima", tmp.tdd 34, "us"; done()
  it "yamaguchiチェック", (done)-> chai.assert.equal "yamaguchi", tmp.tdd 35, "us"; done()
  it "tokushimaチェック", (done)-> chai.assert.equal "tokushima", tmp.tdd 36, "us"; done()
  it "kagawaチェック", (done)-> chai.assert.equal "kagawa", tmp.tdd 37, "us"; done()
  it "ehimeチェック", (done)-> chai.assert.equal "ehime", tmp.tdd 38, "us"; done()
  it "kochiチェック", (done)-> chai.assert.equal "kochi", tmp.tdd 39, "us"; done()
  it "fukuokaチェック", (done)-> chai.assert.equal "fukuoka", tmp.tdd 40, "us"; done()
  it "sagaチェック", (done)-> chai.assert.equal "saga", tmp.tdd 41, "us"; done()
  it "nagasakiチェック", (done)-> chai.assert.equal "nagasaki", tmp.tdd 42, "us"; done()
  it "kumamotoチェック", (done)-> chai.assert.equal "kumamoto", tmp.tdd 43, "us"; done()
  it "oitaチェック", (done)-> chai.assert.equal "oita", tmp.tdd 44, "us"; done()
  it "miyazakiチェック", (done)-> chai.assert.equal "miyazaki", tmp.tdd 45, "us"; done()
  it "kagoshimaチェック", (done)-> chai.assert.equal "kagoshima", tmp.tdd 46, "us"; done()
  it "okinawaチェック", (done)-> chai.assert.equal "okinawa", tmp.tdd 47, "us"; done()
###




###
# v4
describe "数字を入れて都道府県を返す", ->
  it "北海道チェック", (done)->
    chai.assert.equal "北海道", tmp.tdd 1
    done()

  it "沖縄県チェック", (done)->
    chai.assert.equal "沖縄県", tmp.tdd 47
    done()

describe "ローマ字で返ってくるようにする", ->
  it "hokkaidoチェック", (done)->
    chai.assert.equal "hokkaido", tmp.tdd 1, "us"
    done()

  it "okinawaチェック", (done)->
    chai.assert.equal "okinawa", tmp.tdd 47, "us"
    done()

describe "アメリカの州を返す", ->
  it "Alabamaチェック", (done)->
    chai.assert.equal "Alabama", tmp.tdd 1, "us", "us"
    done()

  it "Washingtonチェック", (done)->
    chai.assert.equal "Washington", tmp.tdd 47, "us", "us"
    done()
###


# v5
describe "数字を入れて都道府県を返す", ->
  it "北海道チェック", (done)->
    chai.assert.equal "北海道", tmp.tdd 1
    done()

  it "沖縄県チェック", (done)->
    chai.assert.equal "沖縄県", tmp.tdd 47
    done()

describe "ローマ字で返ってくるようにする", ->
  it "hokkaidoチェック", (done)->
    chai.assert.equal "hokkaido", tmp.tdd 1, "us"
    done()

  it "okinawaチェック", (done)->
    chai.assert.equal "okinawa", tmp.tdd 47, "us"
    done()

describe "アメリカの州を返す", ->
  it "Alabamaチェック", (done)->
    chai.assert.equal "Alabama", tmp.tdd 1, "us", "us"
    done()

  it "Washingtonチェック", (done)->
    chai.assert.equal "Washington", tmp.tdd 47, "us", "us"
    done()

describe "アメリカの州を日本語で返す", ->
  it "アラバマチェック", (done)->
    chai.assert.equal "アラバマ", tmp.tdd 1, "ja", "us"
    done()

  it "ワシントンチェック", (done)->
    chai.assert.equal "ワシントン", tmp.tdd 47, "ja", "us"
    done()





###
chai = require "chai"
describe "allow",->
  it "one", (done)->
    foo = require "./foo"
    obj = new foo.Foo()
    console.log "obj",obj
    console.log "obj-f",obj.methodA
    chai.assert.isFunction obj.methodA
    chai.assert.equal "foovee", obj.methodA()
    obj.methodA()
    done()
  
  it "two", (done)->
    foo = require "./foo"
    obj = new foo.Foo()
    chai.assert.equal "vee", obj.methodB()
    obj.methodA()
    done()
###

###
# リスコフの置換原則に於けるTDD
chai = require "chai"
tmp = require "./Bungu"

describe "スーパークラス1", ->
  it "Bungu", (done)->
    k = tmp.Bungu
    chai.assert.isFunction k.use
    chai.assert.isBoolean k.live
    done()
  
  it "pen", (done)->
    k = tmp.pen
    chai.assert.isFunction k.use
    chai.assert.isBoolean k.live
    done()
  
  it "gum", (done)->
    k = tmp.gum
    chai.assert.isFunction k.use
    chai.assert.isBoolean k.live
    done()
###

###
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


