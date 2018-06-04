<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>카페 정보 수정</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<input type = "button" onclick = "location='loginAction.do?id=${id}&password=${password}'" value = "메인">
<form action = "amCafeUpdatePro.do" method = "post">
	<input type = "hidden" name = "cnum" value = "${cafe.cnum }">
	<input type = "hidden" name = "pageNum" value = "${pageNum }">
	<table border = "1">
		<caption><h2>카페 정보 수정</h2></caption>
		<tr><td>카페 번호</td><td>${cafe.cnum}</td></tr>
		<tr><td>카페명</td><td>
		<input type = "text" name = "cname" required = "required" value = "${cafe.cname }">
		</td></tr>
		<tr><td>카페 주소</td><td>
		<input type = "text" name = "caddress" required = "required" value = "${cafe.caddress }">
		</td></tr>
		<tr><td>개장 시간</td><td>
		<input type = "number" name = "open" required = "required" value = "${cafe.open}">
		</td></tr>
		<tr><td>폐장 시간</td><td>
		<input type = "number" name = "close" required = "required" value = "${cafe.close }">
		</td></tr>
		<tr><td>평일 가격</td><td>
		<input type = "number" name = "price" required = "required" value = "${cafe.price }">
		</td></tr>
		<tr><td>주말 가격</td><td>
		<input type = "number" name = "redprice" required = "required" value = "${cafe.redprice }">
		</td></tr>
		<tr><td>카페 종류</td><td>
		<input type = "text" name = "type" required = "required" value = "${cafe.type }">
		</td></tr>
		<tr><td>소개글</td><td>
		<input type = "text" name = "content" required = "required" value = "${cafe.content }">
		</td></tr>
		<tr><td>방 개수</td><td>
		<input type = "number" name = "roomcount" required = "required" value = "${cafe.roomcount}">
		</td></tr>
		<tr><td>카페 웹사이트</td><td>
		<input type = "text" name = "curl" required = "required" value = "${cafe.curl }">
		</td></tr>
		<tr><td colspan = "2"><input type = "submit" value = "수정완료">
		</td></tr>
		
	</table>
</form>
</body>
</html>