package com.awoo.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.awoo.dao.MailDAO;
import com.awoo.dao.MessageDAO;
import com.awoo.vo.MailVO;


@Service
public class MailService {

	private JavaMailSenderImpl mailSender;
	private MailDAO dao;	
	
	public MailService(JavaMailSenderImpl mailSender, MailDAO dao) {
		super();
		this.mailSender = mailSender;
		this.dao = dao;
	}

	
	public void getMailList(Model model){
		String sortingName = (String) model.getAttribute("sortingname");
		String sortingMonth = (String) model.getAttribute("sortingMonth");
		String sortingYear = (String) model.getAttribute("sortingYear");
		int empno = (int)model.getAttribute("empno");

		if (sortingMonth != null && sortingYear != null && sortingName != null) {
//			String sortedDay = sortingYear + "-" + sortingMonth;
			if (sortingMonth.equals("0") || sortingMonth == "0") {
				sortingMonth = null;
			}
			if (sortingYear.equals("0") || sortingYear == "0") {
				sortingYear = null;
			}
			if (sortingMonth != null && sortingMonth.length() == 1) {
				sortingMonth = "0" + sortingMonth;
			}
			if (sortingName.equals("0") || sortingName == "0") {
				sortingName = null;
			}
			
	
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("empno", empno);
			map.put("name", sortingName);
			map.put("year", sortingYear);
			map.put("month", sortingMonth);
		
		
			model.addAttribute("mailDataList", dao.getmailList(map));
			model.addAttribute("distinctYear", dao.getMailDistinctYear(map));
			model.addAttribute("distinctSender", dao.getMailDistinctSender(map));
		}
	}
	
	
	
	
	
	
	public void sendEmail(List<MailVO> mailList) {
		
	    MimeMessagePreparator[] preparators = new MimeMessagePreparator[mailList.size()];

	    int i = 0;
	    for(final MailVO mvo : mailList) {
	    	preparators[i++] =  new MimeMessagePreparator() {
	    		 @Override
	 	        public void prepare(MimeMessage mimeMessage) throws Exception {
	 	            final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
	 	            helper.setFrom(mvo.getSendFrom());
	 	            helper.setTo(mvo.getSendTo());
	 	            helper.setSubject(mvo.getTitle());
	 	            helper.setText(mvo.getContent(), true);
	 	            int filecnt = 0;
	             	for (int i = 0; i < mvo.getAttachment().length; i++) {
	             		MultipartFile multipartFile = mvo.getAttachment()[i];            		
	             		if(multipartFile.getOriginalFilename() != "") {
	             			filecnt += 1;
	             			// 파일 깨지지 말라고 encodeText 넣어줌
	             			String title = multipartFile.getOriginalFilename();
	             			helper.addAttachment(MimeUtility.encodeText(title,"EUC-KR","B"), multipartFile);
	             		}
	 	            }
	             	mvo.setCountFiles(filecnt);
	    		 }
	    		};
	    		dao.insertMail(mvo);
	    	}
	    //메일 보내는 곳!
	    	mailSender.send(preparators);
	    }
	    
	
	
