<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>카페 추가 확인</title>
</head>
<body>
<c:if test = "${result > 0 }">
	<script type = "text/javascript">
		alert("신규 카페 추가 완료");
		location.href="amCafeList.do?pageNum=${pageNum}";
	</script>
</c:if>
<c:if test = "${result == 0 }">
	<script type="text/javascript">
		alert{"신규 카페 등록 실패"};
		location.href = "amCafeAddForm.do?pageNum=${pageNum}";
	</script>
</c:if>
</body>
</html>