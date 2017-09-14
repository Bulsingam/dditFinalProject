package kr.or.gd.employee.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.EmployeeVO;
import kr.or.gd.vo.PositionVO;

public interface IEmployeeService {
	
	/**
	 * 사원 리스트를 가져오는 메서드
	 * @param params 검색 조건
	 * @return 검색 조건에 해당하는 사원 정보가 담긴 리스트
	 * @throws SQLException
	 * @author 정준혁
	 * @since	2017.08.28	최초작성<br>
	 * 			2017.08.30	메서드명 및 쿼리 수정	@author 박일훈
	 */
	public List<Map<String,String>> getEmpList(Map<String,String>params) throws SQLException;
	
	/**
	 * 사원 리스트를 직급명과 함께 가져오는 메서드
	 * @param params 검색조건
	 * @return 검색 조건에 해당하는 사원 정보와 직급명이 담긴 리스트
	 * @throws SQLException
	 * @since	2017.08.30	최초작성 및 구현	@author 박일훈
	 */
	public List<Map<String,String>> getEmpListByPos(Map<String, String> params) throws SQLException;
	
	/**
	 * 사원 이미지 취득 메서드
	 * @param emp_num 취득할 사원의 번호
	 * @return 해당 사원의 사원 이미지 이름
	 * @throws SQLException
	 * @since	2017.08.30	최초작성 및 구현	@author 박일훈
	 */
	public String getEmpImgName(String emp_num) throws SQLException;

	/**
	 * 사원 개인별 정보를 가져오는 메서드
	 * @param emp_num 사원번호
	 * @return 사원의 정보와 직위를 조인해서 담은 맵
	 * @throws SQLException
	 * @since	2017.08.30	최초작성	@author 박예연
	 */
	public Map<String, String> getEmpInfo(String emp_num) throws SQLException;

	/**
	 * 사원 개인별 정보를 수정하는 메서드
	 * @param EmployeeVO 에 담긴 사원정보 
	 * @return int
	 * @throws SQLException
	 * @since	2017.08.30	최초작성	@author 박예연
	 */
	public int updateEmp(EmployeeVO empInfo) throws SQLException;
	
	/**
	 * 사원 개인 페이지에 list들을 가지고 와서 한꺼번에 뿌릴 List 
	 * @param 본인이 쓴 리스트를 뿌릴 리스트 
	 * @return Map형태로 한꺼번에 다 묶어서 반환
	 * @throws Exception
	 * @since	2017.08.30	최초작성
	 * 			2017.09.--- 마지막에 할 예정	
	 * @author 박예연
	 */
	public Map<String, List<Map<String, String>>> getMyPage(Map<String, String> empInfo) throws Exception;

	/**
	 * 사원 리스트의 페이징처리를 위한 TotalCount 
	 * @param searchInfo
	 * @return String count반환
	 * @throws Exception
	 * @since	2017.08.31	최초작성
	 * @author 박예연
	 */
	public String getTotalCount(Map<String, String> searchInfo) throws SQLException ;
	
	public List<Map<String, String>> getEmpAllList(Map<String, String> searchInfo) throws SQLException;

	/**
	 * 사원급여정보 리스트
	 * @return Map
	 * @throws Exception
	 * @since  2017.09.12	최초작성
	 * @author 강대성
	 */
	public List<Map<String,String>> salaryInfo()throws Exception;

	/**
	 * 사원급여 수정
	 * @throws Exception
	 * @since  2017.09.12	최초작성
	 * @author 강대성
	 */
	public int updateSalary(Map<String, String> params)throws Exception;
}
