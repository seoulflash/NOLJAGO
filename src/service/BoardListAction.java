package service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board;
import dao.BoardDAO;
import dao.Member;
import dao.MemberDAO;

public class BoardListAction implements CommandProcess {
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			// 회원정보 가져오는 DAO메소드
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			
			BoardDAO bd = BoardDAO.getInstance();
			int totCnt = bd.getTotalCnt(); 
			
			String pageNum = request.getParameter("pageNum");
			if (pageNum == null || pageNum.equals("")) {
				pageNum = "1";
			}
			int currentPage = Integer.parseInt(pageNum);
			int pageSize = 10, blockSize = 10;
			int startRow = (currentPage - 1) * pageSize + 1; // 1
			int endRow = startRow + pageSize - 1; // 10
			int startNum = totCnt - startRow + 1; // 38
			if (endRow > totCnt)	
				endRow = totCnt;	
			List<Board> list = bd.list();
			List<Board> list2 = new ArrayList<Board>();
			for (int i = startRow - 1; i < endRow; i++)
				list2.add(list.get(i));	
			int pageCnt = (int) Math.ceil((double) totCnt / pageSize); // 4 Page
			int startPage = (int) (currentPage - 1) / blockSize * blockSize + 1;
			int endPage = startPage + blockSize - 1;
			if (endPage > pageCnt)
				endPage = pageCnt;
			
			request.setAttribute("member", member);
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startNum", startNum);
			request.setAttribute("list", list2);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("pageCnt", pageCnt);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);

			System.out.println("-----------------------------------------------"); // /ch16/list.do
			System.out.println("startNum-->" + startNum); // /ch16/list.do
			System.out.println("totCnt-->" + totCnt); // /ch16/list.do
			System.out.println("currentPage-->" + currentPage); // /ch16/list.do
			System.out.println("blockSize-->" + blockSize); // /ch16/list.do
			System.out.println("pageSize-->" + pageSize); // /ch16/list.do
			System.out.println("pageCnt-->" + pageCnt); // /ch16/list.do
			System.out.println("startPage-->" + startPage); // /ch16/list.do
			System.out.println("endPage-->" + endPage); // /ch16/list.do

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "boardList.jsp";
	}
}