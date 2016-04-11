(function() {
  console.time("tmp");

  document.addEventListener('DOMContentLoaded', function() {
    var get;
    console.log("done");
    get = function(url) {
      return new Promise(function(f, r) {
        var req;
        req = new XMLHttpRequest();
        req.open('GET', url);
        req.onload = function() {
          if (req.status === 200) {
            return f(req.response);
          } else {
            return r(Error(req.statusText));
          }
        };
        req.onerror = function() {
          return r(Error("Network Error"));
        };
        return req.send();
      });
    };
    console.log("eee");
    return get("http://localhost:3000").then(function(r) {
      return console.log("ok", r);
    }, function(e) {
      return console.log("ng", e);
    });

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

}).call(this);
