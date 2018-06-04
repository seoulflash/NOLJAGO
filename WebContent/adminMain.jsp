<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 메인메뉴</title>

<style type="text/css">
 td{
 	color: white;
 	padding: 10px;
 }
 table{
 	text-align: center;
 }
 
</style>
</head>
<body>
<input type = "button" onclick = "location='loginAction.do?id=${id}&password=${password}'" value = "메인">
<div style="margin-left: 670px; margin-top: 150px;">
<c:if test = "${admin == 3}">
	<h1>회원 관리</h1>
	<table bgcolor="#005aa7" border="1" width="30%" >
		<tr><td style="color: white;"><a href="memberList.do" style="color: white; text-decoration: none;">회원 명단 List</a></td></tr>
	</table> <p><p>
	
	<h1>카페 관리</h1>
	<table bgcolor="#005aa7" border="1" width="30%">
		<tr><td><a href="amCafeList.do" style="color: white; text-decoration: none;">카페 명단 List</a></td></tr>
	</table>
	<h1>예약 관리</h1>
	<table bgcolor="#005aa7" border="1" width="30%">
		<tr><td style="color: white;"><a href="amReservationList.do?id=${id}" style="color: white; text-decoration: none;">예약/결제 List</a></td></tr>
	</table>
</c:if>
<c:if test = "${admin == 2}">
<h1>예약 관리</h1>
	<table bgcolor="#005aa7" border="1" width="30%">
		<tr><td><a href="amReservationList.do?id=${id} " style="color: white; text-decoration: none;">예약/결제 List</a></td></tr>
	</table>
</c:if>
</div>
</body>
</html>