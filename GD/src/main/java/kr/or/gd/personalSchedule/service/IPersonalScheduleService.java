package kr.or.gd.personalSchedule.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.EmployeeScheduleVO;

public interface IPersonalScheduleService {

	/**
	 * 사원의 개인 일정을 가져오기 위한 메서드 
	 * MethodName : getEmpSchedule
	 * ClassName  : IEmployeeService
	 * @return EmployeeScheduleVO
	 * @throws Exception
	 * @since  : 2017. 9. 1.
	 * @author  : 박예연
	 */
	public List<Map<String, String>> getEmpSchedule(String emp_num) throws SQLException ;

	/**
	 * 사원 개인일정 등록
	 * MethodName : insertPerSche
	 * ClassName  : IPersonalScheduleService
	 * @return void
	 * @throws Exception
	 * @since  : 2017. 9. 1.
	 * @author  : 박예연
	 */
	public void insertPerSche(EmployeeScheduleVO empScheInfo)throws SQLException;

	/**
	 * 사원 개인 일정 수정
	 * MethodName : updatePerSche
	 * ClassName  : IPersonalScheduleService
	 * @return void
	 * @throws Exception
	 * @since  : 2017. 9. 2.
	 * @author  : 박예연
	 */
	public void updatePerSche(EmployeeScheduleVO empScheInfo)throws SQLException;

	/**
	 * 사원 개인 일정 삭제 
	 * MethodName : deletePerSche
	 * ClassName  : IPersonalScheduleService
	 * @return void
	 * @throws Exception
	 * @since  : 2017. 9. 2.
	 * @author  : 박예연
	 */
	public void deletePerSche(EmployeeScheduleVO empScheInfo)throws SQLException;

	/**
	 * 사원별 개인 프로젝트 리스트 출력
	 * MethodName : getEmpProList
	 * ClassName  : IPersonalScheduleService
	 * @return List<Map<String,String>>
	 * @throws Exception
	 * @since  : 2017. 9. 4.
	 * @author  : 박예연
	 */
	public List<Map<String, String>> getEmpProList(String emp_num)throws SQLException;
}
