<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userId = (String)request.getAttribute("getUserId");
	System.out.println(userId);
	out.println(userId);
%>