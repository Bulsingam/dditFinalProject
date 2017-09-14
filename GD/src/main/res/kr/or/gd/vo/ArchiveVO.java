package kr.or.gd.vo;

import java.util.List;

public class ArchiveVO {

	private String rnum;
	private String arc_postnum;
	private String arc_title;
	private String arc_cont;
	private String arc_writer;
	private String arc_postseq;
	private String arc_postgroup;
	private String arc_postdep;
	private String arc_viewhit;
	private String arc_sta;
	private String arc_regdate;
	private List<FileItemVO> attachFileInfo;
	
	public String getArc_postnum() {
		return arc_postnum;
	}
	public void setArc_postnum(String arc_postnum) {
		this.arc_postnum = arc_postnum;
	}
	public String getArc_title() {
		return arc_title;
	}
	public void setArc_title(String arc_title) {
		this.arc_title = arc_title;
	}
	public String getArc_cont() {
		return arc_cont;
	}
	public void setArc_cont(String arc_cont) {
		this.arc_cont = arc_cont;
	}
	public String getArc_writer() {
		return arc_writer;
	}
	public void setArc_writer(String arc_writer) {
		this.arc_writer = arc_writer;
	}
	public String getArc_postseq() {
		return arc_postseq;
	}
	public void setArc_postseq(String arc_postseq) {
		this.arc_postseq = arc_postseq;
	}
	public String getArc_postgroup() {
		return arc_postgroup;
	}
	public void setArc_postgroup(String arc_postgroup) {
		this.arc_postgroup = arc_postgroup;
	}
	public String getArc_postdep() {
		return arc_postdep;
	}
	public void setArc_postdep(String arc_postdep) {
		this.arc_postdep = arc_postdep;
	}
	public String getArc_viewhit() {
		return arc_viewhit;
	}
	public void setArc_viewhit(String arc_viewhit) {
		this.arc_viewhit = arc_viewhit;
	}
	public String getArc_sta() {
		return arc_sta;
	}
	public void setArc_sta(String arc_sta) {
		this.arc_sta = arc_sta;
	}
	public String getArc_regdate() {
		return arc_regdate;
	}
	public void setArc_regdate(String arc_regdate) {
		this.arc_regdate = arc_regdate;
	}
	public void setAttachFileInfo(List<FileItemVO> attachFileInfo) {
		this.attachFileInfo = attachFileInfo;
	}
	public List<FileItemVO> getAttachFileInfo() {
		return attachFileInfo;
	}
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}

	

	




}
