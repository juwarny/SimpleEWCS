<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<c:url value='/' var="url"/>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
<style type="text/css">
.vertical-center {
  margin-left: auto;
  margin-right:auto;
  position: absolute;
  top: 50%;
  right: 50%;
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
  -ms-transform: translateX(+50%);
  transform: translateX(+50%);
}
</style>
</head>
<body class="text-center align-items-center">
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>
	<c:if test="${not empty member.uid}">
		<div role="main" class="vertical-center">
			<h1>환영합니다!</h1>
			<p class="lead"><strong>${member.uid}</strong>의 회원가입이 완료되었습니다. 이제 더 많은 서비스를 이용할 수
				있습니다!
			</p>
			<p class="lead">
				<a href="../index" class="btn btn-lg btn-secondary">메인 페이지로 돌아가기</a>
			</p>
		</div>
	</c:if>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>