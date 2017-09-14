package kr.or.gd.noticeBoard.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;




import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.noticeBoard.dao.INoticeBoardDao;
import kr.or.gd.vo.FileItemVO;
import kr.or.gd.vo.NoticeBoardVO;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class INoticeBoardServiceImpl implements INoticeBoardService {
	
	@Autowired
	private INoticeBoardDao dao;
	
	/**
	 * 공지게시판 게시글 생성
	 * @param notiboardInfo 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public String insertNotiboardInfo(NoticeBoardVO notiboardInfo) {
		
		String insertInfo = null;
		
		try {
			insertInfo  = dao.insertNotiboardInfo(notiboardInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return insertInfo;
	}



	/**
	 * 공지게시판 게시글 상세보기
	 * @param noti_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getNotiView(Map<String, String> params) throws Exception {
		List<Map<String, String>> notiboardInfo = null;
	
		notiboardInfo = dao.getNotiView(params);
	
		int notiHit = dao.notiHit(params);
		notiboardInfo = dao.getNotiView(params);
		return notiboardInfo;
	}



	/**
	 * 공지게시판 게시글 수정
	 * @param notiboardInfo
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int updateNotiboardInfo(NoticeBoardVO notiboardInfo) {
		int updatCnt = -1;
		try {
			updatCnt = dao.updateNotiboardInfo(notiboardInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return updatCnt;
	}


	/**
	 * 공지게시판 게시글 리스트보기
	 * @param noti_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getNotiboardList(Map<String, String> params)
			throws Exception {
		List<Map<String,String>> notiboardList = null;
		notiboardList = dao.getNotiboardList(params);

		return notiboardList;
	}


	/**
	 * 공지게시판 게시글 삭제
	 * @param noti_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int deleteNotiboardInfo(Map<String, String> params) throws Exception {
		int deleteCnt = -1;
		try {
			deleteCnt = dao.deleteNotiboardInfo(params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return deleteCnt;
	}


	/**
	 * 공지게시판 게시글 파일다운로드
	 * @param file_seq
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public FileItemVO getNotiFileDownload(Map<String, String> params)
			throws Exception {
		FileItemVO getNotiFileDownload = null;
		getNotiFileDownload = dao.getNotiFileDownload(params);
		return getNotiFileDownload;
	}


	/**
	 * 공지게시판 게시글 페이징구현
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public int getTotalCount(Map<String, String> params) throws Exception {
		int getTotalCount = -1;
		getTotalCount = dao.getTotalCount(params);
		return getTotalCount;
	}






//	@Override
//	public String insertReplyNotiboard(NoticeBoardVO notiboardInfo)
//			throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}







	

}
