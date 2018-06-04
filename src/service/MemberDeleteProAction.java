package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;

public class MemberDeleteProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberid = request.getParameter("memberid");
			System.out.println(memberid);
			String pageNum = request.getParameter("pageNum");
			MemberDAO md = MemberDAO.getInstance();
			int result = md.memberDelete(memberid);
			request.setAttribute("result", result);
			request.setAttribute("memberid", memberid);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "memberDeletePro.jsp";
	}

}
