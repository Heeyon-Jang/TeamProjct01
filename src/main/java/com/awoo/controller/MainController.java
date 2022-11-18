package com.awoo.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.awoo.service.CommutingService;
import com.awoo.service.UploadfilesService;
import com.awoo.vo.PersonalInfoVO;
import com.awoo.vo.UploadfilesVO;
@Controller
public class MainController {
	// 출근 퇴근 값 넣기위한 service 자동주입
		
		private CommutingService service;
		private UploadfilesService Uservice;
		
		public MainController(CommutingService service, UploadfilesService uservice) {
			super();
			this.service = service;
			Uservice = uservice;
		}
		
		@RequestMapping("MoveToHome")
		public String MoveToHome(@SessionAttribute("personalInfoVO") PersonalInfoVO vo,UploadfilesVO uvo,
								Model model) {
			model.addAttribute("ename", vo.getName());
			model.addAttribute("empno", vo.getEmpno());
			service.getDefaultData(model);
			
			// 홈에 값 가져오는 애들 ---------------------------------------------
			
			service.getDateForHome(model);
			uvo.setOwnerId(vo.getEmpno());
			Uservice.selectFile(uvo, model);
			return "home/home";
		}
		// 출근 버튼 눌렀을 때
		@GetMapping("/CommutingEnter")
		public String enter(@SessionAttribute("personalInfoVO") PersonalInfoVO vo,
							Model model) {
			model.addAttribute("empno", vo.getEmpno());
			service.insertEnter(model);
			return "redirect:/MoveToHome";
		}
		// 퇴근 버튼 눌렀을 때
		@GetMapping("/CommutingLeave")
		public String leave(@SessionAttribute("personalInfoVO") PersonalInfoVO vo,
							Model model) {
			model.addAttribute("empno", vo.getEmpno());
			service.insertLeave(model);
			return "redirect:/MoveToHome";
		}
		
		// 뉴스 api 
		@ResponseBody
	    @GetMapping(value = "/news", produces = "application/text; charset=UTF-8")
	    public String response() throws UnsupportedEncodingException {
	    	
	    	 String clientId = "FOHTgiZwvwvVP53BJmYI"; //애플리케이션 클라이언트 아이디
	         String clientSecret = "2eGk61b40C"; //애플리케이션 클라이언트 시크릿


	         String text = null;
	         try {
	             text = URLEncoder.encode("경제", "UTF-8");
	         } catch (UnsupportedEncodingException e) {
	             throw new RuntimeException("검색어 인코딩 실패",e);
	         }


	         String apiURL = "https://openapi.naver.com/v1/search/news?display=7&query=" + text;    // JSON 결과


	         Map<String, String> requestHeaders = new HashMap<>();
	         requestHeaders.put("X-Naver-Client-Id", clientId);
	         requestHeaders.put("X-Naver-Client-Secret", clientSecret);
	         String responseBody = get(apiURL,requestHeaders);

	         
//	         System.out.println(responseBody);

	    	return responseBody;
	    }
	    
	    private static String get(String apiUrl, Map<String, String> requestHeaders){
	        HttpURLConnection con = connect(apiUrl);
	        try {
	            con.setRequestMethod("GET");
	            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	                con.setRequestProperty(header.getKey(), header.getValue());
	            }


	            int responseCode = con.getResponseCode();
	            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	                return readBody(con.getInputStream());
	            } else { // 오류 발생
	                return readBody(con.getErrorStream());
	            }
	        } catch (IOException e) {
	            throw new RuntimeException("API 요청과 응답 실패", e);
	        } finally {
	            con.disconnect();
	        }
	    }


	    private static HttpURLConnection connect(String apiUrl){
	        try {
	            URL url = new URL(apiUrl);
	            return (HttpURLConnection)url.openConnection();
	        } catch (MalformedURLException e) {
	            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
	        } catch (IOException e) {
	            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
	        }
	    }


	    private static String readBody(InputStream body){
	        InputStreamReader streamReader = new InputStreamReader(body);


	        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	            StringBuilder responseBody = new StringBuilder();


	            String line;
	            while ((line = lineReader.readLine()) != null) {
	                responseBody.append(line);
	            }


	            return responseBody.toString();
	        } catch (IOException e) {
	            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
	        }
	    }
}
