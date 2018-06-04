package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board;
import dao.BoardDAO;
import dao.Member;
import dao.MemberDAO;

public class BoardContentAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
			try {
				request.setCharacterEncoding("utf-8");
				
				// 회원정보 가져오는 DAO메소드
				String id = request.getParameter("id");
				MemberDAO md = MemberDAO.getInstance();
				Member member = new Member();
				member = md.getUserInfo(id);
				
				int bnum = Integer.parseInt(request.getParameter("bnum"));
				int ref = Integer.parseInt(request.getParameter("ref"));
				String pageNum = request.getParameter("pageNum");
				
				BoardDAO bd = BoardDAO.getInstance();
				Board board = new Board();
				
				bd.readCount(bnum);					// 조회수 증가
				board = bd.select(bnum);			// 보드 정보 가져오는 메소드
				int replyTotCnt = bd.getTotalCnt(); // 게시판 게시물의 총합을 가져오는 메소드
				
				if (pageNum == null || pageNum.equals("")) {
					pageNum = "1";
				}
				int currentPage = Integer.parseInt(pageNum);
				int pageSize = 1000, blockSize = 1000;
				int startRow = (currentPage - 1) * pageSize + 1;
				int endRow = startRow + pageSize - 1;			
				int startNum = replyTotCnt - startRow + 1;				
				
				List<Board> replyList = bd.replyList(startRow, endRow, ref);
				List<Board> re_replyList = bd.re_replyList(startRow, endRow, ref);
				
				int pageCnt = (int) Math.ceil((double) replyTotCnt / pageSize);	//4 Page
				int startPage = (int) (currentPage - 1) / blockSize * blockSize + 1;
				int endPage = startPage + blockSize - 1;
				if (endPage > pageCnt)
					endPage = pageCnt;
				
				request.setAttribute("member", member);				// 멤버 정보
				
				request.setAttribute("replyTotCnt", replyTotCnt);	// 게시물의 총 개수
				request.setAttribute("replyList", replyList);		// 댓글
				request.setAttribute("re_replyList", re_replyList); // 댓글의 댓글
				request.setAttribute("board", board);				// 게시판 정보
				
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("startNum", startNum);
				request.setAttribute("blockSize", blockSize);
				request.setAttribute("pageCnt", pageCnt);
				request.setAttribute("startPage", startPage);
				request.setAttribute("endPage", endPage);
				request.setAttribute("pageNum", pageNum);
				
				request.setAttribute("bnum", bnum);
				request.setAttribute("pageNum", pageNum);
				
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		return "boardContent.jsp";
	}

}
