<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<input type = "button" onclick = "location='loginAction.do?id=${id}&password=${password}'" value = "메인">
${admin }
<form action="memberUpdatePro.do" method="post">
	<input type="hidden" name="id" value="${member.id }">
	<input type="hidden" name="pageNum" value="${pageNum }">
	<table border="1">
		<caption><h2>회원정보 수정</h2></caption>
		<tr><td>아이디</td><td>${member.id}</td></tr>
		<tr><td>비밀번호</td><td>
		<input type="text" name="password" required="required"
		value="${member.password}"></td></tr>
		<tr><td>관리자여부</td><td>
		
		<div class="form-group admin-group">
			<div class="btn-group" data-toggle="buttons">
				<c:if test = "${member.admin == 1 }">
					<label class="btn btn-default active">
		                      <input type="radio" name="admin" autocomplete="off" value="1" checked="checked">일반회원
		            </label>
					<label class="btn btn-default">
		                      <input type="radio"	name="admin" autocomplete="off" value="2">사장님
		            </label>
		        </c:if>
		        
		        <c:if test = "${member.admin == 2 }">
					<label class="btn btn-default active">
		                      <input type="radio" name="admin" autocomplete="off" value="1">일반회원
		            </label>
					<label class="btn btn-default">
		                      <input type="radio"	name="admin" autocomplete="off" value="2" checked="checked">사장님
		            </label>
		        </c:if>
			</div>
		</div>
		
		
		<tr><td>이름</td><td>
		<input type="text" name="name" required="required"
		value="${member.name}"></td></tr>
		<tr><td>생년월일</td><td>
		<input type="text" name="birth" required="required"
		value="${member.birth}"></td></tr>
		<tr><td>주소</td><td>
		<input type="text" name="address" required="required"
		value="${member.address}"></td></tr>
		<tr><td>이메일</td><td>
		<input type="text" name="email" required="required"
		value="${member.email}"></td></tr>
		<tr><td>전화번호</td><td>
		<input type="text" name="tel" required="required"
		value="${member.tel}"></td></tr>
		<tr><td>포인트</td><td>
		<input type="text" name="point" required="required"
		value="${member.point}"></td></tr>
		<tr><td colspan="2"><input type="submit" value="수정완료" >
		</td></tr>
	</table>
</form>

</body>
</html>