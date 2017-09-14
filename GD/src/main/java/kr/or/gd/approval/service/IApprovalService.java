package kr.or.gd.approval.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.DocumentVO;
import kr.or.gd.vo.EmployeeVO;

public interface IApprovalService {

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
	 * 더 높은 직급의 사원 리스트를 불러오는 메서드
	 * @param	pos_id 작성자 직급 아이디
	 * @return 	직급별의 사원정보 List가 포함된 Map 
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since 	2017.08.28	최초 작성<br>
	 * 			2017.08.30	구현 완료
	 */
	public List<List<Map<String,String>>> getAprCandidateList(String pos_id) throws SQLException;

	/**
	 * 결재 등록 메서드
	 * @param 	loginEmp 로그인한 사용자(작성자)
	 * @param 	form 선택한 서식 정보
	 * @param 	document 작성한 문서 정보
	 * @param 	selectedCandidates 선택한 결재선
	 * @return	결재 등록 성공시 true
	 * @throws 	SQLException
	 * @author	박일훈
	 * @since 	2017.08.28	최초 작성<br>
	 * 			2017.08.31	구현 완료
	 */
	public boolean insertApr(EmployeeVO loginEmp, Map<String, String> form,
			DocumentVO document, ArrayList<String> selectedCandidates) throws SQLException;
	
	/**
	 * 결재선 조회 메서드
	 * @param 	doc_linenum 결재선 번호
	 * @return 	해당 번호의 결재선 정보
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since 	2017.08.28	최초 작성<br>
	 * 			2017.09.04	반환 타입 수정 및 구현 완료
	 */
	public List<Map<String, String>> getAprLine(String doc_linenum) throws SQLException;

	/**
	 * 결재 수정 메서드
	 * @param 	loginEmp 로그인한 사용자(수정자)
	 * @param 	form 선택한 서식 정보
	 * @param 	document 수정한 문서 정보
	 * @param 	selectedCandidates 선택한 결재선
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since 	2017.08.28	최초 작성<br>
	 * 			2017.09.04	구현 완료
	 */
	public void updateApr(EmployeeVO loginEmp, Map<String, String> form, DocumentVO document, 
			ArrayList<String> selectedCandidates) throws SQLException;
	
	/**
	 * 결재선 생성 메서드
	 * @return 	생성된 결재선 번호
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.08.31	최초작성 및 구현
	 */
	public String insertAprLine() throws SQLException;

	/**
	 * 결재선 사원 삽입 메서드
	 * @param 	line_num 사원을 삽입할 결재선번호
	 * @param 	aprEmpList 결재선에 삽입할 사원번호 리스트
	 * @return 	삽입 성공시 true를 반환
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.08.31	최초 작성 및 구현
	 */
	public boolean fillAprLine(String line_num, List<String> aprEmpList) throws SQLException;
	
	/**
	 * 전자결재 서명 메서드
	 * @param 	params 결재자,결재선번호,결재상태,결재사유가 포함된 맵
	 * @return	정상적으로 서명시 true
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since 	2017.08.31	최초 작성<br>
	 * 			2017.09.02	구현 완료
	 */
	public boolean aprStaSetting(Map<String, String> params) throws SQLException;
	
	/**
	 * 결재선 수정 메서드
	 * @param 	line_num 수정할 결재선 번호
	 * @param 	aprEmpList 새로 선택한 결재선 리스트
	 * @return	수정에 성공했을 때 새 결재선 번호 반환
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.09.04	최초 작성 및 구현
	 */
	public String updateAprLine(String line_num, List<String> aprEmpList) throws SQLException;
	
	/**
	 * 결재선 삭제 메서드
	 * @param 	line_num 삭제할 결재선 번호
	 * @return	삭제에 성공했을 때 1 반환
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.09.04	최초 작성 및 구현
	 */
	public int deleteAprLine(String line_num) throws SQLException;

	/**
	 * 서식 전결자 변경 메서드
	 * @param 	form_num 전결자를 변경할 서식
	 * @param 	form_prox 변경될 전결자
	 * @author 	박일훈
	 * @since	2017.09.04	최초 작성 및 구현
	 */
	public void updateFormProx(String form_num, String form_prox) throws SQLException;

	/**
	 * 전결 메서드
	 * @param 	det_linenum 전결처리할 결재선 번호
	 * @return	결재 성공시 true 반환
	 * @author 	박일훈
	 * @since	2017.09.04	최초 작성<br>
	 * 			2017.09.05	매개변수 타입 변경 및 전결시 승인으로 처리되는 버그 수정 및 구현 완료<br>
	 * 			2017.09.11	전결 버그 수정
	 */
	public boolean signAll(Map<String, String> params) throws SQLException;
	
}
