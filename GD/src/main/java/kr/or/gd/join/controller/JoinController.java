package kr.or.gd.join.controller;

import java.io.UnsupportedEncodingException;
import java.security.PrivateKey;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.document.service.IDocumentService;
import kr.or.gd.join.service.IJoinService;
import kr.or.gd.project.service.IProjectService;
import kr.or.gd.utils.RSAGenerateKey;
import kr.or.gd.vo.EmployeeVO;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.retry.policy.MapRetryContextCache;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * @ClassName   JoinController.java
 * @Description  로그인과 출퇴근 제어 클래스
 * @Modification Information
 * @author       정준혁
 * @since        2017. 8. 31.
 * @version    1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 * 수정일      수정자   수정내용
 * -------   -------   -------------------
 * 2017. 8. 24.   정준혁   최초 작성
 * </pre>
 */
@Controller
@RequestMapping("/join/")
public class JoinController {

	@Loggable
	private Logger logger;
	
	@Autowired
	private IJoinService service;
	
	@Autowired
	private IProjectService proService;
	
	@Autowired
	private IDocumentService docService;
	
	/**
	 * 로그인 화면
	 * @throws 	SQLException
	 * @author 	정준혁
	 * @since	2017.08.24 최초작성<br>
	 * 			2017.08.24 구현완료
	 */
	@RequestMapping("login")
	public ModelAndView loginView(ModelAndView andView, HttpSession session){
		
		session.invalidate();
		
		andView.setViewName("/join/login");
		return andView;
	}
	
	/**
	 * 사원 로그인 체크
	 * @throws 	SQLException
	 * @author 	정준혁
	 * @since	2017.08.24 최초작성<br>
	 * 			2017.08.25 구현완료
	 */
	@RequestMapping(value="loginCheck",method=RequestMethod.POST)
	public ModelAndView loginCheck(ModelAndView andView,String emp_num, String emp_pass,HttpSession session) throws SQLException, UnsupportedEncodingException{
			String secure_emp_id = emp_num;
			String secure_emp_pass = emp_pass;
			
			//암호화된 ID와 PW를 평문으로 바꿔주는 과정
			RSAGenerateKey generatekey = new RSAGenerateKey();
			String mem_id = generatekey.decryptRSA((PrivateKey)session.getAttribute("rsaPrivateKey"), secure_emp_id);
			String mem_pass = generatekey.decryptRSA((PrivateKey)session.getAttribute("rsaPrivateKey"), secure_emp_pass);
		
			Map<String,String> params = new HashMap<String, String>();
			params.put("emp_num", mem_id);
			params.put("emp_pass", mem_pass);
			
			EmployeeVO empInfo = this.service.loginCheck(params);
			
			if(empInfo == null){
				String message = "";
				message="회원이 아닙니다.";
				andView.addObject("message",message);
				andView.setViewName("/join/login");
			}else{
				session.setAttribute("LOGIN_EMPINFO",empInfo);
				proService.endProStatus();
				
				if(empInfo.getEmp_name().equals("관리자")){
					//관리자
					andView.setViewName("redirect:/join/adminMain.do");
				}else{
					//사원
					andView.setViewName("redirect:/join/employeeMain.do");
				}
			}
			return andView;
	}
	
	/**
	 * 사원등록 화면 출력
	 * @throws 	SQLException
	 * @author 	정준혁
	 * @since	2017.08.25 최초작성<br>
	 * 			2017.08.25 구현완료
	 */
	@RequestMapping("logout")
	public ModelAndView logout(ModelAndView andView,HttpSession session){
		String message = "";
		EmployeeVO log = (EmployeeVO) session.getAttribute("LOGIN_EMPINFO");
		message = log.getEmp_name()+ "님 로그아웃 되었습니다.";
		//세션 초기화
		session.invalidate();
		
		andView.addObject("message",message);
		andView.setViewName("/join/login");
		return andView;
	}
	
