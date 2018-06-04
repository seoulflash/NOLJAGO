package service;

import java.io.File;
import java.io.IOException;
import java.rmi.ServerException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.Member;
import dao.MemberDAO;

public class JoinAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServerException, IOException {
		
		MemberDAO md = MemberDAO.getInstance();
		Member member = new Member();
		String savePath = request.getServletContext().getRealPath("/Profileimg/");		//C:\Users\Administrator\Downloads
		String savefilename="";
		int sizeLimit = 5 * 1024 * 1024;
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		System.out.println("실제 파일 savePath : " + savePath );
		Enumeration en = multi.getFileNames();
		
		try {
			request.setCharacterEncoding("utf-8");
			while (en.hasMoreElements()) {
				String filename1 = (String)en.nextElement();
				//서버에 저장된 파일 이름
				savefilename = "Profileimg/"+multi.getFilesystemName(filename1);
				
				//전송전 원래의 파일 이름
				String original = multi.getOriginalFileName(filename1);
				
				//전송된 파일의 내용 타입
				String type = multi.getContentType(filename1);
				
				//전송된 파일속성이 file인 태그의 name 속성값을 이용해 파일 객체 생성
				File file = multi.getFile(filename1);
			}	
			member.setId(multi.getParameter("id"));
			member.setPassword(multi.getParameter("password"));
			member.setName(multi.getParameter("name"));
			member.setBirth(multi.getParameter("birth"));
			member.setImage(savefilename);
			member.setSex(multi.getParameter("sex"));
			member.setAddress(multi.getParameter("address"));
			member.setEmail(multi.getParameter("email"));
			member.setTel(multi.getParameter("tel"));
			member.setIntro(multi.getParameter("intro"));
			
			int result = md.join(member);
			if(result != 1)		return "join.jsp";
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "joinComplete.jsp";
	}
}
