package service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Cafe;
import dao.CafeDAO;
import dao.Member;
import dao.MemberDAO;

public class SearchAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String keyword = request.getParameter("keyword");
		System.out.println("keyword-->" + keyword);
		StringTokenizer strToken = new StringTokenizer(keyword, " ");	//공백으로 분리
		List<String> wordlist = new ArrayList<String>();
		while (strToken.hasMoreTokens()) {
			wordlist.add(strToken.nextToken());
		}
		
		int spacecnt = keyword.length() - keyword.replaceAll(" ", "").length();		//검색어의 공백숫자 세기
		System.out.println("spacecnt-->" + spacecnt);
		CafeDAO cd = CafeDAO.getInstance();
		
		try {
			// 회원정보 가져오는 DAO메소드
			MemberDAO md = MemberDAO.getInstance();
			Member member = new Member();
			member = md.getUserInfo(id);
			
			List<Cafe> cslist = cd.areaSearchClist(wordlist);	//지역별 검색어를 위한 메소드
			
			if (cslist == null || cslist.isEmpty()) {	//검색어에 해당하는 지역 카페결과가 없을 경우
				
				cslist = cd.nameSearchClist(wordlist);	//전체 키워드로 이름별 검색
				if (cslist == null || cslist.isEmpty()) {	//이름별도 없어?
					if(spacecnt == 1) {	//두 단어 존재
						cslist = cd.twoWordClist(wordlist.get(0), wordlist.get(1));
					} 
				}
			}
			
			request.setAttribute("member", member);
			
			request.setAttribute("cslist", cslist);
			request.setAttribute("keyword", keyword);
			request.setAttribute("id", id);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "searchResult.jsp";
	}

}
