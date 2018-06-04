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
import dao.ReservationDAO;
import dao.Review;
import dao.ReviewDAO;
import dao.Theme;

public class roomListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try{
			// 회원정보 가져오는 DAO메소드
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			
			CafeDAO cd = CafeDAO.getInstance();
			int cnum=0;
			int num=cd.good_num(cnum);
			cnum=Integer.parseInt(request.getParameter("cnum"));
			List<Theme> list = cd.r_select_theme(cnum);
			ReviewDAO rd=ReviewDAO.getInstance();
			List<Review> review =rd.review_view(cnum);
			Cafe cafe = cd.r_list3(cnum);
			ReservationDAO rsd=ReservationDAO.getInstance();
			int res_yn=rsd.res_yn(id, cnum);			//예약을 했다면 후기를 쓸 수 있음
			int review_yn=rsd.review_yn(id, cnum);		//후기 썼으면 더이상 못 쓰게 막음
			int cafe_rate=cd.cafe_rate(cnum);

			request.setAttribute("member", member);
			request.setAttribute("list", list);
			request.setAttribute("cnum", cnum);
			request.setAttribute("cafe", cafe);
			request.setAttribute("review", review);
			request.setAttribute("num", num);
			request.setAttribute("res_yn", res_yn);
			request.setAttribute("review_yn", review_yn);
			request.setAttribute("cafe_rate", cafe_rate);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}

		return "roomListView.jsp";
	}

}
