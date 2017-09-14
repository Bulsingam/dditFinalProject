package kr.or.gd.proWorkRate.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface IProWorkRateDao {
	/**
	 * 사원이랑 프로젝트 팀장이 같은것만 출력하는 메서든
	 * @param params 사원이름
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.31
	 */
	public List<Map<String, String>> plProList(Map<String, String> params) throws SQLException;
	/**
	 * 프로젝트 하나에 해당하는 근무평가 사원 리스트 가져오는 메서드
	 * @param params 사원이름
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.08.31
	 */
	public List<Map<String, String>> workRateEmpList(Map<String, String> params) throws SQLException;
	/**
	 * 프로젝트에 근무평가 정보 유무 검사 메서드
	 * @param wrt_proid 프로젝트ID 
	 *        emp_num   사원번호
	 * @throws SQLException
	 * @author 정준혁
	 * @return 
	 * @since 2017.09.01
	 */
	public Map<String, String> getWorkRateInfo(Map<String,String>parmas) throws SQLException;
	/**
	 * 프로젝트에 근무평가 정보 등록 메서드
	 * @param wrt_proid 프로젝트ID 
	 *        emp_num   사원번호
	 * @throws SQLException
	 * @author 정준혁
	 * @return 
	 * @since 2017.09.01
	 */
	public void insertProWorkRate(String wrt_proid, String wrt_rater,
			List<String> empList, List<String> gradList,
			List<String> contentList) throws SQLException;

}
