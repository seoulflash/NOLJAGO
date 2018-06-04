package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board;
import dao.BoardDAO;
import dao.Member;
import dao.MemberDAO;

public class BoardWriterFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			// 회원정보 가져오는 DAO메소드
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			int bnum = 0, ref = 0, re_level = 0;
			String pageNum = request.getParameter("pageNum");
			if (pageNum == null)
				pageNum = "1";
			if (request.getParameter("bnum") != null) {
				bnum = Integer.parseInt(request.getParameter("bnum"));
				BoardDAO bd = BoardDAO.getInstance();
				Board board = bd.select(bnum);
				ref = board.getRef();
				re_level = board.getRe_level();
			}
			request.setAttribute("member", member);
			request.setAttribute("bnum", bnum);
			request.setAttribute("ref", ref);
			request.setAttribute("re_level", re_level);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "boardWriterForm.jsp";
	}

}
