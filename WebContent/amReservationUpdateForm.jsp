<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<input type = "button" onclick = "location='loginAction.do?id=${id}&password=${password}'" value = "메인">
<c:if test = "${reserv.pnum == 0 || reserv.pnum eq '' || reserv.pnum eq null}">
<form action = "amReservationUpdatePro.do" method = "post">
	<input type = "hidden" name = "resno" value = "${resno}">
	<input type = "hidden" name = "id" value = "${id}">
	<input type = "hidden" name = "pageNum" value = "${pageNum}">
	<table border = "1">
		<caption><h2>예약 정보 수정</h2></caption>
		<tr><td>예약 번호</td><td>${reserv.resno}</td></tr>
		<tr><td>아이디</td><td>${reserv.id}</td></tr>
		<tr><td>카페 번호</td><td>${reserv.cnum}</td></tr>
		<tr><td>테마 번호</td><td>${reserv.tnum}</td></tr>
		<tr><td>포인트</td><td>${reserv.point}</td></tr>
		<tr><td>예약 날짜</td><td>
		<input type = "text" name = "resdate" required value = "${reserv.resdate}">
		</td></tr>
		<tr><td>시작 시간</td><td>
		<input type = "number" name = "starttime" required value = "${reserv.starttime}">
		</td></tr>
		<tr><td>끝 시간<td>
		<input type = "number" name = "endtime" required value = "${reserv.endtime}">
		</td></tr>
		<tr><td colspan = "2"><input type = "submit" value = "수정완료">
		</td></tr>
	</table>
</form>
</c:if>
<c:if test = "${reserv.pnum != 0}">
<script type="text/javascript">
	alert("파티예약의 경우에는 수정이 불가능합니다");
	location.href="amReservationDetail.do?resno=${reserv.resno}&id=${id}&pageNum=${pageNum}"
</script>
</c:if>
</body>
</html>