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
	<div class="panel-heading">Login Page</div>
	<div class="panel-body">
		
		<c:if test="${not empty param.error}">
			<h2>Invalid Username or password</h2>
			<h2>"${param.error}"</h2>
		</c:if>
		<c:if test="${not empty param.logout}">
			<h2>You have been logged out.</h2>
		</c:if>

		<div class='container'>
			<form method="post">
				<p>
					<label for="username">Username</label> 
					<input type="text" id="username" name="username" value="user88" />
				</p>
				<p>
					<label for="password">Password</label> 
					<input type="password" id="password" name="password" value="pw88" />
				</p>

				<p>
					<label for="text">Remember-Me</label> 
					<input type="checkbox" id="remember-me" name="remember-me" />
				</p>

				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button type="submit" class="btn">Log in</button>
			</form>

		</div>

	</div>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>