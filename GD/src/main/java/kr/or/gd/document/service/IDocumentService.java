package kr.or.gd.document.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.gd.vo.DocumentVO;

public interface IDocumentService {

	/**
	 * 문서 정보 조회 메서드
	 * @param 	doc_num 조회할 문서의 번호
	 * @return 	문서 정보가 담긴 Map
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since 	2017.08.28	최초 작성 및 구현
	 * 			
	 */
	public DocumentVO getDoc(String doc_num) throws SQLException;

	/**
	 * 문서 정보 입력 메서드
	 * @param	document 입력할 문서의 정보
	 * @return	입력 성공시 true
	 * @throws	SQLException
	 * @author	박일훈
	 * @since	2017.08.31	최초 작성 및 구현
	 */
	public boolean insertDoc(DocumentVO document) throws SQLException;
	
	/**
	 * 진행문서함 조회 메서드
	 * @param 	params 검색 조건
	 * @return 	검색 조건에 해당하는 로그인한 사용자가 기안하거나 결재를 요청받거나, 요청받은 결재를 승인해 다음 결재자의 결재를 기다리는 문서 리스트
	 * @throws 	SQLException
	 * @author	박일훈
	 * @since	2017.08.31	최초 작성 및 구현
	 */
	public List<Map<String, String>> getPrgFolder(Map<String, String> params) throws SQLException;

	/**
	 * 발신문서함 조회 메서드
	 * @param 	params 검색 조건
	 * @return	검색 조건에 해당하는 로그인한 사용자가 기안해 최종 승인이된 문서 리스트
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.08.31	최초 작성 및 구현
	 */
	public List<Map<String, String>> getSendFolder(Map<String, String> params) throws SQLException;
	
	/**
	 * 수신문서함 조회 메서드
	 * @param 	params 검색 조건
	 * @return	검색 조건에 해당하는 로그인한 사용자가 결재를 요청받아 최종 승인이된 문서 리스트
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.08.31	최초 작성 및 구현
	 */
	public List<Map<String, String>> getRecvFolder(Map<String, String> params) throws SQLException;
	
	/**
	 * 승인문서함 조회 메서드
	 * @param 	params 검색 조건
	 * @return	검색 조건에 해당하는 로그인한 사용자가 포함된 프로젝트 내 승인된 모든 문서
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.08.31	최초 작성 및 구현
	 */
	public List<Map<String, String>> getConfFolder(Map<String, String> params) throws SQLException;
	
	/**
	 * 반려문서함 조회 메서드
	 * @param 	params 검색 조건
	 * @return	검색 조건에 해당하는 로그인한 사용자가 포함된 프로젝트 내 반려된 모든 문서
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.08.31	최초 작성 및 구현
	 */
	public List<Map<String, String>> getRefFolder(Map<String, String> params) throws SQLException;

	/**
	 * 문서 조회 메서드
	 * @param 	doc_num 조회할 문서번호
	 * @return	해당 번호의 문서 정보
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.08.31	최초 작성<br>
	 * 			2017.09.01	구현 완료
	 */
	public List<Map<String, String>> getDocMap(Map<String, String> params) throws SQLException;
	
	/**
	 * 문서를 jasperReport를 이용해 HTML 소스로 변환하는 메서드
	 * @param 	docInfoList HTML소스로 변환할 문서정보
	 * @return 	HTML소스로 변환된 문서 정보
	 * @author 	박일훈
	 * @since	2017.09.01	최초 작성 및 구현<br>
	 * 			2017.09.05	정크파일 삭제 코드 추가
	 */
	public List<String> getHtmlFromJasper(List<Map<String, String>> docInfoList, int page) throws Exception;
	
	/**
	 * 문서 삭제 메서드
	 * @param 	doc_num 삭제할 문서 번호
	 * @return	삭제 성공시 1 반환
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.09.02	최초 작성 및 구현
	 */
	public int deleteDoc(String doc_num) throws SQLException;
	
	/**
	 * 문서 수정 메서드
	 * @param 	document 수정할 정보가 담긴 문서VO
	 * @return	수정에 성공했을 때 true를 반환
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.09.04	최초 작성 및 구현
	 */
	public boolean updateDoc(DocumentVO document) throws SQLException;
	
	/**
	 * 문서함 총 개수 반환 메서드
	 * @param	params 검색조건
	 * @return	검색조건에 해당하는 문서함에 존재하는 문서 수
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.09.06	최초 작성 및 구현
	 */
	public int getTotalCount(Map<String, String> params) throws SQLException;
	
	/**
	 * 문서함 별 문서 수 취득 메서드
	 * @param 	params 취합 조건(프로젝트아이디, 사원번호 등)
	 * @return	취합 조건에 해당하는 문서함별 문서 수가 담긴 Map
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.09.05	최초 작성 및 구현
	 */
	public Map<String, String> getTotalByFolder(Map<String, String> params) throws SQLException;
	
	/**
	 * 페이징 메서드
	 * @param 	params 페이징에 필요한 currentPage, search_keycode, search_keyword
	 * @return	HTML소스화된 페이징 버튼
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.09.06	최초 작성 및 구현
	 */
	public String paging(Map<String, String> params, HttpServletRequest request) throws SQLException;
}
