<%@page import="org.json.simple.JSONObject"%>
<%@page import="sun.security.jca.GetInstance"%>
<%@page import="dao.PartyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
        int pnum = Integer.parseInt(request.getParameter("pnum"));
        String id = request.getParameter("id");
        System.out.println("punm = "+pnum);
        System.out.println("id = "+id);
        PartyDAO pd = PartyDAO.getInstance();
        
        int result = pd.pmemCheck(pnum,id);
        out.print(result);
    %>