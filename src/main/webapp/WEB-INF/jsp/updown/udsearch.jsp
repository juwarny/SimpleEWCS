<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
<c:url value='/' var="root" />
<link rel="stylesheet" type="text/css"
	href="${root}static/css/autocomplete.css" />
<script src="${root}static/js/autocomplete.js"></script>
<script src="${root}static/js/stock.js"></script>
<script src="${root}static/js/updown.js"></script>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication var="principal" property="principal" />
<c:choose>
	<c:when test="${principal eq 'anonymousUser'}">
		<c:set var="uid" value="" />
	</c:when>
	<c:otherwise>
		<c:set var="uid" value="${principal.member.uid}" />
	</c:otherwise>
</c:choose>
<meta name="uid" content="${uid}" />
<style>
#chartdiv {
	width: auto;
	height: 450px;
}

.score {
	width: 3em;
	height: 3em;
}
</style>
</head>
<body>
	<c:url value='/' var="img" />
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<form class="">
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text text-white"
								style="background-color: #3b3838;">검 색</span>
						</div>
						<input id="stockInput" class="form-control form-control-lg"
							type="text" name="stocklist" placeholder="주식 명을 입력하세요...">
					</div>
				</form>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<div class="d-flex justify-content-center" >
					<div class="spinner-border" role="status" id="loading">
						<span class="sr-only">Loading...</span>
					</div>
				</div>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<ul class="list-group" id="stock-info-result">
					<li class="list-group-item px-0 py-1">
						<div id="chartdiv"></div>
					</li>
					<li class="list-group-item">
						<div class="row align-items-center my-2">
							<div class="col" id="avg"></div>
							<div class="col" id="count"></div>
						</div>
					</li>
					<li class="list-group-item">
						<div class="row justify-content-between my-2">
							<div class="col">
								<img class="score" alt="급락" src="${img}static/img/sad.svg">
							</div>
							<div class="col text-center">
								<img class="score" alt="평범" src="${img}static/img/default.svg">
							</div>
							<div class="col text-right">
								<img class="score" alt="급등" src="${img}static/img/smile.svg"
									style="fill: green;">
							</div>
						</div>
						<div class="row">
							<input type="range" min="-10" max="10" value="0"
								class="custom-range" id="userOpinion">
						</div>
						<div class="row justify-content-between my-2">
							<div class="col">
								<h3 class="text-primary">급락</h3>
							</div>
							<div class="col text-center">
								<h3 class="text-warning">중립</h3>
							</div>
							<div class="col text-right">
								<h3 class="text-danger">급등</h3>
							</div>
						</div>

					</li>
				</ul>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>