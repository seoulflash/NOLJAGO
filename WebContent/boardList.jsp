<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/noljaBooster.css">
<link rel="stylesheet" href="imageView.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
<title>심심할땐? 놀자GO! : 자유게시판</title>
<style type="text/css">
/* 테이블 제목 */
#boardImg {
	margin-left: 5px;
	width: 100px;
	height: 100px;
}
h3 {
	margin-top: 10px;
	margin-bottom: 20px;
}
/* 게시판 테이블 관련 */
.list-box {
	margin-top: 65px;
	margin-bottom: 65px;
	width: 80%;
}
.list-box a:hover {
	text-decoration: none;
}
.list-box th {
	color: white;
	background-color: #1ca2e3;
	vertical-align: middle;
	text-align: center;
}
.list-box th:nth-child(1),
.list-box th:nth-child(2) {
	width: 5%;
}
.list-box th:nth-child(3) {
	width: 60%;
}
.list-box th:nth-child(4) {
	padding-left: 15px;
	text-align: left;
	width: 10%;
}
.list-box th:nth-child(5) {
	width: 10%;
}
.list-box th:nth-child(6) {
	width: 10%;
}
.list-box td {
	padding: 0 !important;
	vertical-align: middle !important;
	font-size: 13px;
	text-align: center;
}
.list-box table {
	margin-bottom: 0;
}
.list-box tr:hover {
	background-color: ghostwhite;
}
/* 테이블 하단 영역 */
/* 검색 영역 배경 */
#search-back{
	padding: 0;
	border: none;
	background-color: white;
}
/* 셀렉트 */
#opt {
	margin-top: 0;
}
#searchbar {
	width: 150px;
	border-left: 0;
	margin-top: 0;
}
.write-cont {
	margin-left: 395px;
}
.search-cont {
	margin-left: 80px;
}
.search-cont input:placeholder-shown {
	font-size: 13px;
}
#writeButton {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #005aa7;
}
#submitButton {
	padding-top: 8px;
	padding-bottom: 8px;
	border: none;
	font-size: 13px;
	color: white;
	background-color: #005aa7;
}
.dropdown-menu {
	min-width: 0;
}
/* ID 리스트 영역 */
.nav > li > a:hover  {
	background-color: ghostwhite;
}
.nav .open > a, .nav .open > a:hover, .nav .open > a:focus {
	font-weight: bold;
	background: ghostwhite;
}
/* 글쓰기 모달 영역 */
.write-box table {
	border-bottom: 1px solid #ddd;
}
.write-box th {
	padding: 20px !important;
	width: 20%;
	background-color: #005aa7;
	color: white;
}
.write-box td {
	padding: 20px !important;
	background-color: #f4fbfb;
}
.write-box table > tbody > tr > th,
.write-box table > tbody > tr > td {
	vertical-align: middle;
}
#msgToid {
	margin-top: 0;
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
</style>
<script type="text/javascript">
/* 메세지 보내기 */
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
/* 쪽지보내기 */
function reply(index) {
	var i = index;
	var toid = $("#reply"+i).val();
	$("#msgToid").val(toid);
}
</script>
</head>
<%@include file="menu.jsp" %>
<%------------ B O D Y ------------%>
<body>
	<!---------------- P R E B O R A D ------------------>
	<div class="container">
		<div class="list-box center-block">
			<div class="row text-center">
				<a><img src="images/board.svg" id="boardImg"></a>
			</div>
			<div class="row center-block">
				<h3 class="text-center">자유 게시판</h3>
			</div>
			<div class="talbe-responsive">
				<table class="table"
					style="text-align: center; border: 1px solid #ddd;">
					<thead>
						<tr>
							<th>번호</th>
							<th>분류</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${totCnt > 0 }">
							<c:forEach var="board" items="${list }" varStatus="status">
								<tr>
									<td>${startNum }</td>
									<td>${board.category }</td>
									<td><a href="boardContent.do?id=${id}&bnum=${board.bnum}&pageNum=${currentPage}&ref=${board.ref}">${board.subject }</a></td>
									<td><ul class="nav navbar-nav"><li class="dropdown"><a href="#" class="dropdown-toggle" id="idlist" data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><input type="hidden" id="reply${status.index}" value="${board.id}">${board.id}<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<!-- <li><a href="#">프로필보기</a></li> -->
							<c:if test="${id !=null && id != ''}">
								<li><a href="#" data-target="#writeModal" data-toggle="modal" onclick="reply(${status.index});">쪽지보내기</a></li>
							</c:if>
							<c:if test="${id ==null || id== ''}">
								<li><a href="login.do">쪽지보내기</a></li>
							</c:if>
						</ul></li></ul></td>
									<td>${board.readcount }</td>
									<td>${board.wdate }</td>
								</tr>
								<c:set var="startNum" value="${startNum - 1 }" />
							</c:forEach>
						</c:if>
						<c:if test="${totCtn == 0 }">
							<tr>
								<td class="text-center">작성된 게시글이 존재하지 않습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<!-- 테이블 하단 영역 -->
			<div class="form-inline table-bottom">
				<!-- 페이지 넘버 영역 -->
				<div class="form-group">
					<nav class="pageBlock">
						<ul class="pagination pagination-sm">
						<c:if test="${startPage > blockSize}">
						    <li>
							    <a href='boardList.do?pageNum=${startPage-blockSize }&id=${member.id}' aria-label="Previous">
							    <span aria-hidden="true">&laquo;</span></a>
						    </li>
						</c:if>
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
						    <li><a href='boardList.do?pageNum=${i}&id=${member.id}'>${i}</a></li>
						</c:forEach>
						<c:if test="${endPage < pageCnt}">
						    <li>
						    	<a href='boardList.do?pageNum=${startPage+blockSize}&id=${member.id}' aria-label="Next">
						    	<span aria-hidden="true">&raquo;</span></a>
						    </li>
						</c:if>
						</ul>
					</nav>
				</div>
				<!-- 글쓰기 버튼 영역 -->
				<div class="form-group write-cont">
					<c:if test="${id !=null && id != ''}">
						<a href='boardWriterForm.do?id=${id}' class="btn btn-default" id="writeButton">글쓰기</a>
					</c:if>
					<c:if test="${id ==null || id== ''}">
						<a href="login.do" class="btn btn-default" id="writeButton">글쓰기</a>
					</c:if>
				</div>
				<div class="form-group search-cont">
					<form action="boardSearch.do" method="post">
						<div class="input-group">
							<span class="input-group-addon" id="search-back">
								<select class="form-control input-sm" name="opt" id="opt">
									<option value=1>작성자</option>
									<option value=2>제목</option>
									<option value=3>내용</option>
									<option value=4>제목+내용</option>
								</select>
							</span>
							<input type="text" class="form-control input-sm" placeholder="검색" name="condition" id="searchbar">
							<span class="input-group-btn">
						        <input type="submit" class="btn btn-default input-sm" id="submitButton" value="검 색">
						    </span>
						</div>
				    </form>
				</div>
			</div>
		</div>
	</div>
<!-- 쪽지보내기 -->
<div class="row">
	<div class="modal" id="writeModal" tabindex="-1">
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
</body>
</html>
<%@include file="footer.jsp" %>