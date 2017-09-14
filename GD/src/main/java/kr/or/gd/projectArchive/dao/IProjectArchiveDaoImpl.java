package kr.or.gd.projectArchive.dao;

import java.util.List;
import java.util.Map;

import kr.or.gd.vo.FileItemVO;
import kr.or.gd.vo.ProjectArchiveVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IProjectArchiveDaoImpl implements IProjectArchiveDao {

	@Autowired
	private SqlMapClient client;

	// 프로젝트 자료실 글 등록
	@Override
	public String insertProArc(ProjectArchiveVO proAcrInfo) throws Exception {
		return (String) client.insert("projectarchive.insertProArc", proAcrInfo);
	}

	// 프로젝트 리스트 출력
	@Override
	public List<Map<String, String>> getProArcList(Map<String, String> params)
			throws Exception {
		return client.queryForList("projectarchive.getProArcList", params);
	}

	// 프로젝트 페이징 
	@Override
	public int getTotalcount(Map<String, String> params) throws Exception {
		return (int) client.queryForObject("projectarchive.totalCount", params);
	}

	// 프로젝트 자료실 삭제
	@Override
	public int deleteProArc(String pro_arc_num) throws Exception {
		return client.update("projectarchive.deleteProArc", pro_arc_num);
	}

	// 프로젝트 자료실 정보수정 뷰
	@Override
	public ProjectArchiveVO getProArc(String pro_arc_num)
			throws Exception {
		return (ProjectArchiveVO) client.queryForObject("projectarchive.getProArc", pro_arc_num);
	}

	// 프로젝트 자료실 정보수정
	@Override
	public int updateProArc(ProjectArchiveVO proArcInfo) throws Exception {
		return client.update("projectarchive.updateProArc", proArcInfo);
	}

	// 프로젝트 자료실 다운로드와 다운로드수
	@Override
	public ProjectArchiveVO downloadProArc(Map<String, String> params)
			throws Exception {
		client.update("projectarchive.updateDownHit", params);
		return (ProjectArchiveVO) client.queryForObject("projectarchive.download", params);
	}

	// proScheView에서 프로젝트 자료실 리스트
	@Override
	public List<Map<String, String>> getProArcScheList(Map<String, String> params) throws Exception {
		return client.queryForList("projectarchive.getProArcScheList", params);
	}




	
}
