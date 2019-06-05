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
    <script src="${url}static/js/app.js"></script>
    <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<meta name="uid" content="${uid}"/>
	<meta name="chrno" content="${chrno}"/>
</head>
<body>
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
</body>
</html>