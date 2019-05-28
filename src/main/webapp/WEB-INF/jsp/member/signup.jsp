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
	<form method="post">
		<p>
			<label>UID</label>
			<input type="text" name="uid" value="newbie"/>
		</p>
		<p>
			<label>UPW</label>
			<input type="password" name="upw" value="newbie"/>
		</p>
		<p>
			<label>UNAME</label>
			<input type="text" name="uname" value="newbie"/>
		</p>
		<p><!-- TODO: 나중에 수정 -->
			<input type="checkbox" name="roles[0].roleName" value="BASIC" checked/>BASIC
			<input type="checkbox" name="roles[1].roleName" value="MANAGER" checked/>MANAGER
			<input type="checkbox" name="roles[2].roleName" value="ADMIN" checked/>ADMIN
		</p>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<button type="submit" class="btn">JOIN</button>		
	</form>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>