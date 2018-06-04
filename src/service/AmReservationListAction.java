package service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Reservation;
import dao.MemberDAO;
import dao.ReservationDAO;

public class AmReservationListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ReservationDAO rd = ReservationDAO.getInstance();
		MemberDAO md = MemberDAO.getInstance();
		try {
			String id = request.getParameter("id");
			String password = md.getpassword(id); 
			System.out.println();
			System.out.println(id);
			System.out.println(password);
			String pageNum = request.getParameter("pageNum");
			if (pageNum == null || pageNum.equals("")) {
				pageNum = "1";
			}
			int admin = md.getAdmin(id);
			System.out.println(admin);
			int totCnt = 0;
			List<Reservation> list = null;
			if (admin == 2) {
				totCnt = rd.getCafeResCnt(id);
				System.out.println("-------------------------------------------");
				list = rd.getCafeRes(id);
			}
			if (admin == 3) {	
				totCnt = rd.getTotalCnt();
				list = rd.ResList();
			}
			System.out.println("-------------------------------------------");
			System.out.println(totCnt);
			System.out.println("-------------------------------------------");
		int currentPage = Integer.parseInt(pageNum);
		int pageSize = 10, blockSize = 10;
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		if (endRow > totCnt) {
			endRow = totCnt;
		}
		int startNum = totCnt - startRow + 1;
		List<Reservation> currentlist = new ArrayList<Reservation>();
		for (int i = startRow - 1; i < endRow ; i++) {
			currentlist.add(list.get(i));
		}
		int pageCnt = (int)Math.ceil((double)totCnt/pageSize);
		int startPage = (int)(currentPage - 1)/blockSize * blockSize + 1;
		int endPage = startPage +  blockSize - 1;
		if (endPage > pageCnt)
			endPage = pageCnt;
		
			
			request.setAttribute("id", id);
			request.setAttribute("password", password);
			request.setAttribute("admin", admin);
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startNum", startNum);
			request.setAttribute("list", currentlist);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("pageCnt", pageCnt);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			
			System.out.println("-----------------------------------------------");
			System.out.println("id-->" + id);
			System.out.println("password-->" + password);
			System.out.println("admin-->" + admin); 
			System.out.println("startNum-->" + startNum);  
			System.out.println("totCnt-->" + totCnt); 
			System.out.println("currentPage-->" + currentPage);  
			System.out.println("blockSize-->" + blockSize);  
			System.out.println("pageSize-->" + pageSize); 
			System.out.println("pageCnt-->" + pageCnt); 
			System.out.println("startPage-->" + startPage);  
			System.out.println("endPage-->" + endPage);  
			System.out.println("startRow -->" + startRow);
			System.out.println("endRow -->" + endRow);
			System.out.println("pageNum -->" + pageNum);
			System.out.println("-------------------------------------------");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "amReservationList.jsp";
	}

}
