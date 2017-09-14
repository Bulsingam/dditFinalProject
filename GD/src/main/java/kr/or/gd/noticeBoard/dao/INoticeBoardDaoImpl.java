package kr.or.gd.noticeBoard.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;



import kr.or.gd.vo.FileItemVO;
import kr.or.gd.vo.NoticeBoardVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class INoticeBoardDaoImpl implements INoticeBoardDao {
	@Autowired
	private SqlMapClient client;

	/**
	 * 공지게시판 게시글 등록
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public String insertNotiboardInfo(NoticeBoardVO notiboardInfo)
			throws SQLException {
		String noti_postnum;
		
		client.startTransaction();
		
		noti_postnum = (String) client.insert("notiboard.insertNotiInfo",notiboardInfo);

		
		List<FileItemVO> fileInfoList = notiboardInfo.getAttachFileInfo();
		for(FileItemVO fileInfo: fileInfoList){
			fileInfo.setFile_postnum(noti_postnum);
			client.insert("notiboard.insertFileItem", fileInfo);
		}
			client.commitTransaction();
			client.endTransaction();
			
		
		return noti_postnum;
	}



	
	
	
	/**
	 * 공지게시판 게시글 상세보기
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public List<Map<String, String>> getNotiView(Map<String, String> params)
			throws SQLException {
		return (List<Map<String,String>>) client.queryForList("notiboard.notiboardInfo",params);
	}

	
	
	
	
	/**
	 * 공지게시판 게시글 수정
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public int updateNotiboardInfo(NoticeBoardVO notiboardInfo)
			throws SQLException {
		return client.update("notiboard.updateNotiboardInfo", notiboardInfo);
		
	}

	
	
	
	
	/**
	 * 공지게시판 게시글 리스트 출력
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public List<Map<String, String>> getNotiboardList(Map<String, String> params)
			throws SQLException {

		return client.queryForList("notiboard.notiboardList",params);
	}

	
	
	
	
	/**
	 * 공지게시판 게시글 삭제
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public int deleteNotiboardInfo(Map<String, String> params)
			throws SQLException {
		
		return client.update("notiboard.deleteNotiboardInfo",params);
	}

	
	
	
	/**
	 * 공지게시판 게시글 파일 다운로드
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public FileItemVO getNotiFileDownload(Map<String, String> params) throws Exception {
		client.update("notiboard.updateFileDownHit", params);
		return (FileItemVO) client.queryForObject("notiboard.fileItemInfo", params);
	}

	
	
	
	
	/**
	 * 공지게시판 게시글 페이징 구현
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@Override
	public int getTotalCount(Map<String, String> params) throws SQLException {
		return (int) client.queryForObject("notiboard.totalCount", params);
	}

	
	
	
	
	
	/**
	 * 공지게시판 게시글 조회수 출력
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */	
	@Override
	public int notiHit(Map<String, String> params)
			throws Exception {
		return client.update("notiboard.uphit", params);
	}


	

}
