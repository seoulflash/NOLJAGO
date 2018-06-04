package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MessageDAO;

public class MessageDeleteProAction implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		MessageDAO mdPro = MessageDAO.getInstance();
		int mnum = Integer.parseInt(request.getParameter("mnum"));
		
		try {
			int result = mdPro.messageDelete(mnum);
			request.setAttribute("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "messageDeleteResult.jsp";
}
}