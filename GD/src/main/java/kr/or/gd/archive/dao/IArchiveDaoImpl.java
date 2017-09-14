package kr.or.gd.archive.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ArchiveVO;
import kr.or.gd.vo.FileItemVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IArchiveDaoImpl implements IArchiveDao{
	@Autowired
	private SqlMapClient client;

	@Override
	public List<Map<String, String>> getArcList(Map<String, String> params) throws Exception {
		return client.queryForList("archive.getArcList", params);
	}

	@Override
	public List<Map<String, String>> getArcInfoView(Map<String, String> params) throws Exception {
		return client.queryForList("archive.getArcInfo", params);
	}

	@Override
	public int deleteArc(Map<String, String> params) throws Exception {
		return client.update("archive.deleteArc", params);
	}

	@Override
	public String insertArc(ArchiveVO archiveInfo) throws Exception {
		String arc_postnum;
		
		client.startTransaction();
		
		arc_postnum = (String) client.insert("archive.insertArc", archiveInfo);
		
		List<FileItemVO> fileInfoList = archiveInfo.getAttachFileInfo();
		for(FileItemVO fileInfo : fileInfoList){
			fileInfo.setFile_postnum(arc_postnum);
			client.insert("archive.insertFileItem", fileInfo);
		}
		
		client.commitTransaction();
		client.endTransaction();
		
		return arc_postnum;
	}

	@Override
	public int arcHit(Map<String, String> params)
			throws Exception {
		return client.update("archive.uphit", params);
	}

	@Override
	public FileItemVO getArcFileDownload(Map<String, String> params) throws Exception{
		client.update("archive.updateFileDownHit", params);
		return (FileItemVO) client.queryForObject("archive.fileItemInfo", params);
	}

	@Override
	public int updateArc(ArchiveVO archiveInfo) throws Exception {
		return client.update("archive.updateArc", archiveInfo);
	}

	@Override
	public String insertReplyArc(ArchiveVO archiveInfo) throws Exception {
		
		String depth = String.valueOf(Integer.parseInt(archiveInfo.getArc_postdep()) + 1);
		
		String seq = "";
		if("0".intern() == archiveInfo.getArc_postseq().intern()){
			seq = (String) client.queryForObject("archive.incrementSeq", archiveInfo);
		}else{
			client.update("archive.updateSeq", archiveInfo);
			seq = String.valueOf(Integer.parseInt(archiveInfo.getArc_postseq()) + 1);
		}
		archiveInfo.setArc_postdep(depth);
		archiveInfo.setArc_postseq(seq);
		
		return (String) client.insert("archive.insertReplyArc", archiveInfo);
	
	}

	@Override
	public int getTotalCount(Map<String, String> params) throws Exception {
		return (int) client.queryForObject("archive.totalCount", params);
	}

	// 자료실 파일 수정시 기존 파일 삭제
	@Override
	public int deleteArcFile(ArchiveVO archiveInfo) throws Exception {
		
		int arc_postnum = Integer.parseInt(archiveInfo.getArc_postnum());
		
		List<FileItemVO> fileInfoList = archiveInfo.getAttachFileInfo();
		for(FileItemVO fileInfo : fileInfoList){
			fileInfo.setFile_postnum( String.valueOf( arc_postnum ));
			arc_postnum = client.update("archive.deleteArcFile",fileInfo);
		}
		
		return arc_postnum;

	}

	// 자료실 파일 수정시 파일 인서트
	@Override
	public String insertArcFile(ArchiveVO archiveInfo) throws Exception {
		
		String arc_postnum = archiveInfo.getArc_postnum();
		
		List<FileItemVO> fileInfoList = archiveInfo.getAttachFileInfo();
		for(FileItemVO fileInfo : fileInfoList){
			fileInfo.setFile_postnum(arc_postnum);
			arc_postnum = (String) client.insert("archive.insertFileItem", fileInfo);
		}
		
		return arc_postnum;
	}

	@Override
	public FileItemVO getFileInfo(Map<String, String> params) throws Exception {
		return (FileItemVO) client.queryForObject("archive.getFileInfo", params);
	}









	

}
