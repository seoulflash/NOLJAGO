package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;
import dao.Review;
import dao.ReviewDAO;

public class bestGameAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try{
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			
			ReviewDAO reviewDAO = ReviewDAO.getInstance();
			
			//방탈출 인기 best3
			List<Review> review = reviewDAO.r_p_rank();
			
			//방탈출 평점 best3
			//List<Review> r_a_review = reviewDAO.r_a_rank();
			
			//vr 인기 best3
			List<Review> v_review = reviewDAO.v_p_rank();
			
			//vr 평점 best3
			//List<Review> v_a_review = reviewDAO.v_a_rank();

			request.setAttribute("r_review", review);
			//request.setAttribute("r_review2", r_a_review);
			request.setAttribute("v_review", v_review);
			//request.setAttribute("v_review2", v_a_review);
			
			request.setAttribute("id", id);
			request.setAttribute("member", member);

		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		return "bestGameView.jsp";
	}

}
