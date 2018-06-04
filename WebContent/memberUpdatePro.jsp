<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정 확인 페이지</title></head><body>
<c:if test="${result > 0 }">
	<script type="text/javascript">
		alert("회원수정 완료");
		location.href="memberList.do?pageNum=${pageNum}";
	</script>
</c:if>	
<c:if test="${result == 0 }">
	<script type="text/javascript">
		alert("회원수정 실패. 다시 입력해주세요");
		location.href="memberUpdateForm.do?id=${id}&pageNum=${pageNum}";
	</script>
</c:if>
</body>
</html>