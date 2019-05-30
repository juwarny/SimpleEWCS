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
	<div class="panel panel-default">
		<div class="panel-body">
			<div class="alert alert-danger" role="alert">

				<h2>Sorry, you do not have permission to view this page.</h2>

				Click Login at <a href="./signin">here</a>

			</div>
		</div>
	</div>
<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>	
</body>
</html>