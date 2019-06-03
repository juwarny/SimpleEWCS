<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<meta charset="UTF-8">
<title>WCS page</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
		  <!--<link rel="stylesheet" href="./main.css"/>-->
		  <style type="text/css">
		    body {
		      padding-top: 70px;
		    }
		    footer{
		      position : fixed;
		      bottom:0;
		    }
		  </style>
		  <c:url value='/' var="root"/>
<script src="${root}static/js/vendor/modernizr-2.8.3.min.js"></script>
<script src="${root}static/js/vendor/jquery-1.12.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<meta name="root" content="${root}"/>
</head>