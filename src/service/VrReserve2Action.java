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

public class VrReserve2Action implements CommandProcess {

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
			String date = request.getParameter("datepicker");
			String time = request.getParameter("time");
			String day = request.getParameter("day");
			System.out.println("day-->"+day);
			System.out.println("time=====>" +time);
			int tnum=Integer.parseInt(request.getParameter("tnum"));
			int cnum=Integer.parseInt(request.getParameter("cnum"));
			
			Theme theme = cd.v_theme(cnum,tnum);	//Theme DTO 받아옴
			Cafe cafe = cd.cafe_info(cnum);			//cafe DTO 받아옴
			
			request.setAttribute("member", member);
			request.setAttribute("point", member.getPoint());
			request.setAttribute("cnum", cnum);
			request.setAttribute("tnum", tnum);
			request.setAttribute("theme", theme);
			request.setAttribute("cafe", cafe);
			request.setAttribute("date", date);
			request.setAttribute("time", time);
			if(day.equals("토요일") || day.equals("일요일")) {
				System.out.println("주말");
				request.setAttribute("price", cafe.getRedprice());
			} else {
				System.out.println("평일");
				request.setAttribute("price", cafe.getPrice());
			}
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return "vrReserve2View.jsp";
	}

}
