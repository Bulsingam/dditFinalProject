package kr.or.gd.archive.dao;

import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ArchiveVO;
import kr.or.gd.vo.FileItemVO;

public interface IArchiveDao {

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
	public List<Map<String, String>> getArcList(Map<String, String> params)throws Exception;

	/**
	 * 자료실 글 삭제
	 * @param arc_postnum 
	 * @author 강대성
	 * @since 2017-08-29
	 */
	public int deleteArc(Map<String, String> params)throws Exception;

	/**
	 * 자료실 조회수
	 * @param arc_postnum
	 * @author 강대성
	 * @since 2017-08-29
	 */
	public int arcHit(Map<String, String> params)throws Exception;

	/**
	 * 자료실 파일 다운로드
	 * @param file_seq 
	 * @author 강대성
	 * @since 2017-08-30
	 */
	public FileItemVO getArcFileDownload(Map<String, String> params)throws Exception;

	/**
	 * 자료실 정보 수정
	 * @param arc_postnum
	 * @author 강대성
	 * @since 2017-08-30
	 */
	public int updateArc(ArchiveVO archiveInfo)throws Exception;

	/**
	 * 자료실 댓글 등록
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
	 * 자료실 파일 수정시 기존 파일 삭제
	 * @param 
	 * @author 강대성
	 * @since 2017-09-05
	 */
	public int deleteArcFile(ArchiveVO archiveInfo)throws Exception;

	/**
	 * 자료실 파일 수정시 기존 파일 삭제후 파일 인서트
	 * @param 
	 * @author 강대성
	 * @since 2017-09-05
	 */
	public String insertArcFile(ArchiveVO archiveInfo)throws Exception;

	/**
	 * 자료실 파일 정보 불러오기
	 * @param 
	 * @author 강대성
	 * @since 2017-09-05
	 */
	public FileItemVO getFileInfo(Map<String, String> params)throws Exception;



}
