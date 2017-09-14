package kr.or.gd.project.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ProjectVO;

public interface IProjectDao {
	public String insertPro(ProjectVO projectInfo, List<String> proMemNumList, List<String> proMemRoleList) throws SQLException;
	public List<Map<String, String>> getProList(Map<String,String> params) throws SQLException;
	public void endProStatus() throws SQLException;
	/**
	 * 프로젝트 진행 현황 Bar 퍼센트 가져오는 메서드
	 * @param params 검색 조건과 문자를 담은 Map
	 * @author 정준혁
	 * @since 2017.09.02
	 */
	public Map<String, String> getProBarInfo(String pickProjectID) throws SQLException;
	public void updatePro(List<String> proMemNumList, List<String> proMemRoleList, List<String> deleteMemNumList,
			ProjectVO projectInfo) throws SQLException;
	public void dropProject(String proID) throws SQLException;
	public String getProjectTotalCount(Map<String, String> params) throws SQLException;
	
	/**
	 * 진행중인 List 출력하는 메서드
	 * MethodName : getIngList
	 * ClassName  : IProjectDao
	 * @return List<Map<String,String>>
	 * @throws Exception
	 * @since  : 2017. 9. 6.
	 * @author  : 박예연
	 */
	public List<Map<String, String>> getIngList(Map<String, String> searchInfo)throws SQLException;
	/**
	 * 진행 완료된 List 출력하는 메서드
	 * MethodName : getEndList
	 * ClassName  : IProjectDao
	 * @return List<Map<String,String>>
	 * @throws Exception
	 * @since  : 2017. 9. 6.
	 * @author  : 박예연
	 */
	public List<Map<String, String>> getEndList(Map<String, String> searchInfo)throws SQLException;
}
