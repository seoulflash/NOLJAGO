<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 삭제</title>
</head>
<body>
	<script type="text/javascript">
		if(confirm("삭제하겠습니까?")){
			location.href="boardDeletePro.do?pageNum=${pageNum}&ref=${board.ref}&id=${board.id}";
		}else{
			window.history.back();
		}
	</script>
</body>
</html>