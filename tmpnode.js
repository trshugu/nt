/*
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
