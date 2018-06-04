package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;

public class AddPointAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String id = request.getParameter("id");
			System.out.println("add point id" + id);
			MemberDAO md = MemberDAO.getInstance();
			Member member = md.getUserInfo(id);
			int mempoint = member.getPoint();
			request.setAttribute("member", member);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "addPoint.jsp";
	}

}
