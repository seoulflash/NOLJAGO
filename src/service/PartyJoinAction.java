package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Cafe;
import dao.CafeDAO;
import dao.Member;
import dao.MemberDAO;
import dao.Party;
import dao.PartyDAO;
import dao.Reservation;
import dao.ReservationDAO;
import dao.Theme;

public class PartyJoinAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			request.setCharacterEncoding("utf-8");
			int pnum = Integer.parseInt(request.getParameter("pnum"));
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			String pageNum = request.getParameter("pageNum");
						
			roomReserve3Action r3 = new roomReserve3Action();
			String resno = r3.randomString(10); //10자리 랜덤변수
			PartyDAO pd = PartyDAO.getInstance();
			//reservation 과정
			Party partyInfo = pd.partyInfo(pnum);	//파티정보 갖고옴
			
			System.out.println("빼갈 돈--->" + partyInfo.getPrice());
			md.updateMemberPoint(0-partyInfo.getPrice(), id);	//point 차감
			
			int cnum = partyInfo.getCnum();
			int tnum = partyInfo.getTnum();
			int time = partyInfo.getHopehour();
			String resdate = partyInfo.getHopedate();
			int count = 1;
			CafeDAO cd = CafeDAO.getInstance();
			Cafe cafe = cd.r_list3(cnum);
			ReservationDAO rd = ReservationDAO.getInstance();
			Reservation res = new Reservation();
			res.setResdate(resdate);
			res.setStarttime(time);
			res.setId(id);
			res.setEndtime(time+1);	//사용시간 한시간으로 무조건 제한
			res.setPnum(pnum);
			res.setCnum(cnum);
			res.setTnum(tnum);
			res.setResno(resno);
			res.setCount(count);
			res.setPoint(partyInfo.getPrice());	
			int resultRes = rd.reservation(res);
			
			System.out.println("resultRes " + resultRes);
			
			//party join 과정
			int result = pd.partyJoin(pnum,id);
			
			request.setAttribute("pnum", pnum);
			request.setAttribute("id", id);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("res", res);
			request.setAttribute("result", result);
			request.setAttribute("resultRes", resultRes);
			request.setAttribute("member", member);
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return "partyJoin.jsp";
	}
}
