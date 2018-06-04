package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CafeDAO;
import dao.MemberDAO;
import dao.Theme;

public class RoomlikeAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
			String id = request.getParameter("id");
			MemberDAO md= MemberDAO.getInstance();
			int logincheck = md.logincheck(id);
			if(logincheck == 1) {
			int cnum=Integer.parseInt(request.getParameter("cnum"));
			int tnum=Integer.parseInt(request.getParameter("tnum"));
			CafeDAO cd = CafeDAO.getInstance();
			Theme theme=cd.r_theme(cnum, tnum);
			int result=cd.good(id, cnum, tnum);
			//List<Good> good_list=cd.good_list(cnum,tnum);

			request.setAttribute("theme", theme);
			request.setAttribute("result", result);
			request.setAttribute("cnum", cnum);
			request.setAttribute("tnum", tnum);
			request.setAttribute("id", id);
			//request.setAttribute("good_list", good_list);
			//request.setAttribute("good", good);
			}else return "login.jsp";
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return "RoomLikeView.jsp";
	}
}
