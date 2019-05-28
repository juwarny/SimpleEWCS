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
		<p>
			<label>UID</label>
			<input type="text" name="uid" value="${member.uid}" readonly/>
		</p>
		<p>
			<label>UPW</label>
			<input type="password" name="upw" value="${member.upw}" readonly/>
		</p>
		<p>
			<label>UNAME</label>
			<input type="text" name="uname" value="${member.uname}" readonly/>
		</p>
		<p>"${member.roles}"</p>				
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>