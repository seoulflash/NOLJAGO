<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>카페정보 삭제</title>
</head>
<body>
<c:choose>
	<c:when test = "${result > 0 }">
		<script type="text/javascript">
			alert("카페 정보 삭제");
			location.href = "amCafeList.do?pageNum=&{pageNum}";
		</script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			alert("오류 발생! 카페 정보 삭제 실패!");
			location.href = "amCafeDetail.do?cnum=${cnum}&pageNum=&{pageNum}";
		</script>
	</c:otherwise>
</c:choose>
</body>
</html>