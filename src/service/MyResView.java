package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;
import dao.Reservation;
import dao.ReservationDAO;

public class MyResView implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		MemberDAO md = MemberDAO.getInstance();
		Member member = new Member();
		ReservationDAO rd = ReservationDAO.getInstance();
		
		
		try {
			// 회원정보 가져오는 메소드
			member = md.getUserInfo(id);
			
			// 예약 건수 가져오는 메소드
			int resTotCnt = rd.getResCnt(id);
			
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null || pageNum.equals(""))
				pageNum = "1";
			int currentPage = Integer.parseInt(pageNum);
			int pageSize = 10;
			int blockSize = 5;
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = startRow + pageSize - 1;
			
			List<Reservation> list = rd.getResList(startRow, endRow, id);
			int pageCnt = (int)Math.ceil((double)resTotCnt/pageSize);
			int startPage = (int)(currentPage -1)/blockSize * blockSize +1;
			int endPage = startPage + blockSize - 1;
			if(endPage > pageCnt)
				endPage = pageCnt;
			
			request.setAttribute("member", member);
			request.setAttribute("list", list);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "myres.jsp";
	}

}
