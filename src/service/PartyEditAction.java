package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PartyDAO;

public class PartyEditAction implements CommandProcess {
		public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try{
				request.setCharacterEncoding("utf-8");
				String pageNum = request.getParameter("pageNum");
				String pContent = request.getParameter("pcontent");
				int max = Integer.parseInt(request.getParameter("max"));
				int pnum = Integer.parseInt(request.getParameter("pnum"));
				PartyDAO pd = PartyDAO.getInstance();
				int result = pd.partyEdit(pnum,max,pContent);
				request.setAttribute("pnum", pnum);
				request.setAttribute("pageNum", pageNum);
				request.setAttribute("result", result);
			}catch(Exception e){
				System.out.println(e.getMessage());
			}
			return "partyEdit.jsp";
		}
	}
