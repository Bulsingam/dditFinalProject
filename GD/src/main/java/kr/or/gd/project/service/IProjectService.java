package kr.or.gd.project.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ProjectVO;

public interface IProjectService {
	/**
	 * 프로젝트 생성해주기 위한 메서드
	 * @param proMemNumList 프로젝트에 들어갈 사원의 사원번호 
	 * @param proMemRoleList 사원이 프로젝트에서 담당할 직책
	 * @param projectInfo 생성될 프로젝트의 정보를 담은 VO
	 * @author 김길태
	 * @since 2017. 08. 28
	 */
	public String insertPro(ProjectVO projectInfo, List<String> proMemNumList, List<String> proMemRoleList);
	/**
	 * 생성된 프로젝트의 List를 받아오기 위한 메서드
	 * @param params 검색 조건과 문자를 담은 Map
	 * @author 김길태
	 * @since 2017. 08. 30
	 */
	public List<Map<String, String>> getProList(Map<String,String> params);
	/**
	 * 프로젝트 진행 현황 Bar 퍼센트 가져오는 메서드
	 * @param params 검색 조건과 문자를 담은 Map
	 * @author 정준혁
	 * @throws SQLException 
	 * @since 2017. 09. 02
	 */
	public Map<String, String> getProBarInfo(String pickProjectID) throws SQLException;
	/**
	 * 프로젝트의 현재 상태를 업데이트
	 * @param 변경할 프로젝트의 상태
	 * @author 김길태
	 * @since 2017. 09. 02
	 */
	public void endProStatus();
	/**
	 * 프로젝트와 해당 프로젝트에 착수한 팀원의 정보를 수정하는 메서드
	 * @param proMemNumList 추가할 사원의 사원번호
	 * @param proMemRoleList 추가할 사원의 직책
	 * @param deleteMemNumList 제외할 팀원의 사원번호
	 * @param projectInfo 수정될 프로젝트의 정보를 담은 VO
	 * @author 김길태
	 * @since 2017. 09. 05
	 */
	public void updatePro(List<String> proMemNumList,
			List<String> proMemRoleList, List<String> deleteMemNumList,
			ProjectVO projectInfo);
	/**
	 * 진행중인 프로젝트를 삭제하는 메서드
	 * @param proID 삭제할 프로젝트의 ID
	 * @author 김길태
	 * @since 2017. 09. 05
	 */
	public void dropProject(String proID);
	
	/**
	 * 삭제된 프로젝트를 제외한 모든 프로젝트의 수를 구하는 메서드
	 * @param params 검색 조건
	 * @author 김길태
	 * @since 2017. 09. 05
	 */
	public String getProjectTotalCount(Map<String, String> params);
	
	/**
	 * 진행중인 프로젝트 list와 진행완료된 프로젝트 list불러오는 
	 * MethodName : getIngCheckList
	 * ClassName  : IProjectService
	 * @return List<Map<String,String>>
	 * @throws Exception
	 * @since  : 2017. 9. 6.
	 * @author  : 박예연
	 */
	public Map<String,List<Map<String, String>>> getIngCheckList(Map<String, String> searchInfo)throws SQLException;
}
