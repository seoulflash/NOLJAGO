<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="dao.BoardDAO"%>
<%@page import="dao.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String category = "댓글";
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	String id = request.getParameter("id");
	String subject = request.getParameter("subject");
	int ref = Integer.parseInt(request.getParameter("ref"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	Board board = new Board();
	board.setBnum(bnum);
	board.setId(id);
	board.setSubject(subject);
	board.setRef(ref);
	board.setCategory(category);	
	board.setRe_level(re_level);
	
	BoardDAO bd = BoardDAO.getInstance();
	int result = bd.replyInsert(board);
	
	out.print(result);
%>
