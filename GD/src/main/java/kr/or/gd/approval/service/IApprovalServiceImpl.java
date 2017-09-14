package kr.or.gd.approval.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.gd.approval.dao.IApprovalDao;
import kr.or.gd.document.service.IDocumentService;
import kr.or.gd.employee.service.IEmployeeService;
import kr.or.gd.vo.ApprovalLineVO;
import kr.or.gd.vo.DocumentVO;
import kr.or.gd.vo.EmployeeVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IApprovalServiceImpl implements IApprovalService {

	@Autowired
	private IApprovalDao dao;
	@Autowired
	private IEmployeeService empService;
	@Autowired
	private IDocumentService docService;

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public List<Map<String, String>> getFormList(Map<String, String> params) throws SQLException {
		return dao.getFormList(params);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public List<List<Map<String,String>>> getAprCandidateList(String pos_id) throws SQLException {
		List<List<Map<String,String>>> result = new ArrayList<List<Map<String,String>>>();
		//로그인한 사원의 직급아이디를 정수형으로 변환
		int integer_pos_id = Integer.parseInt(pos_id);
		//검색조건이 담길 Map
		Map<String, String> params = new HashMap<String, String>();
		for (int i = 1; i < integer_pos_id ; i++) {
			//1(사장)부터 로그인한 사원의 직급까지 반복
			params.put("emp_pos", String.valueOf(i));
			//해당 직급의 사원 리스트를 맵에 담아 리스트에 직급별로 추가
			result.add(empService.getEmpListByPos(params));
			//검색조건 초기화
			params.clear();
		}
		return result;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public boolean insertApr(EmployeeVO loginEmp, Map<String, String> form, DocumentVO document
			, ArrayList<String> selectedCandidates)	throws SQLException {
		//문서VO에 선택한 서식의 번호를 입력
		document.setDoc_formnum(String.valueOf(form.get("FORM_NUM")));
		//결재선 생성
		String lineNum = insertAprLine();
		//문서VO에 생성한 결재선 번호를 입력
		document.setDoc_linenum(lineNum);
		//선택한 사원들을 결재선에 삽입
		fillAprLine(lineNum, selectedCandidates);
		//결재문서 등록
		return docService.insertDoc(document);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)	
	public List<Map<String, String>> getAprLine(String doc_linenum) throws SQLException {
		//결재선 번호에 해당하는 결재선 사원 리스트 반환
		return dao.getAprLine(doc_linenum);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public void updateApr(EmployeeVO loginEmp, Map<String, String> form,
			DocumentVO document, ArrayList<String> selectedCandidates) throws SQLException{
		// 선택한 서식 번호 입력
		document.setDoc_formnum(String.valueOf(form.get("FORM_NUM")));
		// 새로운 결재선 생성
		String newLineNum = String.valueOf(updateAprLine(document.getDoc_linenum(), selectedCandidates));
		// 문서VO에 결재선 정보 추가
		document.setDoc_linenum(newLineNum);
		// 문서 정보 업데이트
		docService.updateDoc(document);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public String insertAprLine() throws SQLException {
		ApprovalLineVO approvalLine = new ApprovalLineVO();
		approvalLine.setLine_sta("Y");
		//결재선을 새로 생성하고 결재선번호를 반환
		return dao.insertAprLine(approvalLine);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public boolean fillAprLine(String line_num, List<String> aprEmpList) throws SQLException {
		Map<String, String> params = new HashMap<String, String>();
		for (String emp_num : aprEmpList) {
			//파라메터에 사원번호와 결재선번호, 결재등급을 입력
			params.put("emp_num", emp_num);
			params.put("line_num", line_num);
			params.put("apr_lev", String.valueOf(aprEmpList.size()-aprEmpList.indexOf(emp_num)));
			int result = dao.fillAprLine(params);
			if(result<0){
				//결재선에 사원을 추가하지 못했을 때 false 반환
				return false;
			}
		}
		//기안자의 결재상태를 승인(Y)로 변경
		Map<String, String> staParams = new HashMap<String, String>();
		staParams.put("det_linenum", line_num);
		staParams.put("det_aprlev", "1");
		staParams.put("det_aprsta", "Y");
		staParams.put("det_aprcont", "기안자");
		aprStaSetting(staParams);
		return true;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public boolean aprStaSetting(Map<String, String> params) throws SQLException {
		int result = dao.aprStaSetting(params);
		//업데이트한 행의 개수가 0 초과일때 true 반환
		return (result>0)? true : false;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public String updateAprLine(String line_num, List<String> aprEmpList) throws SQLException {
		String newAprLine = "";
		if(0 < dao.deleteAprLine(line_num)){
			// 기존 결재선의 제거가 완료되었을 때 새 결재선을 만들고 그 결재선의 번호를 저장
			newAprLine = insertAprLine();
			//새 결재선에 결재자들을 입력
			fillAprLine(newAprLine, aprEmpList);
		};
		return newAprLine;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public int deleteAprLine(String line_num) throws SQLException {
		//받아온 결재선 번호에 해당하는 결재선을 삭제하고 삭제 여부를 반환 
		return dao.deleteAprLine(line_num);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public void updateFormProx(String form_num, String form_prox) throws SQLException{
		//전결자를 변경하기 위한 정보 입력(서식번호,전결자직급ID)
		Map<String, String> params = new HashMap<String, String>();
		params.put("form_num", form_num);
		params.put("form_prox", form_prox);
		dao.updateFormProx(params);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public boolean signAll(Map<String, String> params) throws SQLException {
		boolean result = false;
		List<Map<String, String>> aprLine = getAprLine(params.get("det_linenum"));
		for (Map<String, String> map : aprLine) {
			//결재선의 길이만큼 반복
			if(map.get("DET_APRSTA")==null){
				//결재상태가 null인 결재선만 = 결재를 하지 않은 사원만 결재한다.
				map.put("det_linenum", params.get("det_linenum"));
				map.put("det_aprsta", "Y");
				map.put("det_aprlev", String.valueOf(map.get("DET_APRLEV")));
				map.put("det_aprcont", params.get("det_aprcont"));
				result = aprStaSetting(map);			
			}
		}
		return result;
	}

}