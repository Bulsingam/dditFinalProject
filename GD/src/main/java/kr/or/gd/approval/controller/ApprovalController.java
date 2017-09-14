package kr.or.gd.approval.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.or.gd.approval.service.IApprovalService;
import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.document.service.IDocumentService;
import kr.or.gd.employee.service.IEmployeeService;
import kr.or.gd.humanResource.service.IHumanResourceService;
import kr.or.gd.vo.DocumentVO;
import kr.or.gd.vo.EmployeeVO;
import kr.or.gd.vo.PositionVO;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * @ClassName	ApprovalController.java
 * @Description	전자결재 화면 제어 클래스
 * @Modification Information
 * @author 		박일훈
 * @since  		2017. 8. 28.
 * @version 	1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 * 수정일		수정자	수정내용
 * -------	-------	-------------------
 * 2017. 8. 28.	박일훈	최초 작성
 * 2017. 8. 30.	박일훈	서식 선택화면 구현
 * 2017. 8. 30.	박일훈	문서 내용 작성화면 구현
 * 2017. 8. 30.	박일훈	결재선 선택화면 구현
 * 2017. 8. 31.	박일훈	결재 등록 기능 구현
 * 2017. 9.  2.	박일훈	결재 서명 기능 구현
 * 2017. 9.  4.	박일훈	전결자 수정 기능 구현
 * 2017. 9.  4.	박일훈	전결처리 기능 구현
 * </pre>
 */
@Controller
@RequestMapping("/approval/")
public class ApprovalController {

	@Loggable
	private Logger logger;
	@Autowired
	private IApprovalService service;
	@Autowired
	private IDocumentService documentService;
	@Autowired
	private IEmployeeService employeeService;
	@Autowired
	private IHumanResourceService hrService;
	
	private Map<String, String> form = new HashMap<String, String>();
	private Map<String, String> docMap = new HashMap<String, String>();
	private DocumentVO document;
	private String pro_id;
	
	/*
	 * 전자결재 등록
	 */
	/**
	 * 서식 선택 화면
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.08.28 	최초 작성<br>
	 * 			2017.08.30 	구현 완료<br>
	 * 			2017.09.05	프로젝트 연동
	 */
	@RequestMapping("selectForm")
	public ModelAndView selectFormView(ModelAndView andView, String pro_id) throws SQLException{
		//전역변수에 저장되어있는 데이터 제거
		if(this.form != null){ this.form.clear(); }
		if(this.pro_id != null){ this.pro_id = null; }
		if(this.document != null){ this.document = null; }
		//프로젝트에서 전자결재를 요청했을때
		if(pro_id != null){ this.pro_id = pro_id; }
		//검색 조건이 포함되는 Map
		Map<String, String> params = new HashMap<String, String>();
		//검색 조건에 해당하는 리스트 뷰에 넘김
		andView.addObject("formList", service.getFormList(params));
		andView.setViewName("approval/selectFormView");
		return andView;
	}
	
	/**
	 * 문서 내용 작성화면
	 * @param 	form_num 사용자가 선택한 서식의 번호
	 * @author 	박일훈
	 * @since	2017.08.28 	최초작성<br>
	 * 			2017.08.30 	구현완료
	 */
	@RequestMapping("writeDocument")
	public ModelAndView insertDocView(ModelAndView andView, String form_num) throws SQLException{
		//선택한 서식의 번호로 서식 정보를 불러와 전역변수로 저장
		Map<String, String> params = new HashMap<String, String>();
		params.put("form_num", form_num);
		this.form = service.getFormList(params).get(0);
		//선택한 서식에 해당하는 뷰 결정
		String viewName = "approval/insert"+this.form.get("FORM_EXAM").split("_")[0]+"View";
		andView.setViewName(viewName);
		return andView;
	}
	
	/**
	 * 결재선 선택 화면
	 * @param 	document 사용자가 작성한 문서 내용
	 * @author 	박일훈
	 * @since	2017.08.28	최초 작성<br>
	 * 			2017.08.30	구현 완료<br>
	 * 			2017.09.04	코드 정리
	 */
	@RequestMapping("selectApprovalLine")
	public ModelAndView selectAprLineView(ModelAndView andView, HttpSession session, DocumentVO document)
			 throws SQLException{
		//사용자가 작성한 값을 전역변수에 저장
		this.document = document;
		//프로젝트 아이디 문서에 저장
		if(this.pro_id != null){ this.document.setDoc_proid(this.pro_id); }
		//로그인한 사용자 정보 획득
		EmployeeVO loginEmp = (EmployeeVO) session.getAttribute("LOGIN_EMPINFO");
		this.document.setDoc_writer(loginEmp.getEmp_num());
		//로그인한 사용자의 직급보다 높은 직급의 사원리스트를 획득
		String pos_id = loginEmp.getEmp_pos();
		List<List<Map<String,String>>> aprCandidateList = service.getAprCandidateList(pos_id);
		//해당 리스트를 뷰에 넘김
		andView.addObject("candidates", aprCandidateList);
		andView.setViewName("approval/selectAprLineView");
		return andView;
	}
	
