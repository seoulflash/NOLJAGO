package service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Cafe;
import dao.CafeDAO;

public class AmCafeListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		CafeDAO cd = CafeDAO.getInstance();
		try {
			String id = "aa";
			String password = "1234";
			int totCnt = cd.getTotalCnt();
			String pageNum = request.getParameter("pageNum");
			if (pageNum == null || pageNum.equals("")) {
				pageNum = "1";
			}
			int currentPage = Integer.parseInt(pageNum);
			int pageSize = 10, blockSize = 10;
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = startRow + pageSize - 1;
			if (endRow > totCnt) {
				endRow = totCnt;
			}
			int startNum = totCnt - startRow + 1;
			List<Cafe> list = cd.CafeList();
			List<Cafe> currentlist = new ArrayList<Cafe>();
			for (int i = startRow - 1; i < endRow; i++) {
				currentlist.add(list.get(i));
			}
			int pageCnt = (int)Math.ceil((double)totCnt/pageSize);
			int startPage = (int)(currentPage-1)/blockSize*blockSize+1;
			int endPage = startPage + blockSize-1;
			if(endPage>pageCnt)
				endPage=pageCnt;
			
			request.setAttribute("id", id);
			request.setAttribute("password", password);
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startNum", startNum);
			request.setAttribute("list", currentlist);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			
			System.out.println("-----------------------------------------------");  
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
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "amCafeList.jsp";
	}

}
