<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	String id = request.getParameter("id");
	System.out.println(bnum);
	System.out.println(id);
	BoardDAO bd = BoardDAO.getInstance();
	int result = bd.replydelete(bnum, id);
	System.out.println(result);
	out.print(result);
%>

