package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;

public class DeleteUserAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
			
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		MemberDAO md = MemberDAO.getInstance();
		
		try {
			int result = md.deleteUser(id, password);
			request.setAttribute("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "deleteUserResult.jsp";
	}

}
