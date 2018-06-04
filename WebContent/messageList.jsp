<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/noljaBooster.css">
	<title>심심할땐? 놀자GO! : 쪽지함</title>
	
<style type="text/css">
	/* 쪽지함 영역 */
	.msg-head {
		width: 80%;
		margin-top: 65px;
	}
	.msg-head #msgImg {
		width: 100px;
	}
	.msg-head h3 {
		margin-top: 15px;
		margin-bottom: 50px;
	}
	/* 메뉴 영역 */
	.menubar {
		height: 50px;
		width: 80%;
	}
	.menubar-list {
		width: 60%;
	}
	/* 테이블 영역 */
	table th {
		background-color: ghostwhite;
		vertical-align:middle;
		text-align: center;
	}	
	table td {
		padding: 20px !important;
		vertical-align: middle !important;
		font-size: 13px;
		text-align: center;
	}
	table tr:hover {
		background-color: ghostwhite;
	}
	.msg-table th:nth-child(2) {
		width: 20%;
	}
	.msg-table th:nth-child(3) {
		width: 30%;
	}
	.nav-tabs > li.active > a,
	.nav-tabs > li.active > a:hover,
	.nav-tabs > li.active > a:focus {
		color: white;
		background-color: #1ca2e3;
	}
	/* 받은 편지함 테이블 */
	.msg-table {
		width: 80%;
		margin-bottom: 65px;
	}
	.receive-table,
	.send-table,
	.end {
		width: 60%;
	}
	#write {
		font-size: 13px;
		border: none;
		color: white;
		background-color: #005aa7;
	}
	/* 받은 편지함 상세내역 */
	.rcvModal-table table {
		border-bottom: 1px solid silver;
	}
	.rcvModal-table th {
		padding: 20px !important;
		width: 20%;
		background-color: #005aa7;
		color: white;
	}
	.rcvModal-table td {
		background-color: #f4fbfb;
	}
	#reply {
		border: none;
		font-size: 13px;
		color: white;
		background-color: #005aa7;
	}
	#msgDel {
		border: none;
		font-size: 13px;
		color: white;
		background-color: #dc281e;
	}
	/* 보낸 쪽지함 상세내역  */
	.sndModal-table table {
		border-bottom: 1px solid silver;
	}
	.sndModal-table th {
		padding: 20px !important;
		width: 20%;
		background-color: #005aa7;
		color: white;
	}
	.sndModal-table td {
		background-color: #f4fbfb;
	}
	/* 글쓰기 모달 영역 */
	.write-box table {
		border-bottom: 1px solid silver;
	}
	.write-box th {
		padding: 20px !important;
		width: 20%;
		background-color: #005aa7;
		color: white;
	}
	.write-box td {
		background-color: #f4fbfb;
	}
	.write-box table > tbody > tr > th,
	.write-box table > tbody > tr > td {
		vertical-align: middle;
	}
	#writeButton {
		margin-left: 60px;
	}
	#writeButton {
		border: none;
		font-size: 13px;
		background-color: #005aa7;
		color: white;
	}
	#writeCancle {
		border: none;
		font-size: 13px;
		background-color: #dc281e;
		color: white;
	}
	#rcvlist {
		border: none;
		font-size: 13px;
		background-color: #1ca2e3;
		color: white;
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
	/* 보낸 편지함 상세보기 */
	function showRcvMsg(index) {
		var i = index;
		var val = $("#snd"+i).val();
		var valArr = val.split('_');
		var toid = valArr[0];
		var mcont = valArr[1];
		var mdate = valArr[2];
		var mnum = valArr[3];
		$("#toid").text(toid);
		$("#rcvMcont").text(mcont);
		$("#rcvMdate").text(mdate);
		$("#rcvMnum").val(mnum);
	}
	/* 받은 편지함 상세보기 */
	function showSndMsg(index) {
		var i = index;
		var val = $("#rcv"+i).val();
		var valArr = val.split('_');
		var fromid = valArr[0];
		var mcont = valArr[1];
		var mdate = valArr[2];
		var mnum = valArr[3];
		$("#fromid").text(fromid);
		$("#sndMcont").text(mcont);
		$("#sndMdate").text(mdate);
		$("#sndMnum").val(mnum);
	}
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
	/* 받은 메세지 삭제 */
	function deleteRcvMsg() {
		var mnum = $("#rcvMnum").val();
		$.post('messageDeletePro.do', {mnum:mnum}, function(result){
			if(result.trim() == 1) {
				$("#rcvDelOk").addClass("alert alert-info center-block text-center").text("쪽지를 성공적으로 삭제했습니다.").hide().slideDown(1500, function(){
					$("#rcvDelOk").slideUp(1500);
					setTimeout("location.reload()", 2000);
				});
			} else {
				$("#rcvDelOk").addClass("alert alert-danger center-block text-center").text("받은 쪽지 삭제를 실패하였습니다.").hide().slideDown(1500, function(){
					$("#rcvDelOk").slideUp(1500);
					setTimeout("location.reload()", 2000);
				});
			}
		});
	}
	/* 보낸 메세지 삭제 */
	function deleteSndMsg() {
		var mnum = $("#sndMnum").val();
		$.post('messageDeletePro.do', {mnum:mnum}, function(result){
			if(result.trim() == 1) {
				$("#sndDelOk").addClass("alert alert-info center-block text-center").text("쪽지를 성공적으로 삭제했습니다.").hide().slideDown(1500, function(){
					$("#sndDelOk").slideUp(1500);
					setTimeout("location.reload()", 2000);
				});
			} else {
				$("#sndDelOk").addClass("alert alert-danger center-block text-center").text("보낸 쪽지 삭제를 실패하였습니다.").hide().slideDown(1500, function(){
					$("#sndDelOk").slideUp(1500);
					setTimeout("location.reload()", 2000);
				});
			}
		});
	}
	/* 답장쓰기 */
	$(document).ready(function(){
		$("#reply").click(function(){
			var toid = $("#toid").text();
			$("#msgToid").val(toid);
		});
	});
