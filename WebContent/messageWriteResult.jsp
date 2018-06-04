<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int result = (int)request.getAttribute("result");
	System.out.println("view result : " +result);
	out.println(result);
%>