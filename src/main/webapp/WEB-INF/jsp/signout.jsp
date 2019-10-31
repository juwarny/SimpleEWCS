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
			<form method="post">
				<h3>Logout</h3>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button type="submit" class="btn btn-primary">LogOut</button>
			</form>
		</div>
	</div>
<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>	
</body>
</html>