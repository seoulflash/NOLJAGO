<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="javascript">
function moveClose() {
  opener.location.href="PartySelect.do?&pnum=${pnum}&pageNum=${pageNum}";
  self.close();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>심심할땐? 놀자GO!</title>
</head>
<body>
		<c:if test="${result>0 }">
		<script type="text/javascript">
			alert("파티 정보를 정상적으로 수정했습니다.");
			moveClose();
		</script>
	</c:if>
	<c:if test="${result==0 }">
			<script type="text/javascript">
			alert("파티 정보가 수정되지 않았습니다.");
			moveClose();
		</script>
	</c:if>
	<c:if test="${result<0 }">
		<script type="text/javascript">
			alert("최대 인원 설정이 현재 파티원 숫자보다 적습니다!");
			moveClose();
		</script>
	</c:if>
</body>
</html>