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
					<li><a href="${url}main">Home</a></li>
					<li><a href="#">채팅 토론</a></li>
					<li><a href="${url}boards/topic">토픽 게시판</a></li>
					<li><a href="#">UP&Down</a></li>
					<li><a href="${url}dailynews/dnlist">일일뉴스</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li>
						<button type="button" class="btn btn-default navbar-btn">
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
  <div id="tradingview_d3c8d"></div>
  <div class="tradingview-widget-copyright">TradingView 제공 <a href="https://kr.tradingview.com/symbols/NASDAQ-AAPL/" rel="noopener" target="_blank"><span class="blue-text">AAPL 차트</span></a></div>
  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
  <script type="text/javascript">
  new TradingView.widget(
  {
  "autosize": true,
  "symbol": "NASDAQ:AAPL",
  "interval": "D",
  "timezone": "Etc/UTC",
  "theme": "Light",
  "style": "1",
  "locale": "kr",
  "toolbar_bg": "#f1f3f6",
  "enable_publishing": false,
  "allow_symbol_change": true,
  "container_id": "tradingview_d3c8d"
}
  );
  </script>
</div>
<!-- TradingView Widget END -->