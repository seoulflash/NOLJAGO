package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board;
import dao.BoardDAO;

public class BoardReplyWriteFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
			int bnum = 0, ref1 = 0;
			int ref = Integer.parseInt(request.getParameter("ref"));
			String category = "댓글";
			String id = request.getParameter("id");
			String subject = request.getParameter("subject");
			System.out.println("댓글내용--->" + subject);
			String pageNum = request.getParameter("pageNum");
			String re_level = request.getParameter("re_level");
			System.out.println();
			if(pageNum == null)
				pageNum = "1";
			if(request.getParameter("bnum") != null){
				bnum = Integer.parseInt(request.getParameter("bnum"));
				BoardDAO bd = BoardDAO.getInstance();
				Board board = bd.select(bnum);
				ref1 = board.getRef();
			}
			request.setAttribute("bnum", bnum);
			request.setAttribute("ref", ref);
			request.setAttribute("ref1", ref1);
			request.setAttribute("re_level", re_level);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("category", category);
			request.setAttribute("id", id);
			request.setAttribute("subject", subject);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "boardReplyWriteForm.jsp";
	}

}
