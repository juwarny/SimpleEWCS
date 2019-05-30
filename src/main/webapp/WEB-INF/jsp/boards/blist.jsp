<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>
	<div class="panel-heading">List Page</div>
	<div class="panel-body pull-right">
		<h3>
			<c:url value="./bregister" var="url">
			  <c:param name="cno" value="${pageVO.cno}"/>
			</c:url>
			<a class="label label-default " href="${url}">새글 쓰기</a>
		</h3>
	</div>
	<div class="panel-body">
		<c:set var="res" value="${result.result}"/>
			<table class="table table-striped table-bordered table-hover"
				id="dataTables-example">
				<thead>
					<tr>
						<th>TITLE</th>
						<th>WRITER</th>
						<th>REGDATE</th>						
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${res.content}" var="arr">
						<tr class="odd gradeX">
							<td><a href='${arr[0]}' class='boardLink'>${arr[1]}</a> <span
								class="badge">${arr[2]}</span></td>
							<td>${arr[3]}</td>
							<fmt:formatDate value="${arr[4]}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/>
							<td class="center">${formattedDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div>
				<select id='searchType'>
					<option>--</option>
					<option value='t' selected="${pageVO.type} =='t'">Title</option>
					<option value='c' selected="${pageVO.type} =='c'">Content</option>
					<option value='w' selected="${pageVO.type} =='w'">Writer</option>
				</select> <input type='text' id='searchKeyword' value="${pageVO.keyword}">
				<button id='searchBtn'>Search</button>
			</div>


			<nav>

				<div>

					<ul class="pagination">
						<c:if test="${not empty result.prevPage}">
							<li class="page-item"><a
								href="${result.prevPage.pageNumber + 1} ">이전
									${result.prevPage.pageNumber + 1}</a></li>
						</c:if>

						<c:forEach items="${result.pageList}" var="p">
							<c:choose>
								<c:when test="${p.pageNumber == result.currentPageNum -1}">
									<li class="page-item active"><a href="${p.pageNumber + 1}">${p.pageNumber + 1}</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a href="${p.pageNumber +1}">${p.pageNumber + 1}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${not empty result.nextPage}">
							<li class="page-item"><a
								href="${result.nextPage.pageNumber + 1}">다음
									${result.nextPage.pageNumber + 1}</a></li>
						</c:if>
					</ul>
				</div>
			</nav>
	</div>

	<form id='f1' action="./blist" method="get">
		<input type='hidden' name='page' value="${result.currentPageNum}">
		<input type='hidden' name='size'
			value="${result.currentPage.pageSize}"> <input type='hidden'
			name='type' value="${pageVO.type}"> <input type='hidden'
			name='keyword' value="${pageVO.keyword}"> <input
			type='hidden' name='cno' value="${pageVO.cno}">
	</form>


	<script type="text/javascript">
		$(window).load(function() {

			var msg = "<c:out value='${msg}'/>";

			if (msg == 'success') {
				alert("정상적으로 처리되었습니다.");
				var stateObj = {
					msg : ""
				};
			}

		});

		$(document)
				.ready(
						function() {
							var formObj = $("#f1");

							$(".pagination a").click(
									function(e) {

										e.preventDefault();
										formObj.find('[name="page"]').val($(this).attr('href'));
										formObj.submit();
									});

							$(".boardLink")
									.click(
											function(e) {

												e.preventDefault();

												var boardNo = $(this).attr("href");

												formObj.attr("action", "./bview");
												formObj.append("<input type='hidden' name='bno' value='" + boardNo +"'>");

												formObj.submit();

											});

							$("#searchBtn").click(
									function(e) {

										var typeStr = $("#searchType").find(
												":selected").val();
										var keywordStr = $("#searchKeyword")
												.val();

										console.log(typeStr, "", keywordStr);

										formObj.find("[name='type']").val(typeStr);
										formObj.find("[name='keyword']").val(keywordStr);
										formObj.find("[name='page']").val("1");
										formObj.submit();
									});

						});
	</script>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>