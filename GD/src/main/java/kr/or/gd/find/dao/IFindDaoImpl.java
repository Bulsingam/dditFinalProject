package kr.or.gd.find.dao;

import java.util.Map;

import kr.or.gd.vo.EmployeeVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IFindDaoImpl implements IFindDao {

	@Autowired
	private SqlMapClient client;

	// 사원 이름 주민번호앞자리 이메일을 비교해서 등록된 사원인지 체크
	@Override
	public EmployeeVO empNumFind(Map<String, String> params) throws Exception {
		return (EmployeeVO) client.queryForObject("employee.empNumFind", params);
	}

	// 사원번호 주민번호앞자리 이메일을 비교해서 등록된 사원인지 체크
	@Override
	public EmployeeVO passFind(Map<String, String> params) throws Exception {
		return (EmployeeVO) client.queryForObject("employee.passFind",params);
	}
}
