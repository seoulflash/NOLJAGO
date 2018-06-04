package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MessageDAO;


public class MessageWriterProAction implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String fromid = request.getParameter("id");
		String toid = request.getParameter("toid");
		String mcontent = request.getParameter("mcontent");
		System.out.println("fromid : " + fromid);
		System.out.println("toid : " + toid);
		System.out.println("mcontent : " + mcontent);
		MessageDAO md = MessageDAO.getInstance();
		
		try {
			int result = md.messageInsert(fromid, toid, mcontent);
			request.setAttribute("result", result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "messageWriteResult.jsp";
	}
}