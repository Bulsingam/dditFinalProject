package kr.or.gd.approval.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ApprovalLineVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IApprovalDaoImpl implements IApprovalDao {

	@Autowired
	private SqlMapClient client;

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, String>> getFormList(Map<String, String> params)
			throws SQLException {
		return client.queryForList("form.formList", params);
	}

	@Override
	public String insertAprLine(ApprovalLineVO approvalLine) throws SQLException {
		return (String) client.insert("approval.insertAprLine", approvalLine);
	}

	@Override
	public int fillAprLine(Map<String, String> params) throws SQLException {
		return client.update("approval.fillAprLine", params);
	}

	@Override
	public int aprStaSetting(Map<String, String> params) throws SQLException {
		return client.update("approval.aprStaSetting", params);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, String>> getAprLine(String line_num) throws SQLException {
		return client.queryForList("approval.aprLine", line_num);
	}

	@Override
	public int deleteAprLine(String line_num) throws SQLException {
		return client.update("approval.deleteApprovalLine", line_num);
	}

	@Override
	public void updateFormProx(Map<String, String> params) throws SQLException {
		client.update("form.updateFormProx", params);
	}

}
