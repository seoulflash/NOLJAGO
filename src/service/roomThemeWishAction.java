package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CafeDAO;
import dao.Theme;

public class roomThemeWishAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		CafeDAO cd = CafeDAO.getInstance();

		try{
			String id = request.getParameter("id");
			int cnum=0, tnum=0;
			tnum=Integer.parseInt(request.getParameter("tnum"));
			cnum=Integer.parseInt(request.getParameter("cnum"));

			int result = cd.good(id, cnum, tnum);
			//Cafe cafe = cd.r_list3(cnum);
			Theme theme = cd.r_theme(cnum,tnum);
			
			request.setAttribute("result", result);
			request.setAttribute("cnum", cnum);
			request.setAttribute("tnum", tnum);
			//request.setAttribute("cafe", cafe);
			request.setAttribute("theme", theme);
			request.setAttribute("result", result);


		}catch(Exception e){
			System.out.println(e.getMessage());
		}


		return "roomListView.jsp";
	}

}
