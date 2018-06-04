<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 상세정보</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<style type="text/css">
table {
	width: 30%;
}
body { background-color: white; font-size: 15pt; }
table { background-color: #005aa7; }
tr:hover { background-color: white; }
td { background-color: white; text-align: center; padding: 15px;}
.left { text-align: left; }
</style>

<script type="text/javascript">  // 자바 스크립트 시작


	function deleteCheck() {
	
		var form = document.deleteform;
		if (confirm("삭제하시겠습니까?")) {
			//삭제 페이지로 go
			//location.href='memberDeleteForm.do?id=${id}&pageNum=${pageNum}'
			form.submit();
		} else {
			alert("삭제 취소 되었습니다.")
			return;
		}
	}
</script>

</head>
<body>
<input type = "button" onclick = "location='loginAction.do?id=${id}&password=${password}'" value = "메인">
<table border="1">
	<caption><h2>회원정보 상세내역</h2></caption>
	<tr><td width="130">아이디</td><td>${member.id}</td></tr>
	<tr><td>비밀번호</td><td>${member.password}</td></tr>
	<tr><td>관리자여부</td><td>${member.admin}</td></tr>
	<tr><td>이름</td><td>${member.name}</td></tr>
	<tr><td>생년월일</td><td>${member.birth}</td></tr>
	<tr><td>프로필 사진</td><td>
	<img src=${member.image} id="imagepreview" style="width: 64px; height: 64px;"></td></tr>
	<tr><td>성별</td><td>${member.sex}</td></tr>
	<tr><td>주소</td><td>${member.address}</td></tr>
	<tr><td>이메일</td><td>${member.email}</td></tr>
	<tr><td>전화번호</td><td>${member.tel}</td></tr>
	<tr><td>자기소개</td><td>${member.intro}</td></tr>
	<tr><td>포인트</td><td>${member.point}</td></tr>
	<tr><td>가입날짜</td><td>${member.reg_date}</td></tr>	
	<form name = "deleteform" method="post" action="memberDeletePro.do?memberid=${memberid}&pageNum=${pageNum}">
	<tr><td colspan="2">
		<input type="button" value="수정" style="color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0; padding: 15px; font-size: 20px;"
		onclick="location.href='memberUpdateForm.do?memberid=${member.id}&pageNum=${pageNum}'">
	
		<input type="button" value="삭제" style="color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0; padding: 15px; font-size: 20px; margin-left: 15px;" onclick="javascript:deleteCheck()">
	
		<input type="button" value="목록" style="color:white; background: #005aa7; text-decoration:none; border: 0; outline: 0; padding: 15px; font-size: 20px; margin-left: 15px;" 
		onclick="location.href='memberList.do?pageNum=${pageNum}'"></td></tr>
	</form>
</table>
</body>
</html>