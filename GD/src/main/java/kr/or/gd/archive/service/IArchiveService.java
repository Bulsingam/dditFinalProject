package kr.or.gd.archive.service;

import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ArchiveVO;
import kr.or.gd.vo.FileItemVO;

public interface IArchiveService {

	/**
	 * 자료실 글등록
	 * @param archiveInfo 
	 * @author 강대성
	 * @since 2017-08-29
	 */
	public String insertArc(ArchiveVO archiveInfo)throws Exception;
	
	/**
	 * 자료실 상세정보출력
	 * @param arc_postnum 
	 * @author 강대성
	 * @since 2017-08-29
	 */
	public List<Map<String, String>> getArcInfoView(Map<String, String> params)throws Exception;
	
	/**
	 * 자료실 리스트 불러오기
	 * @param 
	 * @author 강대성
	 * @since 2017-08-29
	 * @since 2017-08-30
	 * @since 2017-08-31
	 */
	public List<Map<String, String>> getArcList(Map<String, String> params) throws Exception;
	
	/**
	 * 자료실 글 삭제
	 * @param arc_postnum 
	 * @author 강대성
	 * @since 2017-08-29
	 */
	public int deleteArc(Map<String, String> params)throws Exception;
	
	/**
	 * 자료실 파일 다운로드
	 * @param file_seq 
	 * @author 강대성
	 * @since 2017-08-30
	 */
	public FileItemVO getArcFileDownload(Map<String, String>params)throws Exception;

	/**
	 * 자료실 정보 수정
	 * @param arc_postnum
	 * @author 강대성
	 * @since 2017-08-30
	 */
	public int updateArc(ArchiveVO archiveInfo)throws Exception;

	
	/**
	 * 자료실 댓글등록
	 * @param 
	 * @author 강대성
	 * @since 2017-08-31
	 */
	public String insertReplyArc(ArchiveVO archiveInfo)throws Exception;

	/**
	 * 자료실 페이징
	 * @param 
	 * @author 강대성
	 * @since 2017-08-31
	 */
	public int getTotalCount(Map<String, String> params)throws Exception;

	/**
	 * 자료실 파일 정보 불러오기
	 * @param 
	 * @author 강대성
	 * @since 2017-09-35
	 */
	public FileItemVO getFileInfo(Map<String, String> params)throws Exception;


	




}
