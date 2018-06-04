package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.*;

public class AmCafeDetailAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String id = "aa";
			String password = "1234";
			int cnum = Integer.parseInt(request.getParameter("cnum"));
			String pageNum = request.getParameter("pageNum");
			CafeDAO cd = CafeDAO.getInstance();
			Cafe cafe = cd.cafe_info(cnum);
		
			request.setAttribute("id", id);
			request.setAttribute("password", password);
			request.setAttribute("cnum", cnum);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("cafe", cafe);
		
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return "amCafeDetail.jsp";
	}

}
