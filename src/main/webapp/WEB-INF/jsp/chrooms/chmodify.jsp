<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>
	<div class="panel-heading">Modify Page</div>
	<div class="panel-body">

		<form id='f1' action="./chmodify">
			<div class="form-group">
				<label>CHRNO</label> 
				<input class="form-control" name="chrno" value="${vo.chrno}" readonly="readonly" />
			</div>

			<div class="form-group">
				<label>Title</label> 
				<input class="form-control" name="title" value="${vo.title}" />
				<p class="help-block">Title text here.</p>
			</div>

			<div class="form-group">
				<label>Content</label>
				<textarea class="form-control" rows="3" name='content'>${vo.content}</textarea>
			</div>
			<div class="form-group">
				<label>Writer</label> 
				<input class="form-control" name="writer" value="${vo.member.uid}" readonly="readonly" />
			</div>
			<input type='hidden' name="page" value="${pageVO.page}"> 
			<input type='hidden' name="size" value="${pageVO.size}"> 
			<input type='hidden' name="keyword" value="${pageVO.keyword}">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

		</form>

		<div class="form-group">
			<label>RegDate</label>
			<fmt:formatDate value="${vo.regdate}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/> 
			<input class="form-control" name="regDate" value="${formattedDate}"	readonly="readonly" />
		</div>

		<div class="pull-right">

			<a href="#" class="btn btn-warning modbtn">Modify</a>
			<a href="#" class="btn btn-danger delbtn">Delete</a>			
			<c:url value="./chlist" var="url">
			  <c:param name="page" value="${pageVO.page}"/>
			  <c:param name="size" value="${pageVO.size}"/>
			  <c:param name="keyword" value="${pageVO.keyword}"/>
			  <c:param name="chrno" value="${vo.chrno}"/>
			</c:url>
			<a href="${url}" class="btn btn-primary">Cancel & Go List</a>
		</div>

	</div>

	<script type="text/javascript">
	$(document).ready(function(){
	
		var formObj = $("#f1");
		
		$(".delbtn").click(function(){
			
			formObj.attr("action","delete");
			formObj.attr("method", "post");
			
			formObj.submit();
			
		});
		
		$(".modbtn").click(function(){
			
			formObj.attr("action","chmodify");
			formObj.attr("method", "post");
			
			formObj.submit();
			
		});
		
		
	});	
	</script>
<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>	
</body>
</html>