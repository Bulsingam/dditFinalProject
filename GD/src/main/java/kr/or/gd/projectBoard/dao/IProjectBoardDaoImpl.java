package kr.or.gd.projectBoard.dao;

import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ProjectBoardVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IProjectBoardDaoImpl implements IProjectBoardDao {

	@Autowired
	private SqlMapClient client;

	// 프로젝트 게시판 리스트
	@Override
	public List<Map<String, String>> getProBoList(Map<String, String> params)
			throws Exception {
		return client.queryForList("projectboard.getProBoList", params);
	}

	// 프로젝트 게시판 페이징
	@Override
	public int getTotalcount(Map<String, String> params) throws Exception {
		return (int) client.queryForObject("projectboard.totalCount", params);
	}

	// 프로젝트 게시판 글등록
	@Override
	public String insertProBo(ProjectBoardVO proBoInfo) throws Exception {
		return (String) client.insert("projectboard.insertProBo", proBoInfo);
	}

	// 프로젝트 게시판 상세보기
	@Override
	public List<Map<String, String>> getProBoInfo(Map<String, String> params)
			throws Exception {
		return client.queryForList("projectboard.getProBoInfo", params);
	}

	// 프로젝트 게시판 정보 수정
	@Override
	public int updateProBo(ProjectBoardVO proBoInfo) throws Exception {
		return client.update("projectboard.updateProBo", proBoInfo);
	}

	// 프로젝트 조회수 업
	@Override
	public int upHit(Map<String, String> params) throws Exception {
		return client.update("projectboard.upHit", params);
	}

	// 프로젝트 게시판 삭제
	@Override
	public int deleteProBo(String pro_bo_num) throws Exception {
		return client.update("projectboard.deleteProBo", pro_bo_num);
	}

	// 프로젝트 게시판 댓글 등록
	@Override
	public String insertReplyProBo(ProjectBoardVO proBoInfo) throws Exception {
		
		String depth = String.valueOf(Integer.parseInt(proBoInfo.getPro_bo_dep()) + 1);
		
		String seq = "";
		if("0".intern() == proBoInfo.getPro_bo_seq().intern()){
			seq = (String) client.queryForObject("projectboard.incrementSeq", proBoInfo);
		}else{
			client.update("projectboard.updateSeq", proBoInfo);
			seq = String.valueOf(Integer.parseInt(proBoInfo.getPro_bo_seq()) + 1);
		}
		
		proBoInfo.setPro_bo_dep(depth);
		proBoInfo.setPro_bo_seq(seq);
		
		return (String) client.insert("projectboard.insertReplyProBo", proBoInfo);
	}

	// proScheView에서 프로젝트 게시판 리스트
	@Override
	public List<Map<String, String>> getProBoScheList(Map<String, String> params)throws Exception {
		return client.queryForList("projectboard.getProBoScheList", params);
	}
}




















