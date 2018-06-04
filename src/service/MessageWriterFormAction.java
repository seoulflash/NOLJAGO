package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Message;
import dao.MessageDAO;

public class MessageWriterFormAction implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			int mnum = 0;
			String pageNum = request.getParameter("pageNum");
			String id = request.getParameter("id");
			String toid = request.getParameter("fromid");
			if(pageNum==null)
				pageNum="1";
			if(request.getParameter("mnum")!=null){
				mnum = Integer.parseInt(request.getParameter("mbnum"));
				MessageDAO md = MessageDAO.getInstance();
				Message message = md.messageSelect(mnum);
			}
			request.setAttribute("fromid", id);
			request.setAttribute("toid", toid);
			request.setAttribute("mnum", mnum);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "messageWriterForm.jsp";
	}
}
