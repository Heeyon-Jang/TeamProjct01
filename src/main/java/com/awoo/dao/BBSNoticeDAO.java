package com.awoo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.awoo.vo.BBSFileVO;
import com.awoo.vo.BBSVO;
import com.awoo.vo.PageVO;

@Mapper
public interface BBSNoticeDAO {
	
	//공지사항 게시판-------------------------
	public int selectBBSCountNotice(PageVO vo);
	
	public List<BBSVO> selectBBSListNotice(PageVO vo);
	
	public List<BBSVO> selectCategoryNotice();
	
	public BBSVO selectBBSNotice(BBSVO vo);
	
	public int insertBBSNotice(BBSVO vo);
	
	public int updateBBSNotice(BBSVO vo);
	
	public int deleteBBSNotice(BBSVO vo);
	
	public int updateViewCountNotice(String id);
	
	public int updateFileCountNotice(BBSVO vo);
	
	public int countFilesNotice(String id);
	
	//파일---------------------------------
	public int insertBBSFileNotice(BBSFileVO vo);
	
	public List<BBSFileVO> selectBBSFileNotice(BBSFileVO vo);
	
	public int deleteBBSFileNotice(BBSFileVO vo);
			
}
