package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Cafe;
import dao.CafeDAO;

public class AmCafeUpdateProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try { 
			request.setCharacterEncoding("utf-8");
			String pageNum = request.getParameter("pageNum");
			Cafe cafe = new Cafe();
			cafe.setCnum(Integer.parseInt(request.getParameter("cnum")));
			cafe.setCname(request.getParameter("cname"));
			cafe.setCaddress(request.getParameter("caddress"));
			cafe.setOpen(Integer.parseInt(request.getParameter("open")));
			cafe.setClose(Integer.parseInt(request.getParameter("close")));
			cafe.setPrice(Integer.parseInt(request.getParameter("price")));
			cafe.setRedprice(Integer.parseInt(request.getParameter("redprice")));
			cafe.setType(request.getParameter("type"));
			cafe.setContent(request.getParameter("content"));
			cafe.setRoomcount(Integer.parseInt(request.getParameter("roomcount")));
			cafe.setCurl(request.getParameter("curl"));
			
			CafeDAO cd = CafeDAO.getInstance();
			int result = cd.update(cafe);
			
			request.setAttribute("result", result);
			request.setAttribute("cnum", cafe.getCnum());
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "amCafeUpdatePro.jsp";
	}
}
