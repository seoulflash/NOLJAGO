package service;

import java.io.IOException;
import java.security.SecureRandom;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CafeDAO;
import dao.MemberDAO;
import dao.ReservationDAO;

public class AmReservationAddFormAction implements CommandProcess {
	String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	SecureRandom rnd = new SecureRandom();
	ReservationDAO rd = ReservationDAO.getInstance();
	MemberDAO md = MemberDAO.getInstance();
	CafeDAO cd = CafeDAO.getInstance();
	
	public String randomString( int len ){
		StringBuilder sb = new StringBuilder( len );
		for( int i = 0; i < len; i++ ) 
			sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
		return sb.toString();
	}

	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			String id = request.getParameter("id");
			String password = md.getpassword(id); 
			String pageNum = request.getParameter("pageNum");
			int admin = md.getAdmin(id);
			if (admin == 2) {
				int cnum = cd.getCnum(id);
				request.setAttribute("cnum", cnum);
				int price = cd.getprice(cnum);
				request.setAttribute("price", price);
			}
			String resno = randomString(10);
			
			request.setAttribute("resno", resno);
			request.setAttribute("admin", admin);
			request.setAttribute("id", id);
			request.setAttribute("password", password);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}		
		
		return "amReservationAddForm.jsp";
	}
	
	


}
