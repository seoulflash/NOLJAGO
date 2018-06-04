package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CafeDAO;
import dao.MemberDAO;
import dao.Theme;

public class VrLike2Action implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
			String id = request.getParameter("id");
			int cnum=Integer.parseInt(request.getParameter("cnum"));
			int tnum=Integer.parseInt(request.getParameter("tnum"));
		try{
			
			MemberDAO md= MemberDAO.getInstance();
			int logincheck = md.logincheck(id);
			if(logincheck == 1) {
				CafeDAO cd = CafeDAO.getInstance();
				Theme theme=cd.v_theme(cnum, tnum);
				int result=cd.deleteGood(id, cnum, tnum);	//좋아요 두번 클릭 시 삭제
				int num=cd.good_num2(cnum, tnum);	//테마에 대한 좋아요 개수 출력
				
				request.setAttribute("theme", theme);
				request.setAttribute("cnum", cnum);
				request.setAttribute("tnum", tnum);
				request.setAttribute("id", id);
				request.setAttribute("result", result);
				request.setAttribute("num", num);
				System.out.println("num : " +num);
			} else return "login.jsp";

		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return "vrLikeResult.jsp";
	}

}
