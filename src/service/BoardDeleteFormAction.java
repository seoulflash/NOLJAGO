package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board;
import dao.BoardDAO;

public class BoardDeleteFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			int bnum = Integer.parseInt(request.getParameter("bnum"));
			int ref = Integer.parseInt(request.getParameter("ref"));
			String pageNum = request.getParameter("pageNum");
			System.out.println("bnum---->>"+bnum);
			System.out.println("ref---->>"+ref);
			System.out.println("pageNum---->>"+pageNum);
			BoardDAO bd = BoardDAO.getInstance();
			Board board = bd.select(bnum);
			request.setAttribute("bnum", bnum);
			request.setAttribute("ref", ref);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("board", board);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "boardDeleteForm.jsp";
	}

}
