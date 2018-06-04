package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;

public class AdminMainView implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		MemberDAO md = MemberDAO.getInstance();
		try {
			String id = request.getParameter("id");
			String password = md.getpassword(id);
			int admin = Integer.parseInt(request.getParameter("admin"));
			
			
			request.setAttribute("id", id);
			request.setAttribute("password", password);
			request.setAttribute("admin", admin);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "adminMain.jsp";
	}

}
