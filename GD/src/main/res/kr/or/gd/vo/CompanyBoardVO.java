package kr.or.gd.vo;

import java.util.List;

public class CompanyBoardVO {

	private String com_postnum;
	private String com_title;
	private String com_cont;
	private String com_writer;
	private String com_postseq;
	private String com_postgroup;
	private String com_postdep;
	private String com_viewhit;
	private String com_sta;
	private String com_regdate;
	private List<FileItemVO> attachFileInfo;
	
	public String getCom_postnum() {
		return com_postnum;
	}
	public List<FileItemVO> getAttachFileInfo() {
		return attachFileInfo;
	}
	public void setAttachFileInfo(List<FileItemVO> attachFileInfo) {
		this.attachFileInfo = attachFileInfo;
	}
	public void setCom_postnum(String com_postnum) {
		this.com_postnum = com_postnum;
	}
	public String getCom_title() {
		return com_title;
	}
	public void setCom_title(String com_title) {
		this.com_title = com_title;
	}
	public String getCom_cont() {
		return com_cont;
	}
	public void setCom_cont(String com_cont) {
		this.com_cont = com_cont;
	}
	public String getCom_writer() {
		return com_writer;
	}
	public void setCom_writer(String com_writer) {
		this.com_writer = com_writer;
	}
	public String getCom_postseq() {
		return com_postseq;
	}
	public void setCom_postseq(String com_postseq) {
		this.com_postseq = com_postseq;
	}
	public String getCom_postgroup() {
		return com_postgroup;
	}
	public void setCom_postgroup(String com_postgroup) {
		this.com_postgroup = com_postgroup;
	}
	public String getCom_postdep() {
		return com_postdep;
	}
	public void setCom_postdep(String com_postdep) {
		this.com_postdep = com_postdep;
	}
	public String getCom_viewhit() {
		return com_viewhit;
	}
	public void setCom_viewhit(String com_viewhit) {
		this.com_viewhit = com_viewhit;
	}
	public String getCom_sta() {
		return com_sta;
	}
	public void setCom_sta(String com_sta) {
		this.com_sta = com_sta;
	}
	public String getCom_regdate() {
		return com_regdate;
	}
	public void setCom_regdate(String com_regdate) {
		this.com_regdate = com_regdate;
	}
	
	
	
}                  
