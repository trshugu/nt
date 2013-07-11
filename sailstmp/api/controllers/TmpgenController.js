/*---------------------
	:: Tmpgen 
	-> controller
---------------------*/
var TmpgenController = {
    index: function (req,res) {
        res.view();
        res.view(hell: 'hell');
    }
};
module.exports = TmpgenController;