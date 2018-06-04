package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;
import dao.Party;
import dao.PartyDAO;
import dao.PartyMem;

public class PartyMineAction implements CommandProcess {
	public String requestPro(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		PartyDAO pd = PartyDAO.getInstance();
		int pnum = 0;
		try { 
			// 회원정보 가져오는 DAO메소드
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			int totCnt  = pd.getTotalMyCnt(id);
			System.out.println(totCnt);
			String pageNum = request.getParameter("pageNum");	
			if (pageNum==null || pageNum.equals("")) {	pageNum = "1";	}
			int currentPage = Integer.parseInt(pageNum);	
			int pageSize  = 20, blockSize = 20;
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow   = startRow + pageSize - 1;
			int startNum = totCnt - startRow + 1;
			List<Party>list = pd.showMyParty(id);
			List<PartyMem>memList = pd.memList();
			int count = pd.getTotalCnt();
			int pageCnt = (int)Math.ceil((double)totCnt/pageSize);
			int startPage = (int)(currentPage-1)/blockSize*blockSize + 1;
			int endPage = startPage + blockSize -1;	
			if (endPage > pageCnt) endPage = pageCnt;
			System.out.println("startpage->" + startPage);
			
			request.setAttribute("member", member);
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startNum", startNum);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("pageCnt", pageCnt);
			request.setAttribute("startPage", 1);
			request.setAttribute("endPage", 1);
			request.setAttribute("list", list);
			request.setAttribute("count", count);
			request.setAttribute("memList", memList);
	} catch(Exception e) { System.out.println(e.getMessage()); }
		return "partyBoard.jsp";
	}
}