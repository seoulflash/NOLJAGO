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

public class RoomReserveFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		CafeDAO cd = CafeDAO.getInstance();
		
		try{
			// 회원정보 가져오는 DAO메소드
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			
			int cnum=Integer.parseInt(request.getParameter("cnum"));
			int tnum=Integer.parseInt(request.getParameter("tnum"));
			
			if (id == null || id == "") {
				return "login.jsp";
			}
			
			System.out.println("roomReserveAction id->"+id);
			
			Cafe cafe = cd.r_list3(cnum);		//cafe DTO 받아옴
			Theme theme = cd.r_theme(cnum,tnum);	//THEME DTO 받아옴
			
			int open = cafe.getOpen();
			int close = cafe.getClose();
			int hours = open - close + 1;
			
			request.setAttribute("member", member);
			
			request.setAttribute("cnum", cnum);
			request.setAttribute("tnum", tnum);
			request.setAttribute("id", id);
			request.setAttribute("cafe", cafe);
		    request.setAttribute("theme", theme);
		    request.setAttribute("open", open);
		    request.setAttribute("close", close);
		    request.setAttribute("hours", hours);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return "roomThemeView.jsp";
	}

}
