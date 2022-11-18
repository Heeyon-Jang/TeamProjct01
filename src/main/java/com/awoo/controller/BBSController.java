package com.awoo.controller;

import java.io.File;
import java.nio.channels.Channels;
import java.nio.channels.FileChannel;
import java.nio.channels.WritableByteChannel;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.awoo.service.BBSService;
import com.awoo.service.UploadfilesService;
import com.awoo.vo.BBSCommentVO;
import com.awoo.vo.BBSFileVO;
import com.awoo.vo.BBSVO;
import com.awoo.vo.PersonalInfoVO;
import com.awoo.vo.UploadfilesVO;

@Controller
@RequestMapping("/bbsPage")
public class BBSController {
	
	private BBSService service;

	public BBSController(BBSService service) {
		super();
		this.service = service;
	}

	//게시판 목록
	@GetMapping("/bbs")
	public String getBBSList(Model model, 
						  @RequestParam(value="page", defaultValue = "1") int page,
						  @RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
						  @RequestParam(value = "keyword",required = false, defaultValue = "") String keyword) {
		
		service.selectBBSList(model, page, searchType, keyword);
		return "bbsPage/bbs";
	}
	
	//게시글 상세 보기
	@GetMapping("/bbs/{id}")
	public String getBBSDetail(@SessionAttribute("personalInfoVO") PersonalInfoVO vo, 
							 Model model, @PathVariable("id") String id, 
							 HttpServletResponse response, HttpServletRequest req) {
		//조회수
		Cookie[] cookies = req.getCookies();
        Cookie viewCookie = null; // 비교하기 위해 새로운 쿠키

        // 쿠키가 있을 경우 
		if(cookies != null && cookies.length > 0) {
			for (Cookie cookie : cookies) {
				// Cookie의 name이 cookie + id와 일치하는 쿠키를 viewCookie에 넣어줌 
				if(cookie.getName().equals("cookie"+id)) {
                    viewCookie = cookie;
				}
			}
		}
        // 만일 viewCookie가 null일 경우 쿠키를 생성해서 조회수 증가 로직을 처리함.
        if (viewCookie == null) {    
            Cookie newCookie = new Cookie("cookie"+id, "|" + id + "|"); // 쿠키 생성(이름, 값)
            response.addCookie(newCookie); // 쿠키 추가
            service.updateViewCount(id); // 쿠키를 추가 시키고 조회수 증가시킴
        } else {
            String value = viewCookie.getValue(); // 쿠키 값 받아옴.
        }
		service.selectBBS(model, id, vo);
		
		return "bbsPage/content";
	}
	
	//글쓰기
	@GetMapping("/wrbtn")
	public String getBBSCreate(@ModelAttribute("BBSVO") BBSVO vo2, Model model) {
		service.selectCategory(model);
		return "bbsPage/set";			
	}
	
	//글쓰기(insert)
	@PostMapping("/set")
	public String setBBSCreate(@SessionAttribute("personalInfoVO") PersonalInfoVO vo, BBSVO vo2) {
		vo2.setOwnerId(Integer.toString(vo.getEmpno()));
		vo2.setOwner(vo.getName());
		
		service.insertBBS(vo2);		
		return "redirect:/bbsPage/bbs";
	}
	
	//삭제(delete)
	@GetMapping("/delete/{id}")
	public String deleteBBS(@SessionAttribute("personalInfoVO")PersonalInfoVO vo, @ModelAttribute("BBSVO") BBSVO vo2,
							 @PathVariable("id") String id) {
		vo2.setOwnerId(Integer.toString(vo.getEmpno()));
		vo2.setOwner(vo.getName());
		service.deleteBBS(vo2);
		return "redirect:/bbsPage/bbs";
	}

	//수정하기 선택(select)
	@GetMapping("/put/{id}")
	public String modifyBBS(@PathVariable("id")String id, Model model, @SessionAttribute("personalInfoVO") PersonalInfoVO vo) {
		service.selectBBS(model, id, vo);
		service.selectCategory(model);
		return "bbsPage/put";
	}
	
