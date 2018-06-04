<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/noljaBooster.css">
	<title>심심할땐? 놀자GO!</title>
	<script type="text/javascript">
	function keyword_check() {
		console.log("keyword_check called");
		if (document.search_engine.keyword.value == "" || document.search_engine.keyword.value == null) {
			alert("검색어를 입력하세요");
			document.search_engine.keyword.focus();
			return false;
		}
		return true;
	}
	</script>
	<style type="text/css">
	/* ---------- Jumbotron ---------- */
	.jumbotron {
		position: relative;
		/* background-image: linear-gradient(120deg, #89f7fe 0%, #66a6ff 100%); */ /* 테스트용 그라디언트 */
		color: white;
		border-radius: 30px;
		margin-bottom: 0;
		text-shadow: black 0.5em 0.2em 0.9em;
		overflow: hidden;
		opacity: 0.8;
	}
	.jumbotron h1 {
		margin-top: 100px;
		font-size: 55px;
		font-weight: bolder;
	}
	.jumbotron p {
		font-weight: bolder;
	}
	.jumbotron .search {
	}
	#video { 
		position: absolute;
		height: auto;
		width: auto;
		min-height: 100%;
		min-width: 100%;
		left: 50%;
		top: 50%;
		-webkit-transform: translate3d(-50%, -50%, 0);
		transform: translate3d(-50%, -50%, 0);
		z-index: -1;
	}
	.jumbotron #searchButton {
		border: 1px solid #005aa7;
		color: white;
		background-color: #005aa7;
	}
	.jumbotron #searchBar {
		border-right: none;
	}
	/* 장르별 메뉴 영역 */
	.themeMenu .btn {
		color: darkgray;
		font-size: 2em;
		font-weight: bold;
		border-radius: 0;
		padding-top: 20px;
		margin: 0 60px 0 60px;
		width: 120px;
		height: 70px;
	}
	.themeMenu .btn:hover {
		color: springgreen;
		box-shadow: none;
	}
	.themeMenu img {
		width: 40%;
	}
	/* 장르별 영역 하단 HR  */
	#line1 {
		margin-top: 15px;
		margin-bottom: 30px;
	}
	/* 놀자고 BEST 영역 */
	.img-title img {
		width: 80px;
	}
	.text-title {
		margin-top: 15px;
	}
	.text-title a:hover {
		text-decoration: none;
	}
	.text-title #text-head {
		font-weight: bold;
		font-size: 2em;
	}
	/* 슬라이드 영역  */
	.slide-box {
		width: 80%;
		height: 350px;
		margin-top: 50px;
	}
	.slide{
		width : 300px;
		height: 300px;
		overflow: hidden;
		position: relative;
		margin: 0 auto;
	}
	#imgs{
		width: 300px;
		height: 300px;
	}
	.carousel-caption{
		margin-left: 0px;
	}
	.caro-box {
		width: 300px; 
		margin-top:-250px;
		margin-left: -60px;
		background-color: black;
		opacity: 0.8;
	}
	.caro-box img {
		width: 50px;
	}
	.caro-box #cn {
		color: white;
		font-size: 14px;
	}
	.caro-box a:hover {
		text-decoration: none;
	}
	#line2 {
		margin-bottom: 50px;
	}
	#vrlist, #relist {
		margin-bottom: -10px;
	}
	/* 소개 영역 */
	.introduce > .row > div {
		padding-left: 0;
		padding-right: 0;
	} 
	.introduce #ex-title {
		font-weight: bold;
		margin-top: 90px;
		padding-left: 30px;
		padding-right: 30px;
	}
	.introduce #ex-sub {
		font-size: 2.5rem;
		padding-left: 30px;
		padding-right: 30px;
	}
	.introduce #ex-cont {
		padding-left: 30px;
		padding-right: 30px;
	}
	#line3 {
		margin-top: 50px;
		margin-bottom: 50px;
	}
	</style>
	<script type="text/javascript">
		/* 배너 영역 & 메뉴 영역 액션 이벤트 */
		$(document).ready(function(){
			$("#themeMenu").hide();
			$("#jumboTitle").hide();
			$("#jumboText").hide();
			setTimeout("menuShow()", 0);
		});
		function menuShow() {
			$("#themeMenu").slideDown(1500);
			$("#jumboTitle").fadeIn(2000);
			$("#jumboText").fadeIn(6000);
		}
	</script>
