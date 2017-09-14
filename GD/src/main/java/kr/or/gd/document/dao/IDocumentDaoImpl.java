package kr.or.gd.document.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.DocumentVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IDocumentDaoImpl implements IDocumentDao{

	@Autowired
	private SqlMapClient client;

	@Override
	public String insertDoc(DocumentVO document) throws SQLException {
		return (String) client.insert("document.insertDoc", document);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, String>> getPrgFolder(Map<String, String> params) throws SQLException {
		return client.queryForList("document.getProgressFolder", params);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, String>> getSendFolder(Map<String, String> params) throws SQLException {
		return client.queryForList("document.getSendFolder", params);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, String>> getRecvFolder(Map<String, String> params) throws SQLException {
		return client.queryForList("document.getReceiveFolder", params);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, String>> getConfFolder(Map<String, String> params) throws SQLException {
		return client.queryForList("document.getConfirmFolder", params);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, String>> getRefFolder(Map<String, String> params) throws SQLException {
		return client.queryForList("document.getRefuseFolder", params);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, String>> getDocMap(Map<String, String> params) throws SQLException {
		return client.queryForList("document.getDocument", params);
	}

	@Override
	public int deleteDoc(String doc_num) throws SQLException {
		return client.update("document.deleteDocument", doc_num);
	}

	@Override
	public int updateDoc(DocumentVO document) throws SQLException {
		return client.update("document.updateDocument", document);
	}

	@Override
	public int getTotalCount(Map<String, String> params) throws SQLException {
		return (int) client.queryForObject(params.get("sqlStatement"), params);
	}

	
}
