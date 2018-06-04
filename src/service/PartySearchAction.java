package service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;
import dao.Party;
import dao.PartyDAO;
import dao.PartyMem;

public class PartySearchAction implements CommandProcess {
	public String requestPro(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int option = Integer.parseInt(request.getParameter("option"));
		PartyDAO pd = PartyDAO.getInstance();
		List<Party>list = new ArrayList<Party>();
		String type = null;
		String leaderId= null;
		String cname = null;
		String startdate = null;
		String enddate = null;
		String selectdate = null;
		try { 
			// 회원정보 가져오는 DAO메소드
			if(option==0){
				selectdate = request.getParameter("datepickerSelect");
				list = pd.partySearch4(selectdate, selectdate);
			}else if(option==1){ //대분류
				type = request.getParameter("type"); //대분류
				list = pd.partySearch1(type);
			}else if(option==2){ //파티장 아이디
				leaderId = request.getParameter("find_party"); //파티장 아이디
				list = pd.partySearch2(leaderId);
			}else if(option==3){ //카페 이름
				cname = request.getParameter("find_party"); //카페 이름
				list = pd.partySearch3(cname);
			}else if(option==4){ //희망 날짜
				startdate = request.getParameter("datepickerFirst"); //시작날짜
				enddate = request.getParameter("datepickerEnd"); //끝날짜
				if(startdate==null||startdate==""){
					startdate="1000/01/01";
				}
				if(enddate ==null||enddate==""){
					enddate="9999/12/31";
				}
				list = pd.partySearch4(startdate,enddate);
			}
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			int totCnt  = pd.getTotalCnt();
			String pageNum = request.getParameter("pageNum");	
			if (pageNum==null || pageNum.equals("")) {	pageNum = "1";	}
			int currentPage = Integer.parseInt(pageNum);	
			int pageSize  = 20, blockSize = 20;
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow   = startRow + pageSize - 1;
			int startNum = totCnt - startRow + 1;
			List<PartyMem>memList = pd.memList();
			int count = pd.getTotalCnt();
			int pageCnt = (int)Math.ceil((double)totCnt/pageSize);
			int startPage = (int)(currentPage-1)/blockSize*blockSize + 1;
			int endPage = startPage + blockSize -1;	
			if (endPage > pageCnt) endPage = pageCnt;
			
			request.setAttribute("member", member);
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startNum", startNum);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("pageCnt", pageCnt);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("list", list);
			request.setAttribute("count", count);
			request.setAttribute("memList", memList);
	} catch(Exception e) { System.out.println(e.getMessage()); }
		return "partyBoard.jsp";
	}

}
