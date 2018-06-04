package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Cafe;
import dao.CafeDAO;

public class AmCafeAddProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
			String pageNum = request.getParameter("pageNum");
			Cafe cafe = new Cafe();
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
			int result = cd.cafeAdd(cafe);
			request.setAttribute("result", result);
			request.setAttribute("pageNum", pageNum);
			System.out.println("----------------------------");
			System.out.println(result);
			System.out.println("---------------------------");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return "amCafeAddPro.jsp";
	}

}
