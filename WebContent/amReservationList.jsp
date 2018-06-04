<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약 목록</title>
<style type="text/css">
table {
	width: 100%;
}
body { background-color: white; font-size: 10pt; }
table { background-color: #005aa7; }
table a {
	font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #58FA82;
    }
th{ color: white;}
tr:hover { background-color: white; }
td { background-color: white; text-align: center; padding: 10px;}
.left { text-align: left; }
</style>
</head>
<body>
	<input type = "button" onclick = "location='loginAction.do?id=${id}&password=${password}'" value = "메인">
	<h2>예약 목록</h2>
	<table>
		<tr>
			<td style = "background-color:#D8D8D8"><a href = 'amReservationAddForm.do?id=${id}&pageNum=${pageNum}' style="text-decoration: none;">신규 예약</a></td>
		</tr>
	</table>
	<table>
		<tr>
			<th>예약 날짜</th>
			<th>예약 번호</th>
			<th>아이디</th>
			<th>파티 번호</th>
			<th>카페 번호</th>
			<th>테마 번호</th>
			<th>사용 시간</th>
		</tr>
		
		<c:if test = "${totCnt > 0}">
			<c:forEach var = "reserv" items = "${list }">
				<tr>
					<td width = 200 style = "background-color:#D8D8D8">
					<a href = 'amReservationDetail.do?id=${id}&resno=${reserv.resno}&pageNum=${currentPage}' style="text-decoration: none;"  >
						${reserv.resdate}</a>
					</td>
					<td>${reserv.resno}</td>
					<td>${reserv.id }</td>
					<td>${reserv.pnum }</td>
					<td>${reserv.cnum }</td>
					<td>${reserv.tnum }</td>
					<td>${reserv.starttime} - ${reserv.endtime }</td>
				</tr>
				<c:set var = "startNum" value = "${startNum - 1 }"/>
			</c:forEach>
		</c:if>
		<c:if test = "${totCnt == 0}">
			<tr>
				<td colspan = 7>예약한 손님이 없습니다.</td>
			</tr>
		</c:if>
	</table>
	
	<div style = "text-align: center;">
		<c:if test = "${startPage > blockSize }">
			<a href = 'amReservationList.do?id=${id}&pageNum=${startPage-blockSize}'>[이전]</a>
		</c:if>
		<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
			<a href = 'amReservationList.do?id=${id}&pageNum=${i}'>[${i}]</a>
		</c:forEach>
		<c:if test = "${endPage < pageCnt }">
			<a href = 'amReservationList.do?id=${id}&pageNum=${startPage+blockSize}'>[다음]</a>
		</c:if>
	</div>


</body>
</html>