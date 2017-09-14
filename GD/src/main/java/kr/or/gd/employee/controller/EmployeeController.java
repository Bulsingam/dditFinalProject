package kr.or.gd.employee.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.document.service.IDocumentService;
import kr.or.gd.employee.service.IEmployeeService;
import kr.or.gd.utils.Coolsms;
import kr.or.gd.utils.RolePagingUtil;
import kr.or.gd.vo.EmployeeVO;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
/**
 * 
 * @ClassName   EmployeeController.java
 * @Description   사원관리 컨트롤러 
 * @Modification Information
 * @author      박예연
 * @since      2017. 8. 31.
 * @version 1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 * 수정일      수정자   수정내용
 * -------      -------   -------------------
 * 2017. 8. 30.   박예연   최초작성
 * 2017. 8. 30.	  박예연	 사원 수정 구현
 * </pre>
 */
@Controller
@RequestMapping("/employee/")
public class EmployeeController {
	@Loggable
	private Logger logger;
	
	@Autowired
	private IEmployeeService service;
	@Autowired
	private IDocumentService docService;
	

	// 사원이 update를 한 뒤 updateView로 redirect시키기 위한 전역변수 
	private String emp_num;
	
	private String currentPage;
	
	// sms 보내기 위한 api_key와 api_secret
	// 지금 60원 남음 
	/*
	 * 현재 쓰고 있는 거 길태오빠꺼 
	 * 현재 남은 아이디 
	 * 일훈이꺼 
		api_key : NCSDCPC4L7WX1VYW
		api_secret : IZQ0BOMUL4005DTPM54WNI9SWXE975WC
	 * 
	 * 대성오빠꺼 - 아직 발신번호 등록이 되지 않음
	 * api_key : NCSPRUGTHQOHNR9O
	 * api_secret : 4TJ0GBJ8A02O4XEHDVL3CMZGJOJNMHBR
	 */
	private String api_key = "NCSQGB8ZTSCL0QSU";
	private String api_secret = "DWKGB5V9EBWG8H4AOUU0FRXJOPYXVKDS";
	/**
	 * 개인정보 수정화면
	 * 로그인한 사원의 사원번호로 개인 사원 페이지를 출력한다.
	 * 출력할때 List와 
	 * @param	로그인한 사원의 사원번호
	 * @author	박예연
	 * @throws Exception 
	 * @since	2017.08.30	최초 작성<br>
	 * 			2017.09.06	박일훈(전자결재 연동)
	 */
	// 수정화면 뷰에서 list띄우고 
	@RequestMapping("updateEmployeeView")
	public ModelAndView updateEmpView(ModelAndView andView, String emp_num) throws Exception{
		Map<String,String> empInfo =null;
		Map<String, List<Map<String, String>>> myPageInfo = new HashMap<String, List<Map<String,String>>>();
		if(emp_num == null){
			emp_num = this.emp_num;
			this.emp_num = null;
		}
		empInfo = service.getEmpInfo(emp_num);
		this.emp_num = emp_num;
		//하나의 emp service에 가서 list를 한꺼번에 부른다 
		myPageInfo = service.getMyPage(empInfo);
		
		/*
		 * 전자결재 연동 영역
		 */
		Map<String, String> params = new HashMap<String, String>();
		params.put("det_apremp", emp_num);
		params.put("doc_writer", emp_num);
		//문서함별 문서 개수가 저장된 Map 취득
		Map<String, String> folder = docService.getTotalByFolder(params);

		andView.addObject("folder", folder);
		
		andView.addObject("projectIngList",myPageInfo.get("ingList"));
		andView.addObject("projectEndList",myPageInfo.get("endList"));
		andView.addObject("archiveList",myPageInfo.get("archiveList"));
		andView.addObject("anonymousBoList",myPageInfo.get("anonymousBoList"));
		andView.addObject("notiList",myPageInfo.get("notiList"));
		andView.addObject("comBoList",myPageInfo.get("comBoList"));
		andView.addObject("empInfo",empInfo);
		andView.setViewName("employee/updateEmpView2");
		return andView;
	}
	/**
	 * 개인 정보 수정
	 * @param	수정할 정보
	 * @throws	SQLException
	 * @author	박예연
	 * @since	2017.08.30
	 */
	@RequestMapping("updateEmployee")
	public String updateEmp(RedirectAttributes redirect , EmployeeVO empInfo) throws SQLException{
		int result = service.updateEmp(empInfo);
		redirect.addFlashAttribute("emp_num",emp_num);
		// update해서 다시 그 페이지를 보여주기 위해  redirect 처리
		return "redirect:/employee/updateEmployeeView.do";
	}
	/**
	 * 다른 사원들 list
	 * admin은 상세보기가 가능하지만 사원은 상세보기 페이지로 돌아갈수 없음
	 * list 출력 , 검색, 페이징처리 
	 * @author	박예연
	 * @throws Exception 
	 * @since	2017.08.31
	 */
	@RequestMapping("employeeList")
	public ModelAndView empList(ModelAndView andView,  String search_keyword, String search_keycode
			,String currentPage, HttpServletRequest request )throws Exception{
		int integerCurrentPage = 0;
		List<Map<String, String>> empList = null;
		
		// 페이징 처리를 위해 current페이지
		if(currentPage==null || currentPage == ""){
			integerCurrentPage = 1;
			this.currentPage = "1";
		} else {
			this.currentPage = currentPage;
			integerCurrentPage = Integer.parseInt(this.currentPage);
		}
		Map<String,String> searchInfo = new HashMap<String, String>();
		searchInfo.put("search_keyword", search_keyword);
		searchInfo.put("search_keycode", search_keycode);
		
		// totalcount를 가져와서 그 값으로 페이징 처리
		String totalCount = this.service.getTotalCount(searchInfo);
		int totalCount2=Integer.parseInt(totalCount);
		RolePagingUtil rolePagingUtil = new RolePagingUtil(integerCurrentPage, totalCount2, request);
		searchInfo.put("startCount", rolePagingUtil.getStartCount());
		searchInfo.put("endCount", rolePagingUtil.getEndCount());
		
		empList = service.getEmpList(searchInfo);
		String pagingHtml = rolePagingUtil.getPageHtml();
		
		// 가져가는 값 가지고 다님 search_keyword,search_keycode, currentPage
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("currentPage",currentPage);
		andView.addObject("search_keyword",search_keyword);
		andView.addObject("search_keycode",search_keycode);
		andView.addObject("searchInfo",searchInfo);
		andView.addObject("empList",empList);
		andView.setViewName("employee/empList");
		return andView;
	}

