var express = require('express');
var app = express();


app.set('view engine', 'jade');
app.set('views', __dirname + '/views');

app.get('/', function (req, res) {
  res.render('index', { title: 'Express Sample' });
});

/*
app.get('/', function (req, res) {
  res.send('Hello, World!');
});
*/

app.listen(3000);