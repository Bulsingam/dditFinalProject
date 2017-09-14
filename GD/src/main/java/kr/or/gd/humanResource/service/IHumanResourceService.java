package kr.or.gd.humanResource.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.EmployeeVO;
import kr.or.gd.vo.PositionVO;
import kr.or.gd.vo.RoleVO;

public interface IHumanResourceService {

	/**
	 * 사원등록 메서드
	 * @param empInfo 사원 정보
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.25
	 */
	public String insertEmp(EmployeeVO empInfo) throws SQLException;

	/**
	 * 직위 리스트 불러오는 메서드
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.25
	 */
	public List<PositionVO> getPositionList() throws SQLException;

	/**
	 * 직책 리스트 불러오는 메서드
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.25
	 */
	public List<RoleVO> getRoleList() throws SQLException;

	/**
	 * 사원 삭제 메서드
	 * @param params 사원NUM
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.25
	 */
	public Map<String,String> deleteEmp(Map<String, String>params) throws SQLException;

	/**
	 * 사원 전체 리스트불러오는 메서드
	 * @param params 검색조건
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.25
	 */
	public List<Map<String, String>> getEmpListAll(Map<String, String> params) throws SQLException;
	
	/**
	 *  관리자단 사원들 개인정보를 가져오는 메서드
	 * @param  사원들 개인 사원번호
	 * @return 사원개인정보 Map<String,String>
	 * @throws SQLException
	 * @author 박예연
	 * @since 2017.08.28
	 */
	public Map<String,String> getEmpInfoAdmin(String emp_num) throws SQLException;
	
	/**
	 *  관리자단 사원들 정보를 수정하는 메서드 
	 * @param  수정하려는 정보들 
	 * @return int
	 * @throws SQLException
	 * @author 박예연
	 * @since 2017.08.28
	 */
	public int updateEmp(EmployeeVO empInfo) throws SQLException;
	
	/**
	 * 사원 출결 리스트 불러오는 메서드
	 * @param params 검색조건
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.31
	 */
	public List<Map<String, String>> empAttList(Map<String, String> params) throws SQLException;
	/**
	 * 사원 출결 리스트 전체 카운트를 가져오는 메서드
	 * @param searchInfo 검색조건
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.09.05
	 */
	public String getAttTotalCount(Map<String, String> searchInfo) throws SQLException;
	/**
	 * 사원에 근무평가 리스트를 가져오는 메서드
	 * @param empNum 사원 번호
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.09.06
	 */
	public List<Map<String, String>> getEmpWorkRateList(
			Map<String, String> empNum) throws SQLException;
	/**
	 * Delete뷰에서 페이징처리를 위한 전체 사원의 수를 가져오는 메서드(재직&퇴사)
	 * @param searchInfo 검색조건
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.09.07
	 */
	public String getDeleteTotalCount(Map<String, String> searchInfo) throws SQLException;
	
}
