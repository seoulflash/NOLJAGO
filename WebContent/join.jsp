<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Let's! 놀자GO! : 회원가입</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/nolja.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/noljaBooster.css">
	<style type="text/css">
		form {
			display: block;
		}
		#joinImg {
			width: 80px;
			height: 80px;
		}
		form h2 {
			margin-top: 0;
			margin-bottom: 0;
		}
		.form-join {
			margin: 0 auto;
			padding: 30px;
			width: 400px;
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

		form input[type="submit"] {
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

		/* 주소 관련 CSS */

		form .address {
			margin: 0 auto;
		}
		/* 성별 관련 CSS */

		form .sex-group {
			margin: 15px;
			text-align: center;
		}

		form .input-group-btn .tel {
			margin: 0 auto;
			width: 30%;

		}
		form .address {
			font-size: 12px;
		}
		#address {
			border-radius: 7px 0 0 7px;
		}
		/* 프로필 이미지 업로드 */
		#img {
			width: 100px;
			height: 100px;
		}
		.input-file {
			display: inline-block;
			margin-bottom: 15px;
		}
		#profile-group {
			padding-top: 20px;
		}
  		.input-file [type="file"] {
			position: absolute;
			width: 1px;
			height: 1px;
			padding: 0;
			margin: -1;
			overflow: hidden;
			clip: rect(0, 0, 0, 0);
			border: 0 none;
		} 
 		.input-file .file-label {
			display: inline-block;
			line-height: 24px;
			border-radius: 5px;
			font-size: 13px;
			background-color: #005aa7;
			color: white;
			text-align: center;
		}
 		.input-file .file-name	{
			margin: 0px 0px 15px 55px;
			width: 50%;
			background: #f5f5f5;
			height: 27px;
			line-height: 26px;
			text-indent: 5px;
			border: 1px solid #bbb;
		}
		/* 접근성 탭 포커스 스타일 */
		.file-focus {
			outline: 1px dotted #d2310e;
		}
		/* 한줄 자기소개 */
		#intro {
			margin: 15px auto;
		}
		/* 회원가입버튼 */
		#submit {
			font-size: 14px;
			border: none;
	        background: linear-gradient(141deg, #0fb8ad 0%, #1fc8db 51%, #2cb5e8 75%);
	        color: white;
		}
		div #emailOk {
			margin-bottom: 15px;
		}
		/* 아이디 / 비밀번호 입력 메세지 출력 */
		#idOk, #pwdFalse, #birthOk, #emailOk,
		#nameOk, #telOk, #imgOk {
			font-size: 12px;
			color: red;
		}
		#pwdOk {
			font-size: 12px;
		}
	    
	</style>
	<script type="text/javascript">
	/* 아이디 중복 체크 */
		function checkId() {
			var id = $('#id').val();
			$.post('checkid.do', {id:id}, function(result) {
				if(result.trim() == "0") {
					$("#idOk").html("사용가능한 아이디입니다.").css("color", "#2cb5e8").css("font-size", "12");
				} else if (result.trim() == "1") {
					$("#idOk").html("이미 존재하는 ID입니다.").css("color", "red");
				} else if (result.trim() == "-1") {
					$("#idOk").html("ID는 4자이상 20자이하로 입력해주세요.").css("color", "red");
				}
		 	});
		 }
	/* 비밀번호 체크 */
		function checkPwd() {
		var password = $('#password').val();
		var password2 = $('#password2').val();
		if(password2 == "" || password2 != password) {
			$("#password2").css("background-color", "#FFCECE");
			$("#pwdOk").hide();
			$("#pwdFalse").show();
			$("#pwdFalse").html("비밀번호를 확인해주세요.")
		} else if(password == password2) {
			$("#password2").css("background-color", "#FFFFFF");
			$("#pwdFalse").hide();
			$("#pwdOk").show();
			$("#pwdOk").html("비밀번호 일치").css("color", "#2cb5e8");
		}
			
	}
	/* 생년월일 길이 체크 */
		function checkBirth() {
		var birth = $('#birth').val();
		if(birth.length < 8) {
			$("#birth").css("background-color", "#FFCECE");
			$("#birthOk").html("생년월일을 확인해주세요.")
		} else if(birth.length == 8) {
			$("#birth").css("background-color", "white");
			$("#birthOk").hide();
		}
	}
	/* 이름길이 체크 */
		function checkName() {
		var name = $('#name').val();
		if(name.length < 2 || name.length > 8) {
			$("#name").css("background-color", "#FFCECE");
			$("#nameOk").html("이름은 2자이상 8자이하로 입력해주세요");
		} else if(name.length == 2 || name.length == 8) {
			$("#name").css("background-color", "white");
			$("#nameOk").hide();
		}
	}
	/* 전화번호 체크 */
		function checkTel() {
		var tel = $('#tel').val();
		if(tel.length < 11 || tel.length > 13) {
			$("#tel").css("background-color", "#FFCECE");
			$("#telOk").html("'-'를 포함한 11~13자까지만 가능합니다.")
		} else if(tel.length == 11 || tel.length == 13) {
			$("#tel").css("background-color", "white");
			$("#telOk").hide();
		}
	}
	/* 이메일체크 */
		function checkEmail() {
			var str = $('#email').val();
			if(str.indexOf("@") == -1) {
				$("#email").css("background-color", "#FFCECE");
				$("#emailOk").html("이메일주소를 확인해주세요.")
			} else if(str.indexOf("@") != -1) {
				$("#email").css("background-color", "white");
				$("#emailOk").hide();
			}
		}
	/* 프로필 이미지 업로드 */
		var sel_file;
		$(document).ready(function() {
			$("#image").on("change", handleImgFileSelect);
		});
		
		function handleImgFileSelect(e) {
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);
			
			filesArr.forEach(function(f) {
				if(!f.type.match("image.*")) {
					$("#imgOk").html("이미지파일만 선택가능합니다.");
					/* alert("확장자는 이미지 확장자만 가능합니다."); */
					return;
				}
				
				sel_file = f;
				
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#img').attr("src", e.target.result);
				}
				reader.readAsDataURL(f);
			});
		}
		
	</script>
