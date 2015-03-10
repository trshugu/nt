@s = io.connect(location.origin)

# 日付フォーマット
DateTime2String = (d)->
  d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2) + " " \
   + ("0" + d.getHours()).slice(-2) + ":" \
   + ("0" + d.getMinutes()).slice(-2) + ":" \
   + ("0" + d.getSeconds()).slice(-2)

$ ->
  $("#tmp").css({color: "#f00"})
  
  kkbdbDisp = -> s.emit "kkbdb_disp"
  
  vm=new Vue
    el:"#kkbdb"
    data:
      val1:""
      val2:""
      vala:""
      kkb:[]
    methods:
      disp:(d)->
        sorted = d.sort (i,j)-> Date.parse(i.date) < Date.parse(j.date)
        this.val1 = sorted[0].val1
        this.val2 = sorted[0].val2
        this.vala = sorted[0].vala
        this.kkb = sorted
      kkbadd:->
        s.emit "kkbdb_add", this.val1, this.val2, this.vala, DateTime2String(new Date())
      kkbdelete:(date)->
        s.emit "kkbdb_delete", date
    created: kkbdbDisp
  
  s.on "kkbdb_disp_res", (d)-> vm.disp d
  s.on "kkbdb_redesp", kkbdbDisp
  
  
  

