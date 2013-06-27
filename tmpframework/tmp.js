/*
*/
$(document).ready(function() {
	$("#tmp");
});


// Backbone Model‰ž—p
var Staff = Backbone.Model.extend({
  defaults: {
    "name": "",
    "age": 0,
    "updateTime": new Date()
  },
  initialize: function() {
    console.log("Staff[" + this.cid + "]: " + JSON.stringify(this));
  }
});

var tmpStaff = new Staff(); 
tmpStaff.set({name: "Murata", age: 15, id: 101});

console.log("Staff[" + tmpStaff.cid + "]: " + JSON.stringify(tmpStaff));

var tmpStaff2 = new Staff({name: "Kenichiro", age: 35, id: 102});


/*
// Backbone ModelŠî–{
var obj = new Backbone.Model();

obj.set({name: "Murata"});
obj.set({age: 20});

console.log("obj: " + JSON.stringify(obj));
console.log("obj.name: " + obj.get("name"));
*/
