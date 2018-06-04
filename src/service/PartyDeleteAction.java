package service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;
import dao.Party;
import dao.PartyDAO;

public class PartyDeleteAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		try{
			request.setCharacterEncoding("utf-8");
			String id = request.getParameter("id");
			MemberDAO md = MemberDAO.getInstance();
			Member member = md.getUserInfo(id);	//파티장의 정보가 담겨있음

			int pnum = Integer.parseInt(request.getParameter("pnum"));
			String pageNum = request.getParameter("pageNum");			PartyDAO pd = PartyDAO.getInstance();
			Party party = pd.partyInfo(pnum);	//돈을 받아오기 위한 메소드
			int point = party.getPrice();		//반환해줄 가격
			int result1 = 0;		//포인트 업데이트 성공여부

			result1 = pd.pmemUpdatePoint(pnum, point);	//0이면 돈 돌려주다 문제 발생, 1이면 성공
			if (result1 == 1) {
				int result = pd.partyDelete(pnum);
				request.setAttribute("pnum", pnum);
				request.setAttribute("pageNum", pageNum);
				request.setAttribute("result", result);
				request.setAttribute("result1", result1);
				request.setAttribute("member", member);
			} else {	//환불에서 문제발생
				request.setAttribute("pnum", pnum);
				request.setAttribute("pageNum", pageNum);
				request.setAttribute("result", 0);
				request.setAttribute("result1", result1);
				request.setAttribute("member", member);
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return "partyDelete.jsp";
	}
}
