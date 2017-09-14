package kr.or.gd.projectBoard.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.projectBoard.dao.IProjectBoardDao;
import kr.or.gd.vo.ProjectBoardVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IProjectBoardServiceImpl implements IProjectBoardService {
	
	@Autowired
	private IProjectBoardDao dao;

	// 프로젝트 게시판 리스트
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getProBoList(Map<String, String> params)
			throws Exception {
		List<Map<String, String>> getProBoList = null;
		getProBoList = dao.getProBoList(params);
		return getProBoList;
	}

	// 프로젝트 게시판 페이징
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public int getTotalcount(Map<String, String> params) throws Exception {
		int getTotalcount = -1;
		getTotalcount = dao.getTotalcount(params);
		return getTotalcount;
	}

	// 프로젝트 게시판 글등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public String insertProBo(ProjectBoardVO proBoInfo) throws Exception {
		String insertProBo = null;
		insertProBo = dao.insertProBo(proBoInfo);
		return insertProBo;
	}

	// 프로젝트 게시판 상세보기
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getProBoInfo(Map<String, String> params)
			throws Exception {
		List<Map<String, String>>  getProBoInfo = null;
		int upHit = dao.upHit(params);
		getProBoInfo = dao.getProBoInfo(params);
		return getProBoInfo;
	}

	// 프로젝트 게시판 정보 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int updateProBo(ProjectBoardVO proBoInfo) throws Exception {
		int updateProBo = -1;
		updateProBo = dao.updateProBo(proBoInfo);
		return updateProBo;
	}

	//프로젝트 게시판 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int deleteProBo(String pro_bo_num) throws Exception {
		int deleteProBo = -1;
		deleteProBo = dao.deleteProBo(pro_bo_num);
		return deleteProBo;
	}

	// 프로젝트 게시판 댓글 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public String insertReplyProBo(ProjectBoardVO proBoInfo) throws Exception {
		String insertReplyProBo = null;
		insertReplyProBo = dao.insertReplyProBo(proBoInfo);
		return insertReplyProBo;
	}

	//proScheView에서 프로젝트 게시판 리스트
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getProBoScheList(Map<String, String> params)
			throws Exception {
		List<Map<String, String>> getProBoScheList = null;
		getProBoScheList = dao.getProBoScheList(params);
		return getProBoScheList;
	}
	
}
