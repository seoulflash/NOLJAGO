package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Member;
import dao.MemberDAO;
import dao.Message;
import dao.MessageDAO;

public class MessageListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String id = request.getParameter("id");
			String pageRcvNum = request.getParameter("pageRcvNum");
			String pageSndNum = request.getParameter("pageSndNum");
			MemberDAO memberDAO = MemberDAO.getInstance();
			Member member = new Member();
			//회원 정보 가져오는 메소드
			member = memberDAO.getUserInfo(id);
			
			MessageDAO md = MessageDAO.getInstance();
			int totCnt = md.getTotalCnt(id);
			int totRcv = md.getRcvCnt(id);
			if (pageRcvNum == null || pageRcvNum.equals("")) {
				pageRcvNum = "1";
			}
			if (pageSndNum == null || pageSndNum.equals("")) {
				pageSndNum = "1";
			}
			
			int currentRcvPage = Integer.parseInt(pageRcvNum);
			int currentSndPage = Integer.parseInt(pageSndNum);
			
			int pageRcvSize = 10, blockRcvSize = 10;
			int pageSndSize = 10, blockSndSize = 10;
			
			int startRcvRow = (currentRcvPage - 1) * pageRcvSize + 1; // 1
			int startSndRow = (currentSndPage - 1) * pageSndSize + 1; // 1
			
			int startRcvNum = totRcv - startRcvRow + 1; // 38
			int startSendNum = totCnt - startSndRow + 1; // 38
			
			int endRcvRow = startRcvRow + pageRcvSize - 1; // 10
			if (endRcvRow > totRcv)
				endRcvRow = totRcv;
			
			int endSendRow = startSndRow + pageSndSize - 1; // 10
			if (endSendRow > totCnt)
				endSendRow = totCnt;
			
			
			// 여기 메소드 부분 받은거 보낸거로 정리해서 게시물로 뿌려줘야함 - 내일 해야함
			List<Message> sendList = md.sendList(id);
			List<Message> rcvList = md.rcvList(id);
//			List<Message> list2 = new ArrayList<Message>();
//			for (int i = startRow - 1; i < endSendRow; i++)
//				list2.add(list.get(i));
			
			int pageRcvCnt = (int) Math.ceil((double) totRcv / pageRcvSize); // 4 Page
			int pageSendCnt = (int) Math.ceil((double) totCnt / pageSndSize); // 4 Page
			
			int startRcvPage = (int) (currentRcvPage - 1) / blockRcvSize * blockRcvSize + 1;
			int startSndPage = (int) (currentSndPage - 1) / blockSndSize * blockSndSize + 1;
			
			int endRcvPage = startRcvPage + blockRcvSize - 1;
			if(endRcvPage > pageRcvCnt)
				endRcvPage = pageRcvCnt;
			
			int endSendPage = startSndPage + blockSndSize - 1;
			if (endSendPage > pageSendCnt)
				endSendPage = pageSendCnt;
			
			request.setAttribute("member", member);
			
			request.setAttribute("pageRcvNum", pageRcvNum);
			request.setAttribute("pageSndNum", pageSndNum);
			
			request.setAttribute("currentRcvPage", currentRcvPage);
			request.setAttribute("currentSndPage", currentSndPage);
			
			request.setAttribute("blockRcvSize", blockRcvSize);
			request.setAttribute("blockSndSize", blockSndSize);
			
			request.setAttribute("startRcvPage", startRcvPage);
			request.setAttribute("startSndPage", startSndPage);
			
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("startSendNum", startSendNum);
			request.setAttribute("endSendPage", endSendPage);
			request.setAttribute("pageSendCnt", pageSendCnt);
			request.setAttribute("sendList", sendList);
			
			request.setAttribute("totRcv", totRcv);
			request.setAttribute("startRcvNum", startRcvNum);
			request.setAttribute("endRcvPage", endRcvPage);
			request.setAttribute("pageRcvCnt", pageRcvCnt);
			request.setAttribute("rcvList", rcvList);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "messageList.jsp";
	}

}
