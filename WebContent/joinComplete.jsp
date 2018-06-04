<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>심심할땐? 놀자GO! : 회원가입</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/noljaBooster.css">
	<style type="text/css">
	.join-complete {
		margin: 65px;
	}
	/* 바디 메인 이미지 */
	.container .bodyTitleImg {
		width: 200px;
	}
	/* 바디 타이틀 제목 & 서브 타이틀 제목 */
	.container .page-header {
		margin-bottom: 30px;
		border: none;
	}
	.container #title {
		font-size: 40px;
	}
	.container #subTitle {
		font-size: 25px;
	}
	.btn-lg {
		margin: 0 5px;
		color: white;
		background: linear-gradient(141deg, #0fb8ad 0%, #1fc8db 51%, #2cb5e8 75%);
		font-size: 13px;
	}
	.empty {
		margin: 50px;
	}
	.bline a:hover {
		text-decoration: none;
	}
	</style>
</head>
<%@include file="menu.jsp" %>
<%------------ B O D Y ------------%>
<body>
	<div class="container">
		<div class="join-complete">
			<div class="row titleImg">
				<img src="images/idcard.svg" class="bodyTitleImg center-block">
			</div>
			<div class="page-header">
				<h1 class="text-center" id="title">축하합니다.</h1><p></p>
				<h1 class="text-center" id="subTitle">놀자GO! 회원가입이 완료되었습니다.</h1>
			</div>
			<form class="form-horizontal">
				<div class="row text-center">
					<p>최초 신규가입한 고객님께 놀자GO!에서 사용하실 수 있는 1,000포인트가 지급되었습니다.</p>
					<p>지금부터 놀자GO!로 떠나보세요.</p>
				</div>
				<div class="empty"></div>
			</form>
			<form class="form-inline">
				<div class="bline text-center">
					<a class="btn-lg" href="main.do?id=${id}" role="button">홈 으 로</a>
					<a class="btn-lg" href="login.jsp" role="button">로 그 인</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
<%@include file="footer.jsp" %>