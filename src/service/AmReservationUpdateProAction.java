package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Reservation;
import dao.ReservationDAO;

public class AmReservationUpdateProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
			String resno = request.getParameter("resno");
			String id = request.getParameter("id");
			String pageNum = request.getParameter("pageNum");
			Reservation reserv = new Reservation();
			reserv.setResdate(request.getParameter("resdate"));
			reserv.setStarttime(Integer.parseInt(request.getParameter("starttime")));
			reserv.setEndtime(Integer.parseInt(request.getParameter("endtime")));
			reserv.setResno(request.getParameter("resno"));
			System.out.println("AmReservationUpdateProAction resno->"+resno);
			System.out.println("AmReservationUpdateProAction id->"+id);
			ReservationDAO rd = ReservationDAO.getInstance();
			int result = rd.ResUpdate(reserv);
			
			request.setAttribute("result", result);
			request.setAttribute("resno", resno);
			request.setAttribute("id", id);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "amReservationUpdatePro.jsp";
	}

}
