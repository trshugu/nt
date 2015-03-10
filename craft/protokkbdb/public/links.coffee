@s = io.connect(location.origin)

$ ->
  linksDisp = (page)-> 
    s.emit "links_disp", page
  
  vm=new Vue
    el:"#links"
    data:
      uri:""
      comment:""
      links:[]
      page:1
    methods:
      disp:(d, last)->
        this.page = last if last
        this.links = d
      linksadd:->
        s.emit "links_add", this.uri, this.comment
      linksdelete:(d)->
        s.emit "links_delete", d, this.page
      paging:(page)->
        return if page <= 0
        linksDisp page
        this.page = page
    created: linksDisp
  
  s.on "links_disp_res", (d, last)-> vm.disp d, last
  s.on "links_redesp", linksDisp
  
  

