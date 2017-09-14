package kr.or.gd.proWorkRate.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ProjectWorkRateVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IProWorkRateDaoImpl implements IProWorkRateDao{
	@Autowired
	private SqlMapClient client;

	@Override
	public List<Map<String, String>> plProList(Map<String, String> params)
			throws SQLException {
		return (List<Map<String, String>>)client.queryForList("project.plProList",params);
	}

	@Override
	public List<Map<String, String>> workRateEmpList(Map<String, String> params) throws SQLException {
		return (List<Map<String, String>>)client.queryForList("project.workRateEmpList",params);
	}

	@Override
	public Map<String, String> getWorkRateInfo(Map<String,String>params)
			throws SQLException {
		return (Map<String, String>) client.queryForObject("project.workRateInfo",params);
	}

	@Override
	public void insertProWorkRate(String wrt_proid, String wrt_rater,
			List<String> empList, List<String> gradList,
			List<String> contentList) throws SQLException {
		ProjectWorkRateVO workRateInfo = new ProjectWorkRateVO();
		workRateInfo.setWrt_proid(wrt_proid);
		workRateInfo.setWrt_rater(wrt_rater);
		for(int i = 0; i<empList.size(); i++){
			workRateInfo.setWrt_tar(empList.get(i));
			workRateInfo.setWrt_lev(gradList.get(i));
			workRateInfo.setWrt_cont(contentList.get(i));
			client.insert("project.insertProWorkRate",workRateInfo);
		}
	}

}
