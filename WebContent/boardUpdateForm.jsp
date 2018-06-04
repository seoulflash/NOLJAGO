<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
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
	.write-box {
		margin-top: 65px;
		margin-bottom: 65px;
	}
	.write-box th {
		padding-left: 15px !important;
		color: white;
		background-color: #1ca2e3;
	}
	#sel {
		width: 10%;
	}
	/* 글쓰기 영역 */
	.write-box {
		width: 80%
	}
	/* 버튼 영역 */
	.btn-box {
		text-align: center;
	}
	#savebutton {
		margin-right: 5px;
		border: none;
		font-size: 13px;
		color: white;
		background-color: #005aa7;
	}
	#cancleButton {
		font-size: 13px;
		border: none;
		color: white;
		background-color: #dc281e;
	}
	</style>
	
		<!-- C K E D I T O R -->
	<script type="text/javascript">
		window.onload = function() {
			CKEDITOR.replace('content');
			var editorText = "";
			CKEDITOR.instansec.ckeditor.getdata();
		}
	</script>
</head>
<%@include file="menu.jsp"%>
<%------------ B O D Y ------------%>
<body>
	<!---------------- B O A R D U P D A T E F O R M ------------------>
	<div class="container">
		<div class="write-box center-block">
			<div class="row text-center">
				<a><img src="images/board.svg" id="boardImg"></a>
			</div>
			<div class="row center-block">
				<h3 class="text-center">자유 게시판</h3>
			</div>
			<form action="boardUpdatePro.do?pageNum=${pageNum}" method="post">
				<input type="hidden" name="bnum" value="${board.bnum }">
				<input type="hidden" name="ref" value="${pageNum }">
				<input	type="hidden" name="id" value="${board.id }">
				
				<table class="table">
					<tr>
						<th colspan="2" class="text-left">제목</th>
					</tr>
					<tr>
						<td id="sel">
							<select class="selectpicker form-control" name="category">
								<option>잡담</option>
								<option>정보</option>
								<option>기타</option>
							</select>
						</td>
						<td id="sub">
							<input type="text" class="form-control" name="subject" id="subject" maxlength="50" required="required" value="${board.subject }">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<textarea class="content" name="content" id="content" rows="20" style="width: 100%;">${board.content }</textarea>
						</td>
					</tr>
				</table>
				<div class="btn-box">
					<input type="submit"  class="btn btn-default input-sm" id="savebutton" value="수 정">
					<button type="button" class="btn btn-default btn-sm" id="cancleButton" onclick="history.back();">취 소</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>
<%@include file="footer.jsp"%>