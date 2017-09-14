package kr.or.gd.humanResource.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.employee.service.IEmployeeService;
import kr.or.gd.global.CommonConstant;
import kr.or.gd.humanResource.service.IHumanResourceService;
import kr.or.gd.project.service.IProjectService;
import kr.or.gd.utils.RolePagingUtil;
import kr.or.gd.vo.EmployeeVO;
import kr.or.gd.vo.PositionVO;
import kr.or.gd.vo.RoleVO;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * @ClassName   HumanResourceController.java
 * @Description  인사관리 화면 제어 클래스
 * @Modification Information
 * @author       정준혁
 * @since        2017. 8. 25.
 * @version    1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 * 수정일      수정자        수정내용
 * -------   -------    -------------------
 * 2017. 8. 25.  정준혁   최초 작성
 * 2017. 8. 27.	 정준혁	사원 등록 구현
 * 2017. 8. 30.	 정준혁	사원 삭제 구현
 * 2017. 8. 30.	 박예연	사원 수정 구현
 * </pre>
 */
@Controller
@RequestMapping("/humanResource/")
public class HumanResourceController {

	@Loggable
	private Logger logger;
	
	@Autowired
	private IHumanResourceService service;
	@Autowired
	private IEmployeeService empService;
	@Autowired
	private IProjectService proService;
	
	private String currentPage;
	private String attCurrentPage;
	private String emp_num;
	private String emp_img;
	private String emp_sign;
	/**
	 * 사원등록 화면 출력
	 * @throws 	SQLException
	 * @author 	정준혁
	 * @since	2017.08.25 최초작성<br>
	 * 			2017.08.25 구현완료
	 */
	@RequestMapping("insertEmployeeView")
	public ModelAndView insertEmpView(ModelAndView andView) throws SQLException{
		
		//직위리스트 가져오기
		List<PositionVO> positionList = this.service.getPositionList();
		//직책리스트
		List<RoleVO> roleList = this.service.getRoleList();
		
		andView.addObject("positionList",positionList);
		andView.addObject("roleList",roleList);
		andView.setViewName("humanResource/insertEmpView");
		return andView;
	}
	
