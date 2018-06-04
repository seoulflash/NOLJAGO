package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Message;
import dao.MessageDAO;


public class MessageContentAction implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			int mnum = Integer.parseInt(request.getParameter("mnum"));
			String pageNum = request.getParameter("pageNum");
			MessageDAO md = MessageDAO.getInstance();
			Message message = md.messageSelect(mnum);
			
			request.setAttribute("mnum", mnum);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("message", message);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	return "messageContent.jsp";
	}
}