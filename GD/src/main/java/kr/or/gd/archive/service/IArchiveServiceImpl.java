package kr.or.gd.archive.service;


import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.archive.dao.IArchiveDao;
import kr.or.gd.vo.ArchiveVO;
import kr.or.gd.vo.FileItemVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IArchiveServiceImpl implements IArchiveService{
	
	@Autowired
	private IArchiveDao dao;

	// 자료실 리스트 
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getArcList(Map<String, String> params)
			throws Exception {
		List<Map<String, String>> getArcList = null;
		getArcList = dao.getArcList(params);
		return getArcList;
	}

	// 자료실 상세정보
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getArcInfoView(Map<String, String> params)
			throws Exception {
		List<Map<String, String>> getArcInfoView = null;
		// 자료실 조회수
		int arcHit = dao.arcHit(params);
		getArcInfoView = dao.getArcInfoView(params);
		return getArcInfoView;
	}

	// 자료실 글 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int deleteArc(Map<String, String> params) throws Exception {
		int deleteArc = -1;
		deleteArc = dao.deleteArc(params);
		return deleteArc;
	}

	// 자료실 글 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public String insertArc(ArchiveVO archiveInfo) throws Exception {
		String insertArc = null;
		insertArc = dao.insertArc(archiveInfo);
		return insertArc;
	}
	
	// 자료실 파일 다운로드
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public FileItemVO getArcFileDownload(Map<String, String> params)
			throws Exception {
		FileItemVO getArcFileDownload = null;
		getArcFileDownload = dao.getArcFileDownload(params);
		return getArcFileDownload;
	}

	// 자료실 정보 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int updateArc(ArchiveVO archiveInfo) throws Exception {
		int updateArc = -1;
		int deleteArcFile = dao.deleteArcFile(archiveInfo);
		String insertArcFile = dao.insertArcFile(archiveInfo);
		updateArc = dao.updateArc(archiveInfo);
		return updateArc;
		
	}

	// 자료실 댓글 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public String insertReplyArc(ArchiveVO archiveInfo) throws Exception {
		String insertReplyArc = null;
		insertReplyArc = dao.insertReplyArc(archiveInfo);
		return insertReplyArc;
	}

	// 자료실 페이징
	@Override
	public int getTotalCount(Map<String, String> params) throws Exception {
		int getTotalCount = -1;
		getTotalCount = dao.getTotalCount(params);
		return getTotalCount;
	}

	// 자료실 파일정보 불러오기
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public FileItemVO getFileInfo(Map<String, String> params) throws Exception {
		FileItemVO getFileInfo = null;
		getFileInfo = dao.getFileInfo(params);
		return getFileInfo;
	}
	



	
}
