<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value='/' var="url" />
<style type="text/css">

body{
	background-image: url("<c:out value='${url}static/img/index-image.jpg'/>");
	background-repeat: no-repeat;
	background-position: center center;
	background-attachment: fixed;
	background-size: cover;	
}
#custom-nav{
	background-color: rgba(0,0,0,0.0);
}
.vertical-center {
  width:100%;
  margin-left: auto;
  margin-right:auto;
  position: absolute;
  top: 20%;
  right: 50%;
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
  -ms-transform: translateX(+50%);
  transform: translateX(+50%);
}
h1{
	font-family: "Black Han Sans";
	font-size: 10em;
}
.card-body{
	height: 15px;
}
.card{

}
</style>
</head>
<body class="img-fluid">
	<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>	
	<sec:authentication var="principal" property="principal" />
	<nav id="custom-nam" class="navbar navbar-expand-md navbar-dark fixed-top">
		<a class="navbar-brand" href="${url}index"> 
			<img id="main-logo" src="${url}static/img/logo-wcs.svg" width="60" height="60" alt="WCS">
		</a>
		<div class="collapse navbar-collapse" id="navbarCollapse">
			<ul class="navbar-nav mr-auto"></ul>
			<form class="form-inline mt-2 mt-md-0">
				<c:choose>
					<c:when test="${principal eq 'anonymousUser'}">
						<c:set var="uid" value="" />
						<a class="btn btn-outline-light btn-lg my-2 my-sm-0" href='${url}signin'>Log
							In</a>
					</c:when>
					<c:otherwise>
						<c:set var="uid" value="${principal.member.uid}" />
						<a id="outBtn" class="btn btn-outline-light btn-lg my-2 my-sm-0" href='#'>Log
							Out</a>
					</c:otherwise>
				</c:choose>
			</form>
			<form id="logoutform" method="post">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
	</nav>
	<div role="main" class="vertical-center text-center align-items-center">
			<h1 class="text-white my-4">방구석 경제 전문가</h1>
			<div id="row-menu"class="row justify-content-center">
				<div class="card mx-4 my-4" style="width: 20rem;">					
					<img src="${url}static/img/chatting-icon.svg" class="card-img-top" alt="WCS" style="max-height:50%;">
					<div class="card-body">
						<h4 class="card-title">
							<strong>채팅 토론</strong>
						</h4>
						<p class="card-text">경제, 종목 매매에 대한 실시간 채팅을 참여하실 수 있습니다.</p>
						<p class="card-text"><a href="${url}chrooms/chlist"><strong>서비스 이용하기</strong></a></p>
					</div>
				</div>
				<div class="card mx-4 my-4 rounded-lg" style="width: 20rem;">
					<img src="${url}static/img/board-icon.svg" class="card-img-top" alt="WCS" style="max-height:50%;">
					<div class="card-body">
						<h4 class="card-title">
							<strong>토픽 게시판</strong>							
						</h4>
						<p class="card-text">다양한 주제를 가지니 게시판에 당신의 글을 공유하세요.</p>
						<p class="card-text"><a href="${url}boards/topic"><strong>서비스 이용하기</strong></a></p>
					</div>
				</div>
				<div class="card mx-4 my-4" style="width: 20rem;">
					<img src="${url}static/img/updown-icon.svg" class="card-img-top" alt="WCS" style="max-height:50%;">
					<div class="card-body">
						<h4 class="card-title">
							<strong>UP&DOWN</strong>
						</h4>
						<p class="card-text">일주일 간 사람들이 생각하는 주식 종목의 미래를 예측해 보세요.</p>
						<p class="card-text"><a href="${url}updown/udsearch"><strong>서비스 이용하기</strong></a></p>
					</div>
				</div>
				<div class="card mx-4 my-4" style="width: 20rem;">
					<img src="${url}static/img/news-icon.svg" class="card-img-top" alt="WCS" style="max-height:50%;">
					<div class="card-body">
						<h4 class="card-title">
							<strong>일일뉴스</strong>
						</h4>
						<p class="card-text">사람들이 주목하는 일간 최신 뉴스를 확인해보세요.</p>
						<p class="card-text"><a href="${url}dailynews/dnlist"><strong>서비스 이용하기</strong></a></p>
					</div>
				</div>
			</div>
			<div class="row justify-content-center">
				<h4 class="text-white mt-5"><strong>Copyright ⓒ 방구석 경제 전문가들, All rights Reserved.</strong></h4>
			</div>
	</div>
</body>
<script type="text/javascript">
  $(document).ready(function(){
		$("#outBtn").click(function(){
			var url = '<c:out value="${url}signout"/>'
			var formObj = $("#logoutform");				
			formObj.attr("action", url);
			formObj.attr("method", "post");
			formObj.submit();
		});
	});
 </script>
</html>