	//수정 결과(update)
	@PostMapping("/put")
	public String modifyBBSResult(@SessionAttribute("personalInfoVO")PersonalInfoVO vo, @ModelAttribute("bbsVO") BBSVO vo2) {
		vo2.setOwnerId(Integer.toString(vo.getEmpno()));
		vo2.setOwner(vo.getName());
		service.updateBBS(vo2);
		return "redirect:/bbsPage/bbs";
	}
	
	//댓글 불러오기-------------------------------------------
	@GetMapping("/comment/get/{bbsId}")
	@ResponseBody
	public ResponseEntity<List<BBSCommentVO>> getComments(@PathVariable("bbsId") String bbsId){
		BBSCommentVO cvo = new BBSCommentVO();
		cvo.setBbsId(Integer.parseInt(bbsId));
		List<BBSCommentVO> list = service.getCommentList(cvo);
		ResponseEntity<List<BBSCommentVO>> entity = new ResponseEntity<List<BBSCommentVO>>(list, HttpStatus.OK);
		return entity;
	}
	
	//댓글 달기
	@PostMapping("/comment/set")
	@ResponseBody
	public ResponseEntity<BBSCommentVO> setComments(@RequestBody BBSCommentVO vo){
		service.setComment(vo);
		ResponseEntity<BBSCommentVO> entity = new ResponseEntity<BBSCommentVO>(vo,HttpStatus.OK);
		return entity;
	}
	
	//댓글 삭제
	@DeleteMapping("/comment/delete")
	@ResponseBody
	public ResponseEntity<String> dropComment(@RequestBody BBSCommentVO vo){
		service.deleteComment(vo);
		String str = "삭제되었습니다";
		ResponseEntity<String> entity = new ResponseEntity<String>(str , HttpStatus.OK);
		return entity;
	}
	
	//댓글 수정
	@PatchMapping("/comment/update")
	@ResponseBody
	public ResponseEntity<BBSCommentVO> patchComment(@RequestBody BBSCommentVO vo){
		service.updateComment(vo);
		ResponseEntity<BBSCommentVO> entity = new ResponseEntity<BBSCommentVO>(vo, HttpStatus.OK);
		return entity;
	}
	
	//파일 업로드
	@PostMapping("/uploadfile")
	public @ResponseBody ResponseEntity<List<BBSFileVO>> uploadFile(MultipartFile[] uploadFile) throws Exception{
		ArrayList<BBSFileVO> list = new ArrayList<BBSFileVO>();
		
		for (MultipartFile file : uploadFile) {
			if(!file.getOriginalFilename().isEmpty()) {
				String name = UUID.randomUUID().toString();
				file.transferTo(new File("C:\\sample", name));
				list.add(new BBSFileVO(name, file.getOriginalFilename()));
			}else {
				System.out.println("업로드 파일 데이터가 존재하지 않습니다.");
			}
		}
		ResponseEntity<List<BBSFileVO>> response = new ResponseEntity<List<BBSFileVO>>(list,HttpStatus.OK);
		
		return response;
	}
	
	//파일 다운로드
	@GetMapping("/downloadFile/{clientname}/{servername}")
	public void downloadFile(
						HttpServletResponse response,
						@PathVariable String servername,
						@PathVariable String clientname) {
		try {String path = "C:/sample/"+servername;
			Path file = Paths.get(path);
			response.setHeader("Content-Disposition", "attachment;filename="+clientname);
			FileChannel fc = FileChannel.open(file, StandardOpenOption.READ);
			WritableByteChannel outputChannel = Channels.newChannel(response.getOutputStream());
			fc.transferTo(0, fc.size(), outputChannel);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//파일 전체 삭제
	@PostMapping("/deleteFileAll")
	public @ResponseBody ResponseEntity<String> deleteFileAll(@RequestBody BBSFileVO fvo){
		service.deleteBBSFileAll(fvo);
		return new ResponseEntity<String>("deleteFileAll Success", HttpStatus.OK);
	}
	
	//파일 개별 삭제
	@PostMapping("/deleteFile")
	public @ResponseBody ResponseEntity<String> deleteFile(@RequestBody BBSFileVO[] fvos){
		for (BBSFileVO fileVO : fvos) {
		}
		service.deleteBBSFile(fvos);
		return new ResponseEntity<String>("deleteFile Success", HttpStatus.OK);
	}
	
}
