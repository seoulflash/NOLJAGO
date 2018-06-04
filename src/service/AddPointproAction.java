package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;

public class AddPointproAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String id = request.getParameter("id");
			int point = Integer.parseInt(request.getParameter("point"));
			System.out.println("id" + id);
			System.out.println("point" + point);
			
			MemberDAO md = MemberDAO.getInstance();
			Member member = md.getUserInfo(id);
			int result = md.updateMemberPoint(point, id);
			request.setAttribute("result", result);
			request.setAttribute("member", member);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "addPoint.jsp";
	
	}

}
