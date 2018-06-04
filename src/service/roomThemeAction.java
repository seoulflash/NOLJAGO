package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Cafe;
import dao.CafeDAO;
import dao.Theme;

public class roomThemeAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		CafeDAO cd = CafeDAO.getInstance();
		
		try{
			int cnum=0, tnum=0;
			tnum=Integer.parseInt(request.getParameter("tnum"));
			cnum=Integer.parseInt(request.getParameter("cnum"));
			Cafe cafe = cd.r_list3(cnum);
			Theme theme = cd.r_theme(cnum,tnum);
			//int result = cd.good(cnum, tnum);

			request.setAttribute("cnum", cnum);
			request.setAttribute("tnum", tnum);
			request.setAttribute("cafe", cafe);
			request.setAttribute("theme", theme);
			//request.setAttribute("result", result);
			
			System.out.println("theme.tname->"+theme.getTname());
			System.out.println("theme.Timage->"+theme.getTimage());

		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		
		return "roomThemeView.jsp";
	}

}
