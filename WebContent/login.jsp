<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>들어와! 놀자GO!</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/cookie.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/noljaBooster.css">
<style type="text/css">
	form {
		display: block;
	}
	.form-login {
		margin: 65px auto;
		padding: 30px;
		width: 350px;
	}
	#logImg {
		margin-right: 10px;
		width: 80px;
		height: 80px;
	}
	form h2 {
		margin-top: 10px;
		margin-bottom: 30px;
	}
	form input {
		margin: 15px 0;
	}
	form input:placeholder-shown {
		/* Standard (https://drafts.csswg.org/selectors-4/#placeholder) */
		font-size: 13px;
	}
	
	form label {
		font-weight: normal;
		margin: 0;
		font-size: 14px;
	}
	
	form #submit {
		background-color: powderblue;
		border: none;
		margin: 15px 0;
	}
	
	form .row {
		display: inline-block;
		font-size: 10px;
		margin: 0;
	}
	
	form .checkbox {
		padding: 0;
		margin-top: 0;
	}
	
	form .col-md-6 {
		padding: 0;
		margin-bottom: 15px;
	}
	
	.form-horizontal .checkbox {
		padding: 0;
	}
	form a:hover {
		color: silver;
		text-decoration: none;
		cursor: pointer;
	}
	/* 로그인 버튼 */
	#submit {
		font-size: 14px;
		border: none;
		background: linear-gradient(141deg, #0fb8ad 0%, #1fc8db 51%, #2cb5e8 75%);
		color: white;
	}
	#loginOk {
		font-size: 12px;
		color: red;
		margin-bottom: 15px;
	}
	/* 아이디 비밀번호 찾기 팝업창 */
	/* input 넓이 설정 */
	.modal .input-lg {
	width: 300px;
	/* border-radius: 0; */
	font-size: 13px;
	}
	.modal #findname {
		margin-top: 5px;
	}
	.modal #findid {
	   	margin-top: 5px;
	}
	.modal #findSubmit {
	   	color: white;
		background: linear-gradient(141deg, #0fb8ad 0%, #1fc8db 51%, #2cb5e8 75%);
	}
	.modal #mbCont {
		margin: 30px auto;
	}
	.modal .id-notice {
		color: red;
		font-size: 10px;
	}
	.modal-footer a {
		color: black;
	}
	</style>
<script type="text/javascript">
	/* 아이디저장 스크립트 */
	$(document).ready(function() {
		// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
		var userInputId = getCookie("userInputId");
		$("input[name='id']").val(userInputId);

		if ($("input[name='id']").val() != "") { // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
			$("#saveid").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
		}

		$("#saveid").change(function() { // 체크박스에 변화가 있다면,
			if ($("#saveid").is(":checked")) { // ID 저장하기 체크했을 때,
				var userInputId = $("input[name='id']").val();
				setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
			} else { // ID 저장하기 체크 해제 시,
				deleteCookie("userInputId");
			}
		});

		// ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
		$("input[name='id']").keyup(function() { // ID 입력 칸에 ID를 입력할 때,
			if ($("#saveid").is(":checked")) { // ID 저장하기를 체크한 상태라면,
				var userInputId = $("input[name='id']").val();
				setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
			}
		});
	});
	/* 아이디 찾기 스크립트 */
	function findId() {
		var findname = $('#findname').val();
		var findemail = $('#findemail').val();
		$.post('findId.do', {name:findname, email:findemail}, function(userId) {
			if (userId.trim() != "null") {
				$("#findname").css("background-color", "white");
				$("#findemail").css("background-color", "white");
				$("#findidOk").text("회원님의 아이디는 [" + userId + " ]입니다.").css("color", "#2cb5e8");
			} else if (userId.trim() == "null") {
				$("#findname").css("background-color", "#FFCECE");
				$("#findemail").css("background-color", "#FFCECE");
				$("#findidOk").text("회원님의 이름과 이메일주소를 다시 확인해주세요.").css("font-size", "12px").css("color", "red");
			}
		})
	}
	/* 비밀번호 찾기 */
	function findPwd() {
		var findid = $('#findid').val();
		var findemail2 = $('#findemail2').val();
		$.post('findPwd.do',{findid:findid, findemail2:findemail2}, function(mailResult){
			console.log(mailResult);
			if(mailResult.trim() == "0") {
				$("#findid").css("background-color", "#FFCECE");
				$("#findemail2").css("background-color", "#FFCECE");
				$("#findpwdOk").text("회원님의 아이디와 이메일주소를 다시 확인해주세요").css("font-size", "12px").css("color", "red");
			} else if(mailResult.trim() == "1") {
				$("#findid").css("background-color", "white");
				$("#findemail2").css("background-color", "white");
				$("#findpwdOk").text("메일주소로 임시비밀번호를 전송하였습니다.").css("font-size", "14px").css("color", "#2cb5e8");
			}
		})
	}
