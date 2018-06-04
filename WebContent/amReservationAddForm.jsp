<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신규 예약</title>
<!-- <link rel="stylesheet" type="text/css" href="css/style.css"> -->
<style type="text/css">
body { background-color: white; font-size: 10pt; }
table { background-color: #005aa7; text-align: center; margin-left: 600px; }
tr:hover { background-color: white; }
td { background-color: white; text-align: center; padding: 10px;}
.left { text-align: left; }
</style>
</head>
<body>
<input type = "button" onclick = "location='loginAction.do?id=${id}&password=${password}'" value = "메인">
<form action = "amReservationAddPro.do?id=${id}&pageNum=${pageNum}&resno=${resno}" method = "post">
<c:if test = "${admin == 3}">
<table>
	<caption><h2>예약하기</h2></caption>
	<tr><td>예약 날짜</td><td><input type = "text" name = "resdate" required
							placeholder = "xxxx/xx/xx"></td></tr>
	<tr><td>시작 시간</td><td><input type = "number" name = "starttime" required
							placeholder = "1~24" min = "1" max = "24"></td></tr>
	<tr><td>끝 시간</td><td><input type = "number" name = "endtime" required 
							placeholder = "1~24" min = "1" max = "24"></td></tr>
	<tr><td>아이디</td><td><input type = "text" name = "reservid" required></td></tr>
	<tr><td>카페 번호</td><td><input type = "number" name = "cnum" required></td></tr>
	<tr><td>테마 번호</td><td><input type = "number" name = "tnum" required></td></tr>
	
	<tr><td>예약 번호</td><td>${resno}</td></tr>
	<tr><td>인원 수</td><td><input type = "number" name = "count" required></td></tr>
	<tr>
		<td colspan = "2"><input type = "reset" value = "다시 작성" style="color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0;">
						  <input type = "submit" value = "확인" style="margin-left:20px; color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0;">
		</td>
	</tr>
</table>
</c:if>
</form>
<form action = "amReservationAddPro.do?id=${id}&pageNum=${pageNum}&resno=${resno}" method = "post">
<c:if test = "${admin == 2}">
<table>
	<caption><h2>예약하기</h2></caption>
	<tr><td>예약 날짜</td><td><input type = "text" name = "resdate" required
							placeholder = "xxxx/xx/xx"></td></tr>
	<tr><td>시작 시간</td><td><input type = "number" name = "starttime" required
							placeholder = "1~24" min = "1" max = "24"></td></tr>
	<tr><td>끝 시간</td><td><input type = "number" name = "endtime" required
							placeholder = "1~24" min = "1" max = "24"></td></tr>
	<tr><td>아이디</td><td><input type = "text" name = "reservid" required></td></tr>
	<tr><td>카페 번호</td><td>${cnum}</td></tr>
	<tr><td>테마 번호</td><td><input type = "number" name = "tnum" required></td></tr>
	<tr><td>예약 번호</td><td>${resno}</td></tr>
	<tr><td>인원 수</td><td><input type = "number" name = "count" required></td></tr>
	<tr><td>포인트</td><td>${price }</td></tr>
	<tr>
		<td colspan = "2"><input type = "reset" value = "다시 작성" style="color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0;">
						  <input type = "submit" value = "확인" style="color:white; background: #005aa7; text-decoration:none; border: 0; outline: 0;">
		</td>
	</tr>
</table>
</c:if>
</form>
</body>
</html>