</head>
<%@include file="menu.jsp" %>
<!-------------- B O D Y -------------->
<body>
	<!--------------- J O I N : F O R M ---------------->
	<div class="container">
		<form class="form-horizontal form-join" name="form" id="form" action="joinAction.do" enctype="multipart/form-data" method="post">
			<div class="join-box text-center">
				<a><img src="images/id.svg" id="joinImg"></a>
			</div>
			<h2 class="form-login-heading text-center">Let's 놀자GO!</h2>
			<br>
			<label class="sr-only" for="id">아이디</label>
			<input type="text" class="form-control center-block input-lg center-block" name="id" id="id" placeholder="아이디를 입력해주세요.(4~20자)" pattern="[A-Za-z0-9]{4, 20}" minlength="4" maxlength="20" oninput="checkId();" required autofocus>
			<div id="idOk"></div>
			<label class="sr-only" for="password">비밀번호</label>
			<input type="password" class="form-control center-block input-lg" name="password" id="password" placeholder="비밀번호를 입력하세요.(8~20자)" onkeyup="checkPwd();" minlength="8" maxlength="20" required>
			<label class="sr-only" for="password2">비밀번호확인</label>
			<input type="password" class="form-control center-block input-lg" name="password2" id="password2" placeholder="비밀번호를 한번 더 입력하세요." onkeyup="checkPwd();" minlength="8" maxlength="20" required>
			<div id="pwdFalse"></div>
			<div id="pwdOk"></div>
			<label class="sr-only" for="name">이름</label>
			<input type="text" class="form-control center-block input-lg" name="name" id="name" placeholder="이름을 입력해주세요(2~8자)" pattern="[가-힣]{2, 8}" minlength="2" maxlength="8" oninput="checkName();" required>
			<div id="nameOk"></div>
			<label class="sr-only" for="age">생년월일</label>
			<input type="text" class="form-control center-block input-lg" name="birth" id="birth" placeholder="생년월일 (예: 19890217)" pattern="[0-9]{8}" minlength="8" maxlength="8" oninput="checkBirth();" required>
			<div id="birthOk"></div>
			<label class="sr-only" for="tel">연락처</label>
			<input type="tel" class="form-control center-block input-lg" name="tel" id="tel" placeholder="연락처(에: 010-6744-5345)" pattern="\d{2,3}-\d{3,4}-\d{4}" title="(2~3자리)-(3~4자리)-(4자리)" minlength="11" maxlength="13" oninput="checkTel();" required>
			<div id="telOk"></div>
			<label class="sr-only" for="email">이메일</label>
			<input type="email" class="form-control center-block input-lg" name="email" id="email" placeholder="이메일을 입력해주세요." oninput="checkEmail();" required>
			<div id="emailOk"></div>
			<!------------ 주 소 검 색  ------------>
			<div class="input-group addrGroup">
				<label class="sr-only" for="address">주소</label>
				<input type="text" class="form-control address input-lg" name="address" id="address" placeholder="주소 검색" value="">
				<span class="input-group-btn">
                    <button class="btn btn-default input-lg" type="button" onclick="goPopup()">검색</button>
                </span>
			</div>
			<!------------ 성 별 버 튼 ------------>
			<div class="form-group sex-group">
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default active">
                        <input type="radio" name="sex" autocomplete="off" value="남자" checked="checked">남자
                    </label>
					<label class="btn btn-default">
                        <input type="radio"	name="sex" autocomplete="off" value="여자">여자
                    </label>
				</div>
			</div>
			<!--------------- 프 로 필 업 로 드 ------------->
			<div class="thumbnail" style="border: none;">
				<img src="images/home.png" class="img-circle" id="img">
			</div>
			<div class="input-file col-md-4 col-md-offset-4">
				<label for="image" class="file-label form-control">
				<!-- 	<input type="file" accept="image/*" name="image" id="image" class="file-upload" />업로드 -->
					<input type="file" accept="image/*" name="image" id="image" class="file-upload" />업로드
				</label>
			</div>
			<div class="row">
				<div class="text-center" id="imgOk"></div>
			</div>
			<!------------ 자 기 소 개 ------------->
			<label class="sr-only" for="intro">자기소개</label>
			<textarea class="form-control" name="intro" id="intro" maxlength="50">자신을 소개해 보세요.</textarea>
			<input class="form-control center-block input-lg" id="submit" type="submit" value="회 원 가 입">
		</form>
	</div>
</body>
</html>
<%@include file="footer.jsp" %>