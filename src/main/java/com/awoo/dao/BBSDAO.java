package com.awoo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.awoo.vo.BBSFileVO;
import com.awoo.vo.BBSVO;
import com.awoo.vo.PageVO;

@Mapper
public interface BBSDAO {
	
	public int selectBBSCount(PageVO vo);
	
	public List<BBSVO> selectBBSList(PageVO vo);
	
	public List<BBSVO> selectCategory();
	
	public BBSVO selectBBS(BBSVO vo);
	
	public int insertBBS(BBSVO vo);
	
	public int updateBBS(BBSVO vo);
	
	public int deleteBBS(BBSVO vo);
	
	public int updateViewCount(String id);
	
	public int updateFileCount(BBSVO vo);
	
	public int countFiles(String id);
	
	//파일---------------------------------
	public int insertBBSFile(BBSFileVO vo);
	
	public List<BBSFileVO> selectBBSFile(BBSFileVO vo);
	
	public int deleteBBSFile(BBSFileVO vo);
			
}
