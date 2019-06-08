<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta charset="UTF-8">
<title>WCS page</title>

<c:url value='/' var="root" />
<script src="${root}static/js/vendor/modernizr-2.8.3.min.js"></script>
<script src="${root}static/js/vendor/jquery-1.12.0.min.js"></script>
<script src="${root}static/js/vendor/bootstrap.bundle.js"></script>
<link rel="stylesheet" href="${root}static/css/bootstrap.css" />
<style type="text/css">
body {
	padding-top: 70px;
}

footer {
	position: fixed;
	bottom: 0;
	margin-top: 10em;
}
</style>
<meta name="root" content="${root}" />
</head>