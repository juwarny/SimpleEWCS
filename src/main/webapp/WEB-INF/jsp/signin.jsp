<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>
	<div class="panel-body">
		
		<c:if test="${not empty param.error}">
			<h2>Invalid Username or password</h2>
			<h2>"${param.error}"</h2>
		</c:if>
		<c:if test="${not empty param.logout}">
			<h2>You have been logged out.</h2>
		</c:if>
	</div>
	<div class="container py-5">
    <div class="row">
        <div class="col-md-12">            
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <!-- form card login -->
                    <div class="card rounded-0">
                        <div class= "mx-auto" style="margin:1em;">                        	
                        		<img id="login-logo" src="${url}static/img/logo-wcs.svg" width="200" height="200" alt="WCS">
                        </div>
                        <div class="card-body">
                            <form class="form" role="form" autocomplete="off" id="formLogin" novalidate="" method="POST">
                                <div class="form-group">
                                    <label>아이디</label>
                                    <input type="text" class="form-control form-control-lg rounded-0" id="username" name="username" required="">
                                </div>
                                <div class="form-group">
                                    <label>비밀번호</label>
                                    <input type="password" class="form-control form-control-lg rounded-0" id="password" name="password" required="" autocomplete="new-password">
                                </div>
                                
                                <div class="checkbox mb-3">
									<label> <input type="checkbox" id="remember-me" name="remember-me">Remember me</label>
								</div>                                
                                <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
                                <p><h5 class="text-center">OR</h5></p>
                                <a class="btn btn-lg btn-info btn-block" href="./member/signup">회원가입</a>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </form>
                        </div>
                        <!--/card-block-->
                    </div>
                    <!-- /form card login -->
                </div>
            </div>
            <!--/row-->
        </div>
        <!--/col-->
    </div>
    <!--/row-->
</div>
<!--/container-->
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>