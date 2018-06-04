package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;


public class MemberUpdateProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try { 
			request.setCharacterEncoding("utf-8"); 
	        String pageNum = request.getParameter("pageNum");
	        Member member = new Member();
	        member.setId(request.getParameter("id"));
	        System.out.println(member.getId());
	        member.setPassword(request.getParameter("password"));
	        member.setAdmin(Integer.parseInt(request.getParameter("admin")));
	        member.setName(request.getParameter("name"));
	        member.setBirth(request.getParameter("birth"));
	        member.setAddress(request.getParameter("address"));
	        member.setEmail(request.getParameter("email"));
	        member.setTel(request.getParameter("tel"));
	        member.setPoint(Integer.parseInt(request.getParameter("point")));
	        MemberDAO md = MemberDAO.getInstance();
			int result = md.memberUpdate(member);
			
			request.setAttribute("result", result);
			request.setAttribute("id", member.getId());
			request.setAttribute("pageNum", pageNum);
		} catch(Exception e) { 
			System.out.println(e.getMessage()); 
		}
		
		return "memberUpdatePro.jsp";
	}

}
