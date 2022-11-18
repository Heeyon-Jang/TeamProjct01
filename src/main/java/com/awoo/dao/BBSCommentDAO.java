package com.awoo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.awoo.vo.BBSCommentVO;

@Mapper
public interface BBSCommentDAO {
	
	public List<BBSCommentVO> selectCommentList(BBSCommentVO cvo);
	
	public int insertComment(BBSCommentVO vo);
	
	public int updateComment(BBSCommentVO vo);
	
	public int deleteComment(BBSCommentVO vo);
}
