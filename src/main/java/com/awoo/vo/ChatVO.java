package com.awoo.vo;

import org.apache.ibatis.type.Alias;

@Alias("chatVO")
public class ChatVO {
	private int chId;
	private int empno;
	private String ename;
	private String chContent;
	private String chDate;
	private String chTime;
	
	public int getChId() {
		return chId;
	}
	public void setChId(int chId) {
		this.chId = chId;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getChContent() {
		return chContent;
	}
	public void setChContent(String chContent) {
		this.chContent = chContent;
	}
	public String getChDate() {
		return chDate;
	}
	public void setChDate(String chDate) {
		this.chDate = chDate;
	}
	public String getChTime() {
		return chTime;
	}
	public void setChTime(String chTime) {
		this.chTime = chTime;
	}
}
