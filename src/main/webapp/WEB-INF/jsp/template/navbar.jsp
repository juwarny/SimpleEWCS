<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
	
<header>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Brand</a>
			</div>

			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav nav-pills">
					<c:url value='/' var="url"/>
					<li><a href="${url}index">Home</a></li>
					<li><a href="${url}chrooms/chlist">채팅 토론</a></li>
					<li><a href="${url}boards/topic">토픽 게시판</a></li>
					<li><a href="#">UP&Down</a></li>
					<li><a href="${url}dailynews/dnlist">일일뉴스</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li>
						<button id="login-btn" type="button" class="btn btn-default navbar-btn">
							<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
						</button>
					</li>
				</ul>
			</div>
		</div>
	</nav>
</header>
<!-- TradingView Widget BEGIN -->

	<div class="tradingview-widget-container">
	  <div class="tradingview-widget-container__widget"></div>  
	</div>
<script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-ticker-tape.js" async>
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
		$("#login-btn").click(function(){			
			$(location).attr('href', '<c:out value="${url}signin"/>');			
		});
	});	
 </script>