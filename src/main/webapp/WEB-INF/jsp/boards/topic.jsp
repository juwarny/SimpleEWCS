<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>
	<c:url value='/' var="root" />
	<div class="row">
		<c:forEach var="item" items="${result}">
			<c:url value="./blist" var="url">
				<c:param name="cno" value="${item[0]}" />
			</c:url>
			<div class="card mx-auto" style="width: 20rem; margin:1rem;">
				<img src="${root}static/img/topic/${item[0]}.jpg" class="card-img-top" alt="WCS" style="max-height:60%;">
				<div class="card-body">
					<h4 class="card-title">
						<strong>${item[1]}</strong>
						<a href="${url}" class="badge badge-primary badge-pill">${item[2]}</a>
					</h4>
					<p class="card-text"><a href="${url}" class="btn btn-primary">들어가기</a></p>
				</div>
			</div>
		</c:forEach>
	</div>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>