package service;

import java.io.IOException;
import java.rmi.ServerException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;
import dao.Review;
import dao.ReviewDAO;

public class MainAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServerException, IOException {

		
		try {
			// 회원정보 가져오는 DAO메소드
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			
			ReviewDAO reviewDAO = ReviewDAO.getInstance();
			
			//방탈출 인기 best3
			List<Review> review = reviewDAO.r_p_rank();
			
			//vr 인기 best3
			List<Review> v_review = reviewDAO.v_p_rank();
			
			request.setAttribute("r_review", review);
			request.setAttribute("v_review", v_review);
			
			request.setAttribute("member", member);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "main.jsp";
	}

}
