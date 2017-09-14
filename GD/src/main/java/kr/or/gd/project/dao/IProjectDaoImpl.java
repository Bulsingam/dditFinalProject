package kr.or.gd.project.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ProjectMemberVO;
import kr.or.gd.vo.ProjectVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IProjectDaoImpl implements IProjectDao {

	@Autowired
	private SqlMapClient client;

	@Override
	public String insertPro(ProjectVO projectInfo, List<String> proMemNumList, List<String> proMemRoleList) throws SQLException {
		String success = (String) client.insert("project.insertProject", projectInfo);
		System.out.println(success);
		ProjectMemberVO projectMemInfo = new ProjectMemberVO();
		
		projectMemInfo.setMem_proid(success);
		for (int i = 0; i <= proMemNumList.size()-1; i++) {
			projectMemInfo.setMem_emp(proMemNumList.get(i).toString());
			projectMemInfo.setMem_role(proMemRoleList.get(i).toString());
			client.insert("projectMember.insertProjectMember", projectMemInfo);
		}
		return success;
	}

	@Override
	public List<Map<String, String>> getProList(Map<String, String> params) throws SQLException {
		return client.queryForList("project.projectList", params);
	}

	@Override
	public Map<String, String> getProBarInfo(String pickProjectID)
			throws SQLException {
		return (Map<String, String>) client.queryForObject("project.proBarInfo",pickProjectID);
	}
	
	@Override
	public void endProStatus() throws SQLException {
		client.update("project.endProject");
		List<String> endList = (List<String>) client.queryForList("project.allEndList");
		for (String pro_id : endList) {
			client.update("projectMember.endProject", pro_id);
		}
	}

	@Override
	public void updatePro(List<String> proMemNumList, List<String> proMemRoleList, List<String> deleteMemNumList,
			ProjectVO projectInfo) throws SQLException {
		client.update("project.updateProejct", projectInfo);
		ProjectMemberVO projectMemInfo = new ProjectMemberVO();
		if(proMemNumList != null && proMemRoleList != null){
			for (int i = 0; i <= proMemNumList.size()-1; i++) {
				projectMemInfo.setMem_emp(proMemNumList.get(i).toString());
				projectMemInfo.setMem_role(proMemRoleList.get(i).toString());
				projectMemInfo.setMem_proid(projectInfo.getPro_id().toString());
				client.insert("projectMember.insertProjectMember", projectMemInfo);
			}
		}
		if (deleteMemNumList != null) {
			for (int i = 0; i <= deleteMemNumList.size()-1; i++) {
				projectMemInfo.setMem_emp(deleteMemNumList.get(i).toString());
				projectMemInfo.setMem_proid(projectInfo.getPro_id().toString());
				client.update("projectMember.outProjectMember", projectMemInfo);
			}
		}
	}

	@Override
	public void dropProject(String proID) throws SQLException {
		client.update("project.dropProject", proID);
	}
	
	@Override
	public String getProjectTotalCount(Map<String, String> params)
			throws SQLException {
		return (String) client.queryForObject("project.projectTotalCount", params);
	}

	@Override
	public List<Map<String, String>> getIngList(Map<String, String> searchInfo) throws SQLException {
		return client.queryForList("project.ingList",searchInfo);
	}

	@Override
	public List<Map<String, String>> getEndList(Map<String, String> searchInfo) throws SQLException {
		return client.queryForList("project.endList",searchInfo);
	}
}

