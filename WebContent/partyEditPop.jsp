<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>심심할땐? 놀자GO!</title>
</head>
<body>
	<form action="partyEdit.do" method="post">
		<label>인원수 조정</label>
		<input type="hidden" value="<%=pnum%>" name="pnum">
		<input type="hidden" value="<%=pageNum%>" name="pageNum">
		<h6>인원 수는 현재 파티원 수보다 작게 할 수 없습니다.</h6>
		<select name="max">
			<option value=2 >2명</option>
			<option value=3 >3명</option>
			<option value=4 >4명</option>
			<option value=5 >5명</option>
			<option value=6 >6명</option>
			<option value=7 >7명</option>
			<option value=8 >8명</option>
		</select><br>
		<label>추가 내용</label><br>
		<textarea rows="5" cols="30" name="pcontent"></textarea>
		<input type="submit" value="수정">
	</form>
</body>
</html>