	/**
	 * 전자결재 등록 명령
	 * @param 	selectedCandidates 사용자가 선택한 결재선
	 * @author	박일훈
	 * @since	2017.08.28	최초 작성<br>
	 * 			2017.08.31	구현 완료
	 */
	@RequestMapping("insertApproval")
	public ModelAndView insertApr(HttpSession session, @RequestParam("emp_num")ArrayList<String> selectedCandidates) 
			throws SQLException{
		//로그인한 사용자 정보 획득
		EmployeeVO loginEmp = (EmployeeVO) session.getAttribute("LOGIN_EMPINFO");
		//결재선에 작성자 추가
		selectedCandidates.add(loginEmp.getEmp_num());
		//기존 작성내용과 사용자 정보로 DB에 저장
		service.insertApr(loginEmp, this.form, this.document, selectedCandidates);
		//진행 문서함으로 리다이렉트요청
		ModelAndView andView = new ModelAndView("redirect:/document/progressFolder.do");
		return andView;
	}
	
	
	/*
	 * 전자결재 수정
	 */
	/**
	 * 서식 수정 화면
	 * @param	doc_num 수정할 문서번호
	 * @throws	SQLException
	 * @author	박일훈
	 * @since	2017.08.28	최초 작성<br>
	 * 			2017.09.04	구현 완료
	 */
	@RequestMapping("updateForm")
	public ModelAndView updateFormView(ModelAndView andView, String doc_num) throws SQLException{
		//전역변수에 저장되어있는 데이터 제거
		this.form.clear();
		this.document = null;
		//문서의 기존 서식번호 취득
		Map<String, String> paramsForDoc = new HashMap<String, String>();
		paramsForDoc.put("doc_num", doc_num);
		this.docMap = documentService.getDocMap(paramsForDoc).get(0);
		//검색 조건이 포함되는 Map
		Map<String, String> params = new HashMap<String, String>();
		//검색 조건에 해당하는 리스트와 기존 서식번호를 뷰에 넘김
		andView.addObject("formerFormNum", this.docMap.get("FORM_NUM"));
		andView.addObject("formList", service.getFormList(params));
		andView.setViewName("approval/selectFormView");
		return andView;
	}
	
	/**
	 * 문서 수정 화면
	 * @param	form_num 선택한 서식 번호
	 * @throws	SQLException
	 * @author	박일훈
	 * @since	2017.08.28	최초 작성<br>
	 * 			2017.09.04	구현 완료
	 */
	@RequestMapping("updateDocument")
	public ModelAndView updateDocView(ModelAndView andView, String form_num) throws SQLException{
		//선택한 서식의 번호로 서식 정보를 불러와 전역변수로 저장
		Map<String, String> params = new HashMap<String, String>();
		params.put("form_num", form_num);
		this.form = service.getFormList(params).get(0);
		//선택한 서식과 기존 문서 내용을 뷰에 넘김
		andView.addObject("formerDocument", this.docMap);
		String viewName = "approval/insert"+this.form.get("FORM_EXAM").split("_")[0]+"View";
		andView.setViewName(viewName);
		return andView;
	}
	
	/**
	 * 결재선 수정 화면
	 * @param	document 수정된 문서정보
	 * @throws	SQLException
	 * @author	박일훈
	 * @since	2017.08.28	최초 작성<br>
	 * 			2017.09.04	구현 완료
	 */
	@RequestMapping("updateApprovalLine")
	public ModelAndView updateAprLineView(ModelAndView andView, HttpSession session, DocumentVO document)
			throws SQLException{
		//사용자가 작성한 값을 전역변수에 저장
		this.document = document;
		//로그인한 사용자 정보 획득
		EmployeeVO loginEmp = (EmployeeVO) session.getAttribute("LOGIN_EMPINFO");
		//기존 결재선 취득
		List<Map<String, String>> aprLine = service.getAprLine(this.document.getDoc_linenum());
		//로그인한 사용자의 직급보다 높은 직급의 사원리스트를 획득
		String pos_id = loginEmp.getEmp_pos();
		List<List<Map<String,String>>> aprCandidateList = service.getAprCandidateList(pos_id);
		//해당 리스트를 뷰에 넘김
		andView.addObject("formerAprLine", aprLine);
		andView.addObject("candidates", aprCandidateList);
		andView.setViewName("approval/selectAprLineView");
		return andView;		
	}
	
