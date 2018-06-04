package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class VrWriteReviewAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
			String id=request.getParameter("id");
			request.setAttribute("id",id);
			int cnum=Integer.parseInt(request.getParameter("cnum"));
			request.setAttribute("cnum", cnum);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return "vrWriteReview.jsp";
	}

}
