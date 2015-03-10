@s = io.connect(location.origin)

# 日付フォーマット
Date2String = (d)->
  d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2)

$ ->
  $("#tmp").css({color: "#f00"})
  
  trickleDisp = -> s.emit "trickle_disp"
  
  vm=new Vue
    el:"#tl"
    data:
      kin:false
      ki:false
      kai:false
      yo:false
      shi:false
      ri:false
      me:false
      ami:false
      ju:false
      tlist:[]
    methods:
      disp:(d)->
        today = d.filter (i)->i.date == Date2String(new Date())
        this.kin = today[0].kin
        this.ki = today[0].ki
        this.kai = today[0].kai
        this.yo = today[0].yo
        this.shi = today[0].shi
        this.ri = today[0].ri
        this.me = today[0].me
        this.ami = today[0].ami
        this.ju = today[0].ju
        this.tlist = d
      tladd:->
        s.emit "trickle_add",
          this.kin,
          this.ki,
          this.kai,
          this.yo,
          this.shi,
          this.ri,
          this.me,
          this.ami,
          this.ju,
          Date2String(new Date())
    created: trickleDisp
  
  s.on "trickle_disp_res", (d)-> vm.disp d
  s.on "trickle_redesp", trickleDisp
  
  
  

