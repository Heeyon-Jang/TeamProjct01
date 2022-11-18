package com.awoo.vo;

import org.springframework.web.multipart.MultipartFile;

public class MailVO {
	private int id;
	private int empno;
	private String name;
	private String sendFrom;
	private String sendTo;
	private String sendDate;
	private String title;
	private String content;
	private int countFiles;
	private int showHide;
	private MultipartFile[] attachment;
	
	
	
	public String getSendFrom() {
		return sendFrom;
	}
	public void setSendFrom(String sendFrom) {
		this.sendFrom = sendFrom;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSendTo() {
		return sendTo;
	}
	public void setSendTo(String sendTo) {
		this.sendTo = sendTo;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getCountFiles() {
		return countFiles;
	}
	public void setCountFiles(int countFiles) {
		this.countFiles = countFiles;
	}
	public int getShowHide() {
		return showHide;
	}
	public void setShowHide(int showHide) {
		this.showHide = showHide;
	}
	public MultipartFile[] getAttachment() {
		return attachment;
	}
	public void setAttachment(MultipartFile[] attachment) {
		this.attachment = attachment;
	}
	
	
	
}