</script>
</head>
<%@include file="menu.jsp" %>	
<%------------ B O D Y ------------%>
<body>
	<div class="container">
		<!-- 제목 영역 -->
		<div class="msg-head center-block">
			<div class="row">
				<img src="images/memo.svg" class="img-responsive center-block" id="msgImg" alt="message image">	
			</div>
			<div class="row">
				<h3 class="text-center">${member.name}님의 쪽지함</h3>
			</div>
		</div>
		<!-- 메뉴바 영역 -->
		<div class="menubar center-block">
			<div class="menubar-list center-block">
				<div role="tabpanel">
					<ul class="nav nav-tabs nav-justified" role="tablist" id="myTab">
						<li role="presentation" class="active text-center" id="firstLi"><a href="#receive" aria-controls="receive" role="tab" data-toggle="tab">받은 편지함</a></li>
						<li role="presentation" id="secondLi"><a href="#send" aria-controls="send" role="tab" data-toggle="tab">보낸 편지함</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 테이블 영역 -->
		<div class="msg-table center-block">
			<div class="tab-content center-block">
				<!-- 받은 편지 영역 -->
				<div role="tabpanel" class="tab-pane active" id="receive">
					<div class="receive-table center-block">
						<div class="table-responseive">
							<table class="table">
								<thead>
									<tr>
										<th>내 용</th>
										<th>보낸이</th>
										<th>받은 날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${totCnt > 0 }">
										<c:forEach var="snd" items="${sendList}" varStatus="status">
											<tr>
												<td id="showMsg" data-target="#rcvModal" data-toggle="modal" onclick="showRcvMsg(${status.index});"><input type="hidden" id="snd${status.index}" value="${snd.fromid}_${snd.mcontent}_${snd.mdate}_${snd.mnum}">${snd.mcontent}</td>
												<td>${snd.fromid}</td>
												<td>${snd.mdate}</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${totCnt == 0}">
										<tr>
											<td class="text-center" colspan="3">받은 쪽지가 없습니다.
										</tr>
									</c:if>
								</tbody>
							</table>
							<nav class="pageBlock center-block text-center">
								<ul class="pagination pagination-sm">
								<c:if test="${startSndPage > blockSndSize}">
								    <li>
									    <a href='messageList.do?=${id}&pageSndNum=${startSndPage-blockSndSize}' aria-label="Previous">
									    <span aria-hidden="true">&laquo;</span></a>
								    </li>
								</c:if>
								<c:forEach var="i" begin="${startSndPage}" end="${endSendPage}">
								    <li><a href='messageList.do?id=${id}&pageSndNum=${i}'>${i}</a></li>
								</c:forEach>
								<c:if test="${endSendPage < pageSendCnt}">
								    <li>
								    	<a href='messageList.do?=${id}&pageSndNum=${startSndPage+blockSndSize}' aria-label="Next">
								    	<span aria-hidden="true">&raquo;</span></a>
								    </li>
								</c:if>
								</ul>
							</nav>
							<div class="end center-block text-center">
								<button type="button" class="btn btn-default" id="write" data-target="#writeModal" data-toggle="modal">글쓰기</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 보낸 편지 영역 -->
				<div role="tabpanel" class="tab-pane" id="send">
					<div class="send-table center-block">
						<div class="table-responseive">
							<table class="table">
								<thead>
									<tr>
										<th>내 용</th>
										<th>받는이</th>
										<th>보낸 날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${totRcv > 0}">
										<c:forEach var="rcv" items="${rcvList}" varStatus="stat">
											<tr>
												<td id="showMsg" data-target="#sndModal" data-toggle="modal" onclick="showSndMsg(${stat.index});"><input type="hidden" id="rcv${stat.index}" value="${rcv.toid}_${rcv.mcontent}_${rcv.mdate}_${rcv.mnum}">${rcv.mcontent}</td>
												<td>${rcv.toid}</td>
												<td>${rcv.mdate}</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${totRcv == 0}">
										<tr>
											<td class="text-center" colspan="3">보낸 쪽지가 없습니다.
										</tr>
									</c:if>
								</tbody>
							</table>
							<nav class="pageBlock center-block text-center">
								<ul class="pagination pagination-sm">
								<c:if test="${startRcvPage > blockRcvSize}">
								    <li>
									    <a href='messageList.do?=${id}&pageRcvNum=${startRcvPage-blockRcvSize}' aria-label="Previous">
									    <span aria-hidden="true">&laquo;</span></a>
								    </li>
								</c:if>
								<c:forEach var="i" begin="${startRcvPage}" end="${endRcvPage}" varStatus="status">
								    <li onclick="activeList(${status.index});"><a href='messageList.do?id=${id}&pageRcvNum=${i}'>${i}</a></li>
								</c:forEach>
								<c:if test="${endRcvPage < pageRcvCnt}">
								    <li>
								    	<a href='messageList.do?=${id}&pageRcvNum=${startRcvPage+blockRcvSize}' aria-label="Next">
								    	<span aria-hidden="true">&raquo;</span></a>
								    </li>
								</c:if>
								</ul>
							</nav>
							<div class="end center-block text-center">
								<button type="button" class="btn btn-default" id="write" data-target="#writeModal" data-toggle="modal">글쓰기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- 모달 영역  -->
