package kr.or.gd.noticeBoard.service;


import java.util.List;
import java.util.Map;


import kr.or.gd.vo.FileItemVO;
import kr.or.gd.vo.NoticeBoardVO;

public interface INoticeBoardService {
	
	
	/**
	 * 공지게시판 게시글 등록
	 * @param notiboardInfo 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public String insertNotiboardInfo(NoticeBoardVO notiboardInfo) throws Exception;
	
	
	
	
	
	/**
	 * 공지게시판 게시글 상세보기
	 * @param noti_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public List<Map<String,String>>getNotiView(Map<String, String> params) throws Exception;
	
	
	
	
	
	/**
	 * 공지게시판 게시글 수정
	 * @param notiboardInfo
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public int updateNotiboardInfo(NoticeBoardVO notiboardInfo) throws Exception;

	
	
	
	
	/**
	 * 공지게시판 게시글 리스트 출력
	 * @param noti_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public List<Map<String, String>>getNotiboardList(Map<String,String>params) throws Exception;
	
	
	
	
	
	/**
	 * 공지게시판 게시글 삭제
	 * @param noti_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public int deleteNotiboardInfo(Map<String,String>params)throws Exception;
	
	
	
	
	/**
	 * 공지게시판 게시글 파일 다운로드
	 * @param file_seq
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public FileItemVO getNotiFileDownload(Map<String, String> params) throws Exception;
	
	
	
	
	/**
	 * 공지게시판 게시글 페이징구현
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public int getTotalCount(Map<String, String> params)throws Exception;
	

}
