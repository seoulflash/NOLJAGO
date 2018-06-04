<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.Party"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="sun.security.jca.GetInstance"%>
<%@page import="dao.PartyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
        int cnum = Integer.parseInt(request.getParameter("cnum"));
        int tnum = Integer.parseInt(request.getParameter("tnum"));
        String id = request.getParameter("id");
        System.out.println("partyRecommend ID------->"+id);
        int result = 0;
        
        PartyDAO pd = PartyDAO.getInstance();
        List<Integer> pnumlist= new ArrayList<Integer>();
        pnumlist = pd.recommendParty(cnum, tnum, id);	//추천할 partylist
        
        
        if (pnumlist.size() == 0) {
        	System.out.println("추천할 리스트 0");
        	result = 0;	//추천할게 없어요
        } else {
        	System.out.println("추천할 리스트 1");
        	result = 1;	//추천할게 있어요
        }
        
        JSONObject obj = new JSONObject();
    	for (int i=0; i<pnumlist.size(); i++) {
    		System.out.println(pnumlist.get(i));
    		obj.put("key"+i, ""+pnumlist.get(i));
    	}
    	
    	System.out.println(obj);
    	
    	out.print(obj);
        
       /* for (3) {
        	
        	Party party = pd.recommend(pnum);
        	list.add(party);
        }*/
        		
      
        //out.print(result);
    %>