<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int likeCnt = (int)request.getAttribute("num");	//좋아요 개수
	int result = (int)request.getAttribute("result");	
	String num = likeCnt+"-"+result;
	out.println(num);
%>