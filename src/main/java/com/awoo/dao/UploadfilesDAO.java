package com.awoo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.awoo.vo.UploadfilesVO;

@Mapper
public interface UploadfilesDAO {
	// empno 식별 : 사원 이미지
	public List<UploadfilesVO> selectFile(UploadfilesVO vo);
	// 사원 이미지 업로드
	public void uplaodFile(UploadfilesVO vo);
	// 사원 이미지 업데이트
	public void updateFile(UploadfilesVO vo);
	
}
