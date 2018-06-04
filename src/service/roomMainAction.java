package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Cafe;
import dao.CafeDAO;
import dao.Member;
import dao.MemberDAO;

public class roomMainAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try{
			// 회원정보 가져오는 DAO메소드
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			
			CafeDAO cd = CafeDAO.getInstance();
			List<Cafe> list = cd.r_list();
			
			request.setAttribute("member", member);
			//List<Cafe> list2 = cd.r_list2();
			request.setAttribute("list", list);
			//request.setAttribute("list2", list2);
			request.setAttribute("id", id);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}

		return "roomMainView.jsp";
	}

}
