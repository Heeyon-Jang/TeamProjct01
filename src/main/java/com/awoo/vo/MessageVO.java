package com.awoo.vo;

import org.apache.ibatis.type.Alias;

@Alias("messageVO")
public class MessageVO {
	private int id;
	private int mownerId;
	private String ownerName;
	private String mcontent;
	private String msendDate;
	private int mreceiverId;
	private String receiverName;
	private int view;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMownerId() {
		return mownerId;
	}
	public void setMownerId(int mownerId) {
		this.mownerId = mownerId;
	}
	public String getOwnerName() {
		return ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	public String getMcontent() {
		return mcontent;
	}
	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}
	public String getMsendDate() {
		return msendDate;
	}
	public void setMsendDate(String msendDate) {
		this.msendDate = msendDate;
	}
	public int getMreceiverId() {
		return mreceiverId;
	}
	public void setMreceiverId(int mreceiverId) {
		this.mreceiverId = mreceiverId;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public int getView() {
		return view;
	}
	public void setView(int view) {
		this.view = view;
	}

	
}