<div class="row">
	<!-- 받은 쪽지 상세보기 모달 -->
	<div class="modal" id="rcvModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<a class="rcv-title">받은 쪽지 상세보기</a>
					<button class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div id="rcvDelOk"></div>
					<div class="rcvModal-table">
						<div class="table-responsive">
							<table class="table">
								<tbody>
									<tr>
										<th>보낸이</th>
										<td id="toid"></td>
									</tr>
									<tr>
										<th>내용</th>
										<td id="rcvMcont" style="word-break:break-all;"></td>
									</tr>
									<tr>
										<th>보낸 날짜<input type="hidden" id="rcvMnum"></th>
										<td id="rcvMdate"></td>
									</tr>
								</tbody>
							</table>
						</div>
					<div class="btnGroup text-center">
						<a class="btn btn-default" role="button" id="reply" data-target="#writeModal" data-toggle="modal">답 장</a>
						<a class="btn btn-default" role="button" id="msgDel" onclick="deleteRcvMsg();">삭 제</a>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 보낸 쪽지 상세보기 모달 -->
	<div class="modal" id="sndModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<a class="snd-title">보낸 쪽지 상세보기</a>
					<button class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div id="sndDelOk"></div>
					<div class="sndModal-table">
						<div class="table-responsive">
							<table class="table">
								<tbody>
									<tr>
										<th>받는이</th>
										<td id="fromid"></td>
									</tr>
									<tr>
										<th>내용</th>
										<td id="sndMcont" style="word-break:break-all;"></td>
									</tr>
									<tr>
										<th>보낸 날짜<input type="hidden" id="sndMnum"></th>
										<td id="sndMdate"></td>
									</tr>
								</tbody>
							</table>
						</div>
					<div class="btnGroup text-center">
						<a class="btn btn-default" role="button" id="msgDel" onclick="deleteSndMsg();">삭 제</a>
					</div>
					</div>
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
										<td><input type="text" class="form-control" id="msgToid" placeholder="쪽지를 받는 사람의 ID를 입력해주세요" required="required" style="width: 100%;">
									</tr>
									<tr>
										<th>내 용</th>
										<td><textarea class="form-control" rows="5" cols="50" id="mcontent"></textarea></td>
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
</body>
</html>
<%@include file="footer.jsp" %>