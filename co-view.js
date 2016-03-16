console.log("start");
var co = require('co');
var views = require('co-views');
 
var render = views('examples', {
  map: { html: 'swig' }
});
 
var tobi = {
  name: 'tobi',
  species: 'ferret'
};
 
var loki = {
  name: 'loki',
  species: 'ferret'
};
 
var luna = {
  name: 'luna',
  species: 'cat'
};
 
co(function *(){
  console.log("coですよ");

  var a = render('user', { user: tobi });
  var b = render('user.jade', { user: loki });
  var c = render('user.ejs', { user: luna });
  console.log("yieldの前ですよ");
  var html = yield [a, b, c];
  console.log("yieldの後ですよ");
  html = html.join('');
  console.log(html);
});

co();
console.log("end");
