package kr.or.gd.document.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.document.service.IDocumentService;
import kr.or.gd.vo.EmployeeVO;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * @ClassName	DocumentController.java
 * @Description	결재 문서 관리를 위한 화면을 제어하는 클래스
 * @Modification Information
 * @author		박일훈
 * @since		2017. 8. 25.
 * @version 1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 * 수정일		수정자	수정내용
 * -------		-------	-------------------
 * 2017. 8. 25.	박일훈	최초작성
 * 2017. 8. 31.	박일훈	진행문서함 구현 완료
 * 2017. 8. 31.	박일훈	발신문서함 구현 완료
 * 2017. 8. 31.	박일훈	수신문서함 구현 완료
 * 2017. 8. 31.	박일훈	승인문서함 구현 완료
 * 2017. 8. 31.	박일훈	반려문서함 구현 완료
 * 2017. 9.  1.	박일훈	문서 뷰 구현완료
 * 2017. 9.  2.	박일훈	문서 인쇄/PDF다운로드/수정 구현완료
 * 2017. 9.  6.	박일훈	문서함 페이징 구현완료
 * </pre>
 */
@Controller
@RequestMapping("/document/")
public class DocumentController {

	@Loggable
	private Logger loggable;
	@Autowired
	private IDocumentService service;	
	
	/*
	 * 화면 처리 영역
	 */
	/**
	 * 결재 진행 문서함 출력 뷰
	 * @param params 검색 조건
	 * @author	박일훈
	 * @throws SQLException 
	 * @since	2017.08.25	최초 작성<br>
	 * 			2017.08.31	구현 완료<br>
	 * 			2017.09.06	페이징 구현
	 */
	@RequestMapping("progressFolder")
	public ModelAndView prgFoldView	(ModelAndView andView, @RequestParam Map<String, String> params
			, HttpSession session, HttpServletRequest request) throws SQLException{
		EmployeeVO loginEmp = (EmployeeVO) session.getAttribute("LOGIN_EMPINFO");
		if(!loginEmp.getEmp_pos().equals("0")){
			//로그인한 사용자가 관리자가 아닐 때 사용자 사원번호 파라매터 추가
			params.put("det_apremp", loginEmp.getEmp_num());
		}
		//페이징
		params.put("folderName", "prgFolder");
		String pagingHtml = service.paging(params, request);
		//로그인한 사원이 기안하거나 결재를 요청받은 문서 리스트
		List<Map<String, String>> prgFolder = service.getPrgFolder(params);
	
		andView.addObject("goToList", "/document/progressFolder.do");
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("resultMsg", params.get("resultMsg"));
		andView.addObject("folder", prgFolder);
		andView.setViewName("document/prgFoldList");
		return andView;
	}
	
	/**
	 * 결재 발신 문서함 출력 뷰
	 * @param params 검색 조건
	 * @author 	박일훈
	 * @since	2017.08.25	최초 작성<br>
	 * 			2017.08.31	구현 완료<br>
	 * 			2017.09.06	페이징 구현<br>
	 */
	@RequestMapping("sendFolder")
	public ModelAndView sendFoldView (ModelAndView andView, @RequestParam Map<String, String> params, 
			HttpSession session, HttpServletRequest request) throws SQLException{
		//로그인한 사원 정보 획득
		EmployeeVO loginEmp = (EmployeeVO) session.getAttribute("LOGIN_EMPINFO");	
		params.put("doc_writer", loginEmp.getEmp_num());
		//페이징
		params.put("folderName", "sendFolder");
		String pagingHtml = service.paging(params, request);
		//로그인한 사원이 기안해 최종승인처리된 문서 리스트
		List<Map<String, String>> sendFolder = service.getSendFolder(params);

		andView.addObject("goToList", "/document/sendFolder.do");
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("folder", sendFolder);
		andView.setViewName("document/sendFoldList");
		return andView;
	}
	
