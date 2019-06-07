<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
	<c:url value='/' var="root"/>
	<link rel="stylesheet" type="text/css" href="${root}static/css/autocomplete.css"/>
	<script src="${root}static/js/autocomplete.js"></script>
	<script src="${root}static/js/stock.js"></script>
	<script src="${root}static/js/updown.js"></script>
	<script src="https://www.amcharts.com/lib/4/core.js"></script>
	<script src="https://www.amcharts.com/lib/4/charts.js"></script>
	<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
	<meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<sec:authentication var="principal" property="principal"/>
			<c:choose>
				<c:when test="${principal eq 'anonymousUser'}">
					<c:set var="uid" value=""/>
				</c:when>
				<c:otherwise>
					<c:set var="uid" value="${principal.member.uid}"/>
				</c:otherwise>
			</c:choose>
			<meta name="uid" content="${uid}"/>
<style>
body {
	background-color: #eee;
}

.container {
	margin: 150px auto;
}

#chartdiv {
	width: 100%;
	height: 500px;
}
.slidecontainer {
  width: 100%;
}

.slider {
  -webkit-appearance: none;
  width: 100%;
  height: 15px;
  border-radius: 5px;   
  background: #d3d3d3;
  outline: none;
  opacity: 0.7;
  -webkit-transition: .2s;
  transition: opacity .2s;
}

.slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 25px;
  height: 25px;
  border-radius: 50%; 
  background: #4CAF50;
  cursor: pointer;
}

.slider::-moz-range-thumb {
  width: 25px;
  height: 25px;
  border-radius: 50%;
  background: #4CAF50;
  cursor: pointer;
}

.slider:hover {
  opacity: 1;
}


</style>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>
	
	<form autocomplete="off" action="/action_page.php">
	  <div class="autocomplete" style="width:300px;">
	    <input id="stockInput" type="text" name="stocklist" placeholder="Stock">
	  </div>
	  <input type="submit">
	</form>
	<div>
    	<div id="chartdiv"></div>
  	</div>
  	<div class="container">
		<label>avg</label><button class="btn" id="avg"></button>
		<label>count</label><button class="btn" id="count"></button>
	</div>
  	<div class="slidecontainer">
	  <p>당신의 의견</p>
	  <input type="range" min="-10" max="10" value="0" class="slider" id="userOpinion">
	</div>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>