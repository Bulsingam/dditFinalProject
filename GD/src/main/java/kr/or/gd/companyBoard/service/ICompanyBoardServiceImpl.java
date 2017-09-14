package kr.or.gd.companyBoard.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.companyBoard.dao.ICompanyBoardDao;
import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.vo.CompanyBoardVO;
import kr.or.gd.vo.FileItemVO;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ICompanyBoardServiceImpl implements ICompanyBoardService {
	
	@Autowired
	private ICompanyBoardDao dao;

	
	/**
	 * 사내게시판 게시글 생성
	 * @param comboardInfo 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public String insertComboardInfo(CompanyBoardVO comboInfo) {
			String insertInfo = null;
			
		try {
			insertInfo  = dao.insertComboardInfo(comboInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return insertInfo;
	
	
	}
	
	
	/**
	 * 사내게시판 상세정보조회
	 * @param com_postnum 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getComBoView(Map<String, String> params) 
	throws Exception{
		List<Map<String, String>> comboardInfo = null;
	
	 int comHit = dao.comHit(params);
	 comboardInfo = dao.getComBoView(params);
	
		return comboardInfo;
	}

	
	
	/**
	 * 사내게시판 수정
	 * @param com_postnum 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int updateComboardInfo(CompanyBoardVO comboardInfo) {
		int updatCnt = -1;
		try {
			updatCnt = dao.updateComboardInfo(comboardInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return updatCnt;
	}

	
	/**
	 * 사내게시판 리스트 조회
	 * @param com_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getComboardList(Map<String, String> params)
				throws Exception {
		
		List<Map<String,String>> comboardList = null;
			comboardList = dao.getComboardList(params);
	
		return comboardList;
	}

	
	/**
	 * 사내게시판 게시글삭제
	 * @param com_postnum 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int deleteComboardInfo(Map<String, String> params) {
		int deleteCnt = -1;
		try {
			deleteCnt = dao.deleteComboardInfo(params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return deleteCnt;
	}
	
	
	
	/**
	 * 사내게시판 파일 다운로드 
	 * @param file_seq 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public FileItemVO getComFileDownload(Map<String, String> params)
			throws Exception{
		FileItemVO getComFileDownload = null;
		getComFileDownload = dao.getComFileDownload(params);
		return getComFileDownload;
	}
	
	
	
	/**
	 * 사내게시판 페이징 구현
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
		
		
		
		
		/**
		 * 사내게시판 답글 생성
		 * @param  
		 * @author 조인호
		 * @since 2017-09-05
		 * 
		 */
		@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
		@Override
		public String insertReplyComboard(CompanyBoardVO comboardInfo) throws Exception {
		String insertReplyComboard = null;
		insertReplyComboard = dao.insertReplyComboard(comboardInfo);
		return insertReplyComboard;
		}

	

}
