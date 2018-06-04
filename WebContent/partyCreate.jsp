<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>심심할땐? 놀자GO!</title>
<script language="javascript">
function moveClose() {
  opener.location.href="PartySelect.do?pnum=${res.pnum}&id=${id}&pageNum=1";
  self.close();
}

function moveBack() {
	self.close();
}

function openPoint() {
	opener.window.open('addPoint.do?id=${id}', 'AddPoint', 'width=500px,height=500px');
	self.close();
}
</script>
</head>
<body>
	<c:if test="${result<0 }">
		<script type="text/javascript">
		if (confirm("회원님의 포인트가 모자른데.. 충전하러 Go?")) {
			openPoint();			
		} else {
			alert("결제 취소 되었다Go!");
			moveBack();
		}
		</script>
	</c:if>

	<c:if test="${resultRes>0 }">
		<c:if test="${result>0 }">
		<script type="text/javascript">
			alert("파티가 성공적으로 만들어졌습니다.");
			moveClose();
		</script>
	</c:if>
	<c:if test="${result<0 }">
		<script type="text/javascript">
		if (confirm("회원님의 포인트가 모자른데.. 충전하러 Go?")) {
			movePoint();		
		} else {
			alert("결제 취소 되었다Go!");
			moveBack();
		}
		</script>
	</c:if>
	<c:if test="${result==0 }">
		<script type="text/javascript">
			alert("같은 카페를 가는 파티가 이미 있습니다. 파티 게시판으로 이동합니다.");
			moveClose();
		</script>
	</c:if>
	</c:if>
	<c:if test="${resultRes<=0 }">
		<script type="text/javascript">
			alert("회원님은 같은 날짜, 같은 시간에 이미 다른예약이 있다Go!");
			moveBack();	
		</script>
	</c:if>
</body>
</html>