	/**
	 * 결재 수정 명령
	 * @param	selectedCandidates 선택한 결재선
	 * @throws	SQLException
	 * @author	박일훈
	 * @since	2017.08.28	최초 작성<br>
	 * 			2017.09.04	구현 완료
	 */
	@RequestMapping("updateApproval")
	public ModelAndView updateApr(HttpSession session, @RequestParam("emp_num")ArrayList<String> selectedCandidates)
			throws SQLException{
		//로그인한 사용자 정보 획득
		EmployeeVO loginEmp = (EmployeeVO) session.getAttribute("LOGIN_EMPINFO");
		//결재선에 작성자 추가
		selectedCandidates.add(loginEmp.getEmp_num());
		//기존 작성내용과 사용자 정보로 DB에 저장
		service.updateApr(loginEmp, this.form, this.document, selectedCandidates);
		ModelAndView andView = new ModelAndView("redirect:/document/progressFolder.do");
		return andView;		
	}
	
	
	/*
	 * 기타
	 */
	/**
	 * 결재선 선택사원 이미지 출력
	 * @param	emp_num 선택된 사원 번호
	 * @return	해당 사원의 이미지 이름
	 * @throws	SQLException
	 * @author	박일훈
	 * @since	2017.08.30	최초 작성 및 구현
	 */
	@RequestMapping("getEmpImg")
	public ModelAndView getEmpImg(ModelAndView andView, String emp_num) throws SQLException{
		//넘겨받은 사원 번호로 해당 사원의 증명사진 파일명을 불러옴
		String emp_img = employeeService.getEmpImgName(emp_num);
 		andView.addObject("emp_img", emp_img);
 		//json형태의 데이터로 응답처리
		andView.setViewName("jsonConvertView");
		return andView;
	}
	
	/**
	 * 전자결재 서명 메서드
	 * @param 	andView 진행 문서함
	 * @param 	params 결재 조건이 포함된 맵
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.09.02	최초 작성 및 구현
	 */
	@RequestMapping("signApproval")
	public ModelAndView signApr
		(ModelAndView andView, @RequestParam Map<String, String> params, HttpSession session) throws SQLException{
		boolean result = false;
		EmployeeVO loginEmp = (EmployeeVO) session.getAttribute("LOGIN_EMPINFO");
		if(params.get("form_prox").equals(loginEmp.getEmp_pos())){
			//결재를 한 로그인한 사용자가 전결자일때
			params.put("det_aprcont", loginEmp.getEmp_name()+" 전결: "+params.get("det_aprcont"));
			result = service.signAll(params);
		} else {
			//결재자가 전결자가 아닐때
			result = service.aprStaSetting(params);			
		}
		String resultMsg = "";
		if(result == true){
			resultMsg = "성공적으로 결재하였습니다.";
		} else {
			resultMsg = "결재에 실패하였습니다. 잠시후 다시 시도해주세요.";
		}
		andView.addObject("resultMsg", resultMsg);
		andView.setViewName("redirect:/document/progressFolder.do");
		return andView;
	}
	
	/**
	 * 서식 리스트 뷰
	 * @param 	andView 서식 리스트
	 * @param 	params	검색 조건
	 * @return	검색 조건에 해당하는 서식 리스트
	 * @throws 	SQLException
	 * @author 	박일훈
	 * @since	2017.09.04	최초 작성 및 구현
	 */
	@RequestMapping("formList")
	public ModelAndView formList(ModelAndView andView, Map<String, String> params) throws SQLException {
		List<Map<String, String>> formList = service.getFormList(params);
		List<PositionVO> positionList = hrService.getPositionList();
		andView.addObject("formList", formList);
		andView.addObject("positionList", positionList);
		andView.setViewName("approval/formListView");
		return andView;
	};
	
	/**
	 * 전결자 변경 명령
	 * @param 	form_num 변경할 서식번호
	 * @param 	form_prox 변경할 전결자
	 * @throws 	SQLException
	 * @author	박일훈
	 * @since	2017.09.04	최초 작성 및 구현
	 */
	@RequestMapping("updateFormProx")
	public ModelAndView updateFormProx(ModelAndView andView, String form_num, String form_prox) throws SQLException{
		service.updateFormProx(form_num, form_prox);
		andView.setViewName("jsonConvertView");
		return andView;
	}

}
