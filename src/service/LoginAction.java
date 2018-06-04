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

public class LoginAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServerException, IOException {
		try {
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			MemberDAO md = MemberDAO.getInstance();
			
			// 회원정보 가져오는 DAO메소드
			Member member = new Member();
			member = md.getUserInfo(id);
			
			// 로그인기능 메소드
			int result = md.login(id, password);
			if(result != 1) {
				id = null;
			}
			request.setAttribute("member", member);
			request.setAttribute("result", result);
			if(result == 1) {	//로그인 성공시에
				
				ReviewDAO reviewDAO = ReviewDAO.getInstance();
				
				//방탈출 인기 best3
				List<Review> review = reviewDAO.r_p_rank();
				
				//vr 인기 best3
				List<Review> v_review = reviewDAO.v_p_rank();
				
				request.setAttribute("r_review", review);
				request.setAttribute("v_review", v_review);
				return "main.jsp";
			}
				
				
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "login.jsp";
	}

}