	/**
	 * 사원등록 화면 출력
	 * @author 	정준혁
	 * @throws Exception 
	 * @since	2017.08.25	최초작성<br>
	 * 			2017.08.25	구현완료<br>
	 * 			2017.09.06	박일훈(전자결재 연동)
	 * 			2017.09.06	박예연(공지사항, 사내게시판 연동)
	 * 			
	 */
	@RequestMapping("adminMain")
	public ModelAndView adminMainView(ModelAndView andView , HttpSession session) throws Exception{
		Map<String, String> folder = docService.getTotalByFolder(new HashMap<String, String>());
		andView.addObject("folder", folder);
		Map<String, List<Map<String, String>>> myPageInfo = new HashMap<String, List<Map<String,String>>>();
		String emp_num = (String) session.getAttribute("LOGIN_EMPINFO.emp_num");
		myPageInfo  = service.getMainInfoEmp(emp_num);
		
		andView.addObject("notiList",myPageInfo.get("notiList"));
		andView.addObject("comBoList",myPageInfo.get("comBoList"));
		andView.setViewName("main/adminMain");
		return andView;
	}
	
	/**
	 * 사원 MainView & 출근
	 * @throws 	SQLException
	 * @author 	정준혁
	 * @since	2017.08.30	최초작성<br>
	 * 			2017.08.31	출근날짜 오류 수정<br>
	 * 			2017.08.31	구현완료<br>
	 * 			2017.09.05	박일훈 (전자결재와 연동완료)
	 * 			2017.09.12	박일훈 (전자결재 연동 오류 수정)
	 */
	@RequestMapping("employeeMain")
	public ModelAndView empMainView(ModelAndView andView,HttpSession session) throws Exception{
		EmployeeVO log = (EmployeeVO) session.getAttribute("LOGIN_EMPINFO");
		String emp_num = log.getEmp_num();
		Map<String, String> params = new HashMap<String, String>();
		//관리자가 아닌 사원이 로그인하면 바로 출섹체크가 된다.
		if(emp_num !="201703000"){
				params.put("emp_num", emp_num);
				String attInfo = this.service.attCheck(params);
				
				if(attInfo.equals("0")){
					String insertApp = this.service.insertApp(params);
					if(insertApp==null){
						System.out.println("출근 성공");
					}else{
						System.out.println("출근 실패");
					}
				}
		}
		/*
		 * 전자문서 - 사원 메인 연동 영역
		 */
		//기존에 사용했던 파라매터 맵 초기화
		params.clear();
		//문서 개수를 파악
		params.put("det_apremp", emp_num);
		params.put("doc_writer", emp_num);
		Map<String, String> folder = docService.getTotalByFolder(params);
		
		// 메인의 아래 들어갈 ListInfo
		// service에 가서 가지고  service에서 우르르 가져올 예정
		Map<String, List<Map<String, String>>> myPageInfo = new HashMap<String, List<Map<String,String>>>();
		myPageInfo  = service.getMainInfoEmp(emp_num);
		
		andView.addObject("projectIngList",myPageInfo.get("projectIngList"));
		andView.addObject("projectEndList",myPageInfo.get("projectEndList"));
		andView.addObject("notiList",myPageInfo.get("notiList"));
		andView.addObject("comBoList",myPageInfo.get("comBoList"));
		andView.addObject("folder", folder);
		andView.setViewName("main/main");
		return andView;
	}
	
	/**
	 * 사원 퇴근
	 * @throws 	SQLException
	 * @author 	정준혁
	 * @since	2017.08.30 최초작성<br>
	 * 			2017.08.30 구현완료
	 */
	@RequestMapping("employeeDisappear")
	public ModelAndView empDap(ModelAndView andView, String emp_num) throws SQLException{
		Map<String, String> params = new HashMap<String, String>();
		params.put("emp_num", emp_num);
		
		int updateDap = this.service.updateDap(params);
		if(updateDap==1){
			System.out.println("퇴근 성공");
		}else{
			System.out.println("퇴근 실패");
		}
		String status = "퇴근처리되었습니다.";
		andView.addObject("status",status);
		andView.setViewName("jsonConvertView");
		return andView;
	}
	
	/**
	 * 사원이 진행하고있는 리스트 Left바에 가져오는 메서드
	 * @throws 	SQLException
	 * @author 	정준혁
	 * @since	2017.09.02 최초작성<br>
	 *      	2017.09.02 구현 완료
	 */
	@RequestMapping("employeeProjectList")
	public ModelAndView empProList(ModelAndView andView, String emp_num) throws SQLException{
		Map<String, String> params = new HashMap<String, String>();
		params.put("emp_num", emp_num);
		
		List<Map<String, String>>empProList = this.service.getEmpProList(params);
		
		andView.addObject("empProList",empProList);
		andView.setViewName("jsonConvertView");
		return andView;
	}
}
