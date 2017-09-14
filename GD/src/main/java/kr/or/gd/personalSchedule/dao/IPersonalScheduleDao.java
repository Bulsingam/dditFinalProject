package kr.or.gd.personalSchedule.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.EmployeeScheduleVO;

public interface IPersonalScheduleDao {
	
	public List<Map<String, String>> getEmpSchedule(String emp_num) throws SQLException ;

	/**
	 * 개인스케줄 등록
	 * MethodName : insertPerSche
	 * ClassName  : IPersonalScheduleDao
	 * @return String
	 * @throws Exception
	 * @since  : 2017. 9. 1.
	 * @author  : 박예연
	 */
	public String insertPerSche(EmployeeScheduleVO empScheInfo)throws SQLException;

	/**
	 * 개인 일정 수정
	 * MethodName : updatePerSche
	 * ClassName  : IPersonalScheduleDao
	 * @return int
	 * @throws Exception
	 * @since  : 2017. 9. 2.
	 * @author  : 박예연
	 */
	public int updatePerSche(EmployeeScheduleVO empScheInfo)throws SQLException;

	/**
	 * 개인 일정 삭제 
	 * MethodName : deletePerSche
	 * ClassName  : IPersonalScheduleDao
	 * @return void
	 * @throws Exception
	 * @since  : 2017. 9. 2.
	 * @author  : 박예연
	 */
	public int deletePerSche(EmployeeScheduleVO empScheInfo)throws SQLException;

	/**
	 * 사원당 개인 프로젝트 리스트 출력
	 * MethodName : getEmpProList
	 * ClassName  : IPersonalScheduleDao
	 * @return List<Map<String,String>>
	 * @throws Exception
	 * @since  : 2017. 9. 4.
	 * @author  : 박예연
	 */
	public List<Map<String, String>> getEmpProList(String emp_num) throws SQLException;

}
