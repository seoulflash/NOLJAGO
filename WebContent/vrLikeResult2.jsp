<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int likeCnt = (int)request.getAttribute("num");
	int result = (int)request.getAttribute("result");
	String num = likeCnt+"-"+result;
	out.println(num);
%>