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
	<c:set var="res" value="${result.result}"/>
	<div class="container-fluid">
		<div class="row justify-content-end my-4">
			<div class="col-8 mx-auto">
				<c:url value="./chregister" var="url"/>
				<div class="btn-group float-right">
					<a class="btn btn-info pull-right" href="${url}">새 채팅방</a>
				</div>
			</div>			
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<ul class="list-group">
					<c:forEach items="${res.content}" var="arr">
						<li class="list-group-item">
							<div class="row align-items-center">
								<div class="col-md-8">
									<div class="card-body">
										<h5 class="card-title">
											<a href="${arr[0]}" class="boardLink" style="text-decoration:none;" >${arr[1]}</a>
										</h5>
										<p class="card-text">
											${arr[2]}
										</p>
										<p class="card-text">
											<fmt:formatDate value="${arr[3]}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/>
											<small class="text-muted ">${formattedDate}</small>
										</p>
									</div>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="row justify-content-start my-4">
			<div class="col-8 mx-auto">
				<div class="form-inline">
					<div class="form-group mb-2">
						<input class="form-control" type='text' id='searchKeyword' value="${pageVO.keyword}">
					</div>
					<button id='searchBtn' class="btn btn-primary mb-2">Search</button>
				</div>				
			</div>
		</div>
		<div class="row my-4">
			<div class="col-md-auto mx-auto">
				<nav>
					<ul class="pagination">
						<c:if test="${not empty result.prevPage}">
							<li class="page-item"><a class="page-link"
								href="${result.prevPage.pageNumber + 1} ">이전
									${result.prevPage.pageNumber + 1}</a></li>
						</c:if>
						<c:forEach items="${result.pageList}" var="p">
							<c:choose>
								<c:when test="${p.pageNumber == result.currentPageNum -1}">
									<li class="page-item active"><a class="page-link" href="${p.pageNumber + 1}">${p.pageNumber + 1}<span class="sr-only">(current)</span></a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a href="${p.pageNumber +1}">${p.pageNumber + 1}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${not empty result.nextPage}">
							<li class="page-item"><a class="page-link"
								href="${result.nextPage.pageNumber + 1}">다음
									${result.nextPage.pageNumber + 1}</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
	</div>

	<form id='f1' action="./chlist" method="get">
		<input type='hidden' name='page' value="${result.currentPageNum}">
		<input type='hidden' name='size' value="${result.currentPage.pageSize}"> 
		<input type='hidden' name='keyword' value="${pageVO.keyword}"> 
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

												var chroomNo = $(this).attr("href");

												formObj.attr("action", "./chroom");
												formObj.append("<input type='hidden' name='chrno' value='" + chroomNo +"'>");

												formObj.submit();

											});

							$("#searchBtn").click(
									function(e) {
										var keywordStr = $("#searchKeyword")
												.val();

										//console.log(typeStr, "", keywordStr);

										formObj.find("[name='keyword']").val(keywordStr);
										formObj.find("[name='page']").val("1");
										formObj.submit();
									});

						});
	</script>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>