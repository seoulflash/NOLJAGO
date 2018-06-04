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

public class roomReserveAction implements CommandProcess {

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
			String tname = request.getParameter("tname");
			String date= request.getParameter("datepicker");
			String time = request.getParameter("time");
			String day = request.getParameter("day");
			System.out.println("day-->"+day);
			System.out.println("time=====>" +time);

			int cnum=Integer.parseInt(request.getParameter("cnum"));
			int tnum=Integer.parseInt(request.getParameter("tnum"));

			System.out.println("roomReserveAction tnum->"+tnum);
			System.out.println("roomReserveAction cnum->"+cnum);
			System.out.println("roomReserveAction id->"+id);
			Cafe cafe = cd.r_list3(cnum);		//cafe DTO 받아옴
			Theme theme = cd.r_theme(cnum,tnum);	//THEME DTO 받아옴
			Theme themeP = cd.r_theme_people(cnum,tnum);
			
			request.setAttribute("member", member);
			
			request.setAttribute("cnum", cnum);
			request.setAttribute("tnum", tnum);
			request.setAttribute("cafe", cafe);
		    request.setAttribute("theme", theme);
		    request.setAttribute("headcount", themeP.getHeadcount());

			request.setAttribute("date", date);
			request.setAttribute("time", time);
			request.setAttribute("tname", tname);
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


		return "roomReserve2View.jsp";
	}

}
