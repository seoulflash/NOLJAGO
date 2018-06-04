package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board;
import dao.BoardDAO;

public class BoardReplyDeleteFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			int ref = 0;
			int bnum = Integer.parseInt(request.getParameter("bnum"));
			int board_bnum = Integer.parseInt(request.getParameter("board_bnum"));
			int board_ref = Integer.parseInt(request.getParameter("board_ref"));
			String pageNum = request.getParameter("pageNum");
			String id = request.getParameter("id");
			BoardDAO bd = BoardDAO.getInstance();
			Board board = bd.select(bnum);
			ref = board.getRef();
			
			System.out.println("form bnum----------------->>>"+bnum);
			System.out.println("form board_bnum----------------->>>"+board_bnum);
			System.out.println("form ref----------------->>>"+ref);
			System.out.println("form board_ref----------------->>>"+board_ref);	
			request.setAttribute("bnum", bnum);
			request.setAttribute("board_bnum", board_bnum);
			request.setAttribute("ref", ref);
			request.setAttribute("board_ref", board_ref);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("id", id);
			request.setAttribute("board", board);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "boardReplyDeleteForm.jsp";
	}

}
