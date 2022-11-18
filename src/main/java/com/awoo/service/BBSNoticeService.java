package com.awoo.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.awoo.dao.BBSNoticeDAO;
import com.awoo.vo.BBSFileVO;
import com.awoo.vo.BBSVO;
import com.awoo.vo.PageVO;
import com.google.gson.Gson;

@Service
public class BBSNoticeService {
	
	private BBSNoticeDAO bbsDAO;
	
		public BBSNoticeService(BBSNoticeDAO bbsDAO) {
		super();
		this.bbsDAO = bbsDAO;
	}

	//공지사항 게시판----------------------------------------
	//게시판+페이징
	public void getBBSListNotice(Model model, int page, String searchType, String keyword) {
		PageVO vo = new PageVO();
		vo.setNowPage(page);
		vo.setCntPerPage(10);
		vo.setCntPerBlock(10);
		vo.setSearchType(searchType);
		vo.setKeyword(keyword);
		vo.setTotalRow(bbsDAO.selectBBSCountNotice(vo));
		
		if(!searchType.equals("")) {
			model.addAttribute("searchType", searchType);
			vo.setSearchType(searchType);
		}
		if(!keyword.equals("")) {
			model.addAttribute("keyword", keyword);
			vo.setKeyword(keyword);
		}
		
		vo.process();
		
//		System.out.println(vo);
		
		model.addAttribute("page", vo);
		model.addAttribute("list", bbsDAO.selectBBSListNotice(vo));
		
		BBSVO bvo = new BBSVO();
		bbsDAO.updateFileCountNotice(bvo);
	}

	
	//게시글 상세 보기
	public void selectBBSNotice(Model model, String id) {
		BBSVO vo = new BBSVO();
		vo.setId(Integer.parseInt(id));
		model.addAttribute("bbsVO", bbsDAO.selectBBSNotice(vo));
		
		BBSFileVO fvo = new BBSFileVO();
		fvo.setBbsId(vo.getId());

		List<BBSFileVO> filelist = bbsDAO.selectBBSFileNotice(fvo);
		model.addAttribute("filelist", filelist);
		
		model.addAttribute("countFiles", bbsDAO.countFilesNotice(id));
	}
	
	//추가
//	@Transactional
	public void insertBBSNotice(BBSVO vo2) {
		Gson gson = new Gson();
		
		BBSFileVO[] fileArray = gson.fromJson(vo2.getFilelist(), BBSFileVO[].class);
		List<BBSFileVO> fileList = Arrays.asList(fileArray);
		
		bbsDAO.insertBBSNotice(vo2);
		
		for (BBSFileVO fileVO : fileList) {
			fileVO.setBbsId(vo2.getId());
			bbsDAO.insertBBSFileNotice(fileVO);
		}
		bbsDAO.updateFileCountNotice(vo2);
	}
	
	//삭제
	public void deleteBBSNotice(BBSVO vo2) {
		bbsDAO.deleteBBSNotice(vo2);
		bbsDAO.updateFileCountNotice(vo2);
	}
	
	//수정
	public void updateBBSNotice(BBSVO vo2) {
		Gson gson = new Gson();

		BBSFileVO[] fileArray = gson.fromJson(vo2.getFilelist(), BBSFileVO[].class);

		bbsDAO.updateBBSNotice(vo2);
		
		if(fileArray != null) {
			List<BBSFileVO> fileList = Arrays.asList(fileArray);
		
			for (BBSFileVO fileVO : fileList) {
				fileVO.setBbsId(vo2.getId());
				bbsDAO.insertBBSFileNotice(fileVO);
			}
		}
		bbsDAO.updateFileCountNotice(vo2);
	}
	
	//카테고리
	public void getCateogryNotice(Model model) {
		model.addAttribute("categories", bbsDAO.selectCategoryNotice());
	}
	
	//조회수
	public void setViewCountNotice(String id) {
		bbsDAO.updateViewCountNotice(id);
	}
	
	//파일 삭제(전체 삭제)
	public void deleteBBSFileAllNotice(BBSFileVO fvo) {
		bbsDAO.deleteBBSFileNotice(fvo);
		BBSVO vo =new BBSVO();
		bbsDAO.updateFileCountNotice(vo);
	}
	
	//파일 삭제(개별 삭제)
//	@TRANSACTIONAL
	public void deleteBBSFileNotice(BBSFileVO[] fvos) {
		for (BBSFileVO fvo : fvos) {
			bbsDAO.deleteBBSFileNotice(fvo);
		}
		BBSVO vo =new BBSVO();
		bbsDAO.updateFileCountNotice(vo);
	}
	
}
