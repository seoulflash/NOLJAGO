<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 후 세션값 저장하는 jsp파일 -->
<%
	String id = request.getParameter("id");
	if (id != null) {
		session.setAttribute("id", id);
	}
%>