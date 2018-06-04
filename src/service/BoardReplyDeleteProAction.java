package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board;
import dao.BoardDAO;

public class BoardReplyDeleteProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
			try {
				request.setCharacterEncoding("utf-8");
				int bnum = Integer.parseInt(request.getParameter("bnum"));
				int board_bnum = Integer.parseInt(request.getParameter("board_bnum"));
				int board_ref = Integer.parseInt(request.getParameter("board_ref"));
				int ref = Integer.parseInt(request.getParameter("ref"));
				String id = request.getParameter("id");
				String pageNum = request.getParameter("pageNum");
				BoardDAO bdPro = BoardDAO.getInstance();
				int result = bdPro.replydelete(bnum,id);

				System.out.println("pro bnum----------------->>>"+bnum);
				System.out.println("pro board_bnum----------------->>>"+board_bnum);
				System.out.println("pro ref----------------->>>"+ref);
				System.out.println("pro board_ref----------------->>>"+board_ref);
				
				request.setAttribute("result", result);
				request.setAttribute("pageNum", pageNum);
				request.setAttribute("ref", ref);
				request.setAttribute("board_ref", board_ref);
				request.setAttribute("board_bnum", board_bnum);
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		return "boardReplyDeletePro.jsp";
	}

}
