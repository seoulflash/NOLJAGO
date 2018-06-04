<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<title>심심할땐? 놀자GO! : BEST</title>
	<style type="text/css">
	.best-box {
		margin-top: 65px;
	}
	h2 {
		font-weight: bold;
	}
	#re-box,
	#vr-box {
		margin-bottom: 65px;	
	}
	.slide{
		width : 500px;
		height: 500px;
		overflow: hidden;
		position: relative;
		margin: 0 auto;
	}
	#imgs{
		width: 500px;
		height: 500px;
	}
	.carousel-caption{
		margin-left: 0px;
	}
	</style>
</head>
<%@include file="menu.jsp" %>
<body>
<div class="container-fluid">
	<div class="best-box">
		<div class="row text-center">
			<a><img class="center-block" src="images/medalicon.svg"></a>
		</div>
		<div style="margin-bottom: 50px;">
			<h2 align="center">놀자GO! 인기 BEST!</h2>
		</div>
		
		<!------------------------ vr 랭킹 ------------------------->
		<div id="vr-box" style="float:left; width: 50%;">
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
			      		<a href="vrList1View.do?cnum=${v_review.cnum }">
			      			<img src="images/${v_review.image1 }" alt="" id="imgs">
			      		</a>
					   	<div class="carousel-caption">
			      			<div style="width: 500px; margin-top:-470px; margin-left: -100px; background-color: black; height: 50px;">
			      				<h2 id="rankText" style="background-color: black; padding-top: 3px; padding-bottom: 1px;">
				     				<c:if test="${status.index == 0 }">
				      					<img alt="" src="images/1rank.PNG" style="width: 40px; height: 40px;">
				      				</c:if>
				      				<c:if test="${status.index == 1 }">
				      					<img alt="" src="images/2rank.PNG" style="width: 40px; height: 40px;">
				      				</c:if>
				      				<c:if test="${status.index == 2 }">
				      					<img alt="" src="images/3rank.PNG" style="width: 40px; height: 40px;">
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
		<div id="re-box" style="float:left; width: 50%;">
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
				      	<a href="roomList.do?cnum=${r_review.cnum }"><img src="images/${r_review.image1 }" alt="" id="imgs"></a>
				      	<div class="carousel-caption" >
				      		<div style="width: 500px;  margin-top:-470px; margin-left: -100px; background-color: black; height: 50px;">
				      			<h2 id="rankText" style="background-color: black; padding-top: 3px; padding-bottom: 1px;">
					       		<c:if test="${status.index == 0 }">
					       			<img alt="" src="images/1rank.PNG" style="width: 40px; height: 40px;">
					       		</c:if>
					       		<c:if test="${status.index == 1 }">
					       			<img alt="" src="images/2rank.PNG" style="width: 40px; height: 40px;">
					       		</c:if>
					       		<c:if test="${status.index == 2 }">
					       			<img alt="" src="images/3rank.PNG" style="width: 40px; height: 40px;">
					       		</c:if>
				       			<b>${r_review.cname }</b>
				       			</h2>
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
</div> <!-- 끝 나는 div -->
	
</body>
</html>
<%@include file="footer.jsp" %>
