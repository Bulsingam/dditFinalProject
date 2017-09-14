package kr.or.gd.project.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.gd.project.dao.IProjectDao;
import kr.or.gd.vo.ProjectVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IProjectServiceImpl implements IProjectService {

	@Autowired
	private IProjectDao dao;

	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public String insertPro(ProjectVO projectInfo, List<String> proMemNumList, List<String> proMemRoleList) {
		String success = "-1";
		try {
			success = dao.insertPro(projectInfo, proMemNumList, proMemRoleList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public List<Map<String, String>> getProList(Map<String, String> params) {
		List<Map<String, String>> projectList = null;
		try {
			projectList = dao.getProList(params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return projectList;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public Map<String, String> getProBarInfo(String pickProjectID) throws SQLException {
		Map<String, String> proBarInfo = null;
		proBarInfo = dao.getProBarInfo(pickProjectID);
		return proBarInfo;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public void endProStatus() {
		try {
			dao.endProStatus();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public void updatePro(List<String> proMemNumList,
			List<String> proMemRoleList, List<String> deleteMemNumList,
			ProjectVO projectInfo) {
		try {
			dao.updatePro(proMemNumList, proMemRoleList, deleteMemNumList, projectInfo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public void dropProject(String proID) {
		try {
			dao.dropProject(proID);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public String getProjectTotalCount(Map<String, String> params) {
		String count = "";
		try {
			count = dao.getProjectTotalCount(params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	

	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public Map<String, List<Map<String, String>>> getIngCheckList(Map<String, String> searchInfo) throws SQLException{
		List<Map<String, String>> ingList = dao.getIngList(searchInfo);
		List<Map<String, String>> endList = dao.getEndList(searchInfo);
		Map<String,List<Map<String, String>>> ingEndList = new HashMap<String, List<Map<String,String>>>();
		ingEndList.put("ingList", ingList);
		ingEndList.put("endList", endList);
		return ingEndList;
	}
	
	
	
}
