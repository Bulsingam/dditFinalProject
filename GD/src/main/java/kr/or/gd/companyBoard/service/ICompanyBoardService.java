package kr.or.gd.companyBoard.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.CompanyBoardVO;
import kr.or.gd.vo.FileItemVO;

public interface ICompanyBoardService {
	
	
	/**
	 * 사내게시판 게시글 등록
	 * @param comboardInfo 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public String insertComboardInfo(CompanyBoardVO comboardInfo);
	
	
	
	
	/**
	 * 사내게시판 게시글 답글 달기
	 * @param comboardInfo 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public String insertReplyComboard(CompanyBoardVO comboardInfo) throws Exception;
	
	
	
	
	/**
	 * 사내게시판 게시글 상세조회
	 * @param com_postnum 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public List<Map<String,String>>getComBoView(Map<String, String> params) throws Exception;
	
	
	
	
	/**
	 * 사내게시판 게시글 수정
	 * @param comboardInfo 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public int updateComboardInfo(CompanyBoardVO comboardInfo);

	
	
	
	
	/**
	 * 사내게시판 게시글 생성
	 * @param com_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public List<Map<String, String>>getComboardList(Map<String,String>params) throws Exception;
	
	
	
	
	
	/**
	 * 사내게시판 게시글 생성
	 * @param com_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public int deleteComboardInfo(Map<String,String>params);
	
	
	
	
	
	/**
	 * 사내게시판 게시글 생성
	 * @param com_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public FileItemVO getComFileDownload(Map<String, String> params) throws Exception;
	
	
	
	
	
	/**
	 * 사내게시판 게시글 생성
	 * @param com_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	public int getTotalCount(Map<String, String> params)throws Exception;
	

	
	
	
	
}
