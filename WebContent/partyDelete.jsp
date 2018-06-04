<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ include file="sessionCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>심심할땐? 놀자GO!</title>
</head>
<body>
	<c:if test="${result>0 }">
		<script type="text/javascript">
			alert("파티를 성공적으로 해산하였습니다.");
			location.href = "partyboard.do?pageNum=${pageNum}&id=${member.id}";
		</script>
	</c:if>
	<c:if test="${result<=0 }">
		<c:if test="${result1<=0 }">
			<script type="text/javascript">
				alert("포인트 반환도중 문제발생. 파티가 해산되지 않았습니다.");
				location.href = "partyboard.do?pageNum=${pageNum}&id=${member.id}";
			</script>
		</c:if>
		
		<c:if test="${result1 > 0 }">
			<script type="text/javascript">
				alert("문제발생. 파티가 해산되지 않았습니다.");
				location.href = "partyboard.do?pageNum=${pageNum}&id=${member.id}";
			</script>
		</c:if>
	</c:if>
</body>
</html>