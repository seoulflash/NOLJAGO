package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import dao.Reservation;
import dao.ReservationDAO;

public class AmReservationDetailAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ReservationDAO rd = ReservationDAO.getInstance();
		MemberDAO md = MemberDAO.getInstance();
		try {
			String resno = request.getParameter("resno");
			String id = request.getParameter("id");
			String password = md.getpassword(id);
			String pageNum = request.getParameter("pageNum");
			Reservation reserv = rd.reserv_info(resno);
			
			request.setAttribute("resno", resno);
			request.setAttribute("id", id);
			request.setAttribute("password", password);

			request.setAttribute("pageNum", pageNum);
			request.setAttribute("reserv", reserv);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "amReservationDetail.jsp";
	}

}
