<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>

	<div class="panel-heading">View Page</div>
	<div class="panel-body">

		<form action="${'/login'}"></form>

		<div class="form-group">
			<label>BNO</label> 
			<input class="form-control" name="bno" value="${vo.bno}" readonly="readonly" />
		</div>

		<div class="form-group">
			<label>Title</label> 
			<input class="form-control" name="title" value="${vo.title}" readonly="readonly" />
			<p class="help-block">Title text here.</p>
		</div>

		<div class="form-group">
			<label>Content</label>
			<textarea class="form-control" rows="3" name='content' readonly="readonly">${vo.content}</textarea>
		</div>

		<div class="form-group">
			<label>Writer</label>
			<!-- 수정이 필요할수도있음 --> 
			<input class="form-control" name="writer" value="${vo.member.uid}" readonly="readonly" />
		</div>

		<div class="form-group">
			<label>RegDate</label>
			<fmt:formatDate value="${vo.regdate}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/> 
			<input class="form-control" name="regDate" value="${formattedDate}" readonly="readonly" />
		</div>
		<!-- 수정이 필요할수도있음 --> 
		<div class="pull-right">			
			<sec:authentication var="principal" property="principal"/>
			<c:choose>
				<c:when test="${principal eq 'anonymousUser'}">
					<c:set var="uid" value=""/>
				</c:when>
				<c:otherwise>
					<c:set var="uid" value="${principal.member.uid}"/>
				</c:otherwise>
			</c:choose>
			
			<c:url value="../modify" var="url">
			  <c:param name="page" value="${pageVO.page}"/>
			  <c:param name="size" value="${pageVO.size}"/>
			  <c:param name="type" value="${pageVO.type}"/>
			  <c:param name="keyword" value="${pageVO.keyword}"/>
			  <c:param name="bno" value="${pageVO.bno}"/>
			  <c:param name="bno" value="${pageVO.catno}"/>			  
			</c:url>
			<c:url value="../list" var="url2">
			  <c:param name="page" value="${pageVO.page}"/>
			  <c:param name="size" value="${pageVO.size}"/>
			  <c:param name="type" value="${pageVO.type}"/>
			  <c:param name="keyword" value="${pageVO.keyword}"/>
			  <c:param name="bno" value="${pageVO.bno}"/>
			  <c:param name="bno" value="${pageVO.catno}"/>			  
			</c:url>
			
			<a href="${url}" class="btn btn-default" id='goModBtn'>Modify/Delete</a> 
			<a href="${url2}" class="btn btn-primary">Go List</a>
		</div>

	</div>

	<div class='container'>
		<table class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th>RNO</th>
					<th>REPLY TEXT</th>
					<th>REPLER</th>
					<th>REPLY DATE</th>
				</tr>
			</thead>
			<tbody id="replyTable">
			</tbody>
		</table>

		<div class='pull-right'>
			<button class='btn ' id='addReplyBtn'>Add Reply</button>
		</div>

	</div>

	<!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Modal Header</h4>
				</div>
				<div class="modal-body">
					<label>Reply Text</label> 
					<input type="text" class="form-control" name='replyText'> 
					<label>Replyer</label> 
					<input type="text" class="form-control" name='replyer' readonly="readonly">
				</div>
				<div class="modal-footer">
					<button id='delModalBtn' class="btn btn-danger">Delete</button>
					<button id='modalBtn' class="btn btn-info">Save</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>
	<!--  end Modal -->

	<!-- 수정이 필요-->
	<script type="text/javascript" src="${'/js/reply.js'}"></script>
	<script type="text/javascript">
	
	$(document).ready(function (e){
	
		var mode;
		
	  var bno = "<c:out value='${vo.bno}'/>";
	  
	  var replyTextObj = $("input[name='replyText']");
	  var replyerObj = $("input[name='replyer']");
	  
	  var rno; 		
	  //TODO: 수정이 필요

	  var uid ="<c:out value='${uid}'/>";

	  
	  var csrf = JSON.parse("<c:out value='${_csrf}'/>");
	  
	  
	  $("#addReplyBtn").on('click', function(){
		  
		  if(uid == null){
			  if(confirm("로그인 할까요?")){
				//TODO: 수정이 필요 login 패스 나중에 수정해야됨
				  self.location = "../login"+"?dest=" + encodeURIComponent(self.location);
			  }
			  return;
		  }
		  
		  replyerObj.val(uid);
		  
		  $("#myModal").modal("show");
		  $(".modal-title").text("Add Reply");
		  
		  $("#delModalBtn").hide();
		  
		  mode= "ADD";
	  });
	  
	 
	  
	  $("#goModBtn").click(function(e){
		  
		  e.preventDefault();
		  
		  if(uid == null){
			  if(confirm("로그인 할까요?")){
				  //self.location = [[@{/login}]];
				  self.location = $(this).attr("href");
			  }
		  }else {
			  
			  if(uid == "<c:out value='${vo.member.uid}'/>"){
					self.location = $(this).attr('href');
			  }else {
				  alert("작성자만이 수정이나 삭제할 수 있습니다.");
			  }
		  }
	  });
	  
	  
	  
	  $("#delModalBtn").on("click", function(){
		  
		  var obj = {bno:bno, rno:rno, csrf:csrf};
		  
		  replyManager.remove(obj, function(list){
			  
			  alert("댓글이 삭제되었습니다. ")
				afterAll(list);
		  });
		  
	  });
	  
	  
	  $("#replyTable").on("click", "tr", function(e){
		
		  var tds = $(this).find('td');
		  
		  console.log(tds);
		  
		  rno = tds[0].innerHTML;
		  mode ='MOD';
		  
		  replyTextObj.val(tds[1].innerHTML);
		  replyerObj.val(tds[2].innerHTML);
		  $("#delModalBtn").show();
		  $("#myModal").modal("show");
		  $(".modal-title").text("Modiy/Delete Reply");
		  
		  console.log("==================");
		  console.log(uid);
		  console.log(tds[2].innerHTML);
		  
		  console.log(uid == tds[2].innerHTML);
		  
		  if(uid != tds[2].innerHTML.trim() ){
			
			  $("#delModalBtn").hide();
			  $("#modalBtn").hide();
			  
		  }
		  
		  
	  });
	  
	  function afterAll(list){
		  printList(list);
		  $("#myModal").modal("hide");
			replyTextObj.val("");
			replyerObj.val("");
	  }
	  
	  
	  $("#modalBtn").click(function(){
		  
		  var replyText =  replyTextObj.val();
			var replyer = replyerObj.val();
		  		  
		  if(mode =='ADD'){
			  					
				var obj = {
						replyText:replyText, 
						replyer: replyer, 
						bno:bno,
						csrf:csrf
						};
				
				
				//console.log(obj);
				
				replyManager.add(obj, function(list){
					alert("새로운 댓글이 추가되었습니다. ")
					afterAll(list);
				});				
		  
		  }else if(mode='MOD'){
			  
			  var obj = {replyText:replyText, bno:bno, rno:rno, csrf:csrf};
			  
			  
			  replyManager.update(obj, function(list){
				  
					alert("댓글이 수정되었습니다. ")
					afterAll(list);
			  });
			  
		  }
				
	  });
		
		(function getAllReplies(){
			//load replies 
			replyManager.getAll("<c:out value='${vo.bno}'/>", printList);
		})();
		
		
	  function printList(list){

		  
		  var str = "";
			var replyObj;
			for(var i = 0; i < list.length; i++){
				replyObj = list[i];
				
				str += "<tr>" +
				"<td>"+ replyObj.rno+" </td>" +
				"<td>"+ replyObj.replyText+" </td>" +
				"<td>"+ replyObj.replyer+" </td>" +
				"<td>"+ formatDate(replyObj.regdate)+" </td>" +
				"</tr>";
			}
			$("#replyTable").html(str);
	  }
		
		function formatDate(timeValue){
			
			var date = new Date(timeValue);
			return  date.getFullYear() 
			  + "-" + (date.getMonth()+1 >= 10?date.getMonth()+1 : '0'+ (date.getMonth()+1)  ) 
			  + "-" + date.getDate()
			
		}
		
	});
	</script>	
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>