package kr.or.gd.projectBoard.service;

import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ProjectBoardVO;

/**
 * @author Administrator
 *
 */
public interface IProjectBoardService {

	/**
	 * * 프로젝트 게시판 리스트
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	public List<Map<String, String>> getProBoList(Map<String, String> params)throws Exception;

	/**
	 * * 프로젝트 게시판 페이징
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	public int getTotalcount(Map<String, String> params)throws Exception;

	/**
	 * * 프로젝트 게시판 글등록
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	public String insertProBo(ProjectBoardVO proBoInfo)throws Exception;

	/**
	 * * 프로젝트 게시판 상세보기
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	public List<Map<String, String>> getProBoInfo(Map<String, String> params)throws Exception;

	/**
	 * * 프로젝트 게시판 정보수정
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	public int updateProBo(ProjectBoardVO proBoInfo)throws Exception;

	/**
	 * * 프로젝트 게시판 삭제
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	public int deleteProBo(String pro_bo_num)throws Exception;

	/**
	 * * 프로젝트 게시판 댓글 등록
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 05
	 */
	public String insertReplyProBo(ProjectBoardVO proBoInfo)throws Exception;

	/**
	 * proScheView에서 프로젝트 게시판 리스트
	 * @param params
	 * @author 강대성
	 * @since 2017. 09. 08
	 */
	public List<Map<String, String>> getProBoScheList(Map<String, String> params)throws Exception;


	
}
