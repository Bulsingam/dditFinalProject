package kr.or.gd.projectArchive.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.projectArchive.service.IProjectArchiveService;
import kr.or.gd.utils.RolePagingUtil;
import kr.or.gd.vo.FileItemVO;
import kr.or.gd.vo.ProjectArchiveVO;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
/**
 * @ClassName   ProjectArchiveController.java
 * @Description  프로젝트자료실
 * @Modification Information
 * @author       강대성
 * @since        2017. 09. 01.
 * @version    1.0
 * @see
 * << 개정이력(Modification Information) >>
 * 수정일      수정자   수정내용
 * -------   -------   -------------------
 * 2017. 09. 01.   강대성   최초 작성
 */
@Controller
@RequestMapping("/projectArchive/")
public class ProjectArchiveController {
	@Loggable
	private Logger logger;
	
	@Autowired
	private IProjectArchiveService service;

	/**
	 * 프로젝트 자료실 리스트 출력
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 */ 
	@RequestMapping("proArcList")
	public ModelAndView getProArcList(ModelAndView andView, HttpServletRequest request,
			String pro_id, Map<String, String> params)throws Exception{
		
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
		params.put("search_keycode", search_keycode);
		params.put("search_keyword", search_keyword);
		
		int totalcount = service.getTotalcount(params);
		
		pagingUtil = new RolePagingUtil(currentPage, totalcount, request, pro_id);
		params.put("startCount", pagingUtil.getStartCount());
		params.put("endCount", pagingUtil.getEndCount());
		
		List<Map<String, String>> proArcList = this.service.getProArcList(params);

		pagingHtml = pagingUtil.getPageHtml();
		
		andView.addObject("pro_id", pro_id);
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("proArcList", proArcList);
		andView.setViewName("projectArchive/proArcList");
		
		return andView;
	}
	
	/**
	 * 프로젝트 자료실 글등록
	 * @param  
	 * @author 강대성
	 * @since 2017-09-01
	 * 수정 강대성 2017-09-02
	 */ 
	@RequestMapping("insertProjectArchive")
	public String insertProjectArchive(
			String pro_arc_proid,
			Map<String, String> params,
			ProjectArchiveVO proAcrInfo,
			@RequestBody String parameters,
			RedirectAttributes redirectAttributes,
			HttpServletRequest request)throws Exception{
		
		MultipartHttpServletRequest wrapper = (MultipartHttpServletRequest) request;

		Iterator<String> fileNames = wrapper.getFileNames();
		
		String fileName = "";
		while(fileNames.hasNext()){
			List<MultipartFile> files = wrapper.getFiles(fileNames.next());
			
			for(MultipartFile file : files){
				if(file.getSize() > 0){
					
					proAcrInfo.setPro_arc_filename(file.getOriginalFilename());
					proAcrInfo.setPro_arc_savename(System.currentTimeMillis() + file.getOriginalFilename());
					proAcrInfo.setPro_arc_filesize(String.valueOf(file.getSize()));
					proAcrInfo.setPro_arc_filetype(file.getContentType());
					
					fileName = System.currentTimeMillis() + file.getOriginalFilename();
					
					File saveFile = new File("D:\\2jo\\Project\\ProArchive", fileName);
					
					file.transferTo(saveFile);
					
				}
			}
		}
		String pro_id = pro_arc_proid;
		
		this.service.insertProArc(proAcrInfo);
		return "redirect:/projectArchive/proArcList.do?pro_id=" + pro_id;
	}

	/**
	 * 프로젝트 자료실 글 삭제
	 * @param  
	 * @author 강대성
	 * @since 2017-09-02
	 */
	@RequestMapping("deleteProjectArchive")
	public String deleteProjectArchive(String pro_arc_num, String pro_id)throws Exception{
		
		this.service.deleteProArc(pro_arc_num);
		
		return "redirect:/projectArchive/proArcList.do?pro_id=" + pro_id;
	}
	
	/**
	 * 프로젝트 자료실 모달창
	 * @param  
	 * @author 강대성
	 * @since 2017-09-02
	 */
	@RequestMapping("getProArc")
	public ModelAndView getProArc(ModelAndView andView,
			String pro_arc_num)throws Exception{
		
		ProjectArchiveVO proArcInfo =  this.service.getProArc(pro_arc_num);
		
		andView.addObject("proArcInfo", proArcInfo);
		andView.setViewName("jsonConvertView");
		return andView;
	}
	
	/**
	 * 프로젝트 자료실 수정
	 * @param  
	 * @author 강대성
	 * @since 2017-09-04
	 * @since 2017-09-05 자료실 파일 수정 추가
	 */
	@RequestMapping("updateProArc")
	public String updateProArc(ProjectArchiveVO proArcInfo, 
			String pro_id,
			@RequestBody String parameters,
			HttpServletRequest request)throws Exception{
		
		MultipartHttpServletRequest wrapper = (MultipartHttpServletRequest) request;

		Iterator<String> fileNames = wrapper.getFileNames();
		
		String fileName = "";
		while(fileNames.hasNext()){
			List<MultipartFile> files = wrapper.getFiles(fileNames.next());
			
			for(MultipartFile file : files){
				if(file.getSize() > 0){
					
					proArcInfo.setPro_arc_filename(file.getOriginalFilename());
					proArcInfo.setPro_arc_savename(System.currentTimeMillis() + file.getOriginalFilename());
					proArcInfo.setPro_arc_filesize(String.valueOf(file.getSize()));
					proArcInfo.setPro_arc_filetype(file.getContentType());
					
					fileName = System.currentTimeMillis() + file.getOriginalFilename();
					
					File saveFile = new File("D:\\2jo\\Project\\ProArchive", fileName);
					
					file.transferTo(saveFile);
					
				}
			}
		}
		
		this.service.updateProArc(proArcInfo);
		
		return "redirect:/projectArchive/proArcList.do?pro_id=" + pro_id;
	}

	/**
	 * 프로젝트 자료실 다운로드
	 * @param  
	 * @author 강대성
	 * @since 2017-09-04
	 */	
	@RequestMapping("downloadProArc")
	public ModelAndView downloadProArc(String pro_arc_num, Map<String, String> params)throws Exception{
		params.put("pro_arc_num", pro_arc_num);
		
		ProjectArchiveVO proArcInfo = this.service.downloadProArc(params);
		
		File downloadFile = new File("D:\\2jo\\Project\\ProArchive", proArcInfo.getPro_arc_savename());
		
		return new ModelAndView("downloadView", "downloadFile", downloadFile);
	}
	
}



















