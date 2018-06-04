package service;

import java.io.IOException;
import java.security.SecureRandom;
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

public class roomReserve3Action implements CommandProcess {
	
	String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	SecureRandom rnd = new SecureRandom();
	
	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try{
			CafeDAO cd = CafeDAO.getInstance();
			// 회원정보 가져오는 DAO메소드
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			
			int result = 0;	//예약 테이블용 result
			int result1 = 0;	//멤버 포인트 차감 result
			
			String time = request.getParameter("time");
			StringTokenizer strToken = new StringTokenizer(time, ":");    //:으로 분리
			
			int starttime = Integer.parseInt(strToken.nextToken());	// 정시 받아서 int starttime에 저장
			
			String date=request.getParameter("date");
			if (id == null || id == "") {
				return "login.jsp";
			}
			System.out.println("reserve3 id--->" + id);
			System.out.println(starttime);
			
			int count=Integer.parseInt(request.getParameter("count"));
			int pnum = 0; 
			String pnumstr=request.getParameter("pnum");
			if (pnumstr == null || pnumstr == "") {
				pnum = 0;
			} else {
				pnum = Integer.parseInt(pnumstr);
			}
			
			int cnum=Integer.parseInt(request.getParameter("cnum"));
			int tnum=Integer.parseInt(request.getParameter("tnum"));
			int point = Integer.parseInt(request.getParameter("price"));	//가격 포인트 뽑아오기
			
			String resno = randomString(10);	// 랜덤하게 바꿔줘야함
			Cafe cafe = cd.r_list3(cnum);
			Theme theme = cd.r_theme(cnum,tnum);
			
			if (member.getPoint() < point)	//소지하고 있는 포인트가 지불할 포인트보다 적을 시 
			{
				result = -1;
				request.setAttribute("result", result);
				request.setAttribute("cafe", cafe);
				request.setAttribute("theme", theme);
				return "roomReserve3View.jsp";
			} 
			//돈이 충분하면 진행
			ReservationDAO rd = ReservationDAO.getInstance();
			Reservation res= new Reservation();
			res.setResdate(request.getParameter("date"));
			res.setStarttime(starttime);
			res.setId(id);
			res.setEndtime(starttime+1);	//사용시간 한시간으로 무조건 제한
			res.setPnum(pnum);
			res.setCnum(cnum);
			res.setTnum(tnum);
			res.setResno(resno);
			res.setCount(count);
			res.setPoint(point);	//주말 평일 구분해야됨
			
			result = rd.reservation(res);
			if (result == 1) {	//예약 성공했을시에 포인트 차감
				result1 = md.updateMemberPoint(0 - point, id);	//포인트 차감
				if (result1 == 0) {		//결제 도중 문제 생김
					result = -1;
					request.setAttribute("result", result);
					request.setAttribute("cafe", cafe);
					request.setAttribute("theme", theme);
					return "roomReserve3View.jsp";
				}
			}
			
			member = md.getUserInfo(id);
			request.setAttribute("member", member);
			
			request.setAttribute("cnum", cnum);
			request.setAttribute("tnum", tnum);
			request.setAttribute("cafe", cafe);
			request.setAttribute("theme", theme);

			request.setAttribute("date", date);
			request.setAttribute("time", time);
			request.setAttribute("resno", resno);
			request.setAttribute("member", member);
			request.setAttribute("count", count);
			request.setAttribute("result", result);
			request.setAttribute("point", point);
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		return "roomReserve3View.jsp";
	}
	
	public String randomString( int len ){
	   StringBuilder sb = new StringBuilder( len );
	   for( int i = 0; i < len; i++ ) 
	      sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
	   return sb.toString();
	}

}
