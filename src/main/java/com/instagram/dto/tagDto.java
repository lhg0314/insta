package com.instagram.dto;

public class tagDto {
	private int imgNo;
	private String tag;
	public int getImgNo() {
		return imgNo;
	}
	public void setImgNo(int imgNo) {
		this.imgNo = imgNo;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	@Override
	public String toString() {
		return "tagDto [imgNo=" + imgNo + ", tag=" + tag + "]";
	}
	
	
	
}
