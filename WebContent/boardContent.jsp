<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/noljaBooster.css">
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
/* 테이블 영역 */
.cont-box {
	margin-top: 65px;
	width: 60%;
}
.cont-box table {
	margin-bottom: 65px;
}
#bcont-table {
	margin-top: 0;
	border-top: 1px solid #ddd;
}

.cont-box th {
	font-size: 2em;
	border-bottom: none !important;
	padding-left: 15px !important;
}
.cont-box thead td {
	padding-left: 15px !important;
}
/* 작성자 영역 */
.cont-box thead span {
	margin-right: 15px;
}
#bid {
	font-size: 16px;
	font-weight: bold;
}
#bdate {
	font-size: 12px;
	color: #c7c7c7;
}
#bcnt {
	font-size: 12px;
}
pre {
	font-family: 'Nanum Gothic';
	border: none;
	font-size: 16px;
	background-color: white;
}
/* 버튼 영역 */
#noidlist {
	border: none;
	color: white;
	background-color: #005aa7;
}
#bmodi {
	margin-right: 5px;
	border: none;
	color: white;
	background-color: #1ca2e3;
}
#bdel {
	margin-right: 5px;
	border: none;
	color: white;
	background-color: #dc281e;
}
/* 댓글 영역 */
.re-box .row {
	color: white;
	padding: 15px;
	font-size: 20px;
	font-weight: bold;
	background-color: #1ca2e3;
}
#re-table {
	margin-top: 0;
	margin-bottom: 0;
}
#re-table #reTitle {
	background-color: #e9f7f9;
}
#re-table td {
	border-top: none;
	border-bottom: 1px solid #ddd;
}
/* 댓글 작성자 영역 */
.re-box span {
	margin-right: 15px;
}
#reid {
	font-size: 16px;
	font-weight: bold;
}
#redate {
	font-size: 12px;
	color: #c7c7c7;
}
#reModi {
	margin-right: 5px;
	border: none;
	color: white;
	background-color: #1ca2e3;
}
#reDel {
	margin-right: 5px;
	border: none;
	color: white;
	background-color: #dc281e;
}
#reRe {
	border: none;
	color: white;
	background-color: #1ca2e3;
}
#id-reRe {
	margin-right: 5px;
	border: none;
	color: white;
	background-color: #1ca2e3;
}
#reCont {
	font-size: 14px;
}
/* 댓글 남기기 영역 */
#rewrite-table {
	margin-top: 15px;
}
#rewrite-table td {
	border-top: none !important;
}
#rewrite-section {
	padding: 0;
	background-color: #005aa7;
}
#rewrite-button {
	color: white;
	font-size: 13px;
	border: none;
	height: 72px;
	background-color: #005aa7;
}
#idnull-sub {
	color: #dc281e;
	font-weight: bold;
}
/* 댓글의 댓글 남기기 영역 */
#reRe-button {
	color: white;
	font-size: 13px;
	border: none;
	height: 72px;
	background-color: #005aa7;
}
#reRe-table {
	margin: 0;
}
#reRe-table td {
	border-top: none;
}
#reRe-td {
	border-bottom: none !important;
	padding-left: 8px;
}
#reRe-div {
	margin-top: 15px;
	margin-bottom: 15px;
}
#re_subject {
	border-radius: 4px;
}
#reImg-span {
	margin-right: 0 !important;
	padding: 0;
}
#reImg {
	margin-top: -10px;
	width: 50px;
	height: 20px;
}
#reRe-title {
	background-color: ghostwhite;
}
#reReCont {
	font-size: 14px;
	padding-left: 50px;
}
/* 쪽지보내기 영역 */
.dropdown-menu {
	min-width: 0;
}
.cont-box .navbar-nav > li > a {
	padding: 0;
}
.cont-box .navbar-nav > li > a:hover, .cont-box .navbar-nav > li > a:focus {
	font-weight: bold;
	background-color: white;
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
#writeButton {
	border: none;
	font-size: 13px;
	color: white;
	background-color: #005aa7;
}
</style>
<script>
	/* 댓글의 답변 쓰기 기능 */
	function reRe(index) {
		var i = index;
		$("#rewrite-row").css("display", "none");
		status = $(".reTitle"+i).next(".hide_display").css("display");
		if (status == "none") {
			$(".hide_display").css("display", "none");
			$(".reTitle"+i).next(".hide_display").css("display", "");
		} else {
			$(".reTitle"+i).next(".hide_display").css("display", "none");
			$("#rewrite-row").css("display", "");
		}
	}
	
	/* 댓글 쓰기 */
	function replyWrite() { 
		var subject = $("#subject").val();
		var bnum = '${bnum}';
		var id = '${id}';
		var ref = '${board.ref}';
		var re_level = '${re_level}';
		var sendData = "subject=" + subject + "&bnum=" + bnum + "&id=" + id
				+ "&ref=" + ref + "&re_level=1";
		console.log(sendData);
		$.post('boardReplyWrite.jsp', sendData, function(result) {
			if (result.trim() == "1") {
				alert("댓글 달았어요");
			} else {
				alert("오류 발생");
			}
			location.reload();
		})
	}
	/* 댓글의 댓글 쓰기 */
	function re_replyWrite(index) {
		var i = index;
		var re_subject = $("#re_subject"+i).val();
		var re_bnum = '${bnum}'
		var re_id = '${id}';
		var re_ref = $("#re_ref"+i).val();
		var sendData2 = "subject=" + re_subject + "&bnum=" + re_bnum + "&id=" + re_id + "&ref=" + re_ref + "&re_level=2";

		console.log(sendData2);
		$.post('boardReplyWrite.jsp', sendData2, function(result) {
			if (result.trim() == "1") {
				alert("댓글 달았어요");
			} else {
				alert("오류 발생");
			}
			location.reload();
		})
	}
	/* 댓글 삭제 */
	function replyDelete() {
		var bnum = document.getElementById("re_bnum").value;
		var id = '${id}';
		alert(bnum);
		alert(id);
		if (confirm("댓글을 삭제하시겠습니까?") == true) {
			$.post('boardReplyDelete.jsp', {bnum:bnum,id:id}, function(result) {
				if (result.trim() == "1") {
					location.reload();
				} else {
					location.reload();
				}
			});
		} else {
			return;
		}
	}
	/* 댓글의 댓글 삭제 */
	function re_replyDelete() {
		var bnum = document.getElementById("re_re_bnum").value;
		var id = '${id}';
		var sendData3 = "bnum=" + bnum + "&id=" + id;
		console.log(sendData3)
		if (confirm("댓글을 삭제하시겠습니까?") == true) {
			$.post('boardReplyDelete.jsp', sendData3, function(result) {
				if (result.trim() == "1") {
					location.reload();
				} else {
					location.reload();
				}
			});
		} else {
			return;
		}
	}
	function reply() {
		var toid = $("#reply").val();
		$("#msgToid").val(toid);
	}