</script>
</head>
<%@include file="menu1.jsp" %>
<%------------ B O D Y ------------%>
<body>
	<!-- 로그인체크 -->
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			$(document).ready(function() {
				$("#password").css("background-color", "#FFCECE");
				$("#loginOk").text("비밀번호를 확인해주세요.");
			});
		</script>
	</c:if>
	<c:if test="${result == -1 }">
		<script type="text/javascript">
			$(document).ready(function() {
				$("#id").css("background-color", "#FFCECE");
				$("#loginOk").text("아이디가 존재하지 않습니다.");
			});
		</script>
	</c:if>
	<!--------------- L O G I N : F O R M ---------------->
	<div class="container">
		<form class="form-horizontal form-login" action="loginAction.do" method="post">
			<div class="log-box text-center">
				<a><img src="images/login.svg" id=logImg></a>
			</div>
			<h2 class="form-login-heading text-center">들어와! 놀자GO!</h2>
			<label class="sr-only" for="id">아이디</label>
			<input type="text" class="form-control center-block input-lg" name="id"
				id="id" placeholder="아이디를 입력하세요" required autofocus> <label
				class="sr-only" for="password">비밀번호</label>
			<input type="password" class="form-control center-block input-lg" name="password"
				id="password" placeholder="비밀번호를 입력하세요" required>
			<div id="loginOk"></div>
			<div class="row">
				<label> <input class="pull-left" type="checkbox" id="saveid">&nbsp;아이디저장
				</label>
			</div>
			<a class="text-rihgt pull-right" data-target="#modal" data-toggle="modal" id="findButton">아이디/비밀번호 찾기</a>
				<input class="form-control center-block input-lg" id="submit" type="submit"	value="로&nbsp;그&nbsp;인">
		</form>
	</div>
	<!-- 아이디/비밀번호 찾기 모달 -->
	<div class="row">
		<div class="modal" id="modal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<a class="find-title">아이디/비밀번호 찾기</a>
						<button class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="mbCont">
							<h4 class="text-center">아이디 찾기</h4>
							<div class="form-group text-center">
								<a class="id-notice">※가입하실때 입력하셨던 이름과 이메일을 입력해주세요.</a>
								<label class="sr-only" for="findname">이름</label>
								<input type="text" class="form-control input-lg center-block" name="findname" id="findname" placeholder="이름" required="required">
								<label class="sr-only" for="findemail">이메일</label>
								<input type="email" class="form-control input-lg center-block" name="findemail" id="findemail" placeholder="이메일 주소" required="required">
								<div id="findidOk"></div>
								<input type="button" class="form-control input-lg center-block" id="findSubmit" value="아이디&nbsp;찾기" onclick="findId();">
							</div>
						</form>
						<form class="form-horizontal" id="mbCont">
							<h4 class="text-center">비밀번호 찾기</h4>
							<div class="form-group text-center">
								<a class="id-notice">※가입하실때 입력하셨던 아이디와 이메일을 입력해주세요.</a>
								<input type="text" class="form-control input-lg center-block" name="findid" id="findid" placeholder="아이디" required="required">
								<input type="email" class="form-control input-lg center-block" name="findemail2" id="findemail2" placeholder="이메일 주소" required="required">
								<div id="findpwdOk"></div>
								<input type="button" class="form-control input-lg center-block" id="findSubmit" onclick="findPwd();" value="비밀번호&nbsp;찾기">
								
							</div>
						</form>
					</div>
					<div class="modal-footer text-center">
						<a class="close" role="button" id="close" data-dismiss="modal">돌아가기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@include file="footer.jsp" %>