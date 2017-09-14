package kr.or.gd.personalSchedule.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.EmployeeScheduleVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IPersonalScheduleDaoImpl implements IPersonalScheduleDao {
	@Autowired
	private SqlMapClient client;

	@Override
	public List<Map<String, String>> getEmpSchedule(String emp_num) throws SQLException {
// 	이건 일단 본인이 가지고 있는 프로젝트 뽑는거 
//		 client.queryForObject("perSch.allPro", parameterObject);
		return client.queryForList("perSche.allSchedule", emp_num);
	}

	@Override
	public String insertPerSche(EmployeeScheduleVO empScheInfo) throws SQLException {
		return (String) client.insert("perSche.insertPerSche",empScheInfo);
	}

	@Override
	public int updatePerSche(EmployeeScheduleVO empScheInfo) throws SQLException {
		return client.update("perSche.updatePerSche",empScheInfo);
	}

	@Override
	public int deletePerSche(EmployeeScheduleVO empScheInfo) throws SQLException {
		return client.delete("perSche.deletePerSche",empScheInfo);
	}

	@Override
	public List<Map<String, String>> getEmpProList(String emp_num) throws SQLException {
		return client.queryForList("perSche.empProList",emp_num);
	}
}
