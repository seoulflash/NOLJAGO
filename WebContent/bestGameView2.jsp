<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="sessionCheck.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
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
	/* nav */
	.nav #img {
    	width: 20px;
    	margin-top: 2px;
    	margin-right: 5px;
   	}
	/* ---------- Jumbotron ---------- */
	.jumbotron {
		position: relative;
		background-image: linear-gradient(120deg, #89f7fe 0%, #66a6ff 100%);
		color: white;
		border-radius: 30px;
		margin-bottom: 0;
		text-shadow: black 0.5em 0.2em 0.9em;
		overflow: hidden;
		opacity: 0.8;
	}
	#jumbotron
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
	.jumbotron #searchButton {
		border: 1px solid #005aa7;
		color: white;
		background-color: #005aa7;
	}
	.jumbotron #searchBar {
		border-right: none;
	}
	/* 로그인 후 내정보 메뉴 */
	li #point,
	li #resTot,
	li #totGood {
		color: #005aa7;
		font-weight: bold;
	}
	.badge {
		background-color: #408ec9;
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
	.text-title #text-head {
		font-weight: bold;
		font-size: 2em;
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
	
	
	<!-- 슬라이드 스타일  -->
	<style media="screen">
		*{
			margin: 0;
			padding: 0;
		}
		.slide{
			width : 500px;
			height: 500px;
			overflow: hidden;
			position: relative;
			margin: 0 auto;
		}
		.slide ul{
			 width: 1500px;
			 position: absolute;
			 top:0;
			 left: 0;
			 font-size: 0;
		}
		.slide ul li{
			display: inline-block;
		}
		#back{
			position: absolute;
			top: 250px;
			left: 0;
			cursor: pointer;
			z-index: 1;
		}
		#next{
			position: absolute;
			top: 250px;
			right: 0;
			cursor: pointer;
			z-index: 1;
		}
		
		.slide2{
			width : 500px;
			height: 500px;
			overflow: hidden;
			position: relative;
			margin: 0 auto;
		}
		.slide2 ul{
			 width: 1500px;
			 position: absolute;
			 top:0;
			 left: 0;
			 font-size: 0;
		}
		.slide2 ul li{
			display: inline-block;
		}
		#back2{
			position: absolute;
			top: 250px;
			left: 0;
			cursor: pointer;
			z-index: 1;
		}
		#next2{
			position: absolute;
			top: 250px;
			right: 0;
			cursor: pointer;
			z-index: 1;
		}
		
		#box {
			position: absolute;
			text-align: center;
			color:white;
			bottom: 0;
			background: #4C4C4C;
			border: none;
			right: 250;
			width: 500px;
			right: 0;
			/* cursor: pointer;
			z-index: 1; */
		/* display: block; */
		/* 
		right: 250;
		width: 500px;
		height: 500px;
		margin-left: 80px;
		margin-top: 50px; */
	}
	
	
	
	#imgs{
		width: 500px;
		height: 500px;
	}
	
	.carousel-caption{
		margin-left: 0px;
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
		/* 쪽지함 팝업창 띄우기  */
	     function openMessagePopup(){
	        var   url = "messageList.do?id=${id}";
	        var name = "messageList"
	        window.open(url,name,"width=500,height=650,left=200,top=200")
	    }
		
		
		
	</script>
</head>
<body>

<%
	if(session.getAttribute("id") != null)
		id = (String)session.getAttribute("id");
%>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="sr-only"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href='main.do?id=${id}'>놀자GO!</a>
			</div>
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="#"><span class="sr-only"></span>내주변</a></li>
					<li><a href="bestGame.do">놀자GO! BEST</a></li>
					<li><a href="partyboard.do">함께놀기</a></li>
					<li><a href="boardList.do">게시판</a></li>
				</ul>
				<%	if(id == null || id=="") { %>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="login.do">로그인</a></li>
						<li><a href="agree.do">회원가입</a></li>
					</ul>
				<%	} else { %>
				<c:if test="${admin == 1 }">
				<ul class="nav navbar-nav navbar-right">
					<li><a href='myres.do?id=${id}'>예약내역<span class="badge">${resTotCnt}</span></a></li>
					<li><a onclick="openMessagePopup();">쪽지함</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><img src="images/home.png" class="pull-left img-responsive img-circle" id="img">${name }님<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href='myinfo.do?id=${id}'>내 정보</a></li>
						<li><a href='mypoint.do?id=${id}'>포인트<span id="point">&nbsp;<fmt:formatNumber value="${point }" pattern="#,###"></fmt:formatNumber>P</span></a></li>
						<li><a href='myres.do?id=${id}'>예약내역<span id="resTot">&nbsp;${resTotCnt}건</span></a></li>
						<li><a href='myfavorite.do?id=${id}'>좋아요<span id="totGood">&nbsp;${totGood}개</span></a></li>
						<li><a href="logoutAction.do">로그아웃</a></li>
						<li><a href="#">1:1 문의하기</a></li>
					</ul></li>
				</ul>
				</c:if>
				<c:if test="${admin == 3 }">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><img src="images/home.png" class="pull-left img-responsive img-circle" id="img">${name }님<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="adminMain.do">관리하기</a></li>
						<li><a href="logoutAction.do">로그아웃</a></li>
					</ul></li>
				</ul>
				</c:if>
				<%
					}
				%>
			</div>
		</div>
	</nav>





	<h2 align="center"><b>놀자Go! 이달의  BEST</b></h2>
	
	
	<!------------------------ vr 랭킹 ------------------------->
	<div style="float:left; width: 50%;">
	<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
	  <!-- Indicators -->
	  <ol class="carousel-indicators">
	    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	    <li data-target="#carousel-example-generic" data-slide-to="3"></li>
	  </ol>
	  <!-- Wrapper for slides -->
	  <div class="carousel-inner" role="listbox">
	    <div class="item active">
	      <img src="images/vr_rank.PNG" alt="" id="imgs">
	    </div>
	    <c:forEach var="v_review" items="${v_review }" varStatus="status">
	    <div class="item">
	      <img src="images/${v_review.image1 }" alt="" id="imgs">
	      <div class="carousel-caption">
	      	<div style="width: 500px; margin-top:-470px; margin-left: -100px;"><h2 id="rankText" style="background-color: black;">
		      	<c:if test="${status.index == 0 }">
		       		<img alt="" src="images/1rank.PNG" style="width: 30px; height: 30px;">
		       	</c:if>
		       	<c:if test="${status.index == 1 }">
		       		<img alt="" src="images/2rank.PNG" style="width: 30px; height: 30px;">
		       	</c:if>
		       	<c:if test="${status.index == 2 }">
		       		<img alt="" src="images/3rank.PNG" style="width: 30px; height: 30px;">
		       	</c:if>
	      	<b>${v_review.cname }</b>
	      	</h2>
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
	<div style="float:left; width: 50%;">
	<div id="carousel-example-generic1" class="carousel slide" data-ride="carousel">
	  <!-- Indicators -->
	  <ol class="carousel-indicators">
	    <li data-target="#carousel-example-generic1" data-slide-to="0" class="active"></li>
	    <li data-target="#carousel-example-generic1" data-slide-to="1"></li>
	    <li data-target="#carousel-example-generic1" data-slide-to="2"></li>
	    <li data-target="#carousel-example-generic1" data-slide-to="3"></li>
	  </ol>
	  <!-- Wrapper for slides -->
	  <div class="carousel-inner" role="listbox">
	    <div class="item active">
	      <img src="images/room_rank.PNG" alt="" id="imgs">
	    </div>
	    <c:forEach var="r_review" items="${r_review }" varStatus="status">
	    <div class="item">
	      <img src="images/${r_review.image1 }" alt="" id="imgs">
	      <div class="carousel-caption" style="margin-left: 10px;">
	       	<h3 style="background-color: black;">
		       	<c:if test="${status.index == 0 }">
		       		<img alt="" src="images/1rank.PNG" style="width: 30px; height: 30px;">
		       	</c:if>
		       	<c:if test="${status.index == 1 }">
		       		<img alt="" src="images/2rank.PNG" style="width: 30px; height: 30px;">
		       	</c:if>
		       	<c:if test="${status.index == 2 }">
		       		<img alt="" src="images/3rank.PNG" style="width: 30px; height: 30px;">
		       	</c:if>
	       	<b>${r_review.cname }</b>
	       	</h3>
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
	
	
	
	
	<%-- <div style="float:left; width: 50%;">
		<h4 style="text-align: center; margin-bottom: 25px;"><b>VR 인기 Best 3</b></h4>
		<div class="slide" style="margin-bottom: 20px;">
			<img id="back" alt="" src="images/i_back.png" width="50">
			<ul>
				<c:forEach var="v_review" items="${v_review }">
					<li>
						<a href="vrList1View.do?cnum=${v_review.cnum }">
						<img alt="" src="images/${v_review.image1 }" width="500px;" height="500px;"></a>
					</li>
					
				</c:forEach>
			</ul>
			<img id="next" alt="" src="images/i_next.png" width="50">
		</div>
	</div> 
	
	
	
	<div style="float:left; width: 50%;">
		<h4 style="text-align: center; margin-bottom: 25px;"><b>VR 평점 Best 3</b></h4>
		<div class="slide2" style="margin-bottom: 20px;">
			<img id="back2" alt="" src="images/i_back.png" width="50">
			<ul>
				<c:forEach var="v_review2" items="${v_review2 }">
					<li><img alt="" src="images/${v_review2.image1 }" width="500px;" height="500px;"></li>
				</c:forEach>
			</ul>
			<img id="next2" alt="" src="images/i_next.png" width="50">
		</div>
	</div>
	
	

	<div style="float: left; width: 50%;">
		<h4 style="text-align: center; margin-bottom: 25px;"><b>방탈출 인기 Best 3</b></h4>
		<div class="slide2" style="margin-bottom: 20px;">
			<img id="back2" alt="" src="images/i_back.png" width="50">
			<ul>
				<c:forEach var="r_review" items="${r_review }">
					<li>
						<a href="roomList.do?cnum=${r_review.cnum }">
							<img alt="" src="images/${r_review.image1 }" width="500px;" height="500px;">
						</a>
					</li>
				</c:forEach>
			</ul>
			<img id="next2" alt="" src="images/i_next.png" width="50">
		</div>
	</div>
	
	
	
	<div style="float: left; width: 50%;">
		<h4 style="text-align: center; margin-bottom: 25px;"><b>방탈출 평점 Best 3</b></h4>
		<div class="slide2" style="margin-bottom: 20px;">
			<img id="back2" alt="" src="images/i_back.png" width="50">
			<ul>
				<c:forEach var="r_review2" items="${r_review2 }">
					<li>div<img alt="" src="images/${r_review2.image1 }" width="500px;" height="500px;"></li>
				</c:forEach>
				
			</ul>
			<img id="next2" alt="" src="images/i_next.png" width="50">
		</div>
	</div>  --%>
			
	
	
	
	

</body>


</html>
<%-- <%@include file="footer.jsp" %> --%>
