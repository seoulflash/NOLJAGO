<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 등록</title>
<!-- <link rel="stylesheet" type="text/css" href="css/style.css"> -->
<style type="text/css">

form .sex-group {
			margin: 15px;
			text-align: center;
		}
body { background-color: white; font-size: 10pt; }
table { background-color: #005aa7; margin-left: 600px; }
tr:hover { background-color: white; }
td { background-color: white; text-align: center; padding: 10px;}
.left { text-align: left; }
</style>
</head>
<body>
<input type = "button" onclick = "location='loginAction.do?id=${id}&password=${password}'" value = "메인">
<form action = "memberAddPro.do?pageNum=${pageNum}" method = "post">
<table>
	<caption><h2>회원정보 등록</h2></caption>
	<tr><td> 아이디 </td><td><input type="text" name="id" required="required" > </td></tr>
	<tr><td> 비밀번호 </td><td><input type="password" name="password" required="required" > </td></tr>
	<tr><td> 관리자 여부 </td><td>
	<div class="form-group admin-group">
		<div class="btn-group" data-toggle="buttons">
			<label class="btn btn-default active">
                      <input type="radio" name="admin" autocomplete="off" value="1" checked="checked">일반회원
            </label>
			<label class="btn btn-default">
                      <input type="radio"	name="admin" autocomplete="off" value="2">사장님
            </label>
		</div>
	</div>
	</td></tr>
	<tr><td> 이름 </td><td><input type="text" name="name" required="required" > </td></tr>
	<tr><td> 생년월일 </td><td><input type="text" name="birth" required="required" > </td></tr>
	<input type="hidden" name="image">
	<tr><td> 성별 </td><td>
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
	</td></tr>
	<tr><td> 주소 </td><td><input type="text" name="address" required="required" > </td></tr>
	<tr><td> 이메일 </td><td><input type="text" name="email" required="required" > </td></tr>
	<tr><td> 전화번호 </td><td><input type="text" name="tel" required="required" > </td></tr>
	<tr><td> 한줄 자기소개 </td><td><input type="text" name="intro"> </td></tr>
	<tr><td> 포인트 </td><td><input type="text" name="point" required="required"> </td></tr>
	<tr>
		<td><input type="reset" value="다시작성" style="color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0;"></td>
		<td><input type="submit" value="확인" style="color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0;"></td>
	</tr>
</table>
</form>
</body>
</html>