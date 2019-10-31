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
	<div class="container py-5">
    <div class="row">
        <div class="col-md-12">            
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <!-- form card login -->
                    <div class="card rounded-0">
                        <div class= "mx-auto" style="margin:1em;">
                        	<c:url value='/' var="url"/>                        		                        	
                        	<img id="login-logo" src="${url}static/img/logo-wcs.svg" width="200" height="200" alt="WCS">
                        </div>
                        <div class="card-body">
                            <form class="form" role="form" autocomplete="off" id="formLogin" novalidate="" method="POST">
                                <div class="form-group">
                                    <label>아이디</label>
                                    <input type="text" class="form-control form-control-lg rounded-0" name="uid" required="">
                                </div>
                                <div class="form-group">
                                    <label>비밀번호</label>
                                    <input type="password" class="form-control form-control-lg rounded-0" name="upw" required="" autocomplete="new-password">
                                </div>
                                <div class="form-group">
                                    <label>이름</label>
                                    <input type="text" class="form-control form-control-lg rounded-0" name="uname" required="">
                                </div>
                                <div class="form-group">
	                                <input type="checkbox" name="roles[0].roleName" value="BASIC" checked/>BASIC
									<!-- <input type="checkbox" name="roles[1].roleName" value="MANAGER" checked/>MANAGER
									<input type="checkbox" name="roles[2].roleName" value="ADMIN" checked/>ADMIN  -->                          
								</div>
                                <button class="btn btn-lg btn-primary btn-block" type="submit">JOIN</button>
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
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>