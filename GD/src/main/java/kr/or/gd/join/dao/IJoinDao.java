package kr.or.gd.join.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapException;

import kr.or.gd.vo.EmployeeAttendenceVO;
import kr.or.gd.vo.EmployeeVO;

public interface IJoinDao {

	/**
	 * 로그인 체크 메서드
	 * @param empInfo 사원 정보
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.25
	 */
	public EmployeeVO loginCheck(Map<String, String> params) throws SQLException;

	/**
	 * 출근 정보 확인 메서드
	 * @param empInfo 사원 정보
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.25
	 */
	public String attCheck(Map<String, String> params) throws SQLException;

	/**
	 * 출근정보 입력 메서드
	 * @param empInfo 사원 정보
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.30
	 */
	public String insertApp(Map<String, String> params) throws SQLException;

	/**
	 * 퇴근정보 업데이트 메서드
	 * @param empInfo 사원 정보
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.30
	 */
	public int updateDap(Map<String, String> params) throws SQLException;

	/**
	 * 사원이 진행하고있는 프로젝트 리스트 불러오는 메서드
	 * @param empInfo 사원 정보
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.30
	 */
	public List<Map<String, String>> getEmpProList(Map<String, String> params) throws SQLException;

}
