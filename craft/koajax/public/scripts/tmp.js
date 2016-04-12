(function() {
  console.time("tmp");

  document.addEventListener('DOMContentLoaded', function() {
    return console.log("done");

    /*
     * viewModelでの制御(sortなどができる)
    getSt = (data=[])->
      $.get "http://localhost:3000/rnd/first"
        .done (v)->
          data.push v
           * クライアント側の時間制御
          if v.next
            setTimeout ->
              getSt data
            , 1000
          else
            data
              .sort (a,b)->
                b.seed - a.seed
              .forEach (i)->
                $("#tmp").append("<div>" + i.data + ":" + i.seed + "</div><br>")
    
    getSt()
     */

    /*
    getSt = ->
      $.get "http://localhost:3000/rnd/first"
        .done (v)->
          $("#tmp").append("<div>" + v.data + ":" + v.seed + "</div><br>")
          
           * クライアント側の時間制御
          if v.next
            setTimeout ->
              getSt()
            , 1000
    
    getSt()
     */

    /*
    $.post "http://localhost:3000/poster?ppp=eee", parame:"para", (a)->
      console.log "a", a
     */

    /*
    $.get("http://localhost:3000/nf?ppp=eee", param:"ppp")
      .done (v)->
        console.log v.data
      .fail (e)->
        console.log "e", e
     */

    /*
    $.when(
      $.getJSON(url: "http://localhost:3000/data"),
      $.get(url: "http://localhost:3000/data")
    ).then (a,b)->
      console.log a[1]
      console.log b
     */

    /*
    p = -> new Promise (f)->
      f "hell"
    
    p().then (v)->
      console.log v
     */

    /*
    .done (d,t, c)->
      console.log "t",t
      console.log "c",c
      console.log "d",d
      $("#tmp").append("<div>" + d.data + "</div><br>")
     */

    /*
    $.get url: "http://localhost:3000/data"
    .done (d,t, c)->
      console.log "t",t
      console.log "c",c
      console.log "d",d
      $("#tmp").append("<div>" + d.data + "</div><br>")
     */

    /*
    console.log 1
    r = new XMLHttpRequest()
    r.open "GET", "http://localhost:3000/styles/tmp.css", true
    r.onreadystatechange = ->
      console.log 2
      return if r.readyState != 4 or r.status != 200
      console.log r.responseText
      console.log 3
    
    r.send "a=1&b=2&c=3"
    console.log 4
     */

    /*
    get = (url)-> new Promise (f,r)->
      req = new XMLHttpRequest()
      req.open 'GET', url
      
      req.onload = ->
        if req.status == 200
          f req.response
        else
          r Error(req.statusText)
      
      req.onerror = -> r(Error("Network Error"))
      req.send()
    
    console.log "eee"
    get("http://localhost:3000")
      .then (r)->
          console.log "ok", r
        ,(e)->
          console.log "ng", e
     */

    /*
     * bacon.js2
    up = $("#up").asEventStream("click").map(1)
    down = $("#down").asEventStream("click").map(-1)
    counter = up.merge(down).scan(0, (x, y) -> x + y)
    counter.assign $("#counter"), "text"
     */

    /*
     * FRP1
    arr = [1,2,3,4,5,6,7,8,9]
    Bacon.fromArray(arr).map((n)-> n * 2).log()
    
    arr.push 99
    arr.push 100
    Bacon.fromArray(arr).map((n)-> n * 2).log()
     */

    /*
    console.log 1
    setInterval ->
      $.ajax
        url: "http://localhost:3000"
      .done (d,t)->
        console.log 2
        console.log "t",t
        console.log "d",d
        $("#tmp").append("<div>aaa</div><br>")
      .fail (r)->
        console.log 3
        console.log r
    , 1000
    
    console.log 4
     */
  });


  /*
   * ajax promisify
  @ajax = (url, param="")-> new Promise (f,r)->
     * f()
    re = new XMLHttpRequest()
    re.open "GET", "http://localhost:3000/styles/tmp.css", true
    re.onreadystatechange = ->
      if re.readyState != 4 or re.status != 200
         * r()
        console.log "standby"
        console.log re.readyState
        console.log re.status
        return
      else
         * f()
        console.log re.responseText
        f(re.responseText)
    
    re.send param
  
  console.log "astart"
  @ajax("http://localhost:3000/styles/tmp.css").then (v)->
    console.log "then"
    console.log v
   */

}).call(this);
