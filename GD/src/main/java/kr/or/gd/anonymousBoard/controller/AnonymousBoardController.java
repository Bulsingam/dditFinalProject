package kr.or.gd.anonymousBoard.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.gd.anonymousBoard.service.IAnonymousBoardService;
import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.utils.RolePagingUtil;
import kr.or.gd.vo.AnonymousBoardVO;
import kr.or.gd.vo.FileItemVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.slf4j.Logger;
/**
 * @ClassName   AnonymousBoardController.java
 * @Description  익명게시판
 * @Modification Information
 * @author       강대성
 * @since        2017. 8. 31.
 * @version    1.0
 * @see
 * << 개정이력(Modification Information) >>
 * 수정일      수정자   수정내용
 * -------   -------   -------------------
 * 2017. 8. 31.   강대성   최초 작성
 */
@Controller
@RequestMapping("/anonymousBoard/")
public class AnonymousBoardController {

	@Loggable
	private Logger logger;
	
	@Autowired
	private IAnonymousBoardService service;
	
	/**
	 * 익명게시판 글등록뷰 이동
	 * @author 강대성
	 * @since 2017-08-31
	 */
	@RequestMapping("insertAnyBoView")
	public void insertAnyBoView(){ }
	
	/**
	 * 익명게시판 글등록
	 * @param anyBoInfo 
	 * @author 강대성
	 * @since 2017-08-31
	 */ 
	@RequestMapping("insertAnyBo")
	public String insertAnyBo(AnonymousBoardVO anyBoInfo,
			@RequestBody String parameters,
			RedirectAttributes redirectAttributes,
			HttpServletRequest request) throws Exception{
		
		MultipartHttpServletRequest wrapper = 
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
					
					File saveFile = new File("D:\\2jo\\FileItem\\Anonymous", fileName);
					
					file.transferTo(saveFile);
					
					fileList.add(fileInfo);
				}
			}
		}
		
		anyBoInfo.setAttachFileInfo(fileList);
		this.service.insertAnyBo(anyBoInfo);
		
		return "redirect:/anonymousBoard/getAnyBoList.do";
		
	}
	
	/**
	 * 익명게시판 리스트 출력
	 * @param 
	 * @author 강대성
	 * @since 2017-09-01
	 */ 	
	@RequestMapping("getAnyBoList")
	public ModelAndView getAnyBoList(ModelAndView andView, HttpServletRequest request,
		Map<String, String> params)throws Exception{
		
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
		
		params.put("search_keycode", search_keycode);
		params.put("search_keyword", search_keyword);
		
		int totalcount = service.getTotalcount(params);
		
		pagingUtil = new RolePagingUtil(currentPage, totalcount, request);
		params.put("startCount", pagingUtil.getStartCount());
		params.put("endCount", pagingUtil.getEndCount());
		
		List<Map<String, String>> anyBoList = this.service.getAnyList(params);
		
		pagingHtml = pagingUtil.getPageHtml();
		
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("anyBoList", anyBoList);
		andView.setViewName("anonymousBoard/getAnyBoList");
		
		return andView;
	}
	
	/**
	 * 익명게시판 상세정보 출력
	 * @param 
	 * @author 강대성
	 * @since 2017-09-01
	 * @since 2017-09-05 파일정보 불러오기 수정
	 */ 		
	@RequestMapping("getAnyBoInfoView")
	public ModelAndView getAnyBoInfoView(ModelAndView andView, String any_postnum,
			Map<String, String> params)throws Exception{
		
		params.put("any_postnum", any_postnum);
		
		List<Map<String, String>> anyBoInfo = this.service.getAnyBoInfoView(params);
		FileItemVO fileInfo = this.service.getFileInfo(params);
		
		andView.addObject("fileInfo", fileInfo);
		andView.addObject("anyBoInfo", anyBoInfo);
		andView.setViewName("anonymousBoard/getAnyBoInfoView");
		return andView;
	}
	
	/**
	 * 익명게시판 파일 다운로드
	 * @param 
	 * @author 강대성
	 * @since 2017-09-01
	 */ 	
	@RequestMapping("anyDownload")
	public ModelAndView anyDownload(String file_seq, Map<String, String> params)throws Exception{
		
		params.put("file_seq", file_seq);
		
		FileItemVO fileInfo = this.service.getAnyFileDownload(params);
		
		File downloadFile = new File("D:\\2jo\\FileItem\\Anonymous", fileInfo.getFile_savename());
		
		return new ModelAndView("downloadView", "downloadFile", downloadFile);
		
	}
	
	/**
	 * 익명게시판 정보 수정 뷰
	 * @param 
	 * @author 강대성
	 * @since 2017-09-01
	 */ 		
	@RequestMapping("updateAnyBoView")
	public ModelAndView updateAnyBoView(ModelAndView andView, String any_postnum,
			Map<String, String> params)throws Exception{
		
		params.put("any_postnum", any_postnum);
		List<Map<String, String>> anyBoInfo = this.service.getAnyBoInfoView(params);
		
		andView.addObject("anyBoInfo", anyBoInfo);
		andView.setViewName("anonymousBoard/updateAnyBoView");
		
		return andView;
		
	}
	
	/**
	 * 익명게시판 정보 수정
	 * @param 
	 * @author 강대성
	 * @since 2017-09-01
	 * @since 2017-09-05 파일 수정 추가
	 */ 	
	@RequestMapping("updateAnyBo") 
	public String updateAnyBo(AnonymousBoardVO anyBoInfo,
			@RequestBody String parameters,
			RedirectAttributes redirectAttributes,
			HttpServletRequest request) throws Exception{
		
		MultipartHttpServletRequest wrapper = 
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
					
					File saveFile = new File("D:\\2jo\\FileItem\\Anonymous", fileName);
					
					file.transferTo(saveFile);
					
					fileList.add(fileInfo);
				}
			}
		}
		
		anyBoInfo.setAttachFileInfo(fileList);
		
		this.service.updateAnyBo(anyBoInfo);
		return "redirect:/anonymousBoard/getAnyBoList.do";
		
	}
	
	/**
	 * 익명게시판 게시글 삭제
	 * @param 
	 * @author 강대성
	 * @since 2017-09-01
	 */
	@RequestMapping("deleteAnyBo")
	public String deleteAnyBo(String any_postnum, Map<String, String> params)throws Exception{
		
		params.put("any_postnum", any_postnum);
		this.service.deleteAnyBo(params);
		
		return "redirect:/anonymousBoard/getAnyBoList.do";
		
	}
	
	/**
	 * 익명게시판 댓글 등록 뷰
	 * @param 
	 * @author 강대성
	 * @since 2017-09-01
	 */	
	@RequestMapping("insertReplyAnyBoView")
	public void insertReplyAnyBoView(){ }
	
	/**
	 * 익명게시판 댓글 등록
	 * @param 
	 * @author 강대성
	 * @since 2017-09-01
	 */
	@RequestMapping("insertReplyAnyBo")
	public String insertReplyAnyBo(AnonymousBoardVO anyBoInfo,
			@RequestBody String parameters,
			RedirectAttributes redirectAttributes)throws Exception{
		
		this.service.insertReplyAnyBo(anyBoInfo);
		
		return "redirect:/anonymousBoard/getAnyBoList.do";
	}
	
}

























