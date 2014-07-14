/*
*/







/*
// 並列化試験
var async = require('async');
console.log("start")

function Sleep( T ){ 
   var d1 = new Date().getTime(); 
   var d2 = new Date().getTime(); 
   while( d2 < d1+1000*T ){    //T秒待つ 
       d2=new Date().getTime(); 
   } 
   return; 
}

async.parallel([
  function(callback){
    console.log("wait1");
    Sleep(10);
    setTimeout(callback,1000)
  },
  function(callback){
    console.log("wait2");
    Sleep(10);
    setTimeout(callback,1000)
  },
  function(callback){
    console.log("wait3");
    Sleep(10);
    setTimeout(callback,1000)
  }
],function(err,result)
{
  if (err) { throw err; }
  console.log('all done.' + result);
})

console.log("end")
*/



/*
// async.jsによるフロー制御
var async = require('async');


// 前の関数から引数を受け取ることができる
async.waterfall([
  function (callback)
  {
    console.log('waterfall 1');
    setTimeout(function () {
      console.log('waterfall 1 done.');
      callback(null, 1);
    }, 500);
  },
  function (arg, callback) {
    console.log('waterfall 2');
    setTimeout(function () {
      console.log('waterfall 2 done.');
      callback(null, arg + 1);
    }, 300);
  },
  function (arg, callback) {
    console.log('waterfall 3');
    setTimeout(function () {
      console.log('waterfall 3 done.');
      callback(null, arg + 1);
    }, 100);
  }
],
function (err,result) {
  if (err) { throw err; }
  console.log('waterfall all done.' + result);
});

// 順番に実行。callbackが呼ばれると次が呼ばれる
async.series([
  function (callback) {
    console.log('series 1');
    setTimeout(function () {
      console.log('series 1 done.');
      callback(null, 1);
    }, 500);
  },
  function (callback) {
    console.log('series 2');
    setTimeout(function () {
      console.log('series 2 done.');
      callback(null, 2);
    }, 300);
  },
  function (callback) {
    console.log('series 3');
    setTimeout(function () {
      console.log('series 3 done.');
      callback(null, 3);
    }, 100);
  }
],
function (err, results)
{
  if (err) { throw err; }
  console.log('series all done. ' + results);
});

// 渡されたものを平行で走らせる
async.parallel([
  function (callback) {
    console.log('parallel 1');
    setTimeout(function () {
      console.log('parallel 1 done.');
      callback(null, 1);
    }, 500);
  },
  function (callback) {
    console.log('parallel 2');
    setTimeout(function () {
      console.log('parallel 2 done.');
      callback(null, 2);
    }, 300);
  },
  function (callback) {
    console.log('parallel 3');
    setTimeout(function () {
      console.log('parallel 3 done.');
      callback(null, 3);
    }, 100);
  }
],
function (err, results)
{
  if (err) { throw err; }
  console.log('parallel all done. ' + results);
});

console.log('done.');
*/




/*
// couchnodeでテスト
var couchbase = require("couchbase")
// ここまでやってやっとできた・・・
couchbase.connect(
  {"hosts":["localhost:8091"],"user":"suzuki","password":"suzuki","bucket":"gamesim-sample"},
  function(err,rb)
  {
    if(err)
    {
      console.log("eerere")
    }
    else
    {
      rb.get(
        "Aaron0",
        function(e,d,m)
        {
          console.log(e+d+m.id)
        }
      )
    }
  }
);
*/


/*
// node-couchdbでテスト
var couch =  require("node-couchdb");
couch.insert("mokkai", {"_id": "ccc3","field":"test"});
couch.insert("mokkai", {"_id": "ddd3","field":"test"});

// 連続して行うと早すぎて検索されない
couch.get("mokkai","ccc3",function(err,resData){return console.dir(resData["data"])})
couch.get("mokkai","ddd3",function(err,resData){return console.dir(resData["data"])})
*/


/*
// mongojsでテスト
var mon = require("mongojs");
var db = mon.connect("mongodb://localhost/jss")
*/

/*
// mongooseでmongoDBテスト
var mongoose = require('mongoose');
var db = mongoose.connect('mongodb://localhost/goosedb');
*/


/*
// nodejsが見るパス。これに加えてNODE_PATHを見に行く。
global.module.paths
*/


/*
// オブジェクトからjsonへ変換テスト
var obj = {
  ary:[0,1,2],
  obj:{
    a:0,
    b:1,
    c:2
  }
};
var str = JSON.stringify(obj);

// テスト出力
console.log(str);
*/


/*
// jsonからオブジェクトへ変換テスト
var str = '{"ary":[0,1,2],"obj":{"a":0,"b":1,"c":2}}';
var obj = JSON.parse(str);

// テスト出力
console.log(obj.ary);
console.log(obj.obj);
*/

/*
// もっともシンプルなhttpサーバー
var http = require('http');

http.createServer(function (req, res)
{
  res.writeHead( 200, {'Content-Type': 'text/plain'} );
  res.end( '地獄世界\n' );
})
.listen(1337, "127.0.0.1");

console.log('Server running at http://127.0.0.1:1337/');
*/


/*
// nodejsのまま使う方面
console.log("hell world");
*/
