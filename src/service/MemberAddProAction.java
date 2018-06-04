package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import dao.Member;

public class MemberAddProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			 request.setCharacterEncoding("utf-8"); 
			 String pageNum = request.getParameter("pageNum");
			 Member member = new Member();
			 member.setId(request.getParameter("id"));
			 member.setPassword(request.getParameter("password"));
			 member.setAdmin(Integer.parseInt(request.getParameter("admin")));
			 member.setName(request.getParameter("name"));
			 member.setBirth(request.getParameter("birth"));
			 
			 if(request.getParameter("image") == null || request.getParameter("image") == "") {
				 member.setImage("images/home.png");
			 }
			 
			 member.setSex(request.getParameter("sex"));
			 member.setAddress(request.getParameter("address"));
			 member.setEmail(request.getParameter("email"));
			 member.setTel(request.getParameter("tel"));
			 member.setIntro(request.getParameter("intro"));
			 member.setPoint(Integer.parseInt(request.getParameter("point")));
			 
			 MemberDAO md = MemberDAO.getInstance();
			 int result = md.memberInsert(member);
			 request.setAttribute("result", result);
			 request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "memberAddPro.jsp";
	}

}
