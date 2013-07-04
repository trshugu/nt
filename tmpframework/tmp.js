/*
*/
$(document).ready(function() {
  $("#tmp");
});

/*
*/
// knockout ��Todo���X�g
$(function(){
  //Model���`
  function TodoModel(value){
    var self = this;
    self.todoText = ko.observable(value);
  }
  
  //ViewModel���`
  function TestappViewModel(){
    var self = this;
    
    self.todoList = ko.observableArray(); //todo���X�g
    self.todoInputValue = ko.observable(''); //�ǉ�todo�e�L�X�g
    
    //�ǉ�
    self.addTodo = function(obj, e)
    {
      if( !self.todoInputValue() ) return; //�󕶎��̏ꍇ�͏������Ȃ�
      
      //���͂��ꂽ�e�L�X�g��TodoModel�����Todo���X�g�ɑ}��
      self.todoList.unshift( new TodoModel( self.todoInputValue() ) ); 
      self.todoInputValue('');
    };
    
    //�폜
    self.removeTodo = function(obj, e)
    {
      //�C�x���g�o�C���f�B���O�Ŏ��s�����֐��̑�1�����ɂ�Model�A��2�����ɂ̓C�x���g�I�u�W�F�N�g���n�����
      self.todoList.remove(obj);
    };
  }
  
  //binding�X�^�[�g
  ko.applyBindings( new TestappViewModel() );
});



/*
// knockout data-bind
$(function(){
  //ViewModel���`
  function TestappViewModel(){
    var self = this;
    self.message = ko.observable(''); //�����l�͋󕶎�����w��
  }
  
  //binding�X�^�[�g
  ko.applyBindings( new TestappViewModel() );
});
*/



/*
// angular ���I�Ƀ��f����������
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
// Backbone Model���p
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
// Backbone Model��{
var obj = new Backbone.Model();

obj.set({name: "Murata"});
obj.set({age: 20});

console.log("obj: " + JSON.stringify(obj));
console.log("obj.name: " + obj.get("name"));
*/
