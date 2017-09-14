package kr.or.gd.utils;

import javax.servlet.http.HttpServletRequest;

public class RolePagingUtil {
	private int currentPage;		//현재 페이지
	private int totalCount;			//전체 게시글갯수
	private int totalPage;			//전체 페이지 개수
	private int blockCount = 10;	//페이지별 출력될 게시글의 개수
	private int blockPage = 5;		//페이지별 출력될 페이지 네비게이션 넘버의 개수
	private int startCount;			//페이지별 출력되는 게시글의 시작번호(rnum)
	private int endCount;			//페이지별 출력되는 게시글의 끝번호(rnum)
	private int startPage;			//페이지 네비게이션 메뉴 시작 페이지 번호
	private int endPage;			//페이지 네비게이션 메뉴 끝 페이지 번호
	private String pro_id;
	private HttpServletRequest request;
	
	//패이지 네비게이션 메뉴를 문자열 베이스로 html코드 작성 반환
	private StringBuffer pageHtml = new StringBuffer();

	public RolePagingUtil() {
		
	}

	public RolePagingUtil(int currentPage, int totalCount, HttpServletRequest request) {
		this.currentPage = currentPage;
		this.totalCount = totalCount;
		this.request = request;
		makePagingHtml();
	}

	public RolePagingUtil(int currentPage, int totalCount, int blockCount, HttpServletRequest request) {
		this.currentPage = currentPage;
		this.totalCount = totalCount;
		this.request = request;
		this.blockCount = blockCount;
		makePagingHtml();
	}
	
	public RolePagingUtil(int currentPage, int totalCount, HttpServletRequest request, String pro_id) {
		this.currentPage = currentPage;
		this.totalCount = totalCount;
		this.request = request;
		this.pro_id = pro_id;
		makePagingHtml();
	}
	
	
	
	private void makePagingHtml(){
		// 1. 총 페이지의 갯수
		this.totalPage = (int) Math.ceil((double)this.totalCount/this.blockCount);
		
		if(this.totalPage==0){
			this.totalPage = 1;
		}
		
		// 2. 페이지별 시작 게시글 번호(rnum)
		//freeboardList.jsp에 게시글 출력시 오름차순 정렬.
//		this.startCount = (this.currentPage-1)*this.blockCount+1;
//		this.endCount = this.startCount + this.blockCount - 1;

		//freeboardList.jsp에 게시글 출력시 내림차순 정렬.
		this.startCount = this.totalCount - (this.currentPage-1)*this.blockCount;
		this.endCount = this.startCount - this.blockCount + 1;
		
		if(this.endCount<0){
			this.endCount = 1;
		}
		
		// 3. 페이지별 출력될 페이지 네비게이션 메뉴의 넘버에서 시작 페이지번호
		this.startPage = ((this.currentPage - 1) / this.blockPage * this.blockPage)+1;
		this.endPage = this.startPage + this.blockPage -1;
		
		if(this.endPage>this.totalPage){
			this.endPage = this.totalPage;
		}
		
		this.pageHtml.append("<div class='text-center'>");
		this.pageHtml.append("<ul class='pagination mtm mbm'>");
				
		// /ddit/14/main.jsp
		// /ddit/14/main.jsp?contentPage=./freeboard/freeboardList.jsp?currentPage=2
		
		String requestURI = this.request.getRequestURI();
		
		// 페이지 네비게이션 메뉴 : 이전버튼
		if((this.currentPage-1)==0){
			this.pageHtml.append("<li class='disabled' style='display:inline;padding:0 10px;'><a href='#'>&laquo;</a></li>");
		} else { 
			this.pageHtml.append("<li style='display:inline;padding:0 10px;'><a href='"+requestURI+"?currentPage="+(this.currentPage -1)+"&blockCount="+blockCount+"&pro_id="+pro_id+"'>&laquo;</a></li>");
		}

		// 이전 << 1 2 3 4 5
		for(int i=this.startPage; i<=this.endPage; i++){
			if(this.currentPage == i){
				this.pageHtml.append("<li class='active' style='display:inline;padding:0 10px;'><a href='#'><font color='red'>"+i+"</font></a></li>");
			} else {
				this.pageHtml.append("<li class='active' style='display:inline;padding:0 10px;'><a href='"+requestURI+"?currentPage="+i+"&blockCount="+blockCount+"&pro_id="+pro_id+"'>"+i+"</a></li>");
				
			}
		}
		
		// 이전<< 1 2 3 4 5 >>다음
		if(this.currentPage < this.totalPage){
			this.pageHtml.append("<li style='display:inline;padding:0 10px;'><a href='"+requestURI+"?currentPage="+(this.currentPage +1)+"&blockCount="+blockCount+"&pro_id="+pro_id+"'>&raquo;</a></li>");
		} else { 
			this.pageHtml.append("<li class='disabled' style='display:inline;padding:0 10px;'><a href='#'>&laquo;</a></li>");
		}
		
		this.pageHtml.append("</ul>");
		this.pageHtml.append("</div>");		
	}

	public String getStartCount() {
		return String.valueOf(startCount);
	}

	public String getEndCount() {
		return String.valueOf(endCount);
	}

	public String getPageHtml() {
		return pageHtml.toString();
	}

	public void setBlockCount(int blockCount) {
		this.blockCount = blockCount;
	}
}
