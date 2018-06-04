package service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;

public class FindPwdAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String tempPwd = getTempPwd(10);
		String id = request.getParameter("findid");
		String email = request.getParameter("findemail2");
		System.out.println(id);
		System.out.println(email);
		System.out.println(tempPwd);
		MemberDAO md = MemberDAO.getInstance();
		try {
			int pwdResult = md.updateTempPwd(id, email, tempPwd);
			int mailResult = 0;
			if(pwdResult == 1) {
				mailResult = sendEmail(email, tempPwd);
			} else {
				mailResult = 0;
			}
			request.setAttribute("mailResult", mailResult);
			System.out.println("pwdResult : " + pwdResult);
			System.out.println("mailResult : " + mailResult);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return "findPwdResult.jsp";
	}
	public String getTempPwd(int length) {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6',
				'7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
				'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
				'V', 'W', 'X', 'Y', 'Z' };

		int idx = 0;
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < length; i++) {
			idx = (int) (charSet.length * Math.random()); // 36 * 생성된 난수를 int로 추출
			sb.append(charSet[idx]);
		}
		return sb.toString();
	}
	public int sendEmail(String email, String tempPwd) {
		int result = 0;
		
		 // 메일 관련 정보
        String host = "smtp.naver.com";
        final String username = "kunagisi@naver.com";
        final String password = "Rlaekfqhd89!";
        int port=465;
         
        // 메일 내용
        String recipient = email;
        String subject = "놀자GO! 임시비밀번호 발송 메일입니다.";
        String body = "회원님의 임시 비밀번호는 [" + tempPwd + "]입니다.";
        try {  
		    Properties props = System.getProperties();
		         
		    props.put("mail.smtp.host", host);
		    props.put("mail.smtp.port", port);
		    props.put("mail.smtp.auth", "true");
		    props.put("mail.smtp.ssl.enable", "true");
		    props.put("mail.smtp.ssl.trust", host);
		          
		    Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
		        String un= username;
		        String pw= password;
		        protected PasswordAuthentication getPasswordAuthentication() {
		            return new PasswordAuthentication(un, pw);
		        }
		    });
		    session.setDebug(true); //for debug
	    
	        
		    Message mimeMessage = new MimeMessage(session);
		    mimeMessage.setFrom(new InternetAddress(username));
		    mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
		    mimeMessage.setSubject(subject);
		    mimeMessage.setText(body);
		    Transport.send(mimeMessage);
		    result = 1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			result = 0;
		}
		return result;
	}
}
