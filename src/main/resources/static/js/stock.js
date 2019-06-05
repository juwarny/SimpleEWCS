var stockManager = (function(){
	
	var root = $("meta[name='root']").attr("content");
	var stocks = root+"stocks/";
	var stcode = "stcode/"
	var symbol = "symbol/"
		
	
	var getListStockBySimbol  = function(obj, callback){
		console.log("get ListStockBySimbol ....");
		$.getJSON(stocks+symbol+obj, callback);		
	};
	
	var getHistoryStock = function(obj, callback){
		console.log("get getHistoryStock ....");
		$.getJSON(stocks+stcode+obj, callback);		
	};	
	
	return { 
		getListStockBySimbol: getListStockBySimbol,
		getHistoryStock:getHistoryStock,
	}
		
})();
