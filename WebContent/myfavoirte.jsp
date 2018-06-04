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
	<title>심심할땐? 놀자GO! : 좋아요</title>
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
	/* 좋아요 리스트 영역 */
	.favorite { 
		padding: 10px;
		width: 80%;
	}
	/* 좋아요 리스트 제목 영역 */
	.favTitle {
		font-weight: bolder;
		font-size: 16px;
		padding: 10px 30px 0 30px;
	}
	.favTitle hr {
		margin-top: 15px;
		margin-bottom: 0;
	}
	/* 좋아요리스트 테이블 영역 */
	table th {
		text-align: center;
	}	
	table td {
		font-size: 13px;
		text-align: center;
	}
	table td:nth-child(2),
	table td:nth-child(3),
	table td:nth-child(4),
	table td:nth-child(5) {
		vertical-align: middle !important;
	}
	.favTable {
		padding: 30px 30px 30px 30px;
	}
	table img {
		width: 70px;
		height: 70px;
	}
	table .favCancle {
		border: none;
		font-size: 13px;
		color: white;
		background-color: #dc281e;
	}
	table .favCancle:hover, table .favCancle:focus {
		color: white;
		background-color: #dc281e;
	}
	#favRes {
		border: none;
		font-size: 13px;
		color: white;
		background-color: #005aa7;
	}
	</style>
	<script type="text/javascript">
		/* 좋아요 취소 */
		$(function(){
			$("#cancleOk").hide();
			$("#cancleX").hide();
		});
		function favCancle(index) {
			var i = index;
			var fullNum = $("#"+i).val(); 
			var num = fullNum.split('-');
			var cnum = num[0];
			var tnum = num[1];
			if(confirm("선택하신 테마를 목록에서 삭제합니다.") == true) {
				$.post('myfavCancle.do?id=${id}', {cnum:cnum, tnum:tnum}, function(result){
					if(result.trim() == 1) {
						$("#cancleOk").slideDown(1500, function(){
							$("#cancleOk").slideUp(1500);
						});
						setTimeout("location.reload()", 3000);
					} else {
						$("#cancleX").slideDown(1500, function() {
							$("#cancleX").slideUp(1500);
						});
						setTimeout("location.reload()", 3000);
					}
				});
			} else {
				return;
			};
		}
	</script>
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
					<li><a href='mypoint.do?id=${id}' id="myPoint">포인트</a></li>
					<li><a href='myres.do?id=${id}' id="myRes">예약내역<span class="badge">${member.resTotCnt}</span></a></li>
					<li class="active"><a id="myFavorite">좋아요<span class="badge">${member.totGood}</span></a></li>
				</ul>
			</div>
		</div>
		<!-- 컨텐츠 영역 -->
		<!-- 좋아요 리스트 테이블 영역 -->
		<div class="favorite center-block">
		<div class="alert alert-info center-block text-center" id="cancleOk" role="alert">선택하신 '좋아요'를 성공적으로 삭제했습니다.</div>
		<div class="alert alert-danger center-block text-center" id="cancleX" role="alert">선택하신 '좋아요' 삭제를 실패하였습니다.</div>
			<div class="favTitle center-block">
				'좋아요' 목록
				<hr>
			</div>
			<div class="favTable">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th id="preview">미리보기</th>
								<th>카페이름</th>
								<th>테마이름</th>
								<th>취소</th>
								<th>예약</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${member.totGood > 0}">
								<c:forEach var="good" items="${list}" varStatus="status">
									<tr>
										<td><img src="images/${good.timage}" class="img-circle" alt="theme preivew">
										<td>${good.cname}</td>
										<td>${good.tname}</td>
										<td><button type="button" class="btn btn-default btn-sm favCancle" id="${status.index}" value="${good.cnum}-${good.tnum}" onclick="favCancle(${status.index});">취소</button></td>
										<c:if test="${good.type eq 'vr'}">
											<td><a href='vrReserveView.do?id=${id}&cnum=${good.cnum}&tnum=${good.tnum}' class="btn btn-default btn-sm" role="button" id="favRes">예약하기</a></td>
										</c:if>
										<c:if test="${good.type eq 'room'}">
											<td><a href='roomTheme.do?id=${id}&cnum=${good.cnum}&tnum=${good.tnum}' class="btn btn-default btn-sm" role="button" id="favRes">예약하기</a></td>
										</c:if>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${member.totGood == 0 }">
							<tr>
								<td class="text-center" colspan="6">'좋아요'내역이 없습니다.
							</tr>
						</c:if>
						</tbody>
					</table>
					<nav class="pageBlock center-block text-center">
						<ul class="pagination pagination-sm">
						<c:if test="${startPage > blockSize}">
						    <li>
							    <a href='myfavorite.do?=${id}$pageNum=${startPage-blockSize}' aria-label="Previous">
							    <span aria-hidden="true">&laquo;</span></a>
						    </li>
						</c:if>
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
						    <li><a href='myfavorite.do?id=${id}&pageNum=${i}'>${i}</a></li>
						</c:forEach>
						<c:if test="${endPage < pageCnt}">
						    <li>
						    	<a href='myfavorite.do?=${id}$pageNum=${startPage+blockSize}' aria-label="Next">
						    	<span aria-hidden="true">&raquo;</span></a>
						    </li>
						</c:if>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@include file="footer.jsp" %>