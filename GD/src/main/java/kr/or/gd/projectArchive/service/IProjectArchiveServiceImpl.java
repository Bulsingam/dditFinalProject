package kr.or.gd.projectArchive.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.projectArchive.dao.IProjectArchiveDao;
import kr.or.gd.vo.ProjectArchiveVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IProjectArchiveServiceImpl implements IProjectArchiveService {
	@Autowired
	private IProjectArchiveDao dao;

	// 프로젝트 자료실 글 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public String insertProArc(ProjectArchiveVO proAcrInfo) throws Exception {
		String insertProArc = null;
		insertProArc = dao.insertProArc(proAcrInfo);
		return insertProArc;
	}

	// 프로젝트 리스트 출력
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getProArcList(Map<String, String> params)
			throws Exception {
		List<Map<String, String>> getProArcList = null;
		getProArcList = dao.getProArcList(params);
		return getProArcList;
	}

	// 프로젝트 페이징
	@Override
	public int getTotalcount(Map<String, String> params) throws Exception {
		int getTotalcount = -1;
		getTotalcount = dao.getTotalcount(params);
		return getTotalcount;
	}

	// 프로젝트 자료실 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int deleteProArc(String pro_arc_num) throws Exception {
		int deleteProArc = -1;
		deleteProArc = dao.deleteProArc(pro_arc_num);
		return deleteProArc;
	}

	// 프로젝트 자료실 정보 수정 뷰
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public ProjectArchiveVO getProArc(String pro_arc_num)
			throws Exception {
		ProjectArchiveVO updateProArcView = null;
		updateProArcView = dao.getProArc(pro_arc_num);
		return updateProArcView;
	}

	// 프로젝트 자료실 정보 수정
	// 파일수정 추가 2017-09-05
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int updateProArc(ProjectArchiveVO proArcInfo) throws Exception {
		int updateProArc = -1;
		updateProArc = dao.updateProArc(proArcInfo);
		return updateProArc;
	}

	// 프로젝트 자료실 다운로드
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public ProjectArchiveVO downloadProArc(Map<String, String> params)
			throws Exception {
		ProjectArchiveVO downloadProArc = null;
		downloadProArc = dao.downloadProArc(params);
		return downloadProArc;
	}
	
	//proScheView에서 프로젝트 자료실 리스트
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getProArcScheList(Map<String, String> params) throws Exception {
		List<Map<String, String>> getProArcScheList = null;
		getProArcScheList = dao.getProArcScheList(params);
		return getProArcScheList;
	}


}
