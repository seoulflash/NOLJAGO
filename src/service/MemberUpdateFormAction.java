package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;

public class MemberUpdateFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String id = "aa";
			String password = "1234";
			String memberid = request.getParameter("memberid");
			String pageNum = request.getParameter("pageNum");
			MemberDAO md = MemberDAO.getInstance();
			Member member = md.getUserInfo(memberid);
			
			request.setAttribute("id", id);
			request.setAttribute("password", password);
			request.setAttribute("memberid", memberid);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("member", member);
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "memberUpdateForm.jsp";
	}

}
