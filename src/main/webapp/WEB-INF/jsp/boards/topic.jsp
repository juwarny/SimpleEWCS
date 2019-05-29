<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
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
						<th>TITLE</th>						
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${result}">
						<tr class="odd gradeX">
							<c:url value="./blist" var="url">
		 						<c:param name="cno" value="${item[0]}"/>	  		  
							</c:url>
							<td>
								<a href="${url}">${item[1]}</a> 
								<span class="badge">${item[2]}</span>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>