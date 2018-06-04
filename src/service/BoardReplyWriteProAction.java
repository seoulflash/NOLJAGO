package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board;
import dao.BoardDAO;

public class BoardReplyWriteProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
			String pageNum = request.getParameter("pageNum");
			int ref = Integer.parseInt(request.getParameter("ref"));
			int ref1 = Integer.parseInt(request.getParameter("ref1"));
			Board board = new Board();
			board.setBnum(Integer.parseInt(request.getParameter("bnum")));
			System.out.println("Pro bnum-------->" + request.getParameter("bnum"));
			board.setId(request.getParameter("id"));
			board.setSubject(request.getParameter("subject"));
			board.setCategory(request.getParameter("category"));
			board.setRef(ref);
			board.setRe_level(Integer.parseInt(request.getParameter("re_level")));
			BoardDAO bdPro = BoardDAO.getInstance();
			int result = bdPro.replyInsert(board);
			request.setAttribute("bnum", board.getBnum());
			request.setAttribute("result", result);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("ref", ref);
			request.setAttribute("ref1", ref1);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "boardReplyWriterPro.jsp";
	}

}
