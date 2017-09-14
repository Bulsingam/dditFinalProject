package kr.or.gd.anonymousBoard.dao;

import java.util.List;
import java.util.Map;

import kr.or.gd.vo.AnonymousBoardVO;
import kr.or.gd.vo.FileItemVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IAnonymousBoardDaoImpl implements IAnonymousBoardDao{
	@Autowired
	private SqlMapClient client;

	// 익명게시판 글등록
	@Override
	public String insertAnyBo(AnonymousBoardVO anyBoInfo) throws Exception {
		
		String any_postnum;
		
		client.startTransaction();
		
		any_postnum = (String) client.insert("anonymousboard.insertAnyBo",anyBoInfo);
		
		List<FileItemVO> fileInfoList = anyBoInfo.getAttachFileInfo();		
		for(FileItemVO fileInfo : fileInfoList){
			fileInfo.setFile_postnum(any_postnum);
			client.insert("anonymousboard.insertFileItem", fileInfo);
		}
		
		client.commitTransaction();
		client.endTransaction();
		
		return any_postnum;
	}

	// 익명게시판 리스트 출력
	@Override
	public List<Map<String, String>> getAnyList(Map<String, String> params)
			throws Exception {
		return client.queryForList("anonymousboard.getAnyBoList", params);
	}

	// 익명게시판 페이징
	@Override
	public int getTotalcount(Map<String, String> params) throws Exception {
		return (int) client.queryForObject("anonymousboard.totalCount", params);
	}

	// 익명게시판 상세정보 출력
	@Override
	public List<Map<String, String>> getAnyBoInfoView(Map<String, String> params) throws Exception {
		return client.queryForList("anonymousboard.getAnyBoInfo", params);
	}

	// 익명게시판 파일 다운로드
	@Override
	public FileItemVO getAnyFileDownload(Map<String, String> params)
			throws Exception {
		client.update("anonymousboard.updateFileDownHit", params);
		return (FileItemVO) client.queryForObject("anonymousboard.fileItemInfo", params);
	}

	// 익명게시판 정보 수정
	@Override
	public int updateAnyBo(AnonymousBoardVO anyBoInfo) throws Exception {
		return client.update("anonymousboard.updataAnyBo", anyBoInfo);
	}

	// 익명게시판 게시글 삭제
	@Override
	public int deleteAnyBo(Map<String, String> params) throws Exception {
		return client.update("anonymousboard.deleteAnyBo", params);
	}

	// 익명게시판 조회수
	@Override
	public int anyBoHit(Map<String, String> params) throws Exception {
		return client.update("anonymousboard.uphit", params);
	}

	// 익명게시판 댓글 등록
	@Override
	public String insertReplyAnyBo(AnonymousBoardVO anyBoInfo) throws Exception {
		
		String depth = String.valueOf(Integer.parseInt(anyBoInfo.getAny_postdep()) + 1);
		
		String seq = "";
		if("0".intern() == anyBoInfo.getAny_postseq().intern() ){
			seq = (String) client.queryForObject("anonymousboard.incrementSeq", anyBoInfo);
		}else{
			client.update("anonymousboard.updateSeq", anyBoInfo);
			seq = String.valueOf(Integer.parseInt(anyBoInfo.getAny_postseq()) + 1);
		}
		
		anyBoInfo.setAny_postdep(depth);
		anyBoInfo.setAny_postseq(seq);
		
		return (String) client.insert("anonymousboard.insertReplyAnyBo", anyBoInfo);
	}

	// 익명게시판 파일 수정시 기존 파일 삭제
	@Override
	public int deleteAnyBoFile(AnonymousBoardVO anyBoInfo) throws Exception {
		
		int any_postnum = Integer.parseInt(anyBoInfo.getAny_postnum());
		
		List<FileItemVO> fileInfoList = anyBoInfo.getAttachFileInfo();
		for(FileItemVO fileInfo : fileInfoList){
			fileInfo.setFile_postnum( String.valueOf( any_postnum ));
			any_postnum = client.update("anonymousboard.deleteAnyBoFile",fileInfo);
		}
		
		return any_postnum;
	}

	// 익명게시판 파일 수정시 파일 인서트
	@Override
	public String insertAnyBoFile(AnonymousBoardVO anyBoInfo) throws Exception {
		
		String any_postnum = anyBoInfo.getAny_postnum();
		
		List<FileItemVO> fileInfoList = anyBoInfo.getAttachFileInfo();
		for(FileItemVO fileInfo : fileInfoList){
			fileInfo.setFile_postnum(any_postnum);
			any_postnum = (String) client.insert("anonymousboard.insertFileItem", fileInfo);
		}
		
		return any_postnum;
	}

	// 익명게시판 파일 정보 불러오기
	@Override
	public FileItemVO getFileInfo(Map<String, String> params) throws Exception {
		return (FileItemVO) client.queryForObject("anonymousboard.getFileInfo", params);
	}
	
}



















