package com.instagram.dto;

public class FileDto {
	
    private int fno;
    private int bno;
    private String fileName;     //저장할 파일
    private String fileOriName;  //실제 파일
    private String fileUrl;
	@Override
	public String toString() {
		return "File [fno=" + fno + ", bno=" + bno + ", fileName=" + fileName + ", fileOriName=" + fileOriName
				+ ", fileUrl=" + fileUrl + "]";
	}
	public int getFno() {
		return fno;
	}
	public void setFno(int fno) {
		this.fno = fno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileOriName() {
		return fileOriName;
	}
	public void setFileOriName(String fileOriName) {
		this.fileOriName = fileOriName;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}

    
}