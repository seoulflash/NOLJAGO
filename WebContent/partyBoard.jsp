<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/noljaBooster.css">
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
<title>함께하자! 놀자GO!</title>
<style type="text/css">
.board-table {
	margin-bottom: 150px;
}
.board-box {
	margin-top: 65px;
}
#boardImg {
	width: 80px;
	height: 80px;
}
.board-box h2 {
	margin-top: 0;
}
th {
	color: white;
	background-color: #1ca2e3;
	text-align: center;
}
tbody td {
	background-color: white !important;
}
.content_main {
	cursor: pointer;
}

select, input[type=text] {
	padding: 6px;
	margin-top: 10px;
	font-size: 15px;
	border: 1px solid #dddddd;
}

#myImg {
	border-radius: 5px;
	cursor: pointer;
	transition: 0.3s;
}

#myImg:hover {
	opacity: 0.7;
}
/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.9); /* Black w/ opacity */
}
/* Modal Content (image) */
.modal-content {
	margin: auto;
	display: block;
}
.meminfo{
	display: none;
	position: absolute;
	border: 1px solid gray;
	background-color: white;
	width: 200px;
}
.board-button {
	margin-bottom: 15px;
}
#partyMake {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #005aa7;
}
#partyMy {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #1ca2e3;
}
#searchButton {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #005aa7;
}
.party-modi,
.party-join {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #1ca2e3;
}
.party-del,
.party-out {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #dc281e;
}
.party-modi:hover,
.party-join:hover {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #1ca2e3;;
}
.party-del:hover,
.party-out:hover {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #dc281e;
}
/* 쪽지보내기 영역 */
.dropdown-menu {
	min-width: 0;
}
#idlist {
	padding: 0;
}
.navbar-nav > li > a:hover, .navbar-nav > li > a:focus {
	font-weight: bold;
	background-color: white;
}
.nav > .open > a, .nav > .open > a:hover, .nav > .open > a:focus {
	background-color: white;
}
/* 모달 헤더 */
.modal-header{
	background-color: #1ca2e3;	
}
.snd-title {
	color: white;
	font-weight: bold;
}
.btnGroup {
	margin-left: 50px;
}
#rcvlist {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #1ca2e3;
}
#writeCancle {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #dc281e;
}
#writeButton {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #005aa7;
}
/* 테이블 하단 영역 */
/* 검색 영역 배경 */
#search-back{
	padding: 0;
	border: none;
	background-color: white;
}
.search-cont {
	margin-left: 80px;
}
.search-cont input:placeholder-shown {
	font-size: 13px;
}
#searchOpt {
	margin-top: 0 !important;
}
#find_party {
	width: 150px;
	border-left: 0;
	margin-top: 0;
}
#submitButton {
	padding-top: 8px;
	padding-bottom: 8px;
	border: none;
	font-size: 13px;
	color: white;
	background-color: #005aa7;
}
.input-group-addon {
	font-size: 13px !important;
	padding: 0 !important;
}
#type-box {
	background-color: white !important;
	width: 150px !important;
}
#type-box input {
	vertical-align: middle !important;
	margin-left: 5px !important;
}
#vr-box, #room-box {
	margin-right: 10px !important;
}
.pagination {
	margin: 0 !important;
}
#date-box {
	border: none;
	background-color: white !important;
}
#datepickerFirst, #datepickerEnd {
	margin: 0 !important;
}
</style>
	<!-- 게시물 슬라이드  -->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".content_main").click(function() { //파티 상세보기 슬라이드
				status = $(this).next(".hide_display").css("display");
				if (status == "none") {
					$(".hide_display").css("display","none"); //일단 모든 창의 display를 none로 변경
					$(this).next(".hide_display").css("display", "");
				} else {
					$(this).next(".hide_display").css("display", "none");
				}
			});
		$("#searchOpt").change(function(){ //검색 option 바뀔 경우 표시변경
			var value = $("#searchOpt").val();
				if(value==1){
					status = $(".typeSearch").css("display");
					if(status == "none"){
						$(".normalSearch").css("display","none");
						$(".dateSearch").css("display","none");
						$(".typeSearch").css("display","");
					}
				}
				else if( value==4){ //검색 option이 날짜 선택일 경우
					status = $(".dateSearch").css("display");
					if(status == "none"){
						$(".normalSearch").css("display","none");
						$(".typeSearch").css("display","none");
						$(".dateSearch").css("display","");
					}
				} else{ //검색 option이 날짜 선택 이외의 다른 option일 경우
					status = $(".normalSearch").css("display");
					if(status=="none"){
						$(".dateSearch").css("display","none");
						$(".typeSearch").css("display","none");
						$(".normalSearch").css("display","");
					}
				}
		});
		});
		function createChk(){ //파티 생성 버튼 클릭시 이동
			alert("빠른 파티 생성을 위해 검색 페이지로 이동합니다.");
			location.href='main.do?id=${id}'; //당분간 메인 페이지로 이동
		};
		function myParty(){ //자신이 속한 파티 출력
			alert("자신이 속한 파티를 전부 보여줍니다.");
			location.href='PartyMine.do?id=${id}';
		}
		//달력
		$(function() {
	       $( "#datepickerFirst" ).datepicker({
	        dateFormat: "yy/mm/dd",
	        showMonthAfterYear: true,
	        showButtonPanel: true,
	        currentText: '오늘',
	        closeText: '닫기',
	        changeMonth: true,
	        dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        minDate: 0,
	        onSelect: function(selected) {
	        	 $("#datepickerEnd").datepicker("option","minDate", selected)
	        	 }
	        	 });
	       $( "#datepickerEnd" ).datepicker({
	 	        dateFormat: "yy/mm/dd",
		        showMonthAfterYear: true,
		        showButtonPanel: true,
		        currentText: '오늘',
		        closeText: '닫기',
		        changeMonth: true,
		        dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
		        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
		        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        minDate: 0,
		        onSelect: function(selected) {
		        	 $("#datepickerFirst").datepicker("option","maxDate", selected)
		        	 }
		        	 });
	         $( "#datepickerSelect" ).datepicker({
			 	        dateFormat: "yy/mm/dd",
				        showMonthAfterYear: true,
				        showButtonPanel: true,
				        currentText: '오늘',
				        closeText: '닫기',
				        changeMonth: true,
				        dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
				        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
				        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				        minDate: 0
				        	 }).datepicker("setDate", '0');	
		});
	</script>
