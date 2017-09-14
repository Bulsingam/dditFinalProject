package kr.or.gd.project.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.document.service.IDocumentService;
import kr.or.gd.employee.service.IEmployeeService;
import kr.or.gd.project.service.IProjectService;
import kr.or.gd.projectArchive.service.IProjectArchiveService;
import kr.or.gd.projectBoard.service.IProjectBoardService;
import kr.or.gd.schedule.service.IScheduleService;
import kr.or.gd.utils.RolePagingUtil;
import kr.or.gd.vo.EmployeeVO;
import kr.or.gd.vo.ProjectVO;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * @ClassName	ProjectController.java
 * @Description	프로젝트 관리를 위한 화면을 제어하는 클래스
 * @Modification Information
 * @author		김길태
 * @since		2017. 8. 25.
 * @version     1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 * 수정일		     	수정자	수정내용
 * ------------		-------	-------------------
 * 2017. 8. 25.		김길태	최초작성
 * 2017. 8. 28.		김길태	ProjectInsert 작성
 * 2017. 8. 30.		김길태	ProjectList 작성
 * 2017. 8. 31.		김길태	ProjectScheView 작성
 * 2017. 9. 05.		김길태	수정, 삭제 구현
 * </pre>
 */
@Controller
@RequestMapping("/project/")
public class ProjectController {

	@Loggable 
	private Logger logger;
	
	@Autowired
	private IProjectService service;
	@Autowired
	private IEmployeeService empService;
	@Autowired
	private IScheduleService scheService;
	@Autowired
	private IDocumentService docService;
	@Autowired
	private IProjectBoardService proBoService;
	@Autowired
	private IProjectArchiveService proArcService;
	
	private String currentPage;
	private String attCurrentPage;
	
	/**
	 * 프로젝트 생성 기능
	 * @param proMemNumList 프로젝트에 들어갈 사원의 사원번호 
	 * @param proMemRoleList 사원이 프로젝트에서 담당할 직책
	 * @param projectInfo 생성될 프로젝트의 정보를 담은 VO
	 * @author 김길태
	 * @since 2017. 08. 28
	 */
	@RequestMapping("insertProject")
	public ModelAndView insertPro(@RequestParam(value="mem_emp")List<String> proMemNumList, @RequestParam(value="mem_role")List<String> proMemRoleList,
										ModelAndView andView, ProjectVO projectInfo){
		service.insertPro(projectInfo, proMemNumList, proMemRoleList);
		
		andView.setViewName("redirect:/project/projectList.do");
		return andView;
	}
	
	
	/**
	 * 선택된 프로젝트와 해당 프로젝트에 참여된 인원을 삭제, 선택된 사원을 추가 하는 기능
	 * @param proID 수정할 프로젝트의 ID
	 * @param proMemNumList 추가할 사원의 사원번호
	 * @param proMemRoleList 추가할 사원의 직책
	 * @param deleteMemNumList 삭제할 팀원의 사원번호
	 * @param projectInfo 수정할 프로젝트의 정보
	 * @author 김길태
	 * @since 2017. 09. 05 
	 */
	@RequestMapping("updateProject")
	public ModelAndView updatePro(@RequestParam(value="mem_emp", required=false)List<String> proMemNumList,
								  @RequestParam(value="mem_role", required=false)List<String> proMemRoleList,
								  @RequestParam(value="delete_mem_emp", required=false)List<String> deleteMemNumList,
								  ModelAndView andView, ProjectVO projectInfo) throws SQLException{
		service.updatePro(proMemNumList, proMemRoleList, deleteMemNumList, projectInfo);
		andView.setViewName("redirect:/project/projectList.do");
		return andView;
	}
	
	/**
	 * 선택된 프로젝트를 삭제
	 * @param proID 삭제할 프로젝트의 ID
	 * @author 김길태
	 * @since 2017. 09. 05
	 */
	@RequestMapping("dropProject")
	public ModelAndView dropPro(@RequestParam(value="proID")String proID, ModelAndView andView){
		service.dropProject(proID);
		andView.setViewName("redirect:/project/projectList.do");
		return andView;
	}
	
	/**
	 * 프로젝트의 일정 상세보기 출력
	 * @author 김길태
	 * @since 2017. 08. 25
	 */
	@RequestMapping("projectDetailView")
	public ModelAndView proDetailView(ModelAndView andView){
		andView.setViewName("project/proDetailView");
		return andView;
	}

