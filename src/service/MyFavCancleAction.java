package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GoodDAO;

public class MyFavCancleAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String id = request.getParameter("id");
		int cnum = Integer.parseInt(request.getParameter("cnum"));
		int tnum = Integer.parseInt(request.getParameter("tnum"));
		GoodDAO gd = GoodDAO.getInstance();
		
		try {
			int result = gd.favCancle(id, cnum, tnum);
			request.setAttribute("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "myFavCancleResult.jsp";
	}

}
