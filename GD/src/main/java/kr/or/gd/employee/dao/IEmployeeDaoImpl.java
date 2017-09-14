package kr.or.gd.employee.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.EmployeeVO;
import kr.or.gd.vo.PositionVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IEmployeeDaoImpl implements IEmployeeDao {
	@Autowired
	private SqlMapClient client;

	@Override
	public List<Map<String, String>> getEmpList(Map<String, String> params)
			throws SQLException {
		return client.queryForList("employee.empList", params);
	}

	@Override
	public List<Map<String, String>> getEmpListByPos(Map<String, String> params)
			throws SQLException {
		return client.queryForList("employee.empListByPos", params);
	}

	@Override
	public String getEmpImgName(String emp_num) throws SQLException {
		return (String) client.queryForObject("employee.empImgName", emp_num);
	}
	@Override
	public Map<String, String> getEmpInfo(String emp_num) throws SQLException {
		Map<String,String> empInfo = (Map<String, String>) client.queryForObject("employee.empInfom",emp_num);
		return empInfo;
	}

	@Override
	public int updateEmp(EmployeeVO empInfo) throws SQLException {
		return client.update("employee.updateEmp",empInfo);
	}

	@Override
	public String getTotalCount(Map<String, String> searchInfo)
			throws SQLException {
		return (String) client.queryForObject("employee.totalCount",searchInfo);
	}

	@Override
	public List<Map<String, String>> getEmpAllList(Map<String, String> searchInfo)
			throws SQLException {
		return client.queryForList("employee.empListAll",searchInfo);
	}

	@Override
	public List<Map<String,String>> salaryInfo() throws Exception {
		return (List<Map<String, String>>) client.queryForList("employee.salaryInfo");
	}

	@Override
	public int updateSalary(Map<String, String> params) throws Exception {
		return client.update("employee.updateSalary", params);
	}

}
