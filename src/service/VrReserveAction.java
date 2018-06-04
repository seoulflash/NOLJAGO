package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Cafe;
import dao.CafeDAO;
import dao.Member;
import dao.MemberDAO;
import dao.Theme;

public class VrReserveAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		CafeDAO cd = CafeDAO.getInstance();
		String id = request.getParameter("id");
		
		if (id == null || id == "") {
			return "login.jsp";
		}
		
		try{
			// 회원정보 가져오는 DAO메소드
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			
			
			int cnum = Integer.parseInt(request.getParameter("cnum"));
			int tnum = Integer.parseInt(request.getParameter("tnum"));
			
			
			//Member member=cd.member_into("bbb");
			Cafe cafe = cd.cafe_info(cnum);
			Theme theme = cd.v_theme(cnum,tnum);
			
			request.setAttribute("member", member);
			
			request.setAttribute("cnum", cnum);
			request.setAttribute("tnum", tnum);
			request.setAttribute("cafe", cafe);
			request.setAttribute("theme", theme);
			request.setAttribute("open", cafe.getOpen());
			request.setAttribute("close", cafe.getClose());
			request.setAttribute("hours", cafe.getClose() - cafe.getOpen() + 1);
			request.setAttribute("id", id);
			//request.setAttribute("member", member);
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		return "vrReserveView.jsp";
	}

}
