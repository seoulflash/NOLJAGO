<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신규 카페 등록</title>
<!-- <link rel="stylesheet" type="text/css" href="css/style.css"> -->
<style type="text/css">

form .sex-group {
			margin: 15px;
			text-align: center;
		}
body { background-color: white; font-size: 10pt; }
table { background-color: #005aa7; margin-left: 600px;}
tr:hover { background-color: white; }
td { background-color: white; text-align: center; padding: 10px;}
.left { text-align: left; }
</style>
</head>
<body>
<input type = "button" onclick = "location='loginAction.do?id=${id}&password=${password}'" value = "메인">
<form action = "amCafeAddPro.do?pageNum=${pageNum}" method = "post">
<table>
	<caption><h2>신규 카페 등록</h2></caption>
	<tr><td>카페 이름</td><td><input type = "text" name = "cname" requried></td></tr>
	<tr><td>카페 주소</td><td><input type = "text" name = "caddress" required></td></tr>
	<tr><td>개장 시간</td><td><input type = "number" name = "open" placeholder = "1~24 사이로 기입하시오" required></td></tr>
	<tr><td>폐장 시간</td><td><input type = "number" name = "close" placeholder = "1~24 사이로 기입하시오" required></td></tr>
	<tr><td>평일 가격</td><td><input type = "number" name = "price" required></td></tr>
	<tr><td>주말 가격</td><td><input type = "number" name = "redprice" required></td></tr>
	<tr><td>카페 종류</td><td><input type = "text" name = "type" required></td></tr>
	<tr><td>소개글</td><td><input type = "text" name = "content" required></td></tr>
	<tr><td>방 개수</td><td><input type = "number" name = "roomcount" required></td></tr>
	<tr><td>카페 웹사이트</td><td><input type = "text" name = "curl" required></td></tr>
	<tr>
		<td><input type = "reset" value = "다시 작성" style="color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0;"></td>
		<td><input type = "submit" value = "확인" style="color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0;"></td>
	</tr>
</table>
</form>
</body>
</html>