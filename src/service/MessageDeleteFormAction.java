package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Message;
import dao.MessageDAO;

public class MessageDeleteFormAction implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			int mnum = Integer.parseInt(request.getParameter("mnum"));
			String toid = request.getParameter("id");
			String pageNum = request.getParameter("pagenum");
			System.out.println("form pageNum--------->"+pageNum);
			MessageDAO md = MessageDAO.getInstance();
			Message message = md.messageSelect(mnum);
			request.setAttribute("mnum", mnum);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("toid", toid);
			request.setAttribute("message", message);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "messageDeleteForm.jsp";
	}
}