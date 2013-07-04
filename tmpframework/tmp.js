/*
*/
$(document).ready(function() {
  $("#tmp");
});

/*
*/
// knockout でTodoリスト
$(function(){
  //Modelを定義
  function TodoModel(value){
    var self = this;
    self.todoText = ko.observable(value);
  }
  
  //ViewModelを定義
  function TestappViewModel(){
    var self = this;
    
    self.todoList = ko.observableArray(); //todoリスト
    self.todoInputValue = ko.observable(''); //追加todoテキスト
    
    //追加
    self.addTodo = function(obj, e)
    {
      if( !self.todoInputValue() ) return; //空文字の場合は処理しない
      
      //入力されたテキストでTodoModelを作りTodoリストに挿入
      self.todoList.unshift( new TodoModel( self.todoInputValue() ) ); 
      self.todoInputValue('');
    };
    
    //削除
    self.removeTodo = function(obj, e)
    {
      //イベントバインディングで実行される関数の第1引数にはModel、第2引数にはイベントオブジェクトが渡される
      self.todoList.remove(obj);
    };
  }
  
  //bindingスタート
  ko.applyBindings( new TestappViewModel() );
});



/*
// knockout data-bind
$(function(){
  //ViewModelを定義
  function TestappViewModel(){
    var self = this;
    self.message = ko.observable(''); //初期値は空文字列を指定
  }
  
  //bindingスタート
  ko.applyBindings( new TestappViewModel() );
});
*/



/*
// angular 動的にモデル書き換え
function helloCtrl($scope)
{
  $scope.hello = "Hello, World";
  $scope.goodbye = function()
  {
    $scope.hello = "Good Bye";
  }
}
*/

/*
// angular
$(document).ready(function() {
  $(function(){
    var elem_in=$("input[name='yourname']"),
    elem_out=$("#yourname");
    
    var showName = function(name){
      elem_out.text(name);
    };
    
    showName(elem_in.val());
    
    elem_in.bind('keyup', function(){
      setTimeout(showName,  0, $(this).val());
    });
  });
});
*/


/*
// Backbone Collection
var obj = new Backbone.Model();
obj.set({name: "Murata"});
obj.set({age: 20});
var obj2 = new Backbone.Model({name: "Kenichiro1", age: 30});
var obj3 = new Backbone.Model({name: "Kenichiro2", age: 11});
var obj4 = new Backbone.Model({name: "Kenichiro3", age: 3});

var objs = new Backbone.Collection([obj, obj2, obj3, obj4]);
//console.log("objs: " + JSON.stringify(objs));

//console.log("objs.get(cid): " + JSON.stringify(objs.get("c1")));
//console.log("objs.at(index): " + JSON.stringify(objs.at(0)));

//objs.comparator = function(item) {
//    return item.get("age");
//};
 
//objs.sort();
//console.log("After sort objs: " + JSON.stringify(objs));
//console.log("After sort objs.at(index): " + JSON.stringify(objs.at(0)));

// map
tmpObj = objs.map(function(item){
  return item.get("age") + 1;
});
console.log("map result: " + JSON.stringify(tmpObj));

// reduce
tmpObjred = objs.reduce(function(memo, item){
  return memo + item.get("age") + 1 ;
}, 0);
console.log("reduce result: " + JSON.stringify(tmpObjred));

// pluck
console.log("pluck result: " + JSON.stringify(objs.pluck("name"))); 
*/


/*
// Backbone Model応用
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
*/


/*
// Backbone Model基本
var obj = new Backbone.Model();

obj.set({name: "Murata"});
obj.set({age: 20});

console.log("obj: " + JSON.stringify(obj));
console.log("obj.name: " + obj.get("name"));
*/
