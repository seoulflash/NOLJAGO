package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CafeDAO;

public class AmCafeDeleteProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			int cnum = Integer.parseInt(request.getParameter("cnum"));
			String pageNum = request.getParameter("pageNum");
			CafeDAO cd = CafeDAO.getInstance();
			int result = cd.cafeDelete(cnum);
			request.setAttribute("result", result);
			request.setAttribute("cnum", cnum);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "amCafeDeletePro.jsp";
	}

}
