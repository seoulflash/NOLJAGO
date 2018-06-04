<%@page import="dao.ReservationDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="sun.security.jca.GetInstance"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String hopedate = request.getParameter("hopedate");
        int hopehour = Integer.parseInt(request.getParameter("hopehour"));
        String id = request.getParameter("id");
        System.out.println("hopedate = "+hopedate);
        System.out.println("hopehour = "+hopehour);
        System.out.println("id = "+id);
        
        ReservationDAO rd = ReservationDAO.getInstance();
        int resresult = rd.check(hopedate, hopehour, id);
        //recresult가 -1 이면 이미 예약있어서 막아야함
        //recresult가 1 이면 예약이 없음. 허용
        //recresult가 0 이면 sql이 아예 안돌아간거임
        
        System.out.println(resresult);
        out.print(resresult);
    %>