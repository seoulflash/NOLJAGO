package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CafeDAO;

public class AmCafeAddFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String id = "aa";
			String password = "1234";
			String pageNum = request.getParameter("pageNum");
			if (pageNum == null)
				pageNum = "1";
			
			request.setAttribute("id", id);
			request.setAttribute("password", password);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return "amCafeAddForm.jsp";
	}

}
