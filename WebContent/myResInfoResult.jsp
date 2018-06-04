<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)request.getAttribute("id");
	String resno = (String)request.getAttribute("resno");
	String resdate = (String)request.getAttribute("resdate");
	String starttime = (String)request.getAttribute("starttime");
	String endtime = (String)request.getAttribute("endtime");
	String pnum = (String)request.getAttribute("pnum");
	String cname = (String)request.getAttribute("cname");
	String cnum = (String)request.getAttribute("cnum");
	String type = (String)request.getAttribute("type");
	String tname = (String)request.getAttribute("tname");
	String count = (String)request.getAttribute("count");
	String point = (String)request.getAttribute("point");
	String leaderId = (String)request.getAttribute("leaderId");
	JSONObject obj = new JSONObject();
	obj.put("id", id);
	obj.put("resno", resno);
	obj.put("resdate", resdate);
	obj.put("starttime", starttime);
	obj.put("endtime", endtime);
	obj.put("pnum", pnum);
	obj.put("cname", cname);
	obj.put("cnum", cnum);
	obj.put("type", type);
	obj.put("tname", tname);
	obj.put("count", count);
	obj.put("point", point);
	obj.put("leaderId",leaderId);
	out.print(obj);
%>