</head>
<%@include file="menu.jsp" %>
<%------------ B O D Y ------------%>
<body>
	<!---------------- B O R A D ------------------>
	<div class="container">
			<div class="board-box text-center">
				<a><img src="images/team.svg" id=boardImg></a>
				<h2>파티 게시판</h2>
				<c:if test="${actionChk eq 1 }">
					<h6>지정 날짜만 검색</h6>
					<form name="DaySearch"action="PartySearch.do?id=${member.id}" method="post">
						<input type="hidden" value="0" name="option">
						<input type="text" name="datepickerSelect" id ="datepickerSelect" class="datepicker" placeholder="검색하고 싶은 날짜">
						<input type="submit" class="btn btn-default" id="searchButton" value="검색">
					</form>
				</c:if>
			</div>
			<div class="board-button text-right">
				<c:if test="${id ne null && id ne '' }">
					<a class="btn btn-default" id="partyMy" onclick="return myParty()">내 파티</a>
					<a class="btn btn-default" id="partyMake" onclick="return createChk()">파티 생성</a>
				</c:if>
			</div>
			<div class="board-table">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<th>번호</th>
							<th>카페종류</th>
							<th>지역</th>
							<th>카페이름</th>
							<th>테마이름</th>
							<th>인원수</th>
							<th>희망시간</th>
							<th>파티장</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
					<c:if test = "${totCnt>0 }">
						<!-- 파티에 대한 간략한 정보 표시 -->
						<c:forEach var="partyinfo" items="${list }" varStatus="pcount">
						<tr class="content_main" onclick="return false;">
							<td>${pcount.count }</td>
							<td>${partyinfo.type }</td>
							<td>${partyinfo.caddress }</td>
							<td>${partyinfo.cname }</td>
							<td>${partyinfo.tname }</td>
							<td>${partyinfo.pmcount+1}/${partyinfo.max }</td>
							<td id="${pcount.index }">${partyinfo.hopedate } ${partyinfo.hopehour }:00</td>
							<td>
								<ul class="nav navbar-nav"><li class="dropdown"><input type="hidden" id="reply${pcount.index}" value="${partyinfo.id}">${partyinfo.id}</ul>
							</td>
							<td>${partyinfo.preg_date }</td>
						</tr>
						<c:if test="${pcount.first }"> 
						<!-- pnum의 최대값을 받아 스크립트에 사용 : pnum큰 순서대로 정렬되어 가장 처음 pnum=가장 큰 pnum -->
						<c:set value="${partyinfo.pnum }" var="maxpnum"/>
						</c:if>
						<!-- 파티 세부 정보 표시 -->
						<tr class="hide_display" style="display: none;">
							<td colspan="9">
								<div class="continer">
									<table id="tablesub" class="table table-striped"
										style="text-align: center; border: 1px solid #dddddd; width: 100%;">
										<tr>
											<th width="40%" style="text-align: right">${partyinfo.cname }</th>
											<th colspan="4">${partyinfo.tname }</th>
										</tr>
										<tr>
											<td rowspan="4"><img id="myImg" alt="cafe1"
												src="images/${partyinfo.image3 }" class="img-thumbnail"
												data-toggle="modal" data-target="#myModal${partyinfo.pnum }"></td>
												<td style="text-align: right">영업시간 : </td>
												<td>${partyinfo.open }:00 ~ ${partyinfo.close }:00</td>
											<td style="text-align: right; width: 10%">희망시간 :</td>
											<td style="text-align: left">${partyinfo.hopedate } ${partyinfo.hopehour }:00</td>
										</tr>
										<tr>
											<td style="text-align: right">지불 가격 : </td>
											<td id="price${pcount.index }"><fmt:formatNumber value="${partyinfo.price }" pattern="#,###"/>원 </td>
											<td style="text-align: right">인원 : </td>
											<c:set value="0" var="emptyVal"/>
											<!-- 인원수 체크 Start-->
											<!-- 인원수에 맞춰 방장,멤버,빈자리를 체운 후 나머지 칸을 막음 : 파티 생성시 최대 인원 설정 기준 -->
											<td style="text-align: left">
											<img alt="방장" src="images/person_leader.png" class="${partyinfo.pnum }-1" style="cursor: pointer"><!-- 파티장 -->
											<c:forEach var="person_mem" begin="1" end="${partyinfo.pmcount }" varStatus="status_mem"><!-- 파티원 -->
												<img alt="멤버" src="images/person_mem.png" class="${partyinfo.pnum }-${person_mem+1}" style="cursor: pointer">
												<c:if test="${status_mem.count+1==4 }"><br></c:if><!--인원 아이콘 4개이상일 경우 줄을 바꿈 -->
											</c:forEach>
										 	<c:forEach var="person_empty" begin="1" end="${partyinfo.max-partyinfo.pmcount-1 }" varStatus="status_empty">
												<img alt="빈자리" src="images/person_empty.png"  style="cursor: pointer">
												<c:if test="${status_empty.count+1+partyinfo.pmcount==4}"><br></c:if><!--인원 아이콘 4개이상일 경우 줄을 바꿈 -->
												<c:if test="${status_empty.last }">
													<c:set value="${status_empty.count }" var="emptyVal"/>
												</c:if>
											</c:forEach>
											<c:forEach var="person_locked" begin="1" end="${8-partyinfo.max}" varStatus="status_locked">
												<img alt="막음" src="images/person_locked.png" style="cursor: pointer">
												<c:if test="${emptyVal+1+partyinfo.pmcount+status_locked.count==4}"><br></c:if><!--인원 아이콘 4개이상일 경우 줄을 바꿈 -->
											</c:forEach>
											</td>
											<!-- 인원수 체크 End -->
										</tr>
										<tr>
											<td style="text-align: right">테마 설명 : </td>
											<td style="text-align: left" colspan="3">${partyinfo.tcontent }</td>
										</tr>
										<tr>
											<td style="text-align: right" colspan="1" rowspan="3">추가사항 :</td>
											<td style="text-align: left" colspan="6">${partyinfo.pcontent }
											</td>
										</tr>
										<!--별점 : 0.1 to 0.9까지 half 이미지, 총점 5중 나머지는 empty 이미지-->
										<tr>
											<td colspan="1">
											<c:set var="revAvg" value="${partyinfo.reviewAvg }"/>
											<c:set var="revHalf" value="${fn:split(revAvg,'.') }"/>
											<c:forEach begin="1" end="${revAvg }">
												<img alt="찬별" src="images/star_full_e.png">
											</c:forEach>
												<c:if test="${revHalf[1]>0 }">
													<img alt="반별" src="images/star_half_e.png">
												</c:if>
												<c:forEach begin="1" end="${5-revAvg }">
													<img alt="빈별" src="images/star_empty_e.png">
												</c:forEach>
											<fmt:formatNumber value="${partyinfo.reviewAvg }" pattern="0.0"/>
											점(${partyinfo.reviewCount }명)</td>
										</tr>
										<!-- vr의 경우와 방탈출 카페의 경우를 나누어 각각 카페 상세정보 보기 페이지로 이동할 수 있도록 함 -->
										<tr>
										<c:if test="${partyinfo.type eq 'vr' }">
											<td><a href="vrList2View.do?id=${id }&cnum=${partyinfo.cnum}&tnum=${partyinfo.tnum}" class="btn btn-info">카페소개바로가기</a></td>
										</c:if>
										<c:if test="${partyinfo.type eq 'room' }">
											<td><a href="roomList2View.do?id=${id }&cnum=${partyinfo.cnum}&tnum=${partyinfo.tnum}" class="btn btn-info">카페소개바로가기</a></td>
										</c:if>
										<!-- 파티가입, 파티탈퇴의 경우 일반 회원들에게 보이게 함 -->
										<!-- 파티정보수정, 파티해산의 경우 파티장에게만 보이게 함 -->
										<tr>
											<td colspan="7">
											<c:set var='LoginId' value="<%=id %>"/>
											<c:if test="${LoginId !=null && LoginId != ''}"> <!-- 로그인을 했을 경우 -->
											<c:if test="${LoginId eq partyinfo.id }"><!-- 파티장일 경우 -->
												<a href="partyEditPop.jsp?pnum=${partyinfo.pnum }&pageNum=${pageNum}" onclick="window.open(this.href,'','width=500px,height=500px');return false;"
												 class="btn btn-default pull-center party-modi">파티정보수정</a>&nbsp;&nbsp;
												<button onclick="javascript:deletePCheck(this)" id="delete-to${partyinfo.pnum }"
												class="btn btn-default pull-center party-del">파티해산</button>
											</c:if>
												<c:if test="${LoginId ne partyinfo.id }"> <!--파티장이 아닐 경우  -->
													<a class="btn btn-default pull-center reply" data-target="#writeModal" data-toggle="modal" onclick="reply(${pcount.index});">쪽지보내기</a>&nbsp;&nbsp;
													<c:if test="${partyinfo.max ne partyinfo.pmcount+1 }">
														<button onclick="javascript:joinPCheck(this, ${pcount.index});" id="join-to${partyinfo.pnum }"
													 	class="btn btn-default pull-center party-join">파티가입</button>&nbsp;&nbsp;
													</c:if>
														<button onclick="javascript:outPCheck(this)" id="out-to${partyinfo.pnum }"
														class="btn btn-default pull-center party-out">파티탈퇴</button>
												</c:if>
											</c:if>
											<c:if test="${LoginId==null || LoginId=='' }"> <!-- 로그인을 하지 않았을 경우 -->
												<a href="login.do" class="btn btn-default pull-center party-modi">로그인</a>
											</c:if>
											</td>
									</table>
								</div>
							</td>
						</tr>
							<!-- Modal -->
				<div class="modal fade" id="myModal${partyinfo.pnum }"  role="dialog">
				<div class="modal-dialog modal-lg">
					<!-- Modal content-->
					<div class="modal-body">
						<div id="carousel-example-generic${partyinfo.pnum }" class="carousel slide"
							data-ride="carousel">
							<!-- Indicators -->
							<ol class="carousel-indicators">
								<li data-target="#carousel-example-generic${partyinfo.pnum }" data-slide-to="0" class="active"></li>
								<li data-target="#carousel-example-generic${partyinfo.pnum }" data-slide-to="1"></li>
								<li data-target="#carousel-example-generic${partyinfo.pnum }" data-slide-to="2"></li>
							</ol>	
							<!-- Wrapper for slides -->
	 						<div class="carousel-inner" role="listbox">
								<div class="item active">
									<img src="images/${partyinfo.image1 }" style="width: 100%; height: 500px;">
									<div class="carousel-caption"></div>
								</div>
								<div class="item">
									<img src="images/${partyinfo.image2 }" style="width: 100%; height: 500px;">
									<div class="carousel-caption"></div>
								</div>
								<div class="item">
									<img src="images/${partyinfo.image3 }" style="width: 100%; height: 500px;">
									<div class="carousel-caption"></div>
								</div>
							</div>
							<!-- Controls -->
							<a class="left carousel-control" href="#carousel-example-generic${partyinfo.pnum }"
								role="button" data-slide="prev"> <span
								class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a> <a class="right carousel-control"
								href="#carousel-example-generic${partyinfo.pnum }" role="button" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right"
								aria-hidden="true"></span> <span class="sr-only">Next</span>
							</a>
						</div>
					</div>
				</div>
			</div>
					</c:forEach>
					</c:if>
				</tbody>
			</table>
		<!-- 페이지 하단 영역 -->
		<div class="form-inline table-bottom">
			<!-- 페이지 넘버 영역 -->	
			<c:if test="${actionChk eq 1 }">
				<div class="form-group">
						<nav class="pageBlock">
							<ul class="pagination pagination-sm">
							<c:if test="${startPage > blockSize}">
							    <li>
								    <a href='partyboard.do?pageNum=${startPage-blockSize }' aria-label="Previous">
								    <span aria-hidden="true">&laquo;</span></a>
							    </li>
							</c:if>
							<c:forEach var="i" begin="${startPage}" end="${endPage}">
							    <li><a href='partyboard.do?pageNum=${i }'>${i}</a></li>
							</c:forEach>
							<c:if test="${endPage < pageCnt}">
							    <li>
						    		<a href='partyboard.do?pageNum=${startPage+blockSize }' aria-label="Next">
							    	<span aria-hidden="true">&raquo;</span></a>
							    </li>
							</c:if>
						</ul>
					</nav>
				</div>
				
				<%-- 	<div style="text-align: center;">
						<c:if test="${startPage>blockSize }">
							<a href="partyboard.do?pageNum=${startPage-blockSize }">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<a href="partyboard.do?pageNum=${i }">[${i }]</a>
						</c:forEach>
						<c:if test="${endPage<pageCnt }">
							<a href="partyboard.do?pageNum=${startPage+blockSize }">[다음]</a>
						</c:if>
					</div> --%>
			</c:if>
			<!-- 파티 검색 : 희망날짜 선택시 시작날짜와 끝날짜를 지정하여 사이값을 가져올 수 있도록 함 -->
			<div class="form-group search-cont pull-right">
				<form name="partySearch"action="PartySearch.do?id=${member.id}" method="post">
					<div class="input-group">
						<span class="input-group-addon" id="search-back">
							<select name="option" class="selectpicker form-control input-sm" style="width: 120px;" id = "searchOpt">
								<option value=1 >카페 종류</option>
								<option value=2 selected="selected" >파티장</option>
								<option value=3 >카페 이름</option>
								<option value=4 >희망 날짜</option>
							</select>
							<input type="text" class="form-control input-sm normalSearch" placeholder="검색" name="find_party" id="find_party">
							<span class="input-group-addon typeSearch" id="type-box" style="display: none;">
        						<span id="vr-box"><input type= "radio" name="type" value="vr">V R</span>
								<span id="room-box"><input type= "radio" name="type" value="room">ROOM</span>
      						</span>
							<span class="input-group-addon dateSearch" id="date-box" style="display: none;">
        						<input  type="text" name="datepickerFirst" id ="datepickerFirst" class="datepicker" placeholder="검색일 시작">부터
								<input type="text" name="datepickerEnd" id ="datepickerEnd" class="datepicker" placeholder="검색일 끝">까지
      						</span>
        						
							<span class="input-group-btn">
						        <input type="submit" class="btn btn-default input-sm" id="submitButton" value="검 색">
						    </span>
						</span>
					</div>
						<!-- <table style="float: right;">
							<tr>
								<td>
									<select name="option" class="selectpicker form-control" style="width: 120px;" id = "searchOpt">
										<option value=1 >카페 종류</option>
										<option value=2 selected="selected" >파티장</option>
										<option value=3 >카페 이름</option>
										<option value=4 >희망 날짜</option>
									</select>
								</td>
									<td class="normalSearch">
										<input type="text" placeholder="검색" name="find_party">
										<input type="submit" class="btn btn-default" id="searchButton" value="검색">
									</td>
									<td class="typeSearch" style="display: none;">
										<input type= "radio" name="type" value="vr">VR
										<input type= "radio" name="type" value="room">Room
										<input type="submit" class="btn btn-default" id="searchButton" value="검색">
									</td>
									<td class="dateSearch" style="display: none;">
										<input  type="text" name="datepickerFirst" id ="datepickerFirst" class="datepicker" placeholder="검색일 시작">부터
										<input type="text" name="datepickerEnd" id ="datepickerEnd" class="datepicker" placeholder="검색일 끝">까지
										<input type="submit" class="btn btn-default" id="searchButton" value="검색">
									</td>
							</tr>
						</table> -->
				</form>
			</div>
		</div>
	</div>
		<!-- 각 파티원 정보 id = #pnum-pmnum ex)1-2-->
		<c:forEach var="mem" items="${memList }">
			<div class="meminfo" id="${mem.pnum }-${mem.pmnum}">
				<ul>
					<li>아이디 : ${mem.id }</li>
					<li>이름 : ${mem.name }</li>
					<li>성별 : ${mem.sex }</li>
					<li>생년월일 :  <br>${mem.birth }</li>
					<li>이메일 :  <br> ${mem.email }</li>
					<li>연락처 : 	<br>${mem.tel }</li>
					<li>자기소개 : <br>${mem.intro }</li>
				</ul>
			</div>
		</c:forEach>
	</div>
