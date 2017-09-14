package kr.or.gd.proWorkRate.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface IProWorkRateService {
	/**
	 * 사원이랑 프로젝트 팀장이 같은것만 출력하는 메서드
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
	 * 프로젝트 하나에 해당하는 근무평가 등록 메서드
	 * @param wrt_proid   프로젝트 ID
	 *        wrt_rater   평가 작성자
	 *        empList     평가 대상자
	 *        gradList    평가 등급
	 *        contentList 평가 내용
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.09.01
	 */
	public void insertProWorkRate(List<String> proId, String wrt_rater,
			List<String> empList, List<String> gradList,
			List<String> contentList) throws SQLException;
	/**
	 * 프로젝트 하나에 해당하는 근무평가 정보 유무 검사하는 메서드
	 * @param wrt_proid   프로젝트 ID
	 *        empList     평가 대상자
	 * @throws SQLException
	 * @author 정준혁
	 * @since 2017.09.01
	 */
	public boolean getWorkRateInfo(List<String> proId, List<String> empList) throws SQLException;
}
