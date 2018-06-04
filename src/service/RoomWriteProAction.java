package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Review;
import dao.ReviewDAO;

public class RoomWriteProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		int rate = Integer.parseInt(request.getParameter("rate"));
		int cnum=Integer.parseInt(request.getParameter("cnum"));
		
		try{
		
			ReviewDAO rd = ReviewDAO.getInstance();
			Review review = new Review();
			review.setId(id);
			review.setRate(rate);
			review.setRecontent(request.getParameter("recontent"));
			
			int result = rd.review_insert(review,id,cnum);
			request.setAttribute("result", result);
			request.setAttribute("id",id);
			request.setAttribute("cnum", cnum);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "roomWriteProView.jsp";
	}

}
