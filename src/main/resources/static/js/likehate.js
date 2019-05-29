var likehateManager = (function(){

	var getAll  = function(obj, callback){
		console.log("get All....");

		$.getJSON('/likehate/'+obj, callback );
	};

	var add = function(obj, callback){

		console.log("add....");

		$.ajax({
			type:'post',
			url: '/likehate/'+ obj.bno,
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
			url: '/likehate/'+ obj.bno,
			dataType:'json',
			data: JSON.stringify(obj),
			contentType: "application/json",
			beforeSend : function(xhr){
			       xhr.setRequestHeader(obj.csrf.headerName, obj.csrf.token);
				},
			success:callback
		});

	};

	var remove = function(obj, callback){

		console.log("remove........");

		$.ajax({
			type:'delete',
			url: '/likehate/'+ obj.bno+"/" + obj.lhno,
			dataType:'json',
			beforeSend : function(xhr){
		       xhr.setRequestHeader(obj.csrf.headerName, obj.csrf.token);
			},
			success:callback
		});
	};

	return {
		getAll: getAll,
		add:add,
		update:update,
		remove:remove
	}

})();