	/**
	 * * 프로젝트의 세부 정보창을 출력하는 부분(그 프로젝트의 스케줄과 프로젝트에 참여한 멤버의 정보를 들고간다.)
	 * @param pickProjectID 선택한 프로젝트의 ID
	 * @param search_keycode 프로젝트 List에서 검색한 내역 중 분류 부분
	 * @param search_keyword 프로젝트 List에서 검색한 내역 중 워드 부분 
	 * @author 김길태
	 * @throws Exception 
	 * @since 2017. 08. 25	최초 작성<br>
	 *        2017. 09. 02 	정준혁 (프로젝트 형황 Bar 수정)<br>
	 *        2017. 09. 05	박일훈 (프로젝트에 소속된 문서 개수 출력) 
	 *        2017. 09. 08	강대성 (프로젝트에 소속된 게시판 / 자료실 리스트) 
	 */
	@RequestMapping("projectScheduleView")
	public ModelAndView proScheView	(ModelAndView andView, String pickProjectID, String search_keycode, 
			String search_keyword, HttpSession session, String pickProjectPlID) throws Exception{
		andView.setViewName("project/proScheView");
		
		//모든 스케줄의 정보와 스케줄에 포함된 멤버를 불러온다.
		List<Map<String, String>> projectMember = scheService.getScheMemList(pickProjectID);
		List<Map<String, String>> scheList = scheService.getScheList(pickProjectID);
		
		//프로젝트 진행 상황바
		Map<String, String> proBarInfo = this.service.getProBarInfo(pickProjectID);
		String proName = projectMember.get(0).get("PRO_NAME");
		/*
		 * 전자결재 문서함 개수 출력영역
		 */
		Map<String, String> params = new HashMap<String, String>();
		params.put("doc_proid", pickProjectID);
		params.put("det_apremp", ((EmployeeVO)session.getAttribute("LOGIN_EMPINFO")).getEmp_num());
		//프로젝트에 소속된 문서의 개수 취득
		Map<String, String> folder = docService.getTotalByFolder(params);
		
				
		//프로젝트 게시판 리스트
		params.put("pro_id", pickProjectID);
		List<Map<String, String>> proBoList = this.proBoService.getProBoScheList(params);
		
		//프로젝트 자료실 리스트
		List<Map<String, String>> proArcList = this.proArcService.getProArcScheList(params);
		
		andView.addObject("proArcList", proArcList);
		andView.addObject("proBoList", proBoList);
		andView.addObject("plID", pickProjectPlID);
		andView.addObject("folder", folder);
		andView.addObject("scheList", scheList);
		andView.addObject("proMem", projectMember);
		andView.addObject("proID", pickProjectID);
		andView.addObject("proName", proName);
		andView.addObject("proBarInfo", proBarInfo);
		andView.addObject("search_keycode", search_keycode);
		andView.addObject("search_keyword", search_keyword);
		andView.setViewName("project/proScheView");
		return andView;
	}
	
	/**
	 * 미구현
	 * @author 김길태
	 * @since 2017. 09. 04
	 */
	@RequestMapping("projectScheduleList")
	public ModelAndView proScheList(ModelAndView andView) throws SQLException{
		Map<String, String> params = new HashMap<String, String>();
		andView.setViewName("project/proScheList");
		return andView;
	}
	
	/**
	 * 생성된 프로젝트의 List를 출력
	 * @param search_keycode 검색 조건
	 * @param search_keyword 검색할 문자
	 * @author 김길태
	 * @since 2017.08.30
	 */
	@RequestMapping("projectList")
	public ModelAndView proList(ModelAndView andView, String search_keycode, String search_keyword,
								HttpServletRequest request, String currentPage) throws SQLException{
		// 검색 기능(null은 모든 정보)
		Map<String, String> params = new HashMap<String, String>();
		params.put("search_keycode", search_keycode);
		params.put("search_keyword", search_keyword);
		
		//paging
		int integerCurrentPage = 0;
		if(currentPage==null||currentPage==""){
			integerCurrentPage = 1;
			this.currentPage = "1";
		}else{
			this.currentPage = currentPage;
			integerCurrentPage = Integer.parseInt(this.currentPage);
		}
		String totalCount = this.service.getProjectTotalCount(params);
		int totalCountResult = Integer.parseInt(totalCount);
		RolePagingUtil rolePagingUtil = new RolePagingUtil(integerCurrentPage, totalCountResult, request);
		params.put("startCount", rolePagingUtil.getStartCount());
		params.put("endCount", rolePagingUtil.getEndCount());
		
		List<Map<String, String>> empList = new ArrayList<Map<String, String>>();
		Map<String, String> empListParams = new HashMap<String, String>();
		// 모든 사원의 목록을 읽어온다(프로젝트 추가시에 사원을 추가하기 위해)
		empList = this.empService.getEmpAllList(empListParams);
		
		List<Map<String, String>> projectList = this.service.getProList(params);
		String pagingHtml = rolePagingUtil.getPageHtml();
		
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("currentPage", currentPage);
		andView.addObject("search_keycode", search_keycode);
		andView.addObject("search_keyword", search_keyword);
		andView.addObject("projectList", projectList);
		andView.addObject("insertStatus", "null");
		andView.addObject("employeeList", empList);
		andView.setViewName("project/proList");
		return andView;
	}

	/**
	 * 미구현
	 * @author 김길태
	 * @since 2017.08.25
	 */
	@RequestMapping("projectView")
	public ModelAndView proView(ModelAndView andView) throws SQLException{
		andView.setViewName("project/proView");
		return andView;
	}
	
	/**
	 * 프로젝트의 멤버리스트를 json방식으로 불러오는 기능
	 * @param proID
	 * @author 김길태
	 * @since 2017.09.05
	 */
	@RequestMapping("loadingMemberList")
	public ModelAndView memList(ModelAndView andView, String proID) throws SQLException{
		List<Map<String, String>> projectMember = scheService.getScheMemList(proID);
		
		andView.addObject("proMember", projectMember);
		andView.setViewName("jsonConvertView");
		return andView;
	}

}
