package kr.or.gd.projectArchive.service;

import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ProjectArchiveVO;

public interface IProjectArchiveService {

	/**
	 * 프로젝트 자료실 등록
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 */ 
	public String insertProArc(ProjectArchiveVO proAcrInfo)throws Exception;

	/**
	 * 프로젝트 자료실 리스트 출력
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 */
	public List<Map<String, String>> getProArcList(Map<String, String> params)throws Exception;

	/**
	 * 프로젝트 자료실 페이징
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 */
	public int getTotalcount(Map<String, String> params)throws Exception;

	/**
	 * 프로젝트 자료실 삭제
	 * @param  
	 * @author 강대성
	 * @since 2017-09-02
	 */
	public int deleteProArc(String pro_arc_num)throws Exception;

	/**
	 * 프로젝트 자료실 정보수정 뷰
	 * @param  
	 * @author 강대성
	 * @since 2017-09-02
	 */
	public ProjectArchiveVO getProArc(String pro_arc_num)throws Exception;

	/**
	 * 프로젝트 자료실 수정
	 * @param  
	 * @author 강대성
	 * @since 2017-09-04
	 */
	public int updateProArc(ProjectArchiveVO proArcInfo)throws Exception;

	/**
	 * 프로젝트 자료실 다운로드
	 * @param  
	 * @author 강대성
	 * @since 2017-09-04
	 */	
	public ProjectArchiveVO downloadProArc(Map<String, String> params)throws Exception;

	/**
	 * proScheView에서 프로젝트 자료실 리스트
	 * @param params
	 * @author 강대성
	 * @since 2017. 09. 08
	 */
	public List<Map<String, String>> getProArcScheList(Map<String, String> params)throws Exception;


}
