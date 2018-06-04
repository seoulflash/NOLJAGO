<%@page import="org.json.simple.JSONObject"%>
<%@page import="sun.security.jca.GetInstance"%>
<%@page import="dao.PartyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
        int cnum = Integer.parseInt(request.getParameter("cnum"));
        int tnum = Integer.parseInt(request.getParameter("tnum"));
        String hopedate= request.getParameter("hopedate");
        int hopehour = Integer.parseInt(request.getParameter("hopehour"));
        String id = request.getParameter("id");
        PartyDAO pd = PartyDAO.getInstance();
        int result = pd.checkParty(cnum, tnum, hopedate, hopehour, id);
      
        out.print(result);
    %>