package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;
import dao.PartyDAO;
import dao.Reservation;
import dao.ReservationDAO;

public class PartyOutAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		try{
			request.setCharacterEncoding("utf-8");
			int pnum = Integer.parseInt(request.getParameter("pnum"));
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			String pageNum = request.getParameter("pageNum");
			PartyDAO pd = PartyDAO.getInstance();
			ReservationDAO rd = ReservationDAO.getInstance();
			int resultRes = 0;
			//party out
			int result = pd.partyOut(pnum,id);
			//get resno
			String resno = pd.resnoGet(pnum,id);
			
			//reservation cancel
			if(resno!=null){
				//예약 정보 갖고오기(포인트 반환을 위해)
				Reservation reservation = rd.getResInfo(id, resno);
				resultRes = rd.resCancle(id, resno);
				System.out.println("");
				
				if (resultRes == 1) {	//예약 취소가 성공적이면
					System.out.println("돌려줄 돈--->" + reservation.getPoint());
					md.updateMemberPoint(reservation.getPoint(), id);	//point 차감
				}
			}
			else{
				resultRes = -1;
			}
			request.setAttribute("pnum", pnum);
			request.setAttribute("id", id);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("result", result);
			request.setAttribute("resultRes", resultRes);
			request.setAttribute("member", member);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return "partyOut.jsp";
	}
}
