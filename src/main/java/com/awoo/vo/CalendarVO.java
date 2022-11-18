package com.awoo.vo;

import org.apache.ibatis.type.Alias;

@Alias("calendarVO")
public class CalendarVO {
	private int calId;			// 일정 id 값
	private String calTitle;	// 일정 제목
	private String calPlace;	// 장소
	private String calContent;	// 내용
	private String calStart;	// 시작일
	private String calEnd;		// 종료일
	private int calRange;	// 날짜범위 여부
	private String calAllday;	// 종일여부
	private String calShow;		// 공개 (0),비공개 (사원번호)
	private String calRecur;	// 반복 일정 여부 (매주,매월,매년)
	private int empno;			// 사원번호(작성자)
	private int checkAdmin;		// 관리자여부
	private String approval;	// 승인신청여부
	private String ename;		// 사원 이름
	
	public int getCalId() {
		return calId;
	}
	public void setCalId(int calId) {
		this.calId = calId;
	}
	public String getCalTitle() {
		return calTitle;
	}
	public void setCalTitle(String calTitle) {
		this.calTitle = calTitle;
	}
	public String getCalPlace() {
		return calPlace;
	}
	public void setCalPlace(String calPlace) {
		this.calPlace = calPlace;
	}
	public String getCalContent() {
		return calContent;
	}
	public void setCalContent(String calContent) {
		this.calContent = calContent;
	}
	public String getCalStart() {
		return calStart;
	}
	public void setCalStart(String calStart) {
		this.calStart = calStart;
	}
	public String getCalEnd() {
		return calEnd;
	}
	public void setCalEnd(String calEnd) {
		this.calEnd = calEnd;
	}
	public int getCalRange() {
		return calRange;
	}
	public void setCalRange(int calRange) {
		this.calRange = calRange;
	}
	public String getCalAllday() {
		return calAllday;
	}
	public void setCalAllday(String calAllday) {
		this.calAllday = calAllday;
	}
	public String getCalShow() {
		return calShow;
	}
	public void setCalShow(String calShow) {
		this.calShow = calShow;
	}
	public String getCalRecur() {
		return calRecur;
	}
	public void setCalRecur(String calRecur) {
		this.calRecur = calRecur;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public int getCheckAdmin() {
		return checkAdmin;
	}
	public void setCheckAdmin(int checkAdmin) {
		this.checkAdmin = checkAdmin;
	}
	public String getApproval() {
		return approval;
	}
	public void setApproval(String approval) {
		this.approval = approval;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
}
