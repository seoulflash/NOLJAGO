<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>댓글 작성</title>
</head>
<body>
	<script type="text/javascript">
		if (confirm("댓글 쓸꺼에요?")) {
			location.href = "boardReplyWritePro.do?bnum=${bnum}&pageNum=${pageNum}&ref1=${ref1}&ref=${ref}&re_level=${re_level}&category=${category}&id=${id}&subject=${subject}"
		} else {
			window.history.back();
		}
	</script>
</body>
</html>