	/**
	 * 사원등록
	 * @throws 	SQLException
	 * @author 	정준혁
	 * @since	2017.08.25 최초작성<br>
	 * 			2017.08.27 구현완료
	 */
	@RequestMapping("insertEmployee")
	public ModelAndView insertEmp(ModelAndView andView,EmployeeVO empInfo, HttpServletRequest request) throws SQLException{
		MultipartHttpServletRequest wrapper = (MultipartHttpServletRequest) request;
		
		Iterator<String> fileNames = wrapper.getFileNames();
		
		String fileName = "";
		while(fileNames.hasNext()){
			List<MultipartFile> files = wrapper.getFiles(fileNames.next());
			for(MultipartFile file : files){
				if(file.getSize()>0){
					
					String baseName = FilenameUtils.getBaseName(file.getOriginalFilename());
		            String extension = FilenameUtils.getExtension(file.getOriginalFilename());
		               
		            String id = UUID.randomUUID().toString().replace("-", "");
		            if(empInfo.getEmp_img() == null){
		            	empInfo.setEmp_img(baseName + "_" + id + "." + extension);
		            	
		            	fileName = file.getOriginalFilename();
		            	File saveFile = new File("D:\\2jo\\Employee\\img", empInfo.getEmp_img());
		            	
		            	try {
							file.transferTo(saveFile);
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
		            }else{
		            	empInfo.setEmp_sign(baseName + "_" + id + "." + extension);
		            	
		            	fileName = file.getOriginalFilename();
		            	File saveFile = new File("D:\\2jo\\Employee\\sign", empInfo.getEmp_sign());
		            	
		            	try {
							file.transferTo(saveFile);
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
		            }
					
					
				}
			}
		}
		
		
		service.insertEmp(empInfo);
		
		andView.setViewName("humanResource/insertEmpView");
		return andView;
	}
	
	/**
	 * 사원 탈퇴
	 * @throws 	SQLException
	 * @author 	정준혁
	 * @since	2017.08.30 최초작성<br>
	 * 			2017.08.30 구현완료
	 */
	@RequestMapping("deleteEmployee")
	public ModelAndView deleteEmp(ModelAndView andView,@RequestParam(value="empNum")List<String> empNumList) throws SQLException{
		Map<String, String> params = new HashMap<String, String>();
		for(int i = 0; i<empNumList.size(); i++){
			params.put("emp_num", empNumList.get(i).toString());
			this.service.deleteEmp(params);
			params.clear();
		}
		
		andView.setViewName("redirect:/humanResource/deleteEmployeeView.do");
		return andView;
	}
	
	/**
	 * 사원 탈퇴 화면 출력
	 * @throws 	SQLException
	 * @author 	정준혁
	 * @since	2017.08.30 최초작성<br>
	 * 			2017.09.05 페이징 처리
	 */
	@RequestMapping("deleteEmployeeView")
	public ModelAndView deleteEmpView(ModelAndView andView,  String search_keyword, String search_keycode, HttpServletRequest request,String currentPage) throws SQLException{
		int integerCurrentPage = 0;
		Map<String, String> searchInfo = new HashMap<String, String>();
		
		if(currentPage==null||currentPage == ""){
			integerCurrentPage = 1;
			this.currentPage = "1";
		}else{
			this.currentPage = currentPage;
			integerCurrentPage = Integer.parseInt(this.currentPage);
		}
		searchInfo.put("search_keyword", search_keyword);
		searchInfo.put("search_keycode", search_keycode);
		
		String totalCount = this.service.getDeleteTotalCount(searchInfo);
		int totalCountResult = Integer.parseInt(totalCount);
		RolePagingUtil rolePagingUtil = new RolePagingUtil(integerCurrentPage, totalCountResult, request);
		searchInfo.put("startCount", rolePagingUtil.getStartCount());
		searchInfo.put("endCount", rolePagingUtil.getEndCount());
		
		List<Map<String, String>> empList = this.service.getEmpListAll(searchInfo);
		String pagingHtml = rolePagingUtil.getPageHtml();
		
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("currentPage",currentPage);
		andView.addObject("search_keyword",search_keyword);
		andView.addObject("search_keycode",search_keycode);
		andView.addObject("empList",empList);
		andView.setViewName("humanResource/deleteEmpView");
		return andView;
	}
	
	
	@RequestMapping("updateSalary")
	public ModelAndView updateSal(ModelAndView andView){
		
		andView.setViewName("humanResource/updateSalaryView");
		return andView;
	}
	
	/**
	 * 사원 개인 정보 수정(관리자단)
	 * 관리자는 사원을 수정할때 기본적인 이미지를 띄워주고 이미지를 하나만 바꾸어도 업데이트가 가능하게 해야한다.
	 * @throws SQLException
	 * @since	2017.08.30	최초작성	@author 박예연
	 */
	@RequestMapping("updateEmployee")
	public String updateEmp(RedirectAttributes redirect , EmployeeVO empInfo, HttpServletRequest request  )throws SQLException{
		int result = 0;
		MultipartHttpServletRequest wrapper = (MultipartHttpServletRequest) request;
		Iterator<String> fileNames = wrapper.getFileNames();
		String fileName = "";
		// 이미지 업데이트를 하기 위해서 count사용
		int count =0;
		while(fileNames.hasNext()){
			List<MultipartFile> files = wrapper.getFiles(fileNames.next());
			for(MultipartFile file : files){
				// 딱 두개를 가지고 들어왔을때 혹은 하나만 가지고 들어왔을때 파일이 사이즈가 있는지 없는지 확인 
				if(file.getSize()>0){
					// 파일을 savename으로 저장 하기 위해 baseName, extension 선언
					String baseName = FilenameUtils.getBaseName(file.getOriginalFilename());
		            String extension = FilenameUtils.getExtension(file.getOriginalFilename());
		            
		            //savename에 들어갈 ID 
		            String id = UUID.randomUUID().toString().replace("-", "");
		            	// count가 0이라는 소리는 지금 있는 이 사진이 직원 증명사진이다 
		            	// 그렇다면 empInfo의Emp_img에 저장한다. 
			            if(count==0){
				            	empInfo.setEmp_img(baseName + "_" + id + "." + extension);
				            	
				            	fileName = file.getOriginalFilename();
				            	File saveFile = new File(CommonConstant.EMPLOYEE_IMG, empInfo.getEmp_img());
				            	
								try {
									file.transferTo(saveFile);
								} catch (IllegalStateException e) {
									e.printStackTrace();
								} catch (IOException e) {
									e.printStackTrace();
								}
								count++;
				        }else if(count==1 ){
				        	// count가 1이라는 말은 emp_sign을 변경하겠다는 이야기 
				            	empInfo.setEmp_sign(baseName + "_" + id + "." + extension);
				            	
				            	fileName = file.getOriginalFilename();
				            	File saveFile = new File(CommonConstant.EMPLOYEE_SIGN, empInfo.getEmp_sign());
				            	
				            	try {
									file.transferTo(saveFile);
								} catch (IllegalStateException e) {
									e.printStackTrace();
								} catch (IOException e) {
									e.printStackTrace();
								}
				        }
		            }else{
		            	// 파일이 하나만 들어있을때 원래 있던 값으로 update환경을 맞춰준다.
		            	if(count==0){
		            		empInfo.setEmp_img(this.emp_img);
		            	}else if(count==1){
		            		empInfo.setEmp_sign(this.emp_sign);
		            	}
		            	count++;
		            }
			}
		}        
		
		result = this.service.updateEmp(empInfo);
		redirect.addFlashAttribute("emp_num",emp_num);
		return "redirect:/humanResource/updateEmployeeView.do";
	}
	/**
	 * 사원 개인별 상세 정보 화면(관리자단)
	 * @param emp_num 사원번호  
	 * @throws SQLException
	 * @since	2017.08.30	최초작성	   @author 박예연
	 * 			2017.09.06 근무평가 리스트 @author 정준혁
	 * 			2017.09.06 종료된 리스트   @author 정준혁
	 */	
	@RequestMapping("updateEmployeeView")
	public ModelAndView updateEmpView(ModelAndView andView, String emp_num, String search_keyword, String search_keycode
			,String currentPage) throws SQLException{
		Map<String,String> empInfo =null;
		Map<String,String> searchInfo = new HashMap<String, String>();
		Map<String,String> empNum = new HashMap<String, String>();
		searchInfo.put("search_keyword", search_keyword);
		searchInfo.put("search_keycode", search_keycode);
		List<RoleVO> roleList = this.service.getRoleList();
		if(emp_num == null){
			emp_num = this.emp_num;
			this.emp_num = null;
		}
		
		empInfo = service.getEmpInfoAdmin(emp_num);
		service.getRoleList();
		List<PositionVO> positionList =service.getPositionList();
		
		// emp_num을 전역변수로 줘야 수정하고 다시 원래 페이지로 돌아갈때 이용가능
		this.emp_num = emp_num;
		this.emp_img = empInfo.get("EMP_IMG");
		this.emp_sign = empInfo.get("EMP_SIGN");
		
		//종료된 프로젝트 리스트 가져오기
		empNum.put("emp_num", emp_num);
		Map<String, List<Map<String, String>>> endList = this.proService.getIngCheckList(empNum);
		//사원 근무평가 리스트 가져오기
		List<Map<String, String>> empWorkRateList = this.service.getEmpWorkRateList(empNum);
		
		// 검색하고 다시 원래 페이지로 돌아가기 위해서 currentPage, search_keyword, search_keycode가지고 감
		andView.addObject("empWorkRateList",empWorkRateList);
		andView.addObject("endList",endList.get("endList"));
		andView.addObject("currentPage",currentPage);
		andView.addObject("search_keyword",search_keyword);
		andView.addObject("search_keycode",search_keycode);
		andView.addObject("searchInfo",searchInfo);
	    andView.addObject("positionList",positionList);
	    andView.addObject("roleList",roleList);
		andView.addObject("empInfo",empInfo);
		andView.setViewName("humanResource/updateEmpViewAdmin");
		return andView;
	}
	
	/**	
	 * 사원 출결 리스트 출력
	 * @param params 검색조건
	 * @author 	정준혁
	 * @since	2017.08.31 최초작성<br>
	 * 			2017.09.05 페이징 처리
	 */
	@RequestMapping("employeeAttendanceList")
	public ModelAndView empAttList(ModelAndView andView, String search_keycode, String search_keyword, HttpServletRequest request
			,String currentPage) throws SQLException{
		int integerCurrentPage = 0;
		Map<String,String> searchInfo = new HashMap<String, String>();
		
		if(currentPage==null || currentPage == ""){
			integerCurrentPage = 1;
			this.attCurrentPage = "1";
		}else{
			this.attCurrentPage = currentPage;
			integerCurrentPage = Integer.parseInt(this.attCurrentPage);
		}
		
		searchInfo.put("search_keycode", search_keycode);
		searchInfo.put("search_keyword", search_keyword);
		
		String totalCount = this.service.getAttTotalCount(searchInfo);
		int totalCountResult = Integer.parseInt(totalCount);
		RolePagingUtil rolePagingUtil = new RolePagingUtil(integerCurrentPage, totalCountResult, request);
		searchInfo.put("startCount", rolePagingUtil.getStartCount());
		searchInfo.put("endCount", rolePagingUtil.getEndCount());
		
		
		List<Map<String, String>> attList = this.service.empAttList(searchInfo);
		String pagingHtml = rolePagingUtil.getPageHtml();
		
		andView.addObject("pagingHtml",pagingHtml);
		andView.addObject("currentPage",currentPage);
		andView.addObject("search_keyword",search_keyword);
		andView.addObject("search_keycode",search_keycode);
		andView.addObject("searchInfo",searchInfo);
		andView.addObject("attList",attList);
		andView.setViewName("humanResource/empAttList");
		return andView;
	}
}