	public MailVO getDetailMail(Model model) {
		
		int id = (int)model.getAttribute("id");	
		return dao.getDetailMail(id);
	}
	
	
	// 로그인 인증 메일 보내는 곳
	public void sendAuthMail(Map<String, Object> map) { 
		 
	    MimeMessagePreparator[] preparators = new MimeMessagePreparator[1];
    	preparators[0] =  new MimeMessagePreparator() {
    		 @Override 
 	        public void prepare(MimeMessage mimeMessage) throws Exception {
 	            final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
 	            helper.setFrom("awoogof@gmail.com");
 	            helper.setTo((String)map.get("mail"));
 	            helper.setSubject("[AWOO]인증번호입니다.");
 	            helper.setText(
 	            		
 	            		
 	            		"<p style=\"text-align:center\">&nbsp;</p>"
 	       	         + "\r\n"
 	       	         + "<p style=\"text-align:center\"><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHEAAAAyCAYAAABrsjQSAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAgeSURBVHhe7VsxaxtJFPbP2DaQJpDC6uIyghTWkSKCBE5guCCuMDoXh3CREynOESmMcBHMHTEiHAcyXMIGLiDnCKybgFwE5E4pAnIgBwqk2MLFFinevVnNrmZn3syOtNIRy/vBA3tnpJ2db9733sw+rUCOC4+cxCVATuISICdxCZCTuAQwkxiMoH/sgTdP++cFPN1rQev3F/Caal+Q/f3HAu/Jn+npX6/p9rnYAHxOiwwziZ86UF5ZgZXcvgFrQo/TIiMn8cLYrCT6PWjvogxZWG2d32y1Ag2iPbZft+Ded7fh9r0teES1a60GJf5AhY0G0W62X36Y4p6bJT5xBag8INpl489076dHdHvCGlBZ5XO1XiPaddaFIadFxtwSm94OH9jdDoz4tfmiB01OYvlwMXeIcdLkJJah84lfmxtG0LnL52pH51vTYW4kBqct9BQHKoe69ZIVPi4U9JDVGnTnPrESvnhQR28pbHYXsiAHB8zTS9A6DfiVbJgbifDVgwau3PYZ/98G5z74vg/Wj3LcgJU7ba2syAjwu31/ionC8QxPWSboQuPWChQfumFm2D/DMX7lfWZGAP5oAD2Waf5WRRKrsM/+PhnAaJoxEpgLicNXdSg6XCLQG0t7/VRihs+rcIXLo3Onk0JMAL3HRXCi/jfrqd44el4R+regrxvQVx/6L5tQue7w8evMgWvfN6FzMp1vBp882McYGz2r1q6WoPYE455uH2FAdhI/tOOEY2IONI5NNPahGZPOrIDSwpso4D2Kie9HqcOFoocQd7g1T3iTiDMXajeS/WxsbcuFYapn4uLYK8ULydoclNl30zGZmcT+XoEezH1XuzlFP4TOnWT/2it979FhOdE3tFsmWe2htIv9i9D+wJsinHWgklhI05mzYVIPVI6dNfJzdraGi85eYjOS2IdWlC4rVgX3C+9GoP84KV96zwrA2xa/N7IKuDplUzy3Ie2xRuBuEPJ5tQz1ZxgHT4dhrPb9EQxOXGhvl0k51GXJwbsmrCn9HSj+2ILOUQ8Go3Eu4J/1oXvYgupNYiyruC+05DEbiZiRFuSbC1Z9qfcu/1Ut2X/D1WSCuLXQeEz9Df2UwZt6sq8cc4lxOxttGJzzdgqU565irOXNE/jg3pf6oWc13pgkkmXequea5k9EJhL7uxopjcwkqbK3OE1iQhBEPIxM573Dg2Kin/M42U9uZ+m+IrcEhs+iQ4DICJkOcHuS6IP3f+ClJnrscw15kWxbfA6RgURVSqs/16UVbpBU5WFpeWRZ5qSPZGRcVOU3GW8JeTbGVwHEglLUwKYPidnHNTuJiiThJvwLQaxWEuTkxoHmO94UQ36wKlQTUoX3VL5eHoPsLWrman3K5HehJn4OTYmL8WnPxMjMmICaJOrPS0XMTKIipZvdUDqV6wZJlZMbNVGQtiIY2/pSLFVWuTLRalIzM4ksPoufQ5sniWoWvlASVY+LJUvxUL2kKsmNfJYoSVMYA6lrIuT7KwcJOYljGIlSs0mtpMrxQ5pwmeTGW3ZVWkApn5GTmpxEjjTJ7O1I+x6tpMqbclH65HgYxT/d9TFkiVYPEXISEaqUUg+SPG7SSao8oWXoxAfoeo+jPZSBbeKFz1BbgJxEhCKl1Ds3e0mVPScmBDfXYlVBIvZp46J8JisnNQw5iaqUaibAVlJlryoejP1Nvp7MQiWyojGMXKgIn6HHdulJVKW09CyZ+0UIjht2kionN/yUovdQuKbsBzVxUZpANalhuOwkKlJqOK4ijpGUBw4hJTfhKYW0WIiTi+RJjhNOlDwJ9JuRS05i6llpmmnkLZmMoFedGuJhBCIuxnU+oVFJDcOlJhEfQPKs6Y0uPEomNwWob5viYQQ5LjagkTjGo5IahgwkXvhjNxzc1G+pCaMkVdmgOyKpuveGxIGxaNpXWz50N6W+yqmOBlLGzEyRbCXkiFsgM5J5ABr5qkuFNYlKtplWX8otrkeNjFr1cnIjmuEk3/SGg05qxlBX/KyvooiyEsJbZ34Vxc+j02BJoiql0VYgDbKX6faVyZObiZnIMJFPJzUchKqE5RamuhnqpbBDyR0h16zc4q2JDrqcg04EVdiRqDy0LmkgYBNH8MGTyc3EzO/idHE6bXxDaMsKgeZcr0Dz0JuUT6CN3vfAfVIVqvkmVtIsZFZZoIaeK1Da3Ac3Lv1ghnn4UQead69IfdGcOnimSgMBViTKpyq2Wj0GEYOIeEUXXBnqaELo4qIuqRGQsVBq5YZpDrIWSjlmJZFgQaI6UWTKb4AiqUScUw8H0NbT32yrcm0ZgxBh1foMRDq3kcBULxlCd2sWIteQQLtQFcHKEwOU07h66yru43QlF1r0YT+u6NKV+g/BvS/IilPE1NyGCvG72fiq4E5ThY6S1t2twDULMkO5fan/nSCF0Ukb6uuEXCo2llvPLgwmYJnYIFgJPcqUN3M5O8Yh3MeVNcd0EYKjcan+wIY/AcMD3Cg/6GYotw/CEkJWwt/mv1wKf33FShiP+zDMWGoP56z80YPu4T7/1VUJarv70DnyoPd+lOlnAtYkDv9kpwniq6IpcY4ZKJuYbc+wkgOMjeMfzUzlTfiN3jbG1HUbmbOA1VhnRzSX7Q8ZFwaHJYmTtNk27VUQn2TQpzZjTI61prqP8PbC9nTECKuxzgphC/K//LQt/6XwN2T6I7icxAtjOYlLYLOSyDK2+HRhXvYZPn78iPaZaFug/bvIe/Jn+ky1zcv0SZBlYpPjW0ZO4hIgJ3EJkJO4BMhJvPAA+A8ybJdd3LJ/MQAAAABJRU5ErkJggg==\" /></p>"
 	       	         + "\r\n"
 	       	         + "<p style=\"text-align:center\"><span style=\"font-size:16px\"><span style=\"color:#8e44ad\">[AWOO] </span>직원 회원가입을 위&nbsp;한 <span style=\"color:#8e44ad\">보안 인증 메일</span>입니다.</span></p>"
 	       	         + "\r\n"
 	       	         + "<p style=\"text-align:center\">아래 &nbsp;번호를 입력하여 초기비밀번호를 수정 해주세요.</p>"
 	       	         + "\r\n"
 	       	         + "<p style=\"text-align:center\"><span style=\"font-size:36px\"><span style=\"background-color:#d7d4fb\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+map.get("random").toString()+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></p>"
 	       	         + "\r\n"
 	       	         + "<p style=\"text-align:center\">&nbsp;</p>"
 	       	         + "\r\n"
 	       	         + "<p style=\"text-align:center\"><span style=\"font-family:Courier New,Courier,monospace\"><span style=\"font-size:8px\">COPYRIGHT @ AWOO ALL RIGHTS RESERVED</span></span></p>"
 	       	         + "\r\n"
 	       	         +" <p>&nbsp;</p>"
 	            		, true);
 	            
 	            
 	            
 	          

 	            
 	            
 	            
 	            
 	            }
			};
		//메일 보내는 곳!
			mailSender.send(preparators);
		}
	    
	
}

