package kr.or.gd.companyBoard.controller;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.activation.CommandMap;
import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import kr.or.gd.companyBoard.service.ICompanyBoardService;
import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.utils.RolePagingUtil;
import kr.or.gd.vo.ArchiveVO;
import kr.or.gd.vo.CompanyBoardVO;
import kr.or.gd.vo.FileItemVO;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping("/companyBoard/")
public class CompanyBoardController {

	@Loggable
	private Logger logger;
	
	@Autowired
	private ICompanyBoardService service;
	

	/**
	 * 사내게시판 게시글 등록폼이동
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@RequestMapping("insertComView")
	public void insertComView(){} 
			
	

		
	/**
	 * 사내게시판 게시글 등록
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@RequestMapping("insertComboardInfo")
	public String insertComboardInfo(CompanyBoardVO comboardInfo,
			@RequestBody String parameters,
			RedirectAttributes redirectAttributes,
			HttpServletRequest request) throws Exception{
		
		MultipartHttpServletRequest wrapper= 
				(MultipartHttpServletRequest) request;
		
		Iterator<String> fileNames = wrapper.getFileNames();
		List<FileItemVO> fileList = new ArrayList<FileItemVO>();
		
		String fileName = "";
		while(fileNames.hasNext()){
			List<MultipartFile> files = wrapper.getFiles(fileNames.next());
			
			for(MultipartFile file : files){
				if(file.getSize() > 0){
					FileItemVO fileInfo = new FileItemVO();
					
					fileInfo.setFile_name(file.getOriginalFilename());
					fileInfo.setFile_savename(System.currentTimeMillis() + file.getOriginalFilename());
					fileInfo.setFile_size(String.valueOf(file.getSize()));
					fileInfo.setFile_type(file.getContentType());
					
					fileName = System.currentTimeMillis() + file.getOriginalFilename();
					
					File saveFile = new File("D:\\2jo\\FileItem\\Company", fileName);
					
					file.transferTo(saveFile);
					
					fileList.add(fileInfo);
				}
			}
		}
		
			comboardInfo.setAttachFileInfo(fileList);
			this.service.insertComboardInfo(comboardInfo);
		
		
		
		return "redirect:/companyBoard/comList.do";
		
	}
	
	
	
	

	
		/**
		* 사내게시판 게시글 상세조회 
		* @param 
		* @author 조인호
		* @since 2017-09-05
		* 
		*/
	@RequestMapping("comView")
	public ModelAndView getComBoInfo(ModelAndView andView, String com_postnum,Map<String,String> params)
	throws Exception{
		params.put("com_postnum", com_postnum);
		
		List<Map<String,String>> comboardInfo = this.service.getComBoView(params);
		
		andView.addObject("comboardInfo",comboardInfo);
		andView.setViewName("companyBoard/comView");
		return andView;
	}
	

	
	
	
	
		/**
		* 사내게시판 게시글 리스트 출력
		* @param 
		* @author 조인호
		* @since 2017-09-05
		* 
		*/
	@RequestMapping("comList")
	public ModelAndView getComboardList(ModelAndView andView, HttpServletRequest request,
			Map<String,String> params) throws Exception{
		
		int currentPage;
		
		if(request.getParameter("currentPage") == null || request.getParameter("currentPage")==""){
			currentPage = 1;
		}else{
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		String search_keycode = request.getParameter("search_keycode");
		String search_keyword = request.getParameter("search_keyword");
		
		String pagingHtml;
		RolePagingUtil pagingUtil;
		
		params.put("search_keycode", search_keycode);
		params.put("search_keyword", search_keyword);
		
		int totalCount = service.getTotalCount(params);
		
		pagingUtil = new RolePagingUtil(currentPage, totalCount, request);
		params.put("endCount", pagingUtil.getEndCount());
		params.put("startCount", pagingUtil.getStartCount());
		
		List<Map<String, String>> comboardList = this.service.getComboardList(params);
		
		pagingHtml = pagingUtil.getPageHtml();
		
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("comboardList", comboardList);
		andView.setViewName("companyBoard/comList");
		
		return andView;
				
		
	}
	
	/**
	* 사내게시판 게시글 삭제
	* @param 
	* @author 조인호
	* @since 2017-09-05
	* 
	*/
	@RequestMapping("deleteComboardInfo")
	public String deleteComboardInfo(String com_postnum, Map<String,String> params)
		throws Exception{
		
		params.put("com_postnum", com_postnum);
		
		this.service.deleteComboardInfo(params);
		
		return "redirect:/companyBoard/comList.do";
	}
	
	
	
	/**
	* 사내게시판 게시글 수정뷰로이동
	* @param 
	* @author 조인호
	* @since 2017-09-05
	* 
	*/
	@RequestMapping("updateComView")
	public ModelAndView updateComView(ModelAndView andView, String com_postnum, Map<String,String> params) throws Exception{
		params.put("com_postnum", com_postnum);
		
		List<Map<String,String>> comboardInfo = this.service.getComBoView(params);
		
		andView.addObject("comboardInfo", comboardInfo);
		andView.setViewName("companyBoard/updateComView");
		return andView;
		
	}
	
	
	
	/**
	* 사내게시판 게시글 수정
	* @param 
	* @author 조인호
	* @since 2017-09-05
	* 
	*/
	@RequestMapping("updateComboardInfo")
	public String updateComboardInfo(CompanyBoardVO comboardInfo){
		this.service.updateComboardInfo(comboardInfo);
		return "redirect:/companyBoard/comList.do";
	}
	
	
	/**
	* 사내게시판 게시글 파일 다운로드
	* @param 
	* @author 조인호
	* @since 2017-09-05
	* 
	*/
	@RequestMapping("comDownload")
	public ModelAndView comDownload(String file_seq, Map<String, String> params)throws Exception{
		
		params.put("file_seq", file_seq);
		
		FileItemVO fileInfo = this.service.getComFileDownload(params);
		
		File downloadFile = new File("D:\\2jo\\FileItem\\Company", fileInfo.getFile_savename());
		
		return new ModelAndView("downloadView", "downloadFile", downloadFile);
	}
	
	
	/**
	* 사내게시판 게시글 답글 등록뷰이동
	* @param 
	* @author 조인호
	* @since 2017-09-05
	* 
	*/
	@RequestMapping("insertReplyComView")
	public void insertReplyComView(){ }
	
	
	
	/**
	* 사내게시판 게시글 답글등록
	* @param 
	* @author 조인호
	* @since 2017-09-05
	* 
	*/
	@RequestMapping("insertReplyComboard")
	public String insertReplyComboard(CompanyBoardVO comboardInfo,
			@RequestBody String parameters,
			RedirectAttributes redirectAttributes)throws Exception{
			
		this.service.insertReplyComboard(comboardInfo);
		return "redirect:/companyBoard/comList.do";
	}

	
}
