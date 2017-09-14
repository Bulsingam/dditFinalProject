package kr.or.gd.join.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.EmployeeAttendenceVO;
import kr.or.gd.vo.EmployeeVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapException;

@Repository
public class IJoinDaoImpl implements IJoinDao {

	@Autowired
	private SqlMapClient client;

	@Override
	public EmployeeVO loginCheck(Map<String, String> params)
			throws SqlMapException, SQLException {
		return (EmployeeVO) client.queryForObject("join.loginCheck",params);
	}

	@Override
	public String attCheck(Map<String, String> params)
			throws SQLException {
		return (String) client.queryForObject("join.attCheck",params);
	}

	@Override
	public String insertApp(Map<String, String> params) throws SQLException {
		return (String) client.insert("join.insertAtt",params);
	}

	@Override
	public int updateDap(Map<String, String> params) throws SQLException {
		return client.update("join.updateDap",params);
	}

	@Override
	public List<Map<String, String>> getEmpProList(Map<String, String> params)
			throws SQLException {
		return (List<Map<String, String>>) client.queryForList("join.EmpProList",params);
	}
}
