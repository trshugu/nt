(function() {
  $(function() {
    return $("#tmp").css("color", "#f00");
  });


  /*
   * knockout 解析
  $ ->
     * Modelを定義
    M = (value) ->
      self = this
      self.text = ko.observable(value)
      return
    
     * ViewModelを定義
    VM = ->
      self = this
      self.list = ko.observableArray() # todoリスト
      self.inputValue = ko.observable("") # 追加todoテキスト
      
       * 追加
      self.add = (obj, e) ->
        return  unless self.inputValue() # 空文字の場合は処理しない
        
         * 入力されたテキストでTodoModelを作りTodoリストに挿入
        self.list.unshift new M(self.inputValue())
        self.inputValue ""
        return
      
       * 削除
      self.remove = (obj, e) ->
         * イベントバインディングで実行される関数の第1引数にはModel、第2引数にはイベントオブジェクトが渡される
        self.list.remove obj
        return
      return
    
     * bindingスタート
    ko.applyBindings new VM()
    return
   */


  /*
   * knockout でTodoリスト
  $ ->
     * Modelを定義
    TodoModel = (value) ->
      self = this
      self.todoText = ko.observable(value)
      return
    
     * ViewModelを定義
    TestappViewModel = ->
      self = this
      self.todoList = ko.observableArray() # todoリスト
      self.todoInputValue = ko.observable("") # 追加todoテキスト
      
       * 追加
      self.addTodo = (obj, e) ->
        return  unless self.todoInputValue() # 空文字の場合は処理しない
        
         * 入力されたテキストでTodoModelを作りTodoリストに挿入
        self.todoList.unshift new TodoModel(self.todoInputValue())
        self.todoInputValue ""
        return
      
       * 削除
      self.removeTodo = (obj, e) ->
         * イベントバインディングで実行される関数の第1引数にはModel、第2引数にはイベントオブジェクトが渡される
        self.todoList.remove obj
        return
      return
    
     * bindingスタート
    ko.applyBindings new TestappViewModel()
    return
   */


  /*
   * knockout タスクリストサンプル
  $ ->
     * タスク
    TaskViewModel = (name) ->
      
       * タスク名
      @name = ko.observable(name)
      
       * 完了かどうか
      @completed = ko.observable(false)
      
       * 編集中かどうか
      @editing = ko.observable(false)
      
       * 編集ビューの切り替え
      @toggleEdit = ->
        @editing not @editing()
        return
      
       * 削除要求コールバック
      @requestRemove = (task) ->
         * 何もしない
      
       * 削除ボタンのイベントハンドラ
      @destroy = ->
        @requestRemove this  if confirm("削除していいですか？")
        return
      return
  
    
     * アプリケーション
    appViewModel =
       * 新しいタスクの名前
      newTaskName: ko.observable("")
      
       * 登録されたタスク
      tasks: ko.observableArray()
      
       * 登録ボタンのハンドラ
      addTask: ->
        taskName = @newTaskName()
        newTask = new TaskViewModel(taskName)
        
         * タスクを削除するときのコールバックを設定
        self = this
        newTask.requestRemove = (task) ->
          self.tasks.remove task
          return
        
        @tasks.push newTask
        @newTaskName ""
        return
    
     * ビューにバインド
    ko.applyBindings appViewModel
    return
   */


  /*
   * knockout data-bindの試し書き
  $ ->
     * ViewModelを定義
    TestappViewModel = ->
      self = this
      self.message = ko.observable("") # 初期値は空文字列を指定
      return
    
     * bindingスタート
    ko.applyBindings new TestappViewModel()
    return
   */


  /*
   * knockout wiki曰く
  $ ->
    ViewModel = ->
      @firstName = ko.observable("Planet")
      @lastName = ko.observable("Earth")
      @fullName = ko.computed(->
        @firstName() + " " + @lastName()
      , this)
      return
    
    ko.applyBindings new ViewModel()
    return
   */


  /*
   * knockout Modelのテスト用
  $ ->
    Model = ->
      self = this
      self.text = ""
    
    ViewModel = ->
      self = this
      self.value = ko.observable("asdf")
      self.btn = (obj, e) ->
        obj.value Date()
      return
    
    ko.applyBindings new ViewModel()
  
  
  @ddd = ->
    @btn
    return
   */


  /*
  $ ->
     * knockout ViewはViewModelを知っているべきでViewModelはViewを知らなくてもよい
    vm = {
      pN1: ko.observable( Date() ),
      pN2: ko.observable( Date() ),
      pN3: ko.observable( Date() )
    }
    
    ko.applyBindings(vm)
   */


  /*
   * underscore.js & lodash.js
  numbers = [1,2,3,4,5]
  persons = [ 
    { 
      name : "jonny", 
      age : 24, 
      birth_month : 8, 
      gender : 0 # 0 : male, 1, female 
    }, 
    { 
      name : "paul", 
      age : 52, 
      birth_month : 7, 
      gender : 1 
    }, 
    { 
      name : "under score", 
      age : 32, 
      birth_month : 8, 
      gender : 0 
    } 
  ]
  
   * arrays
  console.log _.first([5, 4, 3, 2, 1])
  console.log _.rest([5, 4, 3, 2, 1])
  console.log _.rest([5, 4, 3, 2, 1], 3)
  console.log _.last([5, 4, 3, 2, 1])
  console.log _.compact([0, 1, false, 2, '', 3])
  console.log _.flatten([1, [2], [3, [[[4]]]]])
  console.log _.without([1, 2, 1, 0, 3, 1, 4], 0, 1)
  console.log _.uniq([1, 2, 1, 3, 1, 4])
   */

}).call(this);
