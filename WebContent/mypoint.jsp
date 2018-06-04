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
	<title>심심할땐? 놀자GO! : 포인트내역</title>
	<style type="text/css">
	hr {
		border-top: 1px solid #98FB98;
		margin-top: 30px;
		margin-bottom: 30px;
	}
	.container {
		margin-bottom: 65px;
	}
	/* 내 정보 배너 영역 */
	.banner {
		width: 80%;
		height: 250px;
		background: linear-gradient(141deg, #fffde4, #005aa7);
	}
	.banner .title {
		font-size: 24px;
		font-weight: bold;
		padding: 10px 0 0 30px;
	}
	.banner-cont {
		margin-top: 30px;
		margin-bottom: 30px;
	}
	/* 프로필 이미지 박스 영역 */
	.profileImg { /* 프로필 이미지 크기 */
		margin-left: 5px;
		width: 120px;
		height: 120px;
	}
	/* 프로필 데이터 박스 영역 */
	.form-inline {
		margin: 12px 0 10px 0;
	}
	.form-inline label {
		margin-right: 10px;
	}
	/* 메뉴 영역 */
	.menubar {
		height: 50px;
		width: 80%;
	}
	.menubar a {
		margin: 0px 30px 10px 30px;
	}
	.menubar li > a {
		padding-bottom: 5px;
		padding-left: 0px;
		padding-right: 0px;
	}
	.menubar a:hover {
		border-bottom: 1.5px solid #98FB98;
	}
	.menubar .navbar-nav > li > a:hover {
		color: black;
		background-color: white;
	}
	.menubar .navbar-nav .active > a,
	.menubar .navbar-nav .active > a:hover,
	.menubar .navbar-nav .active > a:focus {
		color: black;
		background-color: white;
		border-bottom: 1.5px solid #98FB98;
	}
	.menubar-list {
		padding-left: 30px;
		width: 60%;
	}
	/* 컨텐츠 영역 */
	.myPoint {
		padding: 10px;
		width: 80%;
	}
	.myPoint hr {
		margin-top: 15px;
		margin-bottom: 0;
	}
	/* 사용 내역 테이블  */
	.usePointTable {
		padding: 30px;
	}
	.usePointTable caption {
		color: #f92672;
		font-size: 12px;
		padding: 0;
	}
	/* 적립 내역 테이블 */
	.savePointTable {
		padding: 0 30px 30px 30px;
	}
	.savePointTable caption {
		color: #f92672;
		font-size: 12px;
		padding: 0;
	}
	/* 사용 가능한 포인트 영역 */
	.myPointAmount {
		font-weight: bolder;
		font-size: 16px;
		padding: 10px 30px 0 30px;
	}
	.myPointAmount #pointInfo {
		color: #005aa7;
	}
	</style>
</head>
<%@include file="menu.jsp" %>
<%------------ B O D Y ------------%>
<body>
	<!------------------ 나의 정보 컨텐츠 영역 ------------------->
	<div class="container">
		<!-- 배너 영역 -->
		<div class="banner center-block">
			<div class="row title">
				마이 페이지
			</div>
			<div class="banner-cont col-lg-6 col-lg-offset-3">
				<div class="img-box text-center col-xs-6">
					<img class="profileImg img-circle center-block" src="${member.image}" alt="profile">
				</div>
				<div class="info-box col-xs-6">
					<div class="form-inline">
						<label id="viewId">- 이름</label> 
						<span class="userName">${member.name}</span>
					</div>
					<div class="form-inline">
						<label id="viewBirth">- 생일</label> 
						<span class="userBirth">${member.birth}</span>
					</div>
					<div class="form-inline">
						<label id="viewJoinDate">- 가입일</label> 
						<span class="userJoinDate">${member.reg_date}</span>
					</div>
				</div>
			</div>
			<div class="banner-cont col-lg-3"></div>
		</div>
		<!-- 메뉴바 영역 -->
		<div class="menubar center-block">
			<div class="menubar-list center-block">
				<ul class="nav navbar-nav">
					<li><a href='myinfo.do?id=${id}' id="myInfo">내 정보</a></li>
					<li class="active"><a id="myPoint">포인트</a></li>
					<li><a href='myres.do?id=${id}' id="myReserved">예약내역<span class="badge">${member.resTotCnt}</span></a></li>
					<li><a href='myfavorite.do?id=${id}' id="myFavorite">좋아요<span class="badge">${member.totGood}</span></a></li>
				</ul>
			</div>
		</div>
		<!-- 컨텐츠 영역 -->
		<div class="myPoint center-block">
			<div class="myPointAmount center-block">
				사용 가능한 포인트<span id="pointInfo">&nbsp;<fmt:formatNumber value="${member.point }" pattern="#,###"></fmt:formatNumber>P</span>
				<hr>
			</div>
			<div class="usePointTable">
				<div class="table-responsive">
					<table class="table">
					<caption>포인트 사용 내역</caption>
						<thead>
							<tr>
								<th>예약 번호</th>
								<th>사용 장소</th>
								<th>사용 내용</th>
								<th>사용 금액</th>
								<th>사용 일자</th>
							</tr>
							<tr>
								<td class="noUsePoint text-center" colspan="5">포인트 사용 내역이 없습니다.</td>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div class="savePointTable">
				<div class="table-responsive">
					<table class="table">
					<caption>포인트 적립 내역</caption>
						<thead>
							<tr>
								<th>예약 번호</th>
								<th>적립 장소</th>
								<th>적립 내용</th>
								<th>적립 금액</th>
								<th>사용 일자</th>
							</tr>
							<tr>
								<td class="text-center" colspan="5">포인트 적립 내역이 없습니다.</td>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@include file="footer.jsp" %>