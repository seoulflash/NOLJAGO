package service;

import java.io.IOException;

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

public class PartyCreateAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		try{
			request.setCharacterEncoding("utf-8");
			int count = 1;
			int result = 0;
			int result1 = 0;	//결제용 result1
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			
			roomReserve3Action r3 = new roomReserve3Action();
			String resno = r3.randomString(10); //10자리 랜덤변수
			int point = Integer.parseInt(request.getParameter("perprice"));
			int cnum=Integer.parseInt(request.getParameter("cnum"));
			int tnum=Integer.parseInt(request.getParameter("tnum"));
			System.out.println(point);
			
			if (member.getPoint() < point)	//소지하고 있는 포인트가 지불할 포인트보다 적을 시 
			{
				System.out.println("거지냐?");
				result = -1;
				request.setAttribute("result", result);
				request.setAttribute("id", id);
				return "partyCreate.jsp";
			} 
			
			//돈이 충분하면 진행
			//Party Create
			PartyDAO pd = PartyDAO.getInstance();
			Party party = new Party();
			party.setCnum(Integer.parseInt(request.getParameter("cnum")));
			party.setTnum(Integer.parseInt(request.getParameter("tnum")));
			party.setMax(Integer.parseInt(request.getParameter("max")));
			party.setPcontent(request.getParameter("pcontent"));
			party.setHopehour(Integer.parseInt(request.getParameter("hopehour")));
			party.setHopedate(request.getParameter("hopedate"));
			result = pd.partyCreate(party, id, point);
			
			//PartyCreate시 파티장의 정보를 reservation에 저장
			CafeDAO cd = CafeDAO.getInstance();
			Cafe cafe = cd.r_list3(party.getCnum());
			ReservationDAO rd = ReservationDAO.getInstance();
			Reservation res = new Reservation();
			
			int pnum = pd.pnumCheck(id);
			res.setResdate(party.getHopedate());
			res.setStarttime(party.getHopehour());
			res.setId(id);
			res.setEndtime(party.getHopehour()+1);	//사용시간 한시간으로 무조건 제한
			res.setPnum(pnum);
			res.setCnum(party.getCnum());
			res.setTnum(party.getTnum());
			res.setResno(resno);
			res.setCount(count);
			res.setPoint(point);
			
			int resultRes = rd.reservation(res);
			
			if(result>0 ){	//성공적으로 파티 생성시
				
				result1 = md.updateMemberPoint(0 - point, id);	//포인트 차감
				if (result1 == 0) {	//결제 오류
					result = -1;
					request.setAttribute("result", result);
					request.setAttribute("id", id);
					return "partyCreate.jsp";
				}
				request.setAttribute("result", result);
				request.setAttribute("resultRes", resultRes);
				request.setAttribute("res", res);
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return "partyCreate.jsp";
	}
}