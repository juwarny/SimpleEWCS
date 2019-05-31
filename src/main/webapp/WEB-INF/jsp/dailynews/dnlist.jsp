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
	<table class="table table-striped table-bordered table-hover"
		id="dataTables-example">
		<thead>
			<tr>
				<th>HeadLine</th>
				<th>pretxt</th>
				<th>office</th>	
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${news}">
				<tr class="odd gradeX">
					<td><a href="${item.href}" target="_blank">${item.headline}</a></td>
					<td>${item.pretxt}</td>
					<td>${item.office}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div>
		<ul class="pagination">
						
						<c:if test="${not empty prevDate}">
							<c:url value='./dnlist' var="url">
								<c:param name="date" value="${prevDate}"/>
							</c:url>
							<li class="page-item">
							<a href="${url}">${prevDate}</a></li>
						</c:if>
							<li class="page-item"><a>${date}</a></li>
						<c:if test="${not empty nextDate}">
							<c:url value='./dnlist' var="url">
								<c:param name="date" value="${nextDate}"/>
							</c:url>
							<li class="page-item">
							<a href="${url}">${nextDate}</a></li>
						</c:if>
					</ul>
	</div>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>