package service;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;

public class MyInfoView implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		MemberDAO md = MemberDAO.getInstance();
		Member member = new Member();
		
		try {
			// 회원정보 가져오는 메소드
			member = md.getUserInfo(id);
			
			request.setAttribute("member", member);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return "myInfo.jsp";
	}

}
