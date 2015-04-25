console.log "OK"

window.onload = ->
  vm=new Vue
    el:"#vali"
    data:
      vo:""
      valiin:""
    watch:
      "valiin":(n,o)->
        # console.log vm
        setTimeout checkValidation, 1000, [n, vm]
        # vm.vo=n
  
  console.log hiki
  console.log mval
  if mval.length != 0
    checkValidation [mval, vm]
  




ichi=(val)->
  # console.log val
  if val[0]? && val[0].length == 1
    val[1].vo = true
  else
    val[1].vo = false


# 一秒後にチェックする
checkValidation = (v)->
  console.log ichi(v)
  




###
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
      if d.length > 0
        sorted = d.sort (i,j)-> Date.parse(j.date) - Date.parse(i.date)
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
###



