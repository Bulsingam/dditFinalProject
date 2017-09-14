package kr.or.gd.projectBoard.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.projectBoard.service.IProjectBoardService;
import kr.or.gd.utils.RolePagingUtil;
import kr.or.gd.vo.ProjectBoardVO;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @ClassName   ProjectBoardController.java
 * @Description  프로젝트게시판
 * @Modification Information
 * @author       강대성
 * @since        2017. 09. 04.
 * @version    1.0
 * @see
 * << 개정이력(Modification Information) >>
 * 수정일      수정자   수정내용
 * -------   -------   -------------------
 * 2017. 09. 04.   강대성   최초 작성
 */
@Controller
@RequestMapping("/projectBoard/")
public class ProjectBoardController {
	@Loggable
	private Logger logger;
	
	@Autowired
	private IProjectBoardService service;
	
	/**
	 * * 프로젝트 게시판 리스트
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	@RequestMapping("proBoList")
	public ModelAndView getProBoList(ModelAndView andView, String pro_id,
			HttpServletRequest request, Map<String, String> params)throws Exception{
		
		int currentPage;
		
		if(request.getParameter("currentPage") == null || request.getParameter("currentPage") == ""){
			currentPage = 1;
		}else{
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		String search_keycode = request.getParameter("search_keycode");
		String search_keyword = request.getParameter("search_keyword");
		
		String pagingHtml;
		RolePagingUtil pagingUtil;
		
		params.put("pro_id", pro_id);
		params.put("search_keyword", search_keyword);
		params.put("search_keycode", search_keycode);
		
		int totalcount = service.getTotalcount(params);
		
		pagingUtil = new RolePagingUtil(currentPage, totalcount, request, pro_id);
		params.put("startCount", pagingUtil.getStartCount());
		params.put("endCount", pagingUtil.getEndCount());
		
		List<Map<String, String>> proBoList = this.service.getProBoList(params);
		
		pagingHtml = pagingUtil.getPageHtml();
		
		andView.addObject("pro_id", pro_id);
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("proBoList", proBoList);
		andView.setViewName("projectBoard/proBoList");
		
		return andView;
	}
	
	
	/**
	 * 프로젝트 게시판 글등록 뷰 이동
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	@RequestMapping("insertProBoView")
	public ModelAndView insertProBoView(ModelAndView andView, String pro_id){
		andView.addObject("pro_id",pro_id);
		andView.setViewName("projectBoard/insertProBoView");
		return andView;
	}
	
	/**
	 * * 프로젝트 게시판 글등록
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	@RequestMapping("insertProBo")
	public String insertProBo(ProjectBoardVO proBoInfo,
			Map<String, String> params)throws Exception{
		
		this.service.insertProBo(proBoInfo);
		
		String pro_id = proBoInfo.getPro_bo_proid();
		
		return "redirect:/projectBoard/proBoList.do?pro_id=" + pro_id;
		
	}
	
	/**
	 * * 프로젝트 게시판 상세보기
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	@RequestMapping("proBoView")
	public ModelAndView getProBoInfo(ModelAndView andView, String pro_bo_num,
			Map<String, String> params)throws Exception{
		
		params.put("pro_bo_num", pro_bo_num);
		
		List<Map<String, String>> proBoInfo = this.service.getProBoInfo(params);
		
		andView.addObject("proBoInfo", proBoInfo);
		andView.setViewName("projectBoard/proBoView");
		return andView;
	}
	
	/**
	 * * 프로젝트 게시판 정보수정 뷰
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	@RequestMapping("updateProBoView")
	public ModelAndView getProBoInfoView(ModelAndView andView, String pro_bo_num,
			Map<String, String> params)throws Exception{
		
		params.put("pro_bo_num", pro_bo_num);
		
		List<Map<String, String>> proBoInfo = this.service.getProBoInfo(params);
		
		andView.addObject("proBoInfo", proBoInfo);
		andView.setViewName("projectBoard/updateProBoView");
		return andView;
		
	}
	
	/**
	 * * 프로젝트 게시판 정보수정
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	@RequestMapping("updateProBo")
	public String updateProBo(ProjectBoardVO proBoInfo)throws Exception{

		this.service.updateProBo(proBoInfo);
		
		String pro_id = proBoInfo.getPro_bo_proid();
		
		return "redirect:/projectBoard/proBoList.do?pro_id=" + pro_id;
	}
	
	
	/**
	 * * 프로젝트 게시판 삭제
	 * @param 
	 * @author 강대성
	 * @since 2017. 09. 04
	 */
	@RequestMapping("deleteProBo")
	public String deleteProBo(String pro_bo_num, String pro_id)throws Exception{
		
		this.service.deleteProBo(pro_bo_num);
		
		return "redirect:/projectBoard/proBoList.do?pro_id=" + pro_id;
	}
	
	/**
	 * 프로젝트 게시판 댓글 등록 뷰
	 * @author 강대성
	 * @since 2017-09-05
	 */
	@RequestMapping("insertReplyProBoView")
	public void insertReplyProBoView(){}

	/**
	 * 프로젝트 게시판 댓글 등록
	 * @author 강대성
	 * @since 2017-09-05
	 */
	@RequestMapping("insertReplyProBo")
	public String insertReplyProBo(ProjectBoardVO proBoInfo)throws Exception{
		
		String pro_id = proBoInfo.getPro_bo_proid();
		
		this.service.insertReplyProBo(proBoInfo);
		
		return "redirect:/projectBoard/proBoList.do?pro_id=" + pro_id;
		
	}
}













































