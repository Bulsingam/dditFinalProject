package kr.or.gd.vo;

import java.util.List;

public class AnonymousBoardVO {

	private String rnum;
	private String any_postnum;
	private String any_title;
	private String any_cont;
	private String any_writer;
	private String any_postseq;
	private String any_postgroup;
	private String any_postdep;
	private String any_viewhit;
	private String any_sta;
	private String any_regdate;
	private List<FileItemVO> attachFileInfo;
	
	public String getAny_postnum() {
		return any_postnum;
	}
	public void setAny_postnum(String any_postnum) {
		this.any_postnum = any_postnum;
	}
	public String getAny_title() {
		return any_title;
	}
	public void setAny_title(String any_title) {
		this.any_title = any_title;
	}
	public String getAny_cont() {
		return any_cont;
	}
	public void setAny_cont(String any_cont) {
		this.any_cont = any_cont;
	}
	public String getAny_writer() {
		return any_writer;
	}
	public void setAny_writer(String any_writer) {
		this.any_writer = any_writer;
	}
	public String getAny_postseq() {
		return any_postseq;
	}
	public void setAny_postseq(String any_postseq) {
		this.any_postseq = any_postseq;
	}
	public String getAny_postgroup() {
		return any_postgroup;
	}
	public void setAny_postgroup(String any_postgroup) {
		this.any_postgroup = any_postgroup;
	}
	public String getAny_postdep() {
		return any_postdep;
	}
	public void setAny_postdep(String any_postdep) {
		this.any_postdep = any_postdep;
	}
	public String getAny_viewhit() {
		return any_viewhit;
	}
	public void setAny_viewhit(String any_viewhit) {
		this.any_viewhit = any_viewhit;
	}
	public String getAny_sta() {
		return any_sta;
	}
	public void setAny_sta(String any_sta) {
		this.any_sta = any_sta;
	}
	public String getAny_regdate() {
		return any_regdate;
	}
	public void setAny_regdate(String any_regdate) {
		this.any_regdate = any_regdate;
	}
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	public List<FileItemVO> getAttachFileInfo() {
		return attachFileInfo;
	}
	public void setAttachFileInfo(List<FileItemVO> attachFileInfo) {
		this.attachFileInfo = attachFileInfo;
	}

	
	
	
	
	
	
}
