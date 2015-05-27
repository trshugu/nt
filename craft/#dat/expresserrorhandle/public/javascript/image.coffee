$ ->
  vm = new Vue
    el:"#vue"
    data:
      vuefile:""
      im:""
    watch:
      vuefile:(n,o)->
        console.log vm.vuefile
  
  console.log vm.vuefile
  
  
  setFI = $("#jake")
  setFI.each ->
    selfF = $(this)
    selfI = $(this).find "input[type=file]"
    
    selfI.change ->
      file = $(this).prop("files")[0]
      fileRdr = new FileReader()
      selfImg = selfF.find ".imgView"
      selfCrear = selfF.find "#clear"
      
      if !this.files.length
        if 0 < selfImg.size()
          selfImg.remove()
          selfClear.remove()
          return
      else
        if file.type.match("image.*") 
          if !(0 < selfImg.size())
            selfF.append '<img class="imgView"/><p id="clear">くりあ</p>'
            $("#clear").bind "click",->
              $("#jake > input[type=file]").val("")
              $(".imgView").remove()
              $("#clear").remove()
          prevElm = selfF.find ".imgView"
          
          fileRdr.onload = ->
            prevElm.attr "src", fileRdr.result
          fileRdr.readAsDataURL file
        else
          if 0<selfI.size()
            selfImg.remove()
            selfCrear.remove()
            return
