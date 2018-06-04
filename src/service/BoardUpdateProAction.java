package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board;
import dao.BoardDAO;

public class BoardUpdateProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
			String pageNum = request.getParameter("pageNum");
			Board board = new Board();
			
			board.setBnum(Integer.parseInt(request.getParameter("bnum")));
			board.setCategory(request.getParameter("category"));
			board.setId(request.getParameter("id"));
			board.setSubject(request.getParameter("subject"));
			board.setContent(request.getParameter("content"));
			BoardDAO bdPro = BoardDAO.getInstance();
			int result = bdPro.update(board);
			
			request.setAttribute("bnum", board.getBnum());
			request.setAttribute("result", result);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "boardUpdatePro.jsp";
	}

}
