<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="dao.ReservationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String date = request.getParameter("date");
	int cnum = Integer.parseInt(request.getParameter("cnum"));
	int tnum = Integer.parseInt(request.getParameter("tnum"));
	ReservationDAO rd = ReservationDAO.getInstance();
	
	List<Integer> startlist = new ArrayList<Integer>();
	startlist = rd.confirmEmpty(date, cnum, tnum);
	
	JSONObject obj = new JSONObject();
	for (int i=0; i<startlist.size(); i++) {
		obj.put("key"+i, ""+startlist.get(i));
		
	}
	System.out.println(obj);
	out.print(obj);
%>

