
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , user = require('./routes/user')
  , http = require('http')
  , path = require('path');

var app = express();

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(require('stylus').middleware(__dirname + '/public'));
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

var Ap = require("./provide").Ap;
var ap = new Ap();

app.get('/', routes.index);
app.get('/users', user.list);
app.get("/blonew/new", function(req,res){
  res.render("blonew.jade",{title:"tttti"});
});
app.post("/blonew/new", function(req,res){
  console.log(req.param("tit"));
  console.log(req.param("body"));
  
  ap.save(
    {
      titt: req.param("tit"),
      body: req.param("body")
    },
    function(err, article)
    {
      res.redirect("/blonew/new");
    }
  );
});

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
