package util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail  {

	// 매개변수 : 발신자, 수신자, 제목, 내용
	public static void sendMail(String from, String to, String subject, String content) {
		// 1. 메일서버 정보 설정 (Property)
		Properties prop = System.getProperties();
		prop.put("mail.smtp.host", "smtp.naver.com");
		prop.put("mail.smtp.port", "465");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.protocols", "TLSv1.2"); // No appropriate protocal에러
		
		// 2. 인증을 위해 Session객체 생성
		Session session = Session.getDefaultInstance(prop, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("2do2023","!Engus101");
			}
		});
		session.setDebug(true);
		
		// 3. MimeMessage 객체 생성(발신자, 수신자, 제목, 내용 설정)
		try {
			MimeMessage mm = new MimeMessage(session);
			mm.setFrom(new InternetAddress(from)); // 발신자
			mm.setRecipient(Message.RecipientType.TO, new InternetAddress(to)); // 수신자
			mm.setSubject(subject); // 제목
			//mm.setText(content); // 내용(텍스트)
			mm.setContent(content, "text/html; charset=utf-8"); // 내용(html)
			
			// 4. 메일 발송
			Transport.send(mm);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
	}
	
	public static void main(String[] args) {
		sendMail("2do2023@naver.com", "eatdu0918@gmail.com", "test", "<b>한글</b>test content");
	}
}
