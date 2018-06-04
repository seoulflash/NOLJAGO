<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>카페 상세정보</title>
<!-- <link rel="stylesheet" type="text/css" href="css/style.css"> -->
<style type="text/css">
table {
	width: 30%;
}
body { background-color: white; font-size: 10pt; }
table { background-color: #005aa7; margin-left: 550px; }
th{ color: white;}
tr:hover { background-color: white; }
td { background-color: white; text-align: center; padding: 10px;}
.left { text-align: left; }
</style>

<script type="text/javascript">
	function cafeDelete() {
		var form = document.cafedeleteform;
		if(confirm("삭제하시겠습니까?")) {
			form.submit();
		} else {
			alert("취소됐습니다.");
			return;
		}
	}
</script>

</head>
<body>
<input type = "button" onclick = "location='loginAction.do?id=${id}&password=${password}'" value = "메인">
<table border = "1">
	<caption><h2>카페 정보 상세 내역</h2></caption>
	<tr><td width = "100">카페 번호</td><td>${cafe.cnum }</td></tr>
	<tr><td>카페 이름</td><td>${cafe.cname }</td></tr>
	<tr><td>카페 주소</td><td>${cafe.caddress }</td></tr>
	<tr><td>개장 시간</td><td>${cafe.open }</td></tr>
	<tr><td>폐장 시간</td><td>${cafe.close }</td></tr>
	<tr><td>평일 가격</td><td>${cafe.price }</td></tr>
	<tr><td>주말 가격</td><td>${cafe.redprice }</td></tr>
	<tr><td>카페 종류</td><td>${cafe.type }</td></tr>
	<tr><td>이미지</td>
		<td><img src = "images/${cafe.image1}" id = "cafeimage1" style = "width : 80px; height : 80px;">
		</td></tr>
	<tr><td>소개글</td><td>${cafe.content }</td></tr>
	<tr><td>방 개수</td><td>${cafe.roomcount }</td></tr>
	<tr><td>카페 웹사이트</td><td>${cafe.curl }</td></tr>
	<form name = "cafedeleteform" method = "post" action = "amCafeDeletePro.do?cnum=${cnum }&pageNum=${pageNum}">
		<tr><td colspan= "2">
		<input type = "button" value = "수정" style="color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0;" onclick = "location.href='amCafeUpdateForm.do?cnum=${cnum}&pageNum=${pageNum }'">
		<input type = "button" value = "삭제" style="margin-left:20px; color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0;" onclick = "javascript:cafeDelete()">
		<input type = "button" value = "목록" style="margin-left:20px; color:white; background-color: #005aa7; text-decoration:none; border: 0; outline: 0;" onclick = "location.href='amCafeList.do?pageNum=${pageNum }'">
		</td></tr>
	</form>
</table>
</body>
</html>