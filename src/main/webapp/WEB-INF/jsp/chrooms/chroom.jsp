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
	<div class="container-fluid">
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<h1 class="text-center">${vo.title}</h1>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<ul class="list-group">
					<li class="list-group-item">
						<div class="row align-items-center justify-content-between">
							<div class="col">
								<h5 class="text-left">작성자 : ${vo.member.uid}</h5>
							</div>
							<div class="col">
								<fmt:formatDate value="${vo.regdate}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/>
								<h5 class="text-right">수정 날짜 : ${formattedDate}</h5>	
							</div>													
						</div>
					</li>
					<li class="list-group-item">
						 <div class="row my-2">
						 	<div class="btn-group float-right">
						        <button id="connect" class="btn btn-primary pull-right mx-2" type="submit">참여하기</button>
						        <button id="disconnect" class="btn btn-warning pull-right mx-2" type="submit" disabled="disabled">방나가기</button>
					        </div>					 
					    </div>
					    <div class="row">
					        <div class="col-md-12">
					        	<div id="conversation">
					        		<div id="received-message">
					        		
					        		</div>					        		
					        	</div>
					        
					        </div>
					    </div>
					</li>
					<li class="list-group-item">
						<form>
					    	<div class="form-row align-items-center">
					    		<div class="input-group">
					    			<input type="text" id="send-message" class="form-control" placeholder="message here...">
					    			<button id="send" class="btn btn-primary" type="submit">보내기</button>
					    		</div>    
					        </div>					        
					     </form>
					</li>
				</ul>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<form action="">
					<input type="hidden" class="form-control" name="chrno" value="${vo.chrno}" readonly="readonly" />
					<input type="hidden" class="form-control" name="writer" value="${vo.member.uid}" readonly="readonly"/>
					<input type="hidden" class="form-control" name="title" value="${vo.title}" readonly="readonly" />
					<fmt:formatDate value="${vo.regdate}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/>
					<input type="hidden" class="form-control" name="regDate" value="${formattedDate}" readonly="readonly" />
				</form>
			</div>
		</div>
		<div class="row mb-4">
			<div class="col-8 mx-auto">
				<sec:authentication var="principal" property="principal"/>
				<c:choose>
					<c:when test="${principal eq 'anonymousUser'}">
						<c:set var="uid" value=""/>
					</c:when>
					<c:otherwise>
						<c:set var="uid" value="${principal.member.uid}"/>
					</c:otherwise>
				</c:choose>

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
				<div class="btn-group float-right">
					<a href="${url}" class="btn btn-warning pull-right mx-2" id='goModBtn'>수정/삭제</a>
					<a href="${url2}" class="btn btn-primary pull-right">채팅방 리스트</a>
				</div>				
			</div>
		</div>
	</div>
	<!--  start chat -->
	<div id="main-content" class="container">
   
</div>
	<c:url value='/' var="url3"/>
	<script type="text/javascript" src="${url3}static/js/chatapp.js"></script>	
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>
