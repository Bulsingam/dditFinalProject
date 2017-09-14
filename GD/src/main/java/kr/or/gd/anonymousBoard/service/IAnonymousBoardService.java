package kr.or.gd.anonymousBoard.service;

import java.util.List;
import java.util.Map;

import kr.or.gd.vo.AnonymousBoardVO;
import kr.or.gd.vo.FileItemVO;

public interface IAnonymousBoardService {


	/**
	 * 익명게시판 글등록
	 * @param anyBoInfo 
	 * @author 강대성
	 * @since 2017-08-31
	 */ 
	public String insertAnyBo(AnonymousBoardVO anyBoInfo)throws Exception;

	/**
	 * 익명게시판 리스트 출력
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 */ 
	public List<Map<String, String>> getAnyList(Map<String, String> params)throws Exception;

	/**
	 * 익명게시판 페이징
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 */ 	
	public int getTotalcount(Map<String, String> params)throws Exception;

	/**
	 * 익명게시판 상세정보 출력
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 */ 	
	public List<Map<String, String>> getAnyBoInfoView(Map<String, String> params)throws Exception;

	/**
	 * 익명게시판 파일 다운로드
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 */
	public FileItemVO getAnyFileDownload(Map<String, String> params)throws Exception;
	
	/**
	 * 익명게시판 정보수정
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 */
	public int updateAnyBo(AnonymousBoardVO anyBoInfo)throws Exception;

	/**
	 * 익명게시판 글 삭제
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 */
	public int deleteAnyBo(Map<String, String> params)throws Exception;

	/**
	 * 익명게시판 댓글 등록
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 */
	public String insertReplyAnyBo(AnonymousBoardVO anyBoInfo)throws Exception;

	/**
	 * 익명게시판 파일정보 불러오기
	 * @param  
	 * @author 강대성
	 * @since 2017-09-05
	 */
	public FileItemVO getFileInfo(Map<String, String> params)throws Exception;
	
	
}
