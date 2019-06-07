var updownManager = (function(){
	
	var root = $("meta[name='root']").attr("content");
	var updowns = root+"updowns/";
	
	var getAvgAndCount  = function(obj, callback){
		console.log("get AvgCount....");
		
		$.getJSON(updowns+obj,callback );		
	};
	
	var getUpdownOfUser = function(obj, callback){
		console.log("get AvgCount....");
		
		$.getJSON(updowns + obj.stcode+"/"+obj.uid, callback );		
	};
	
	var add = function(obj, callback){
		
		console.log("add....");
		
		$.ajax({
			type:'post',
			url: updowns+obj.stcode+"/"+obj.uid,
			data:JSON.stringify(obj), 
			dataType:'json',
			beforeSend : function(xhr){
			       xhr.setRequestHeader(obj.csrf.headerName, obj.csrf.token);
				},
			contentType: "application/json",
			success:callback
		});
	};
	
	var update = function(obj, callback){
		console.log("update.......");
		
		$.ajax({
			type:'put',
			url: updowns + obj.stcode+"/"+obj.upno,
			dataType:'json',
			data: JSON.stringify(obj),
			contentType: "application/json",
			beforeSend : function(xhr){
			       xhr.setRequestHeader(obj.csrf.headerName, obj.csrf.token);
				},
			success:callback
		});
		
	};
	
	return { 
		getAvgAndCount: getAvgAndCount,
		getUpdownOfUser: getUpdownOfUser,
		add:add,
		update:update
	}
		
})();
