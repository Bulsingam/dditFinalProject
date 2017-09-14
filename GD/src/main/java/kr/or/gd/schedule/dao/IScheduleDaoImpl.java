package kr.or.gd.schedule.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ProjectScheduleVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IScheduleDaoImpl implements IScheduleDao {
	
	@Autowired
	private SqlMapClient client;
	
	@Override
	public String insertSche(ProjectScheduleVO scheVO) throws SQLException {
		return (String) client.insert("schedule.insertSchedule", scheVO);
	}

	@Override
	public List<Map<String, String>> getScheMemList(String proID)
			throws SQLException {
		return client.queryForList("projectMember.memberList", proID);
	}

	@Override
	public List<Map<String, String>> getScheList(String proID)
			throws SQLException {
		return client.queryForList("schedule.scheduleList", proID);
	}

	@Override
	public int updateSche(ProjectScheduleVO scheVO, String sche_empInfo) throws SQLException{
		if(scheVO.getSche_emp() == null){
			scheVO.setSche_emp(sche_empInfo);
		}
		return client.update("schedule.updateSchedule", scheVO);
	}

	@Override
	public int deleteSche(String sche_seq) throws SQLException {
		return client.delete("schedule.deleteSchedule", sche_seq);
	}

}
