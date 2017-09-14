package kr.or.gd.humanResource.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.EmployeeAttendenceVO;
import kr.or.gd.vo.EmployeeVO;
import kr.or.gd.vo.PositionVO;
import kr.or.gd.vo.ProjectMemberVO;
import kr.or.gd.vo.RoleVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IHumanResourceDaoImpl implements IHumanResourceDao{
	@Autowired
	private SqlMapClient client;

	@Override
	public String firstEmpNum() throws SQLException {
		return (String) client.queryForObject("hr.firstEmpNum");
	}

	@Override
	public String secondEmpNum() throws SQLException {
		return (String) client.queryForObject("hr.secondEmpNum");
	}
	
	@Override
	public String empCheck() throws SQLException {
		return (String) client.queryForObject("hr.empCheck");
	}
	
	@Override
	public String insertEmp(EmployeeVO empInfo) throws SQLException {
		return (String) client.insert("hr.insertEmp",empInfo);
	}

	@Override
	public List<PositionVO> getPositionList() throws SQLException {
		return client.queryForList("hr.getPositionList");
	}

	@Override
	public List<RoleVO> getRoleList() throws SQLException {
		return client.queryForList("hr.getRoleList");
	}

	@Override
	public Map<String, String> deleteEmp(Map<String, String> params)
			throws SQLException {
		ProjectMemberVO proMemVO = new ProjectMemberVO();
		List<Map<String, String>> memProList = new ArrayList<Map<String,String>>();
		memProList = client.queryForList("join.EmpProList", params);
		for (Map<String, String> project : memProList) {
			System.out.println(params.get("emp_num"));
			proMemVO.setMem_emp(params.get("emp_num"));
			proMemVO.setMem_proid(project.get("PRO_ID"));
			client.update("projectMember.outProjectMember", proMemVO);
		}
		return (Map<String, String>) client.queryForObject("hr.deleteEmp",params);
	}

	@Override
	public List<Map<String, String>> getEmpListAll(Map<String, String> params) throws SQLException {
		return (List<Map<String, String>>) client.queryForList("hr.getEmpDeleteList",params);
	}
	
	@Override
	public Map<String,String> getEmpInfoAdmin(String emp_num) throws SQLException {
		Map<String,String> empInfo = (Map<String, String>) client.queryForObject("hr.empInfom",emp_num);
		return empInfo;
	}
	
	@Override
	public int updateEmp(EmployeeVO empInfo) throws SQLException {
		int result = (int) client.update("hr.updateEmp", empInfo);
		return result;
	}

	@Override
	public List<Map<String, String>> empAttList(Map<String, String> params)
			throws SQLException {
		return (List<Map<String, String>>)client.queryForList("hr.empAttList",params);
	}

	@Override
	public String getAttTotalCount(Map<String, String> searchInfo)
			throws SQLException {
		return (String) client.queryForObject("hr.attTotalCount",searchInfo);
	}

	@Override
	public List<Map<String, String>> getEmpWorkRateList(
			Map<String, String> empNum) throws SQLException {
		return client.queryForList("hr.empWorkRateList",empNum);
	}

	@Override
	public String getDeleteTotalCount(Map<String, String> searchInfo) throws SQLException {
		return (String) client.queryForObject("hr.deleteCount",searchInfo);
	}

}
