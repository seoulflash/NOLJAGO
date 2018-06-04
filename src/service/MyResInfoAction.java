package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Reservation;
import dao.ReservationDAO;

public class MyResInfoAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String resno = request.getParameter("resno");
		
		ReservationDAO rd = ReservationDAO.getInstance();
		Reservation reservation = new Reservation();
		try {
			reservation = rd.getResInfo(id, resno);
			request.setAttribute("id", id);
			request.setAttribute("resno", resno);
			request.setAttribute("resdate", reservation.getResdate());
			request.setAttribute("starttime", Integer.toString(reservation.getStarttime()));
			request.setAttribute("endtime", Integer.toString(reservation.getEndtime()));
			request.setAttribute("pnum", Integer.toString(reservation.getPnum()));
			request.setAttribute("cname", reservation.getCname());
			request.setAttribute("cnum", Integer.toString(reservation.getCnum()));
			request.setAttribute("type", reservation.getType());
			request.setAttribute("tname", reservation.getTname());
			request.setAttribute("count", Integer.toString(reservation.getCount()));
			request.setAttribute("point", Integer.toString(reservation.getPoint()));
			request.setAttribute("leaderId", reservation.getLeaderId());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "myResInfoResult.jsp";
	}

}
