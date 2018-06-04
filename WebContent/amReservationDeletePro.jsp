<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약정보 삭제</title>
</head>
<body>
<c:if test = "${result > 0 }">
	<script type="text/javascript">
		alert("예약 정보 삭제");
		location.href = "amReservationList.do?id=${id}&pageNum=${pageNum}";
	</script>
</c:if>
<c:if test="${result == 0}">
	<script type="text/javascript">
		alert("예약 정보 삭제 실패");
		location.href = "amReservationDetail.do?resno=${resno}&id=${id}&pageNum=${pageNum}";
	</script>
</c:if>
</body>
</html>