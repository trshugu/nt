var dri = require("couchbase");

Ap = function(){};

dri.connect(
  {
    "user":"suzuki",
    "password":"suzuki",
    "hosts":["192.168.80.64:8091"],
    "bucket":"njstest",
    "debug":"true"
  },
  function(err,cb)
  {
    if(err)
    {
      throw(err)
    }
    
    Ap.prototype.cb = cb;
  }
);

Ap.prototype.save = function(article, callback){
  var prov = this;
  prov.cb.incr("articleId", function(err, id)
    {
      article.type = "article";
      article.created_at = new Date();
      prov.cb.set(id.toString(), article, function(err, meta)
        {
          callback(err, article)
        }
      );
    }
  );
};

exports.Ap=Ap;
