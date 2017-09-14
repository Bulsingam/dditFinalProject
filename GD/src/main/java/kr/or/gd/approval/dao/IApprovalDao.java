package kr.or.gd.approval.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ApprovalLineVO;

public interface IApprovalDao {

	/**
	 * 사내 표준 서식 리스트를 불러오는 메서드
	 * @param	params 검색 조건
	 * @return	사내 표준으로 정해진 서식 정보가 담긴 리스트
	 * @throws	SQLException
	 * @author	박일훈
	 * @since 	2017.08.28	최초 작성<br>
	 * 			2017.08.30	구현 완료
	 */
	public List<Map<String, String>> getFormList(Map<String, String> params) throws SQLException;
	
	/**
	 * 결재선 생성 메서드
	 * @return 	생성된 결재선 번호
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.08.31	최초 작성 및 구현
	 */
	public String insertAprLine(ApprovalLineVO approvalLine) throws SQLException;
	
	/**
	 * 결재선 사원 삽입 메서드
	 * @param	params 사원번호와 결재선번호가 포함된 맵
	 * @return 	성공시 1 반환
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since 	2017.08.31	최초 작성 및 구현
	 */
	public int fillAprLine(Map<String, String> params) throws SQLException;
	
	/**
	 * 전자결재 상태 변환 메서드
	 * @param 	params 결재자,결재선번호,결재상태가 포함된 맵
	 * @return	결재 성공시 1 반환
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.08.31	최초 작성 및 구현
	 */
	public int aprStaSetting(Map<String, String> params) throws SQLException;
	
	/**
	 * 결재선 취득 메서드
	 * @param 	line_num 취득할 결재선 번호
	 * @return	결재선 번호에 해당하는 결재선 사원 리스트 
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.09.04	최초 작성 및 구현
	 */
	public List<Map<String, String>> getAprLine(String line_num) throws SQLException;
	
	/**
	 * 결재선 삭제 메서드
	 * @param 	line_num 삭제할 결재선 번호
	 * @return	삭제에 성공했을 때 1반환
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.09.04	최초 작성 및 구현
	 */
	public int deleteAprLine(String line_num) throws SQLException;

	/**
	 * 서식 전결자 변경 메서드
	 * @param 	params 변경정보가 저장된 맵
	 * @author 	박일훈
	 * @since	2017.09.04	최초 작성 및 구현
	 */
	public void updateFormProx(Map<String, String> params) throws SQLException;

}
