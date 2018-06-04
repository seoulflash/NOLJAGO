package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;
import dao.Reservation;
import dao.ReservationDAO;

public class MyResCancleAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String resno = request.getParameter("resno");
		ReservationDAO rd = ReservationDAO.getInstance();
		MemberDAO md = MemberDAO.getInstance();	//포인트 환불을 위한 md
		
		try {
			Reservation reserve = rd.getResInfo(id, resno);	//포인트 환불을 위해 취소를 누른 예약내역 갖고옴
			int result = rd.resCancle(id, resno);
			if(result == 1) //삭제 성공했을 시 멤버한테 포인트 환불
			{
				int result1 = md.updateMemberPoint(reserve.getPoint(), id);	// 포인트 환불
				System.out.println("환불 성공여부 "+result1);
			}
			request.setAttribute("point", reserve.getPoint());
			request.setAttribute("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "myResCancleResult.jsp";
	}

}
