package com.awoo.vo;

import org.apache.ibatis.type.Alias;

@Alias("BBSVO")
public class BBSVO {
	private int id;
	private String category;
	private String title;
	private String ownerId;
	private String owner;
	private String content;
	private String createDate;
	private String isDelete;
	private int viewCounts;
	private String filelist;
	private int fileCounts;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getOwnerId() {
		return ownerId;
	}
	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}
	public int getViewCounts() {
		return viewCounts;
	}
	public void setViewCounts(int viewCounts) {
		this.viewCounts = viewCounts;
	}
	public String getFilelist() {
		return filelist;
	}
	public void setFilelist(String filelist) {
		this.filelist = filelist;
	}
	public int getFileCounts() {
		return fileCounts;
	}
	public void setFileCounts(int fileCounts) {
		this.fileCounts = fileCounts;
	}
	@Override
	public String toString() {
		return "BBSVO [id=" + id + ", category=" + category + ", title=" + title + ", ownerId=" + ownerId + ", owner="
				+ owner + ", content=" + content + ", createDate=" + createDate + ", isDelete=" + isDelete
				+ ", viewCounts=" + viewCounts + ", filelist=" + filelist + ", fileCounts=" + fileCounts + "]";
	}
	
	
}
