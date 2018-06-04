<!-- 가상의 결제 시스템을 만들기 위한 페이지. 현실에선 안쓰임.-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="js/bootstrap.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/noljaBooster.css">
	<title>심심할땐? 놀자GO! 결제 페이지</title>
	<script type="text/javascript">
	
	function selfclose() {
		
		opener.location.reload();
		
		alert("성공적으로 충전되었다Go! 정확한 포인트 결산을 위해 페이지를 갱신해달라Go!");
		self.close();
	}

	//숫자만 입력 가능하게
	function numkeyCheck(e) 
	{ 
		var keyValue = event.keyCode; 
		if((keyValue >= 48) && (keyValue <= 57))
			return true; 
		else 
			return false; 
	}

	</script>
	
</head>
<%@include file="menu.jsp" %>
<body>
	<form action="addPointpro.do?id=${id}" method="post">
		<input type="text" name="point" onKeyPress="return numkeyCheck(event)">
		
		<input type="submit" value="충전하기">
	</form>
	
	<c:if test = "${result > 0 }">
		<script type = "text/javascript">
			selfclose();	
		</script>
	</c:if>
	
	<c:if test = "${result == 0 }">
	<script type="text/javascript">
		alert{"충전이 되지 않았다Go!"};
		location.href = "addPoint.do?id=${id}";
	</script>
</c:if>
	
</body>
</html>