</script>
</head>
<%@include file="menu.jsp"%>
<%------------ B O D Y ------------%>
<body>
	<div class="container">
		<div class="cont-box center-block">
			<div class="row text-center">
				<a><img src="images/board.svg" id="boardImg"></a>
			</div>
			<div class="row center-block">
				<h3 class="text-center">자유 게시판</h3>
			</div>
			<div class="table-responsive">
				<table class="table" id="bcont-table">
					<thead>
						<tr>
							<th>${board.subject }</th>
						</tr>
						<tr>
							<td>
								<ul class="nav navbar-nav"><li class="dropdown"><a href="#" class="dropdown-toggle" id="idlist" data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><input type="hidden" id="reply" value="${board.id}">${board.id}<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<!-- <li><a href="#">프로필보기</a></li> -->
							<c:if test="${id !=null && id != ''}">
								<li><a href="#" data-target="#writeModal" data-toggle="modal" onclick="reply();">쪽지보내기</a></li>
							</c:if>
							<c:if test="${id ==null || id== ''}">
								<li><a href="login.do">쪽지보내기</a></li>
							</c:if>
						</ul></li></ul>
								<span id="bdate">${board.wdate}</span>
								<span id="bcnt">${board.readcount} views</span>
								<c:if test="${board.id != member.id || id == null || id == ''}">
									<a href="boardList.do?bnum=${board.bnum}&pageNum=${pageNum}"
										class="btn btn-default btn-xs pull-right" id="noidlist">목록</a>
								</c:if>
								<c:if test="${board.id == member.id}">
									<a href="boardList.do?bnum=${board.bnum}&pageNum=${pageNum}&id=${member.id}"
										class="btn btn-default btn-xs pull-right" id="noidlist">목록</a>
									<a href="boardDeleteForm.do?bnum=${board.bnum}&pageNum=${pageNum}&ref=${board.ref}"
											class="btn btn-default btn-xs pull-right" id="bdel">삭제</a>
									<a href="boardUpdateForm.do?bnum=${board.bnum}&pageNum=${pageNum}"
											class="btn btn-default btn-xs pull-right" id="bmodi">수정</a>
								</c:if>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><pre>${board.content}</pre></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 댓글 영역 -->
			<div class="re-box">
				<div class="row center-block">
					댓글 목록
				</div>
				<div class="table-responsive">
					<!-- 댓글 뿌려주기 -->
					<c:if test="${replyTotCnt > 0 }">
						<c:forEach var="reply" items="${replyList }" varStatus="status">
							<table class="table" id="re-table">
								<tr id="reTitle">
									<td>
										<span id="reid">${reply.id}</span>
										<span id="redate">${reply.wdate}</span>
										<c:if test="${id == reply.id }">
										<input type="hidden" id="re_bnum" value="${reply.bnum }">
											<button type="button" class="btn btn-default btn-xs pull-right" id="reDel" onclick="replyDelete()">삭제</button>
											<!-- <button type="button" class="btn btn-default btn-xs pull-right" id="reModi">수정</button> -->
											<button type="button" class="btn btn-default btn-xs pull-right" id="id-reRe" onclick="reRe(${status.index});">답변</button>
										</c:if>
										<c:if test="${id != reply.id && id !=null && id !=''}">
											<button type="button" class="btn btn-default btn-xs pull-right" id="reRe" onclick="reRe(${status.index});">답변</button>
										</c:if>
									</td>
								</tr>
								<tr class="reTitle${status.index}">
									<td><pre id="reCont">${reply.subject}</pre></td>
								</tr>
								
								<!-- 답변 클릭했을 때 -->
								<tr class="hide_display" style="display: none;">
									<td id="reRe-td">
										<div class="input-group" id="reRe-div">
											<input type="hidden"  id="re_ref${status.index}" value="${reply.bnum}">
											<input type="hidden" id="re_id" value="${id}">
											<textarea class="form-control" rows="3" id="re_subject${status.index}" style="width: 100%;" maxlength="150" placeholder="댓글의 댓글 남기기"></textarea>
											<span class="input-group-addon" id="rewrite-section">
												<button type="button" class="btn btn-default btn-lg" id="reRe-button" onclick="re_replyWrite(${status.index});">등록</button>
											</span>
										</div>	
									</td>
								</tr>
								
								<!-- 댓글의 댓글 뿌려주기 -->
								<c:forEach var="re_reply" items="${re_replyList }">
									<c:if test="${ reply.bnum == re_reply.ref }">
										<input type="hidden" id="re_re_bnum" value="${re_reply.bnum }">
										<tr id="reRe-title">
											<td>
												<span id="reImg-span"><img src="images/reply2.svg" id="reImg"></span>
												<span id="reid">${re_reply.id}</span>
												<span id="redate">${re_reply.wdate}</span>
												<c:if test="${id == re_reply.id }">
													<button type="button" class="btn btn-default btn-xs pull-right" id="reDel" onclick="re_replyDelete()">삭제</button>
													<!-- <button type="button" class="btn btn-default btn-xs pull-right" id="reModi">수정</button> -->
												</c:if>
											</td>
										</tr>
										<tr>
											<td><pre id="reReCont">${re_reply.subject}</pre></td>
										</tr>
									</c:if>
								</c:forEach>
							</table>
						</c:forEach>
					</c:if>
					
					<!-- 댓글 쓰기 영역 -->
					<div class="rewrite-box">
						<input type="hidden" id="bnum" name="bnum" value="${board.bnum }">
						<input type="hidden" id="id" name="id" value="${id }">
						<input type="hidden" id="ref" name="ref" value="${board.ref }">
						<input type="hidden" id="re_level" name="re_level" value="${board.re_level }">
						<table class="table" id="rewrite-table">
							<tr id="rewrite-row">
								<c:if test="${id != null && id != ''}">
									<td>
										<div class="input-group">
											<textarea class="form-control" rows="3" id="subject" style="width: 100%;" maxlength="150" placeholder="댓글 남기기"></textarea>
											<span class="input-group-addon" id="rewrite-section">
												<button type="button" class="btn btn-default btn-lg" id="rewrite-button" onclick="replyWrite()">등록</button>
											</span>
										</div>
									</td>
								</c:if>
								<c:if test="${id == null  || id == ''}">
									<td>
										<div class="input-group">
											<textarea class="form-control text-center" rows="3" id="idnull-sub" style="width: 100%;" maxlength="150" disabled="disabled">
											                                 로그인 후 사용이 가능합니다.</textarea>
											<span class="input-group-addon" id="rewrite-section">
												<button type="button" class="btn btn-default btn-lg" id="rewrite-button" disabled="disabled">등록</button>
											</span>
										</div>
									</td>
								</c:if>
							</tr>
						</table>
					</div>
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
							<button class="btn btn-default" id="writeCancle" onclick="document.getElementById('writeModal').style.display='none'">취 소</button>
							<a href="messageList.do?id=${id}" class="btn btn-default pull-right" role="button" id="rcvlist">목 록</a>
						</div>
					</div>	
				</div>
			</div>
		</div>
	</div>
</div>								
									
	<!---------------- C O N T E N T _ E N D------------------>
</body>
</html>
<%@include file="footer.jsp"%>