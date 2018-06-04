<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	/* 메뉴바 프로필 이미지 크기 */
	.nav #img {
	   	width: 20px;
	   	margin-top: 2px;
	   	margin-right: 5px;
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
	#j {
		transform: rotate(90deg);
	    width: 30px;
        position: relative;
        animation-name: example;
        animation-duration: 3s;
        animation-iteration-count: infinite;
    }
    #f {
        width: 30px;
        position: relative;
        animation-name: example;
        animation-duration: 4s;
        animation-iteration-count: infinite;
    }
    #z {
    	transform: rotate(-70deg);
    	width: 30px;
    	position: relative;
        animation-name: example;
        animation-duration: 5s;
        animation-iteration-count: infinite;
    }
    @keyframes example {
   		0%   {top:0px;}
    	25%  {top:16px;}
    	50%  {top:0px;}
    	75%  {top:10px;}
    	100% {top:0px;}
    }
    #top-brand {
    	padding: 0;
    }
    .form-inline {
    	margin-left: 10px;
    }
    .form-inline img {
    	margin-right: -5px;
    }
</style>
</head>
<body>

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
				<a class="navbar-brand" id="top-brand" href='main.do?id=${id}'>
					<div class="form-inline">
						<img src="images/j.png" id="j" />
	        			<img src="images/f.png" id="f" />
	        			<img src="images/z.png" id="z" />
					</div>
				</a>
			</div>
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href='vrMainView.do?id=${id}'>VR</a></li>
					<li><a href='roomMain.do?id=${id}'>방탈출</a></li>
					<li><a href="bestGame.do?id=${id }">인기 BEST</a></li>
					<li><a href='partyboard.do?id=${id}'>함께놀기</a></li>
					<li><a href='boardList.do?id=${id}'>커뮤니티</a></li>
				</ul>
				<c:if test="${id == null || id == ''}">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="login.do">로그인</a></li>
						<li><a href="agree.do">회원가입</a></li>
					</ul>
				</c:if>
				<c:if test="${id != null }">
					<c:if test="${admin == 1 }">
					<ul class="nav navbar-nav navbar-right">
						<li><a href='myres.do?id=${id}'>예약내역<span class="badge">${resTotCnt}</span></a></li>
						<li><a onclick="openMessagePopup();">쪽지함</a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><img src="${member.image}" class="pull-left img-responsive img-circle" id="img">${name }님<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href='myinfo.do?id=${id}'>내 정보</a></li>
							<li><a href='mypoint.do?id=${id}'>포인트<span id="point">&nbsp;<fmt:formatNumber value="${point }" pattern="#,###"></fmt:formatNumber>P</span></a></li>
							<li><a href='myres.do?id=${id}'>예약내역<span id="resTot">&nbsp;${resTotCnt}건</span></a></li>
							<li><a href='myfavorite.do?id=${id}'>좋아요<span id="totGood">&nbsp;${totGood}개</span></a></li>
							<!-- <li><a href="#">1:1 문의하기</a></li> -->
						<c:if test="${member.admin == 2}">
							<li><a href="adminMain.do?id=${id}&admin=${member.admin}">관리하기</a></li>
						</c:if>
						<c:if test="${member.admin == 3}">
							<li><a href="adminMain.do?id=${id}&admin=${member.admin}">관리하기</a></li>
						</c:if>
							<li><a href="logoutAction.do">로그아웃</a></li>
						</ul></li>
					</ul>
					</c:if>
				</c:if>
			</div>
		</div>
	</nav>
</body>
</html>