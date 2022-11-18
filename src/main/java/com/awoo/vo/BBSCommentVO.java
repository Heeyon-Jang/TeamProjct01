package com.awoo.vo;

import org.apache.ibatis.type.Alias;

@Alias("BBSCommentVO")
public class BBSCommentVO {
	private int id;
	private int bbsId;
	private int ownerId;
	private String owner;
	private String comment;
	private String createDate;
	private int orderId;
	private int isDelete;
	private String edepartment;
	private String eposition;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBbsId() {
		return bbsId;
	}
	public void setBbsId(int bbsId) {
		this.bbsId = bbsId;
	}
	public int getOwnerId() {
		return ownerId;
	}
	public void setOwnerId(int ownerId) {
		this.ownerId = ownerId;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}
	public String getEdepartment() {
		return edepartment;
	}
	public void setEdepartment(String edepartment) {
		this.edepartment = edepartment;
	}
	public String getEposition() {
		return eposition;
	}
	public void setEposition(String eposition) {
		this.eposition = eposition;
	}
	@Override
	public String toString() {
		return "BBSCommentVO [id=" + id + ", bbsId=" + bbsId + ", ownerId=" + ownerId + ", owner=" + owner
				+ ", comment=" + comment + ", createDate=" + createDate + ", orderId=" + orderId + ", isDelete="
				+ isDelete + "]";
	}

	
}
