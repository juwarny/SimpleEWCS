<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
	<c:url var="url" value="/"/>
    <title>Hello WebSocket</title>
    <link href="${url}static/css/main.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<sec:authentication var="principal" property="principal"/>
	<c:choose>
		<c:when test="${principal eq 'anonymousUser'}">
			<c:set var="uid" value="" />
		</c:when>
		<c:otherwise>
			<c:set var="uid" value="${principal.member.uid}" />
		</c:otherwise>
	</c:choose>
	<meta name="uid" content="${uid}"/>
	<meta name="chrno" content="${vo.chrno}"/>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>

	<div class="panel-heading">View Page</div>
	<div class="panel-body">

		<form action="${'/login'}"></form>

		<div class="form-group">
			<label>BNO</label>
			<input class="form-control" name="bno" value="${vo.chrno}" readonly="readonly" />
		</div>

		<div class="form-group">
			<label>Title</label>
			<input class="form-control" name="title" value="${vo.title}" readonly="readonly" />
			<p class="help-block">Title text here.</p>
		</div>

		<div class="form-group">
			<label>Writer</label>
			<!-- 수정이 필요할수도있음 -->
			<input class="form-control" name="writer" value="${vo.member.uid}" readonly="readonly" />
		</div>

		<div class="form-group">
			<label>RegDate</label>
			<fmt:formatDate value="${vo.regdate}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/>
			<input class="form-control" name="regDate" value="${formattedDate}" readonly="readonly" />
		</div>
		<!-- 수정이 필요할수도있음 -->
		<div class="pull-right">
			<c:url value="./chmodify" var="url">
			  <c:param name="page" value="${pageVO.page}"/>
			  <c:param name="size" value="${pageVO.size}"/>
			  <c:param name="keyword" value="${pageVO.keyword}"/>
			  <c:param name="chrno" value="${vo.chrno}"/>
			</c:url>
			<c:url value="./chlist" var="url2">
			  <c:param name="page" value="${pageVO.page}"/>
			  <c:param name="size" value="${pageVO.size}"/>
			  <c:param name="keyword" value="${pageVO.keyword}"/>
			  <c:param name="chrno" value="${vo.chrno}"/>
			</c:url>
			<a href="${url}" class="btn btn-default" id='goModBtn'>Modify/Delete</a>
			<a href="${url2}" class="btn btn-primary">Go List</a>
		</div>

	</div>
	
	<!--  start chat -->
	<div id="main-content" class="container">
    <div class="row">
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <label for="connect">채팅 연결</label>
                    <button id="connect" class="btn btn-default" type="submit">참여하기</button>
                    <button id="disconnect" class="btn btn-default" type="submit" disabled="disabled">방나가기</button>
                </div>
            </form>
        </div>
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <label for="send-message">메시지를 보내세요</label>
                    <input type="text" id="send-message" class="form-control" placeholder="message here...">
                </div>
                <button id="send" class="btn btn-default" type="submit">Send</button>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table id="conversation" class="table table-striped">
                <thead>
                <tr>
                    <th>uid</th>
                    <th>message</th>
                </tr>
                </thead>
                <tbody id="received-message">
                </tbody>
            </table>
        </div>
    </div>
</div>
	<c:url value='/' var="url3"/>
	<script type="text/javascript" src="${url3}static/js/chatapp.js"></script>	
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>
