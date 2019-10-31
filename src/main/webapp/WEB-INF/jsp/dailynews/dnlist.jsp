<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
<style type="text/css">
a[disabled="disabled"] {
	pointer-events: none;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<ul class="list-group">
					<c:forEach var="item" items="${news}">
						<li class="list-group-item">
							<div class="row align-items-center">
								<div class="col-md-4">
									<c:choose>
										<c:when test="${not empty item.imgSrc}">
											<img src="${item.imgSrc}" class="card-img" alt="...">
										</c:when>
										<c:otherwise>
											<c:url value='/' var="root" />
											<img src="${root}static/img/logo-wcs.svg" class="card-img"
												alt="...">
										</c:otherwise>
									</c:choose>

								</div>
								<div class="col-md-8">
									<div class="card-body">
										<h5 class="card-title">
											<a href="${item.href}" target="_blank" style="text-decoration:none;" >${item.headline}</a>
										</h5>
										<p class="card-text">
											<c:out value="${item.pretxt}"></c:out>
										</p>
										<p class="card-text">
											<small class="text-muted">${item.office}</small>
										</p>
									</div>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-md-auto mx-auto">
				<nav>
					<ul class="pagination">
						<c:if test="${not empty prevDate}">
							<c:url value='./dnlist' var="url">
								<c:param name="date" value="${prevDate}" />
							</c:url>
							<fmt:parseDate value="${prevDate}" var="formattedDate"
								pattern="yyyyMMdd" />
							<li class="page-item"><a class="page-link" href="${url}"><fmt:formatDate
										value="${formattedDate}" pattern="MM월 dd일" /></a></li>
						</c:if>
						<fmt:parseDate value="${date}" var="formattedDate"
							pattern="yyyyMMdd" />
						<li class="page-item active" aria-current="page"><a
							class="page-link"><fmt:formatDate value="${formattedDate}"
									pattern="MM월 dd일" /><span class="sr-only">(current)</span></a></li>
						<c:if test="${not empty nextDate}">
							<c:url value='./dnlist' var="url">
								<c:param name="date" value="${nextDate}" />
							</c:url>
							<fmt:parseDate value="${nextDate}" var="formattedDate"
								pattern="yyyyMMdd" />
							<li class="page-item"><a class="page-link" href="${url}"><fmt:formatDate
										value="${formattedDate}" pattern="MM월 dd일" /></a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>