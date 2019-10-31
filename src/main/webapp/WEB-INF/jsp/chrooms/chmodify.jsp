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
	<div class="container-fluid">
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<input class="form-control form-control-lg" name="titleinput" value="${vo.title}"/>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<ul class="list-group">
					<li class="list-group-item">
						<div class="row align-items-center justify-content-between">
							<div class="col">
								<h5 class="text-left">작성자 : ${vo.member.uid}</h5>
							</div>
							<div class="col">
								<fmt:formatDate value="${vo.regdate}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/>
								<h5 class="text-right">수정 날짜 : ${formattedDate}</h5>	
							</div>													
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<form id='f1' action="./chmodify">
					<input type="hidden" class="form-control" name="chrno" value="${vo.chrno}" readonly="readonly" />
					<input type="hidden" class="form-control" name="writer" value="${vo.member.uid}" readonly="readonly"/>
					<input type="hidden" class="form-control" name="title" value="${vo.title}" readonly="readonly" />
					<fmt:formatDate value="${vo.regdate}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/>
					<input type="hidden" class="form-control" name="regDate" value="${formattedDate}" readonly="readonly" />
					<input type='hidden' name="page" value="${pageVO.page}"> 
					<input type='hidden' name="size" value="${pageVO.size}"> 
					<input type='hidden' name="keyword" value="${pageVO.keyword}">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
		</div>
		<div class="row mb-4">
			<div class="col-8 mx-auto">				
				<div class="btn-group float-right">
					<a href="#" class="btn btn-warning mx-1 modbtn">편집</a>
					<a href="#" class="btn btn-danger mx-1 delbtn">삭제</a>			
					<c:url value="./chlist" var="url">
					  <c:param name="page" value="${pageVO.page}"/>
					  <c:param name="size" value="${pageVO.size}"/>
					  <c:param name="keyword" value="${pageVO.keyword}"/>
					  <c:param name="chrno" value="${vo.chrno}"/>
					</c:url>
					<a href="${url}" class="btn btn-primary mx-1">취소</a>
				</div>				
			</div>
		</div>		
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
	
		var formObj = $("#f1");
		var titleinput = $("input[name='titleinput']");
		var title = $("input[name='title']");
		
		$(".delbtn").click(function(){
			
			formObj.attr("action","delete");
			formObj.attr("method", "post");
			title.val(titleinput.val());
			formObj.submit();
			
		});
		
		$(".modbtn").click(function(){
			
			formObj.attr("action","chmodify");
			formObj.attr("method", "post");
			title.val(titleinput.val());			
			formObj.submit();
			
		});
		
		
	});	
	</script>
<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>	
</body>
</html>