	/**
	 * 결재 수신 문서함 출력 뷰
	 * @param params 검색 조건
	 * @author 	박일훈
	 * @since	2017.08.25	최초 작성<br>
	 * 			2017.08.31	구현 완료<br>
	 * 			2017.09.06	페이징 구현
	 */
	@RequestMapping("receiveFolder")
	public ModelAndView recvFoldView (ModelAndView andView, @RequestParam Map<String, String> params, 
			HttpSession session, HttpServletRequest request) throws SQLException{
		//로그인한 사원 정보 획득
		EmployeeVO loginEmp = (EmployeeVO) session.getAttribute("LOGIN_EMPINFO");		
		params.put("det_apremp", loginEmp.getEmp_num());
		//페이징
		params.put("folderName", "recvFolder");
		String pagingHtml = service.paging(params, request);
		//로그인한 사원이 결재승인해 최종 승인처리된 문서 리스트
		List<Map<String, String>> recvFolder = service.getRecvFolder(params);
		
		andView.addObject("goToList", "/document/receiveFolder.do");
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("folder", recvFolder);
		andView.setViewName("document/recvFoldList");
		return andView;
	}
	
	/**
	 * 결재 승인 문서함 출력 뷰
	 * @param params 검색 조건
	 * @author 	박일훈
	 * @since	2017.08.25	최초 작성<br>
	 * 			2017.08.31	구현 완료<br>
	 * 			2017.09.06	페이징 구현
	 */
	@RequestMapping("confirmFolder")
	public ModelAndView confFoldView (ModelAndView andView, @RequestParam Map<String, String> params, 
			HttpSession session, HttpServletRequest request) throws SQLException{
		//페이징
		params.put("folderName", "confFolder");
		String pagingHtml = service.paging(params, request);
		//승인된 모든 문서를 조회
		List<Map<String,String>> confFolder = service.getConfFolder(params);
		
		andView.addObject("goToList", "/document/confirmFolder.do");
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("folder", confFolder);
		andView.setViewName("document/confFoldList");
		return andView;
	}
	
	/**
	 * 결재 반려 문서함 출력 뷰
	 * @param params 검색 조건
	 * @author 	박일훈
	 * @since	2017.08.25	최초 작성<br>
	 * 			2017.08.31	구현 완료<br>
	 * 			2017.09.06	페이징 구현
	 */
	@RequestMapping("refuseFolder")
	public ModelAndView refFoldView (ModelAndView andView, @RequestParam Map<String, String> params, 
			HttpSession session, HttpServletRequest request) throws SQLException{
		//페이징
		params.put("folderName", "refFolder");
		String pagingHtml = service.paging(params, request);
		//반려된 모든 문서를 조회
		List<Map<String, String>> refFolder = service.getRefFolder(params);
		
		andView.addObject("goToList", "/document/refuseFolder.do");
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("folder", refFolder);
		andView.setViewName("document/refFoldList");
		return andView;
	}
	
	/**
	 * 결재 문서 출력 뷰
	 * @param 	doc_num 문서 번호
	 * @author 	박일훈
	 * @throws 	Exception 
	 * @since	2017.08.25	최초 작성<br>
	 * 			2017.09.01	구현 완료<br>
	 * 			2017.09.07	HTML 소스를 출력하던 것을 이미지로 변경
	 */
	@RequestMapping("documentView")
	public ModelAndView aprDocView(ModelAndView andView, String doc_num, String goToList) throws Exception{
		//문서번호에 해당하는 문서 정보 취득
		Map<String, String> params = new HashMap<String, String>();
		params.put("doc_num", doc_num);
		List<Map<String, String>> result = service.getDocMap(params);
		//리포트를 이미지로 취득
		int page = 0;
		if(String.valueOf(result.get(0).get("FORM_NUM")).equals("2")){
			page = 1;
		}
		List<String> imgSource = service.getHtmlFromJasper(result, page);
		
		andView.addObject("goToList", goToList);
		andView.addObject("imgSource", imgSource);
		andView.addObject("document", result);
		andView.setViewName("document/docView");
		return andView;
	}
	
	
	/*
	 * 명령 처리 영역
	 */
	/**
	 * 결재 문서 삭제
	 * @return	진행 문서함 뷰
	 * @param 	doc_num 문서 번호
	 * @author 	박일훈
	 * @throws 	SQLException 
	 * @since	2017.08.25	최초 작성<br>
	 * 			2017.09.02	구현 완료
	 */
	@RequestMapping("deleteDocument")
	public ModelAndView deleteAprDoc(ModelAndView andView, String doc_num) throws SQLException{
		service.deleteDoc(doc_num);
		
		andView.setViewName("redirect:/document/progressFolder.do");
		return andView;
	}
	
}