</head>
<%@include file="menu.jsp" %>
<%------------ B O D Y ------------%>
<body>
	<!------------------  H E A D E R : JUMBOTRON  ------------------>
	<!-- 여기 바뀜  -->
	<!-- ************************************************************* -->
	<div class="container">
		<div class="jumbotron" id=jumbotron>
		<video id="video" preload="auto" autoplay="autoplay" loop="loop" muted="muted" volume="0">
		    <source src="images/vr2.mp4">
		</video>
			<div class="jumboTitle" id="jumboTitle">
				<h1 class="text-center">심심할땐? 놀자GO!</h1>
			</div>
			<div class="jumboText" id="jumboText">
				<p class="text-center">재미있는 테마 카페들이 한	곳에 !</p>
			</div>
			<div class="row">
				<div class="search col-md-8 col-md-offset-2">
					<form name = "search_engine"  action="search.do" method="get" onsubmit="return keyword_check()">
						<input type="hidden" name="id" value="${id}">
					<div class="input-group">
						<input name="keyword" class="form-control input-lg" type="search"
						placeholder="주소, 가게명으로 검색: 예)마포 브이알존" id="searchBar"/>
						<span class="input-group-btn">
							<button class="btn btn-default btn-lg" type="submit" id="searchButton">GO!</button>
						</span>
					</div>
					</form>
				</div>
			</div>
		</div>
		<!-- 장르별 메뉴 아이콘 -->
		<div class="themeMenu text-center" id="themeMenu">
			<a href='vrMainView.do?id=${id}' class="btn" role="button"><img src="images/vricon.svg"> V R</a>
			<a href='roomMain.do?id=${id}' class="btn" role="button"><img src="images/escicon.svg"> 방탈출</a>
			<a href="#" class="btn" id="icon3" role="button"><img src="images/gamepad.svg"> E T C</a>
		</div>
		<hr id="line1">
		
		<!-- 놀자고 베스트 TOP 영역  -->
		<div class="best">
			<div class="img-title">
				<img class="center-block" src="images/medalicon.svg">
			</div>
			<div class="text-title text-center">
				<a href="bestGame.do?id=${id }"><span id="text-head">놀자GO! 인기 BEST!</span></a>
			</div>
			<div class="slide-box center-block">
				<!------------------------ vr 랭킹 ------------------------->
				<div class="col-lg-6" id="vr-box">
					<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
						<!-- Indicators -->
						<ol class="carousel-indicators" id="vrlist">
							<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
							<li data-target="#carousel-example-generic" data-slide-to="1"></li>
							<li data-target="#carousel-example-generic" data-slide-to="2"></li>
							<li data-target="#carousel-example-generic" data-slide-to="3"></li>
						</ol>
						
					  	<!-- Wrapper for slides -->
					  	<div class="carousel-inner" role="listbox">
					    	<div class="item active">
					      		<img src="images/vr_rank.PNG" alt="" id="imgs" class="img-responsive">
					    	</div>
					    	<c:forEach var="v_review" items="${v_review }" varStatus="status">
					    	<div class="item">
					      		<a href="vrList1View.do?id=${id}&cnum=${v_review.cnum }">
					      			<img src="images/${v_review.image1 }" class="img-responsive" alt="" id="imgs">
					      		</a>
							   	<div class="carousel-caption">
					      			<div class="caro-box">
					      				<div id="rankText">
						     				<c:if test="${status.index == 0 }">
						      					<img alt="" src="images/1rank.PNG" class="img-responsive center-block">
						      				</c:if>
						      				<c:if test="${status.index == 1 }">
						      					<img alt="" src="images/2rank.PNG" class="img-responsive center-block">
						      				</c:if>
						      				<c:if test="${status.index == 2 }">
						      					<img alt="" src="images/3rank.PNG" class="img-responsive center-block">
						      				</c:if>
					      					<a id="cn">${v_review.cname }</a>
					      				</div>
					      			</div>
					      		</div>
					   		</div>
					    	</c:forEach>
					  	</div>
					  	<!-- Controls -->
					  	<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
					    	<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					    	<span class="sr-only">Previous</span>
					  	</a>
					  	<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
					    	<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					    	<span class="sr-only">Next</span>
					  	</a>
					</div>
				</div>
				<!--------------------------방탈출 랭킹  -------------------------->
				<div class="col-lg-6" id="re-box">
					<div id="carousel-example-generic1" class="carousel slide" data-ride="carousel">
					  	<!-- Indicators -->
					  	<ol class="carousel-indicators" id="relist">
					    	<li data-target="#carousel-example-generic1" data-slide-to="0" class="active"></li>
					    	<li data-target="#carousel-example-generic1" data-slide-to="1"></li>
					    	<li data-target="#carousel-example-generic1" data-slide-to="2"></li>
					    	<li data-target="#carousel-example-generic1" data-slide-to="3"></li>
					  	</ol>
					  	
					  	<!-- Wrapper for slides -->
					  	<div class="carousel-inner" role="listbox">
						    <div class="item active">
						      	<img src="images/room_rank.PNG" alt="" id="imgs" class="img-responsive">
						    </div>
						    
						    <c:forEach var="r_review" items="${r_review }" varStatus="status">
						    <div class="item">
						      	<a href="roomList.do?cnum=${r_review.cnum }">
						      		<img src="images/${r_review.image1 }" alt="" id="imgs" class="img-responsive">
						      	</a>
						      	<div class="carousel-caption" >
						      		<div class="caro-box">
						      			<div id="rankText">
								       		<c:if test="${status.index == 0 }">
								       			<img alt="" src="images/1rank.PNG" class="img-responsive center-block">
								       		</c:if>
								       		<c:if test="${status.index == 1 }">
								       			<img alt="" src="images/2rank.PNG" class="img-responsive center-block">
								       		</c:if>
								       		<c:if test="${status.index == 2 }">
								       			<img alt="" src="images/3rank.PNG" class="img-responsive center-block">
								       		</c:if>
							       			<a id="cn">${r_review.cname }</a>
						       			</div>
						       		</div>
						      	</div>
						    </div>
						    </c:forEach>
					  	</div>
					  	<!-- Controls -->
					  	<a class="left carousel-control" href="#carousel-example-generic1" role="button" data-slide="prev">
					    	<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					    	<span class="sr-only">Previous</span>
					  	</a>
					  	<a class="right carousel-control" href="#carousel-example-generic1" role="button" data-slide="next">
					    	<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					    	<span class="sr-only">Next</span>
					  	</a>
					</div>
				</div>
			</div>
		</div>
		<hr id="line2">
		<!-- 소개 영역 -->
		<div class="introduce">
			<div class="row">
				<div class="col-md-6">
					<img src="images/vrintroduce.jpg" style="width: 100%;">
				</div>
				<div class="col-md-6">
					<span id="text">
						<h2 id="ex-title">01</h2>
						<p id="ex-sub">실제 현실같은 가상 현실 공간</p>
						<p id="ex-cont">VR PLACE 에 오시면 모든 것이 새롭습니다.<br>실제와 같은 가상현실 안에서 재미와 모험을 느낄 수 있는 공간입니다.</p>
					</span>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6 text-right">
					<h2 id="ex-title">02</h2>
					<p id="ex-sub">실제 상황을 방불케 하는 테마룸</p>
					<p id="ex-cont">룸에 갇힌 채 60분 이내에 주어진 미션을 해결하는 신개념 문화/여가 시설<br>
	                주어진 시나리오에 따라 여러분의 명석한 두뇌로 숨겨진 암호를 파헤쳐 룸을 탈출하라</p>
				</div>
				<div class="col-md-6">
					<img src="images/escintroduce.jpg" style="width: 100%;">
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<img src="images/together.png" style="width: 100%;">
				</div>
				<div class="col-md-6">
					<h2 id="ex-title">03</h2>
					<p id="ex-sub">심심할땐?! 놀자GO!</p>
					<p id="ex-cont">심심한데 무언가를 함께 할 사람이 없을때<br>
	                	놀자GO!의 차별화된 매칭 시스템을 체험해보세요.</p>
				</div>
			</div>
			<hr id="line3">
		</div>
	</div>
</body>
</html>
<%@include file="footer.jsp" %>
