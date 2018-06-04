<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result>0 }">
	<script type="text/javascript">
		var ok;
		ok=confirm("위시리스트 목록으로 이동하시겠습니까?");
		if(ok){
			location.href="myfavorite.do?id=${id}";
		}
		else{
			location.href="vrList2View.do?id=${id}&&cnum=${cnum}&&tnum=${tnum}";
		}
	</script>
	</c:if>

	<c:if test="${result==0 }">
	<script type="text/javascript">
		alert("이미 위시리스트에 있습니다.");
		location.href="vrList2View.do?id=${id}&&cnum=${cnum}&&tnum=${tnum}";

	</script>
</c:if>
</body>
</html>