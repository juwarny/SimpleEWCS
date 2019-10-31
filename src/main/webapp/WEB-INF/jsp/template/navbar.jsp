<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<c:url value='/' var="url" />
<sec:authentication var="principal" property="principal" />
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-primary">
	<a class="navbar-brand" href="${url}index"> <img id="main-logo"
		src="${url}static/img/logo-wcs.svg" width="40" height="40" alt="WCS">
	</a>
	<div class="collapse navbar-collapse" id="navbarCollapse">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item"><a class="nav-link"
				href="${url}chrooms/chlist">채팅 토론</a></li>
			<li class="nav-item"><a class="nav-link"
				href="${url}boards/topic">토픽 게시판</a></li>
			<li class="nav-item"><a class="nav-link"
				href="${url}updown/udsearch">UP&Down</a></li>
			<li class="nav-item"><a class="nav-link"
				href="${url}dailynews/dnlist">일일뉴스</a></li>
		</ul>
		<form class="form-inline mt-2 mt-md-0">
			<c:choose>
				<c:when test="${principal eq 'anonymousUser'}">
					<c:set var="uid" value="" />
					<a class="btn btn-outline-light my-2 my-sm-0" href='${url}signin'>Log In</a>
				</c:when>
				<c:otherwise>
					<c:set var="uid" value="${principal.member.uid}" />
					<a id="outBtn"class="btn btn-outline-light my-2 my-sm-0" href='#'>Log Out</a>
				</c:otherwise>
			</c:choose>
		</form>
		<form id="logoutform" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
	</div>
</nav>

<!-- TradingView Widget BEGIN -->

<div class="tradingview-widget-container">
	<div class="tradingview-widget-container__widget"></div>
</div>
<script type="text/javascript"
	src="https://s3.tradingview.com/external-embedding/embed-widget-ticker-tape.js"
	async>
  {
  "symbols": [
    {
      "title": "S&P 500",
      "proName": "OANDA:SPX500USD"
    },
    {
      "title": "상하이 컴포지트",
      "proName": "INDEX:XLY0"
    },
    {
      "title": "EUR/USD",
      "proName": "FX_IDC:EURUSD"
    },
    {
      "title": "BTC/USD",
      "proName": "BITSTAMP:BTCUSD"
    },
    {
      "title": "ETH/USD",
      "proName": "BITSTAMP:ETHUSD"
    }
  ],
  "colorTheme": "light",
  "isTransparent": false,
  "displayMode": "adaptive",
  "locale": "kr"
}
  </script>
<!-- TradingView Widget END -->
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
