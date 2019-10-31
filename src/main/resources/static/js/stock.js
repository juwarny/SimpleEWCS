var stockManager = (function(){
	
	var root = $("meta[name='root']").attr("content");
	var stocks = root+"stocks/";
	var stcode = "stcode/";
	var symbol = "symbol/";
	var stocklist = "stocklist/";
	
	var getAll  = function(callback){
		console.log("get All....");
		
		$.getJSON(stocks+stocklist, callback);
	};
	
	var getListStockBySimbol  = function(obj, callback){
		console.log("get ListStockBySimbol ....");
		$.getJSON(stocks+symbol+obj, callback);		
	};
	
	var getHistoryStock = function(obj, callback){
		console.log("get getHistoryStock ....");
		$.getJSON(stocks+stcode+obj, callback);		
	};	
	
	return {
		getAll : getAll,
		getListStockBySimbol: getListStockBySimbol,
		getHistoryStock:getHistoryStock
	}
		
})();