	/**
	    * sms 보내기 위한 메서드 일단 먼저 뷰로 가는 메서드 
	    * MethodName : sendsms
	    * ClassName  : HumanResourceController
	    * @return ModelAndView
	    * @throws Exception
	    * @since  : 2017. 9. 7.
	    * @author  : 박예연
	    * @throws SQLException 
	    */
	   @RequestMapping("sms")
	   public ModelAndView smsView(ModelAndView andView) throws SQLException{
	      //갈때 가져가야하는 사항 : 현재 잔액, 사원 list
	      Map<String, String > searchInfo= new HashMap<String, String>();
	      List<Map<String, String>> smsList = this.service.getEmpAllList(searchInfo);
	      andView.addObject("smsList",smsList);
	      andView.setViewName("employee/sms");
	      return andView;
	   }
	   /**
	    * sms 보내는 메서드 
	    * MethodName : sendMessage
	    * ClassName  : EmployeeController
	    * @return ModelAndView
	    * @throws Exception
	    * @since  : 2017. 9. 8.
	    * @author  : 박예연
	    */
	   @RequestMapping("sendMessage")
	   public ModelAndView sendMessage(ModelAndView andView,@RequestParam(value="emp") List<String> empTelList ,String messageText) throws SQLException{
	      
	      HashMap<String, String> set = new HashMap<String, String>();
	      Coolsms coolsms = new Coolsms(api_key, api_secret);
	      for(int i=0; i<empTelList.size();i++){
	         if(empTelList.get(i).equals("all")){
	            List<Map<String, String>> allTel = service.getEmpAllList(set);
	            for(int j = 0; j<3;j++){
	            	// db에서 정보를 가지고 와서 처음 012만 메세지를 보내겠다 db검색했을때 그 쿼리 순서대로 나오는듯 
	            	// 관리자는 안보낼거면 0빼고 보내기 
	               set.put("to",allTel.get(j).get("EMP_TEL"));
	               set.put("from", "01051461130");
	               set.put("text",messageText);
	               set.put("type", "sms");
	               JSONObject result = coolsms.send(set);
	               if ((Boolean) result.get("status") == true) {
	                  // 메시지 보내기 성공 및 전송결과 출력
	                  System.out.println("성공");            
	                  System.out.println(result.get("group_id")); // 그룹아이디
	                  System.out.println(result.get("result_code")); // 결과코드
	                  System.out.println(result.get("result_message"));  // 결과 메시지
	                  System.out.println(result.get("success_count")); // 메시지아이디
	                  System.out.println(result.get("error_count"));  // 여러개 보낼시 오류난 메시지 수
	               } else {
	                  // 메시지 보내기 실패
	                  System.out.println("실패");
	                  System.out.println(result.get("code")); // REST API 에러코드
	                  System.out.println(result.get("message")); // 에러메시지
	               }   
	            }
	         }else{
	            set.put("to",empTelList.get(i).toString());
	            set.put("from", "01051461130");
	            set.put("text",messageText);
	            set.put("type", "sms");
	            JSONObject result = coolsms.send(set);
	            if ((Boolean) result.get("status") == true) {
	               // 메시지 보내기 성공 및 전송결과 출력
	               System.out.println("성공");            
	               System.out.println(result.get("group_id")); // 그룹아이디
	               System.out.println(result.get("result_code")); // 결과코드
	               System.out.println(result.get("result_message"));  // 결과 메시지
	               System.out.println(result.get("success_count")); // 메시지아이디
	               System.out.println(result.get("error_count"));  // 여러개 보낼시 오류난 메시지 수
	            } else {
	               // 메시지 보내기 실패
	               System.out.println("실패");
	               System.out.println(result.get("code")); // REST API 에러코드
	               System.out.println(result.get("message")); // 에러메시지
	            }   
	            
	         }
	            
	      }
	      andView.setViewName("redirect:/employee/sms.do");
	      return andView;
	   }
	   
		/**
		 * 사원급여정보 리스트
		 * @return Map
		 * @throws Exception
		 * @since  2017.09.12	최초작성
		 * @author 강대성
		 */
	   @RequestMapping("salaryInfo")
	   public ModelAndView salaryInfo(ModelAndView andView)throws Exception{
		   
		   List<Map<String,String>> salInfo = this.service.salaryInfo();
		   
		   andView.addObject("salInfo", salInfo);
		   andView.setViewName("jsonConvertView");
		   return andView;
	   }
	   
		/**
		 * 사원급여 수정
		 * @throws Exception
		 * @since  2017.09.12	최초작성
		 * @author 강대성
		 */
	   @RequestMapping("updateSalary")
	   public String updateSalary(String pos_id,  String pos_sal, Map<String, String> params)throws Exception{
		   
		   String[] arr_id = pos_id.split(",");
		   String[] arr_sal = pos_sal.split(",");
		   
		   for(int i=0; i<arr_id.length;i++){
			   
			   params.put("pos_id", arr_id[i]);
			   
			   params.put("pos_sal", arr_sal[i]);
			   
			   this.service.updateSalary(params);
		   }
		   
		   return "redirect:/employee/employeeList.do";
		   
	   }	   
	   
	   
}
