package kr.or.gd.vo;

import java.util.List;

public class NoticeBoardVO {

	private String noti_postnum;
	private String noti_title;
	private String noti_cont;
	private String noti_writer;
	private String noti_viewhit;
	private String noti_sta;
	private String noti_regdate;
	private List<FileItemVO> attachFileInfo;
	
	
	public String getNoti_postnum() {
		return noti_postnum;
	}
	public void setNoti_postnum(String noti_postnum) {
		this.noti_postnum = noti_postnum;
	}
	public String getNoti_title() {
		return noti_title;
	}
	public void setNoti_title(String noti_title) {
		this.noti_title = noti_title;
	}
	public String getNoti_cont() {
		return noti_cont;
	}
	public void setNoti_cont(String noti_cont) {
		this.noti_cont = noti_cont;
	}
	public String getNoti_writer() {
		return noti_writer;
	}
	public void setNoti_writer(String noti_writer) {
		this.noti_writer = noti_writer;
	}
	public String getNoti_viewhit() {
		return noti_viewhit;
	}
	public void setNoti_viewhit(String noti_viewhit) {
		this.noti_viewhit = noti_viewhit;
	}
	public String getNoti_sta() {
		return noti_sta;
	}
	public void setNoti_sta(String noti_sta) {
		this.noti_sta = noti_sta;
	}
	public String getNoti_regdate() {
		return noti_regdate;
	}
	public void setNoti_regdate(String noti_regdate) {
		this.noti_regdate = noti_regdate;
	}
	public List<FileItemVO> getAttachFileInfo() {
		return attachFileInfo;
	}
	public void setAttachFileInfo(List<FileItemVO> attachFileInfo) {
		this.attachFileInfo = attachFileInfo;
	}


	
	
	
}
