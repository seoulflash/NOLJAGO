package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;

public class MyInfoUpdateAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		String intro = request.getParameter("intro");
		MemberDAO md = MemberDAO.getInstance();
		try {
			int result = md.infoUpdate(id, password, email, tel, intro);
			request.setAttribute("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "myinfoUpdateResult.jsp";
	}

}
