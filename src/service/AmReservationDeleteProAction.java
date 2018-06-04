package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import dao.ReservationDAO;

public class AmReservationDeleteProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ReservationDAO rd = ReservationDAO.getInstance();
		MemberDAO md = MemberDAO.getInstance();
		try {
			String resno = request.getParameter("resno");
			String id = request.getParameter("id");
			String pageNum = request.getParameter("pageNum");
			String reservid = request.getParameter("reservid");
			int reservpoint = Integer.parseInt(request.getParameter("reservpoint"));
			md.updateMemberPoint(reservpoint, reservid);
			
			int result = rd.ResDelete(resno);
			request.setAttribute("resno", resno);
			request.setAttribute("id", id);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("reservid", reservid);
			request.setAttribute("reservpoint", reservpoint);
			request.setAttribute("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "amReservationDeletePro.jsp";
	}

}
