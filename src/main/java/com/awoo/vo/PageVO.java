package com.awoo.vo;

public class PageVO {
	// 현재 페이지
	private int nowPage;
	// 시작 페이지
	private int startPage;
	// 종료 페이지
	private int endPage;
	// 전체 페이지
	private int totalPage;
	// 총 row의 갯수
	private int totalRow;
	// 현재 페이지에 보이는 시작 row
	private int startRow;
	// 현재 페이지에 보이는 끝 row
	private int endRow;
	// 페이지 당 row 갯수 // 15
	private int cntPerPage;
	// 블록 당 페이지 갯수 // 10
	private int cntPerBlock;
	// 옵션
	private String searchType;
	// 키워드
	private String keyword;

	public int getNowPage() {return nowPage;}
	public void setNowPage(int nowPage) {this.nowPage = nowPage;}
	public int getStartPage() {return startPage;}
	public void setStartPage() {this.startPage = ((this.nowPage - 1)/this.cntPerBlock)*this.cntPerBlock+1;}
	public int getEndPage() {return endPage;}
	public void setEndPage() {
		this.endPage = ((this.nowPage - 1)/this.cntPerBlock)*this.cntPerBlock+this.cntPerBlock;
		this.endPage = (this.totalPage < this.endPage)?this.totalPage:this.endPage;}
	public int getTotalPage() {return totalPage;}
	public void setTotalPage() {
		this.totalPage = (this.totalRow%this.cntPerPage==0)?(this.totalRow/this.cntPerPage):(this.totalRow/this.cntPerPage+1);}
	public int getTotalRow() {return totalRow;}
	public void setTotalRow(int totalRow) {	this.totalRow = totalRow;}
	public int getStartRow() {return startRow;}
	public void setStartRow() {	this.startRow = ((this.nowPage-1)*this.cntPerPage+1)-1;}
	public int getEndRow() {return endRow;}
	public void setEndRow() {
		int init = (this.nowPage-1)*this.cntPerPage+this.cntPerPage;
		this.endRow = (init > this.totalRow)?this.totalRow:init;}
	public int getCntPerPage() {return cntPerPage;}
	public void setCntPerPage(int cntPerPage) {this.cntPerPage = cntPerPage;}
	public int getCntPerBlock() {return cntPerBlock;}
	public void setCntPerBlock(int cntPerBlock) {this.cntPerBlock = cntPerBlock;}

	public void process() {
		this.setTotalPage();
		this.setStartPage();
		this.setEndPage();
		this.setStartRow();
		this.setEndRow();
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	public String getSearchTypeKeyword() {

		if(searchType.equals("") || keyword.equals("")) {
			return "";	
		} else {
			return "&searchType=" + searchType + "&keyword=" + keyword;	
		}
	}



}




