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
	<sec:authentication var="principal" property="principal" />
	<c:set var="member" value="${principal.member}"/>
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
								<h5 class="text-left">작성자 : ${member.uid}</h5>
							</div>
							<div class="col">
							</div>
						</div>
					</li>					
				</ul>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
			<form id='f1' action="./chregister" method="post">				
				<input type="hidden" class="form-control" name="member.uid"	value="${member.uid}" readonly="readonly" />
				<input type="hidden" class="form-control" name="title" value="${vo.title}" readonly="readonly"/>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</form>
			</div>
		</div>
		<div class="row mb-4">
			<div class="col-8 mx-auto">
				<div class="btn-group float-right">
					<button id="regBtn" type="submit" class="btn btn-primary">글쓰기 완료</button>				
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){

		var formObj = $("#f1");
		var titleinput = $("input[name='titleinput']");
		var title = $("input[name='title']");
		
		$("#regBtn").click(function(){			
			title.val(titleinput.val());
			formObj.submit();

		});
	});
	</script>	
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>