<!-- 쪽지보내기 -->
<div class="row">
	<div class="modal" id="writeModal" tabindex="-1" style="overflow: auto">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<a class="snd-title">쪽지 보내기</a>
					<button class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div class="write-box center-block">
						<div id="writeOk" role="alert"></div>
						<div class="table-responsive">
							<table class="table">
								<tbody>
									<tr>
										<th>받는이</th>
										<td><input type="text" class="form-control center-block" id="msgToid" placeholder="쪽지를 받는 사람의 ID를 입력해주세요" required="required" style="width: 100%;">
									</tr>
									<tr>
										<th>내 용</th>
										<td><textarea class="form-control center-block" rows="5" cols="50" id="mcontent"></textarea></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="btnGroup text-center">
							<button class="btn btn-default" id="writeButton" onclick="msgWrite()">보내기</button>
							<button class="btn btn-default" id="writeCancle" data-dismiss="modal">취 소</button>
							<a href="messageList.do?id=${id}" class="btn btn-default pull-right" role="button" id="rcvlist">목 록</a>
						</div>
					</div>	
				</div>
			</div>
		</div>
	</div>
</div>		
	<script type="text/javascript">
	/* 쪽지보내기 */
	function reply(index) {
		var i = index;
		var toid = $("#reply" + i).val();
		$("#msgToid").val(toid);
	}
	//메세지 보내기
	function msgWrite() {
		var toid = $('#msgToid').val();
		var mcontent = $('#mcontent').val();
		$.post('messageWriterPro.do?id=${id}', {toid:toid,mcontent:mcontent}, function(result) {
			if(result.trim() == 1) {
				$("#writeOk").addClass("alert alert-info center-block text-center").text("쪽지를 성공적으로 보냈습니다.").hide().slideDown(1500, function(){
					$("#writeOk").slideUp(1500);
					setTimeout("location.reload()", 2000);
				});
			} else {
				$("#writeOk").addClass("alert alert-danger center-block text-center").text("쪽지보내기를 실패하였습니다.").hide().slideDown(1500, function(){
					$("#writeOk").slideUp(1500);
					setTimeout("location.reload()", 2000);
				});
			}
		});
	}
	//파티 참가시 경고문 표시
		 function joinPCheck(obj, index) {
            var pid = obj.id;
            var string = pid.split("to");
            var pnum=string[1];
            var id = '${id}';
        	
            if(id !=null&&id !=""){
                var sendData = "pnum="+pnum+"&id="+id;
                console.log(sendData);
            $.post('pmemCheck.jsp',sendData,function(result){
                if(result.trim()=="-1"){ //파티에 속해있을 경우
                    alert("이미 파티에 속해있습니다.");
                    return;
                }
                else if(result.trim()=="1"){ //파티에 없을 경우
                	//var i = index;
                    var hopestr = $("#"+index).text();
                 	var str = hopestr.split(" ");
                 	var hopedate = str[0];
                 	var hopehourstr = str[1];
                 	console.log(hopestr);
                 	var str1 = hopehourstr.split(":");
                 	var hopehour = str1[0];	//시간만 int로 뽑을라고
                 	
                 	var sendD = "hopedate=" +hopedate+ "&hopehour=" +hopehour+ "&id=" +id;
                 	console.log(sendD);
                 	 $.post('resCheck.jsp',sendD,function(resresult){
                 		 if(resresult.trim()== "-1") {	// 그시간에 예약이 이미 있는 경우
                 			alert("회원님은 같은 날짜, 같은 시간에 이미 다른예약이 있다Go!");
                 		 	return;
                 			 
                 		 } else if (resresult.trim() == "1") {	//예약이 없는 경우
                 			
                 			 var point = $("#price"+index).text();
                 		 	 point = point.replace("원", "");
                 		 	 var price = point.replace(",", "");
                 		 	 
	                    	 var mempoint1 = '${member.point}';
	         				 var mempoint = Number(mempoint1);		//int로 강제변환. 안하면 에러남
                 			 console.log(price > mempoint)
	         				 
			                 if (confirm("파티 참가시 예약접수를 위해 자동으로 "+price+"포인트가 차감됩니다. 계속하시겠습니까?")) {
			                    if (price > mempoint)	// 가격이 유저포인트보다 더 비싸면
			                    {
			                    	if(confirm("회원님의 포인트가 모자른데.. 충전하러 Go?!!")) {
										window.open('addPoint.do?id=${id}', 'AddPoint', 'width=500px,height=500px')
									} else {
										alert("충전이 취소 되었다Go! 파티페이지로 돌아간다Go!");
										return;
									}
			                    } else {
									//모든 케이스 다 무사통과		                    	
			                        location.href="partyJoin.do?pnum="+pnum+"&id=<%=id%>&pageNum=${pageNum}";
			                    }
			         			 
			                    	
			                  } else {
			                        alert("파티 참가를 취소합니다.")
			                        return;
			                  }
                 		 }
                 	 });
                	
                }
            })
            }
        }
	//파티 탈퇴시 경고문 표시
		function outPCheck(obj) {
			var pid = obj.id;
			var string = pid.split("to");
			var pnum=string[1];
			var id = '${id}';
        	
            if(id !=null&&id !=""){
                var sendData = "pnum="+pnum+"&id="+id;
                console.log(sendData);
            	$.post('pmemCheck.jsp',sendData,function(result){
	                if(result.trim()=="-1"){ //파티에 속해있을 경우
						if (confirm("파티 탈퇴시 관련 예약이 취소되고, 차감된 포인트가 반환됩니다. 계속하시겠습니까?")) {
							location.href="partyOut.do?pnum="+pnum+"&id=<%=id%>&pageNum=${pageNum}";
						} else {
							return;
						}
	                }
	                else {
	                    alert("파티에 속해있지 않습니다.");
	                    return;
	                }
           		})
            }
		}
	// 파티 해산시 경고 표시
		function deletePCheck(obj) {
			var pid = obj.id;
			var string = pid.split("to");
			var pnum=string[1];
			if (confirm("파티 해산시 모든 파티원의 차감된 포인트가 반환됩니다. 계속하시겠습니까?")) {
				location.href="partyDelete.do?pnum="+pnum+"&pageNum=${pageNum}"+"&id=${id}";
			} else {
				alert("파티 해산을 취소합니다.")
				return;
			}
		}
	for(j=1;j<="${maxpnum}";j++){
	//마우스 오버시 파티원 정보 표시
		for(i=1;i<=8;i++){
			var divClass = '.'+j+'-'+i;
				$(divClass).hover(function(e){ //mouse over
				var divName ='#'+$(this).attr('class');
				var sWidth = window.innerWidth;
				var sHeight = window.innerHeight;
				var oWidth = $(divName).width();
				var oHeight = $(divName).height();
				// 레이어가 나타날 위치를 셋팅한다.
				var divLeft = e.pageX+10;	//마우스 포인터에서 X좌표 + 10
				var divTop = e.pageY-5;		//마우스 포인터에서 Y좌표 - 5
				// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
				if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
				if( divTop + oHeight > sHeight ) divTop -= oHeight;
				// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
				if( divLeft < 0 ) divLeft = 0;
				if( divTop < 0 ) divTop = 0;
				$(divName).css({
					"top": divTop,
					"left": divLeft,
					"position": "absolute"
				}).show();
			},function(){ //mouse out
				$('.meminfo').hide();
			}).mousemove(function(ev) {
				var divName ='#'+$(this).attr('class');
				  // 이벤트 좌표
				  var $ev_x = ev.pageX;
				  var $ev_y = ev.pageY;
				  // 툴팁 좌표
				  var $tt_x = $(divName).outerWidth();
				  var $tt_y = $(divName).outerHeight();
				  // 본문 좌표
				  var $bd_x = $(this).outerWidth();
				  var $bd_y = $(this).outerHeight();
				  // 툴팁을 이동시킨다.
				  $('.meminfo').css({
				   'top': $ev_y + $tt_y > $bd_y ? $ev_y - $tt_y -10 : $ev_y,
				   'left': $ev_x + $tt_x +10 > $bd_x ? $ev_x - $tt_x -10 : $ev_x - 20
				  });
			 });
		}
	}
</script>
<!--
		// Get the modal
		var modal = document.getElementById('myModal');

		// Get the image and insert it inside the modal - use its "alt" text as a caption
		var img = document.getElementById('myImg');
		var modalImg = document.getElementById("img01");
		var captionText = document.getElementById("caption");
		img.onclick = function() {
			modal.style.display = "block";
			modalImg.src = this.src;
			captionText.innerHTML = this.alt;
		}

		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];

		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
			modal.style.display = "none";
		}
	</script> -->
	<!---------------- B O R A D _ E N D------------------>
</body>
</html>
<%@include file="footer.jsp" %>