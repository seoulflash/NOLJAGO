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
	<title>심심할땐? 놀자GO! : 예약내역</title>
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
	.reservation {
		padding: 10px;
		width: 80%;
	}
	/* 예약내역 제목 영역 */
	.resTitle {
		font-weight: bolder;
		font-size: 16px;
		padding: 10px 30px 0 30px;
	}
	.resTitle hr {
		margin-top: 15px;
		margin-bottom: 0;
	}
	/* 예약내역 테이블 영역 */
	table th {
		text-align: center;
	}	
	table td {
		font-size: 13px;
		text-align: center;
	}
	.resTable {
		padding: 30px 30px 30px 30px;
	}
	#showDetail {
		border: none;
		font-size: 13px;
		color: white;
		background-color: #005aa7;
	}
	.resTable .table {
		margin-bottom: 0;
	}
	.resTable td {
		font-size: 13px;
	}
	/* 상세보기 테이블 영역 */
	.detailTable table {
		border-bottom: 1px solid silver;
	}
	.detailTable th {
		text-align: center;
	}
	.detailTable td {
		padding: 20px !important;
		font-size: 13px;
		text-align: center;
	}
	.detailTable tr td:first-child {
		background-color: #005aa7;
		color: white;
		font-weight: bold;
	}
	.detailTable tr td:nth-child(2) {
		background-color: 	#f4fbfb;
	}
	.detailTable #pay {
		font-size: 16px;
		font-weight: bold;
		color: #dc281e;
	}
	#writeReview {
		border: none;
		width: 100px;
		padding-top: 10px;
		padding-bottom: 10px;
		margin-bottom: 20px;
		font-size: 13px;
		color: white;
		background-color: #005aa7;
	}
	#resCancle {
		border: none;
		width: 100px;
		padding-top: 10px;
		padding-bottom: 10px;
		margin-bottom: 20px;
		font-size: 13px;
		color: white;
		background-color: #dc281e;
	}
	#cancleOk {
		margin-bottom: 20px;
	}
	#first-td {
		width: 30%;
	}
	.modal-header{
		background-color: #1ca2e3;	
	}
	.modal-header a {
		color: white;
		font-weight: bold;
	}
	</style>
	<script type="text/javascript">
		/* 상세보기 버튼 눌렀을시에 해당 로우의 예약번호를 가져와 정보를 조회 */
		
		function getResNo(index) {
			var i = index;
			var resno = $("#"+i).text();
			$.post('myresInfo.do?id=${id}', {resno:resno}, function(msg){
				var list = JSON.parse(msg);
				$("#resno").text(list.resno);
				$("#resno").val(list.resno);
				$("#cname").text(list.cname);
				$("#cnum").val(list.cnum);
				$("#tname").text(list.tname);
				if(list.pnum == 0) {
					$("#pnum").text("파티에 속해있지 않습니다").css("color", "#dc281e");
				} else {
					if(list.id==list.leaderId){
						$("#pnum").text("해당 파티의 파티장입니다.").css("color","#17E249");
						$("#pnum").val(list.pnum);
					}else{
						$("#pnum").text(list.leaderId+"님의 파티에 속해있습니다.").css("color","#17E249");
						$("#pnum").val(list.pnum);
					}
					$("#pnum").append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onclick='javascript:detail_go();' id='btn_party_detail' class='btn btn-info pull-center'>바로가기</a>");
				}
				$("#count").text(list.count);
				$("#resdate").text(list.resdate);
				$("#time").text(list.starttime+" ~ "+list.endtime);
				$("#pay").text(list.point+"원");
				$("#cnum").val(list.cnum);
				
				$("#writeReview").click(function(){
					var cnum = $("#cnum").val();
					if(list.type =="vr") {
						var fname = document.fname;
						fname.action = "vrList1View.do?id=${id}&cnum="+cnum;
						fname.submit();
					} else if (list.type == "room") {
						var fname = document.fname;
						fname.action = "roomList.do?id=${id}&cnum="+cnum;
						fname.submit();
					}
				});
			});
		}
		/* 예약취소 펑션  */
		function resCan() {
			var resno = $("#resno").val();
			$.post('myresInfo.do?id=${id}', {resno:resno}, function(msg){
				var list = JSON.parse(msg);
				if(list.pnum != 0) {	//파티에 속해 있을 때
					var pnum= list.pnum;
					if (confirm ("파티에 속해있는 경우 예약 취소는 파티페이지에서 가능합니다.")) {
						location.href="PartySelect.do?pnum="+pnum+"&id=${id}";
					} else {
						return;
					}
				} else {	//파티에 속해있지 않을 때 
					if(confirm("예약을 취소하시겠습니까? 포인트는 환불되니 걱정말라Go!")) {
						$.post('myrescancle.do?id=${id}',{resno:resno}, function(result){
							//result + " " + point라는 string으로 돌려받음
							var str = result.trim();
							var strarray = str.split(" ");
							if(strarray[0] == "1") {
								$("#cancleOk").text("예약이 성공적으로 취소되었습니다. " + strarray[1] + "포인트를 환불받았습니다.").css("color", "#2cb5e8").css("font-size", "16px");
								setTimeout("location.reload()", 2000);
							} else {
								$("#cancleOk").text("예약 취소가 실패하였습니다.").css("color", "#dc281e").css("font-size", "12px");
							}
						});
							
					} else {
						return;
					}
				}
			})
		}
		
		function go_url(){
	        location.href="myres.jsp";
	     }
		//party 정보 확인을 위해 이동
		function detail_go() {
			var pnum=$("#pnum").val();
			alert("해당 파티로 이동합니다.");
			location.href="PartySelect.do?pnum="+pnum+"&id=${id}";
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
					<li class="active"><a id="myReserved">예약내역<span class="badge">${member.resTotCnt}</span></a></li>
					<li><a href='myfavorite.do?id=${id}' id="myFavorite">좋아요<span class="badge">${member.totGood}</span></a></li>
				</ul>
			</div>
		</div>
		<!-- 컨텐츠 영역 -->
		<!-- 예약 내역 테이블 영역 -->
		<div class="reservation center-block">
			<div class="resTitle cneter-block">
				예약 내역
				<hr>
			</div>
			<div class="resTable">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th>예약번호</th>
								<th>카페이름</th>
								<th>테마이름</th>
								<th>예약날짜</th>
								<th>시작시간</th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${member.resTotCnt > 0}">
							<c:forEach var="res" items="${list}" varStatus="status">
								<tr>
									<td id="${status.index }">${res.resno}</td>
									<td>${res.cname}</td>
									<td>${res.tname}</td>
									<td>${res.resdate}</td>
									<td>${res.starttime}</td>
									<td><button class="btn btn-default btn-sm" id="showDetail" type="button" data-target="#modal" data-toggle="modal" onclick="getResNo(${status.index})">상세보기</button></td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${member.resTotCnt == 0 }">
							<tr>
								<td class="text-center" colspan="6">예약내역이 없습니다.
							</tr>
						</c:if>
						</tbody>
					</table>
					<nav class="pageBlock center-block text-center">
						<ul class="pagination pagination-sm">
						<c:if test="${startPage > blockSize}">
						    <li>
							    <a href='myres.do?=${id}$pageNum=${startPage-blockSize}' aria-label="Previous">
							    <span aria-hidden="true">&laquo;</span></a>
						    </li>
						</c:if>
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
						    <li><a href='myres.do?id=${id}&pageNum=${i}'>${i}</a></li>
						</c:forEach>
						<c:if test="${endPage < pageCnt}">
						    <li>
						    	<a href='myres.do?=${id}$pageNum=${startPage+blockSize}' aria-label="Next">
						    	<span aria-hidden="true">&raquo;</span></a>
						    </li>
						</c:if>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<!-- 상세보기 영역 -->
	<div class="row">
		<div class="modal" id="modal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<a class="detail-title">예약내역 상세보기</a>
						<button class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<div class="detailTable center-block">
							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th id="first-td">분류</th>
											<th>내용</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>예약 번호</td>
											<td id="resno"><input type="hidden" id="hideresno"></td>
										</tr>
										<tr>
											<td>카페 이름</td>
											<td id="cname"></td>
										</tr>
										<tr>
											<td>테마 이름</td>
											<td id="tname"></td>
										</tr>
										<tr>
											<td>파티 여부</td>
											<td id="pnum"></td>
										</tr>
										<tr>
											<td>예약 인원</td>
											<td id="count"></td>
										</tr>
										<tr>
											<td>예약 날짜</td>
											<td id="resdate"></td>
										</tr>
										<tr>
											<td>예약 시간<br><small>(시작 ~ 종료)</small></td>
											<td id="time"></td>
										</tr>
										<tr>
											<td>지불 금액</td>
											<td id="pay"></td>
										</tr>
									</tbody>
								</table>
								<div class="text-center" id="cancleOk"></div>
								<div class="row center-block text-center">
									<form action="" name="fname" method="post">
										<input type="hidden" id="cnum" value="">
										<button type="button" class="btn btn-default" id="resCancle" onclick="resCan();">예약 취소</button>
										<button type="button" class="btn btn-default" id="writeReview">후기 남기기</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@include file="footer.jsp" %>