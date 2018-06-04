package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;

public class FindIdAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		MemberDAO md = MemberDAO.getInstance();
		try {
			String getUserId = md.findId(name, email);
			System.out.println(getUserId);
			request.setAttribute("getUserId", getUserId);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "findIdResult.jsp";
	}
}
