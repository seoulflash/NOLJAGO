package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board;
import dao.BoardDAO;

public class BoardUpdateFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			int bnum = Integer.parseInt(request.getParameter("bnum"));
			String pageNum = request.getParameter("pageNum");
			String id = request.getParameter("id");
			System.out.println("id---->"+id);
			BoardDAO bd = BoardDAO.getInstance();
			Board board = bd.select(bnum);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("board", board);
			request.setAttribute("id", id);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "boardUpdateForm.jsp";
	}

}