package kr.or.gd.anonymousBoard.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.anonymousBoard.dao.IAnonymousBoardDao;
import kr.or.gd.vo.AnonymousBoardVO;
import kr.or.gd.vo.FileItemVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IAnonymousBoardServiceImpl implements IAnonymousBoardService{
	@Autowired
	private IAnonymousBoardDao dao;

	// 익명게시판 글 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public String insertAnyBo(AnonymousBoardVO anyBoInfo) throws Exception {
		String insertAnyBo = null;
		insertAnyBo = dao.insertAnyBo(anyBoInfo);
		return insertAnyBo;
	}

	// 익명게시판 리스트 출력
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getAnyList(Map<String, String> params)
			throws Exception {
		List<Map<String, String>> getAnyList = null;
		getAnyList = dao.getAnyList(params);
		return getAnyList;
	}

	// 익명게시판 페이징
	@Override
	public int getTotalcount(Map<String, String> params) throws Exception {
		int getTotalcount = -1;
		getTotalcount = dao.getTotalcount(params);
		return getTotalcount;
	}

	// 익명게시판 상세정보
	// 익명게시판 조회수
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getAnyBoInfoView(Map<String, String> params)
			throws Exception {
		List<Map<String, String>> getAnyBoInfoView = null;
		int anyBoHit = dao.anyBoHit(params);
		getAnyBoInfoView = dao.getAnyBoInfoView(params);
		return getAnyBoInfoView;
	}

	// 익명게시판 파일 다운로드
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public FileItemVO getAnyFileDownload(Map<String, String> params)
			throws Exception {
		FileItemVO getAnyFileDownload = null;
		getAnyFileDownload = dao.getAnyFileDownload(params);
		return getAnyFileDownload;
	}

	// 익명게시판 정보 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int updateAnyBo(AnonymousBoardVO anyBoInfo) throws Exception {
		int updateAnyBo = -1;
		int deleteAnyBoFile = dao.deleteAnyBoFile(anyBoInfo);
		String insertAnyBoFile = dao.insertAnyBoFile(anyBoInfo);
		updateAnyBo = dao.updateAnyBo(anyBoInfo);
		return updateAnyBo;
	}

	// 익명게시판 게시글 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int deleteAnyBo(Map<String, String> params) throws Exception {
		int deleteAnyBo = -1;
		deleteAnyBo = dao.deleteAnyBo(params);
		return deleteAnyBo;
	}

	// 익명게시판 댓글 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public String insertReplyAnyBo(AnonymousBoardVO anyBoInfo) throws Exception {
		String insertReplyAnyBo = null;
		insertReplyAnyBo = dao.insertReplyAnyBo(anyBoInfo);
		return insertReplyAnyBo;
	}

	// 파일정보 불러오기
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public FileItemVO getFileInfo(Map<String, String> params) throws Exception {
		FileItemVO getFileInfo = null;
		getFileInfo = dao.getFileInfo(params);
		return getFileInfo;
	}
	
}


















