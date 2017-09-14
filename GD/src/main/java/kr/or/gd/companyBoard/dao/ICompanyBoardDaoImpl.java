package kr.or.gd.companyBoard.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.CompanyBoardVO;
import kr.or.gd.vo.FileItemVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class ICompanyBoardDaoImpl implements ICompanyBoardDao {
	@Autowired
	private SqlMapClient client;

	
	
	
	
	/**
	 * 사내게시판 게시글 등록
	 * @param comboardInfo
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public String insertComboardInfo(CompanyBoardVO comboardInfo) throws SQLException {
		String com_postnum;
		
		client.startTransaction();
		
		com_postnum = (String) client.insert("comboard.insertComBoInfo",comboardInfo);

		
		List<FileItemVO> fileInfoList = comboardInfo.getAttachFileInfo();
		for(FileItemVO fileInfo: fileInfoList){
			fileInfo.setFile_postnum(com_postnum);
			client.insert("comboard.insertFileItem", fileInfo);
		}
			client.commitTransaction();
			client.endTransaction();
			
		
		return com_postnum;
	}

	
	
	
	/**
	 * 사내게시판 게시글 상세조회
	 * @param com_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public List<Map<String, String>> getComBoView(Map<String, String> params)
			throws SQLException {
		
		return (List<Map<String,String>>) client.queryForList("comboard.comboardInfo",params);
	}

	
	
	/**
	 * 사내게시판 게시글 수정
	 * @param comboardInfo
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public int updateComboardInfo(CompanyBoardVO comboardInfo) throws SQLException {
		return client.update("comboard.updateComboardInfo", comboardInfo);
	}
	
	
	
	/**
	 * 사내게시판 게시글 리스트 출력
	 * @param com_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public List<Map<String, String>> getComboardList(Map<String, String> params)
			throws SQLException {
		
		return client.queryForList("comboard.comboardList",params);
		
	}

	
	
	/**
	 * 사내게시판 게시글 삭제
	 * @param com_postnum
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public int deleteComboardInfo(Map<String, String> params) throws SQLException {
		
		return client.update("comboard.deleteComboardInfo",params);
	}
	
	
	
	/**
	 * 사내게시판 게시글 파일 다운로드
	 * @param file_seq
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public FileItemVO getComFileDownload(Map<String, String> params)
		throws Exception{
		client.update("comboard.updateFileDownHit", params);
		return (FileItemVO) client.queryForObject("comboard.fileItemInfo", params);
	}
	
	
	
	/**
	 * 사내게시판 게시글 페이징 구현
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public int getTotalCount(Map<String, String> params) throws Exception {
		return (int) client.queryForObject("comboard.totalCount", params);
	}

	
	
	/**
	 * 사내게시판 게시글 답글등록
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public String insertReplyComboard(CompanyBoardVO comboardInfo)
			throws Exception {
		
		String depth = String.valueOf(Integer.parseInt(comboardInfo.getCom_postdep()) + 1);
		
		String seq = "";
		if("0".intern() == comboardInfo.getCom_postseq().intern()){
			seq = (String) client.queryForObject("comboard.incrementSeq", comboardInfo);
		}else{
			client.update("comboard.updateSeq", comboardInfo);
			seq = String.valueOf(Integer.parseInt(comboardInfo.getCom_postseq()) + 1);
		}
		comboardInfo.setCom_postdep(depth);
		comboardInfo.setCom_postseq(seq);
		
		return (String) client.insert("comboard.insertReplyComboard", comboardInfo);
		
	}

	

	
	/**
	 * 사내게시판 게시글 조회수
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public int comHit(Map<String, String> params)
			throws Exception {
		return client.update("comboard.uphit", params);
	}



	

}
