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
	<title>심심할땐? 놀자GO! : 내 정보</title>
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
	.menubar-list {
		padding-left: 30px;
		width: 60%;
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
	/* 컨텐츠 영역 */
	.myInfo {
		padding: 10px;
		width: 80%;
	}
	.myInfo-box {
		width: 300px;
	}
	.myInfo-box label {
		font-size: 13px;
		font-weight: normal;
	}
	.joinOut {
		width: 300px;
	}
	.joinOut p {
		font-size: 12px;
		color: 	#f92672;
		margin-top: 20px;
		margin-bottom: 20px;
	}
	.myInfo #modi,
	.myInfo #modiOk {
		border: none;
		font-size: 13px;
		color: white;
		background-color: #005aa7;
	}
	.myInfo #delete {
		border: none;
		padding: 10px 25px 10px 25px;
		font-size: 13px;
		color: white;
		background: linear-gradient(141deg, #f00000, #dc281e);
	}
	#pwdOk, #telOk, #emailOk, #afterDelete {
		font-size: 12px;
		color: #dc281e;
	}
	#updateOk {
		font-size: 14px;
		margin-top: 20px;
	}
	#deletePwd {
		margin-top: 15px;
		margin-bottom: 15px;
	}
	/* 모달 관련 */
	#deleteOk {
		margin-top: 15px;
		border: none;
		padding: 10px 25px 10px 25px;
		font-size: 13px;
		color: white;
		background-color: #005aa7;
	}
	/* 모달 위치 */
	.modal {
        text-align: center;
	}
	@media screen and (min-width: 768px) { 
	    .modal:before {
	        display: inline-block;
	        vertical-align: middle;
	        content: " ";
	        height: 100%;
	    }
	}
	.modal-dialog {
	    display: inline-block;
	    text-align: left;
	    vertical-align: middle;
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
	/* 비밀번호 체크 */
	function checkPwd() {
		var password = $('#password').val();
		if(password.length < 8 || password.length > 20 ) {
			$("#password").css("background-color", "#FFCECE");
			$("#pwdOk").html("비밀번호는 8~20자까지만 가능합니다.");
		} else if(password.length  >= 8 && password.length <= 20) {
			$("#password").css("background-color", "#FFFFFF");
			$("#pwdOk").hide();
		}
	}
	/* 전화번호 체크 */
	function checkTel() {
		var tel = $('#tel').val();
		if(tel.length < 11 || tel.length > 13) {
			$("#tel").css("background-color", "#FFCECE");
			$("#telOk").html("'-'를 포함한 11~13자까지만 가능합니다.")
		} else if(tel.length == 11 || tel.length == 12 || tel.length == 13) {
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
	/* 개인정보 수정 버튼 눌렀을때 */
	function modify() {
		if(document.getElementById("password").disabled == true) {
			$("#password").attr("disabled", false);
			$("#password").attr("type", "text");
			$('#email').attr('disabled', false);
			$('#tel').attr('disabled', false);
			$('#intro').attr('disabled', false);
			$('#modi').html("취&nbsp;&nbsp;소");
			$('#modiOk').attr('disabled', false);
		} else {
			$("#password").attr("disabled", true);
			$("#password").attr("type", "password");
			$('#email').attr('disabled', true);
			$('#tel').attr('disabled', true);
			$('#intro').attr('disabled', true);
			$('#modi').html("수&nbsp;&nbsp;정");
			$('#modiOk').attr('disabled', true);
		}
	}
	/* 개인정보 확인 버튼 눌렀을때 */
	function modified() {
		var id = $('#id').val();
		var password = $('#password').val();
		var email = $('#email').val();
		var tel = $('#tel').val();
		var intro = $('#intro').val();
		$.post('myinfoUpdate.do', {id:id,password:password,email:email,tel:tel,intro:intro}, function(result){
			console.log(typeof result);
			if(result.trim() == "1") {
				$("#password").attr("disabled", true);
				$("#password").attr("type", "password");
				$('#email').attr('disabled', true);
				$('#tel').attr('disabled', true);
				$('#intro').attr('disabled', true);
				$('#modi').html("수&nbsp;&nbsp;정");
				$('#modiOk').attr('disabled', true);
				$('#updateOk').text("개인정보가 성공적으로 변경되었습니다.").css("color", "#2cb5e8");
				setTimeout("location.reload()", 1500);
			} else {
				$('#updateOk').text("개인정보 변경이 실패했습니다.").css("color", "#dc281e").css("font-size", "12px");
			}
		})
	}
	/* 탈퇴 버튼 눌렀을때 */
	function deleteUser() {
		var password = $("#deletePwd").val();
		console.log(password);
		if(confirm("정말로 탈퇴하시겠습니까?") == true) {
			$.post('deleteUser.do?id=${id}', {password:password}, function(result){
				if(result.trim() == "1") {
					$("#deletePwd").css("background-color", "#FFFFFF");
					$("#afterDelete").text("성공적으로 탈퇴되었습니다.").css("color", "#2cb5e8").css("font-size", "14px");
					setTimeout("go_url()", 1000);
				} else if(result.trim() == "0") {
					alert("탈퇴실패");
				} else if(result.trim() == "-1") {
					$("#deletePwd").css("background-color", "#FFCECE");
					$("#afterDelete").text("회원님의 비밀번호가 일치하지 않습니다");
				}
			});
		} else {
			return;
		}
	}
	function go_url(){
        location.href="sessionOut.jsp";
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
					<li class="active"><a href='myinfo.do?id=${id}' id="myInfo">내 정보</a></li>
					<li><a href='mypoint.do?id=${id}' id="myPoint">포인트</a></li>
					<li><a href='myres.do?id=${id}' id="myReserved">예약내역<span class="badge">${member.resTotCnt}</span></a></li>
					<li><a href='myfavorite.do?id=${id}' id="myFavorite">좋아요<span class="badge">${member.totGood}</span></a></li>
				</ul>
			</div>
		</div>
		<!-- 컨텐츠 영역 -->
		<div class="myInfo center-block">
			<div class="myInfo-box form-horizontal center-block">
				<h4 class="text-center">내 정보</h4>
				<hr>
				<div class="form-group text-left">
			    	<label for="id" class="col-sm-3 control-label">아이디</label>
			    	<div class="col-sm-9">
			      		<input type="text" class="form-control" id="id" value="${member.id}" disabled="disabled">
			    	</div>
			  	</div>
				<div class="form-group">
			    	<label for="password" class="col-sm-3 control-label">비밀번호</label>
			    	<div class="col-sm-9">
			      		<input type="password" class="form-control" id="password" value="${member.password}" oninput="checkPwd();" minlength="8" maxlength="20" disabled="disabled">
			    	</div>
			    	<div class="col-sm-offset-3 col-sm-9" id="pwdOk"></div>
			  	</div>
			  	<div class="form-group">
			    	<label for="email" class="col-sm-3 control-label">이메일</label>
			    	<div class="col-sm-9">
			      		<input type="email" class="form-control" id="email" value="${member.email}" oninput="checkEmail();" disabled="disabled">
			    	</div>
			    	<div class="col-sm-offset-3 col-sm-9" id="emailOk"></div>
			  	</div>
			  	<div class="form-group">
			    	<label for="tel" class="col-sm-3 control-label">연락처</label>
			    	<div class="col-sm-9">
			      		<input type="text" class="form-control" id="tel" value="${member.tel}" pattern="\d{2,3}-\d{3,4}-\d{4}" title="(2~3자리)-(3~4자리)-(4자리)" minlength="11" maxlength="13" oninput="checkTel();" disabled="disabled">
			    	</div>
			    	<div class="col-sm-offset-3 col-sm-9" id="telOk"></div>
			  	</div>
			  	<div class="form-group">
			    	<label for="tel" class="col-sm-3 control-label">자기소개</label>
			    	<div class="col-sm-9">
			      		<textarea class="form-control" name="intro" id="intro" maxlength="50" rows="3" disabled="disabled">${member.intro}</textarea>
			    	</div>
			  	</div>
			  	<div class="text-center" id="updateOk"></div>
			  	<div class="form-inline text-center">
					<button type="button" class="btn btn-default" id="modi" onclick="modify();">수&nbsp;&nbsp;정</button> 	
					<button type="button" class="btn btn-default" id="modiOk" onclick="modified();" disabled="disabled">확&nbsp;&nbsp;인</button> 	
			  	</div>
			</div>
			<div class="joinOut form-horizontal center-block">
				<hr id="outLine">
				<h4 class="text-center">회원 탈퇴</h4>
				<p class="text-center">탈퇴를 하시려면 안내 및 동의를 받아야합니다.<br>정말 탈퇴하시겠습니까?</p>
				<button type="button" class="btn btn-default center-block" id="delete" data-target=".bs-example-modal-sm" data-toggle="modal">탈&nbsp;&nbsp;퇴</button>
			</div>
		</div>
	</div>
	<!-- 회원가입 탈퇴 모달 -->
	<div class="row">
		<div class="modal bs-example-modal-sm" id="modal" tabindex="-1">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<a class="find-title">회원 탈퇴</a>
						<button class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<form class="form-horizontal">
							<div class="form-group text-center">
								<p>탈퇴 진행을 위해 비밀번호를 입력해주세요.</p>
								<label class="sr-only" for="deletePwd">비밀번호</label>
								<input type="password" class="deletePwd center-block" name="deletePwd" id="deletePwd" autofocus="autofocus">
								<div id="afterDelete"></div>
								<button type="button" class="btn btn-default center-block" id="deleteOk" onclick="deleteUser();">확&nbsp;&nbsp;인</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@include file="footer.jsp" %>