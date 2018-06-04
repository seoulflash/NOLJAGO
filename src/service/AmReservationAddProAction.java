package service;

import java.io.IOException;
import java.security.SecureRandom;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CafeDAO;
import dao.MemberDAO;
import dao.Reservation;
import dao.ReservationDAO;

public class AmReservationAddProAction implements CommandProcess {
	
	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
 
		ReservationDAO rd = ReservationDAO.getInstance();
		CafeDAO cd = CafeDAO.getInstance();
		MemberDAO md = MemberDAO.getInstance();
		
		try {
			request.setCharacterEncoding("utf-8");
			String pageNum = request.getParameter("pageNum");
			Reservation reserv = new Reservation();
			String id = request.getParameter("id");
			String resno = request.getParameter("resno");
			
			System.out.println("-------------------------------------------------------------------------------");
			System.out.println("AmReservationAddProAction reserv-->" + reserv);
			System.out.println("AmReservationAddProAction pageNum-->" + pageNum);
			System.out.println("AmReservationAddProAction id-->" + id);
			System.out.println("AmReservationAddProAction resno-->" + resno);
			System.out.println("-------------------------------------------------------------------------------");
			
			int admin = md.getAdmin(id);
			if (admin == 3) {
				reserv.setResdate(request.getParameter("resdate"));
				reserv.setStarttime(Integer.parseInt(request.getParameter("starttime")));
				reserv.setId(request.getParameter("reservid"));
				reserv.setEndtime(Integer.parseInt(request.getParameter("endtime")));
				reserv.setPnum(0);
				reserv.setCnum(Integer.parseInt(request.getParameter("cnum")));
				reserv.setTnum(Integer.parseInt(request.getParameter("tnum")));
				reserv.setResno(resno);
				reserv.setCount(Integer.parseInt(request.getParameter("count")));
				int cnum = reserv.getCnum();
				int point = cd.getprice(cnum);
				reserv.setPoint(point);
				md.updateMemberPoint(-reserv.getPoint(), reserv.getId());
			}
			
			if (admin == 2) {
				int cnum = cd.getCnum(id);	
				int price = cd.getprice(cnum);
				reserv.setResdate(request.getParameter("resdate"));
				reserv.setStarttime(Integer.parseInt(request.getParameter("starttime")));
				reserv.setId(request.getParameter("reservid"));
				reserv.setEndtime(Integer.parseInt(request.getParameter("endtime")));
				reserv.setPnum(0);
				reserv.setCnum(cnum);
				reserv.setTnum(Integer.parseInt(request.getParameter("tnum")));
				reserv.setResno(resno);
				reserv.setCount(Integer.parseInt(request.getParameter("count")));
				reserv.setPoint(price);
				md.updateMemberPoint(-price, reserv.getId());
			}
			int result = rd.reservation(reserv);
			System.out.println("-------------------------------------------------------------------------------");
			System.out.println("AmReservationAddProAction result-->"+ result);
			System.out.println("-------------------------------------------------------------------------------");
			
			request.setAttribute("result", result);
			request.setAttribute("id", id);
			request.setAttribute("pageNum", pageNum);
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}		
		return "amReservationAddPro.jsp";
	}
	
	


}
