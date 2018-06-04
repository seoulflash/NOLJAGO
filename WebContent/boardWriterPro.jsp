<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${result > 0 }">
	<script type="text/javascript">
		alert("입력 완료");
		location.href="boardList.do?pageNum=${pageNum}&id=${member.id}";
	</script>
</c:if>
<c:if test="${result == 0 }">
	<script type="text/javascript">
		alert("입력 실패");
		location.href="boardWriterForm.do?bnum=${bnum}&pageNum=${pageNum}";
	</script>
</c:if>
</body>
</html>