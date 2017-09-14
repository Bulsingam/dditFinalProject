package kr.or.gd.find.dao;

import java.util.Map;

import kr.or.gd.vo.EmployeeVO;

public interface IFindDao {

	// 사원 이름 주민번호앞자리 이메일을 비교해서 등록된 사원인지 체크
	public EmployeeVO empNumFind(Map<String, String> params)throws Exception;

	// 사원번호 주민번호앞자리 이메일을 비교해서 등록된 사원인지 체크
	public EmployeeVO passFind(Map<String, String> params)throws Exception;

}
