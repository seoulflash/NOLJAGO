<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>심심할땐? 놀자GO!</title>
</head>
<body>
	<c:if test="${resultRes>0 }">
		<c:if test="${result>0 }">
		<script type="text/javascript">
			alert("파티 가입이 성공적으로 이루어졌습니다.");
			location.href = "PartySelect.do?pnum=${pnum}&pageNum=${pageNum}&id=${member.id}";
		</script>
	</c:if>
	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("파티 가입이 되지 않았습니다.");
			location.href = "partyboard.do?pageNum=${pageNum}&id=${member.id}";
		</script>
	</c:if>
	<c:if test="${result==-1 }">
		<script type="text/javascript">
			alert("이미 해당 파티에 속해있습니다.");
			location.href = "PartySelect.do?pnum=${pnum}&pageNum=${pageNum}&id=${member.id}";		</script>
	</c:if>
	<c:if test="${result==-2 }">
		<script type="text/javascript">
			alert("파티 인원이 가득 찼습니다.");
			location.href = "partyboard.do?pageNum=${pageNum}&id=${member.id}";
		</script>
	</c:if>
	</c:if>
	<c:if test="${resultRes==0 }">
			<script type="text/javascript">
			alert("파티 가입이 되지 않았습니다.");
			location.href = "partyboard.do?pageNum=${pageNum}&id=${member.id}";
		</script>
	</c:if>
</body>
</html>