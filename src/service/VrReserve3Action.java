package service;

import java.io.IOException;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Cafe;
import dao.CafeDAO;
import dao.Member;
import dao.MemberDAO;
import dao.Reservation;
import dao.ReservationDAO;
import dao.Theme;

public class VrReserve3Action implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try{
			// 회원정보 가져오는 DAO메소드
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			
			int result = 0;	//예약 테이블용 result
			int result1 = 0;	//멤버 포인트 차감 result
			
			System.out.println("vrReserve3 Action called");
			int pnum = 0;
			int tnum=Integer.parseInt(request.getParameter("tnum"));
			int cnum=Integer.parseInt(request.getParameter("cnum"));
			int point = Integer.parseInt(request.getParameter("price"));
			System.out.println("point===>"+point);
			
			String starttime = request.getParameter("time");
			System.out.println("starttime" + starttime);
			StringTokenizer strToken = new StringTokenizer(starttime, ":");
			int time = Integer.parseInt(strToken.nextToken());
			
			System.out.println("time---->" +time);
			String pnumstr=request.getParameter("pnum");
			if (pnumstr == null || pnumstr == "") {
				pnum = 0;
			} else {
				pnum = Integer.parseInt(pnumstr);
			}
			
			roomReserve3Action r3 = new roomReserve3Action();
			String resno = r3.randomString(10);		//10개 랜덤변수
			
			
			int count=Integer.parseInt(request.getParameter("count")); //인원수
			
			CafeDAO cd = CafeDAO.getInstance();
			Cafe cafe = cd.r_list3(cnum);
			Theme theme = cd.r_theme(cnum,tnum);
			
			if (member.getPoint() < point)	//소지하고 있는 포인트가 지불할 포인트보다 적을 시 
			{
				System.out.println("거지");
				result = -1;
				request.setAttribute("result", result);
				request.setAttribute("cafe", cafe);
				request.setAttribute("theme", theme);
				return "vrReserve3View.jsp";
			} 
			
			//돈이 충분하면 진행
			ReservationDAO rd = ReservationDAO.getInstance();
			Reservation res = new Reservation();
			
			res.setResdate(request.getParameter("date"));
			res.setStarttime(time);
			res.setId(id);
			res.setEndtime(time+1);	//사용시간 한시간으로 무조건 제한
			res.setPnum(pnum);
			res.setCnum(cnum);
			res.setTnum(tnum);
			res.setResno(resno);
			res.setCount(count);
			res.setPoint(point);	//주말 평일 구분해야됨
			
			result = rd.reservation(res);
			
			if(result == 1)	//성공적인 예약 시 
			{
				result1 = md.updateMemberPoint(0 - point, id); //point 차감
				if (result1 == 0) {		//결제 도중 문제 생김
					result = -1;
					request.setAttribute("result", result);
					request.setAttribute("cafe", cafe);
					request.setAttribute("theme", theme);
					return "vrReserve3View.jsp";
				}
			}
			
			member = md.getUserInfo(id);
			request.setAttribute("member", member);			
			request.setAttribute("tnum", tnum);
			request.setAttribute("cnum", cnum);
			request.setAttribute("cafe"	, cafe);
			request.setAttribute("theme", theme);
			request.setAttribute("date", res.getResdate());
			request.setAttribute("time", starttime);
			request.setAttribute("resno", resno);
			request.setAttribute("count", count);
			request.setAttribute("result", result);
			request.setAttribute("point", point);
			
			System.out.println("result->"+result);
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return "vrReserve3View.jsp";
	}

}
