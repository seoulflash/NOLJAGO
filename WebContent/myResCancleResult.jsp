<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int result = (int)request.getAttribute("result");
	int point = (int)request.getAttribute("point");
	System.out.println("VIEW result : " + result);
	System.out.println("VIEW point : " + point);
	out.println(result+ " " +point);
%>