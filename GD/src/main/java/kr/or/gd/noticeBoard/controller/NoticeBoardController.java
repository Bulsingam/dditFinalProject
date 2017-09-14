package kr.or.gd.noticeBoard.controller;

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




import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.noticeBoard.service.INoticeBoardService;
import kr.or.gd.utils.RolePagingUtil;
import kr.or.gd.vo.ArchiveVO;
import kr.or.gd.vo.CompanyBoardVO;
import kr.or.gd.vo.FileItemVO;
import kr.or.gd.vo.NoticeBoardVO;

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
@RequestMapping("/noticeBoard/")
public class NoticeBoardController {

	@Loggable
	private Logger logger;
	
	@Autowired
	private INoticeBoardService service;
	

	/**
	 * 공지게시판 게시글 등록폼으로 이동
	 * @param 
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@RequestMapping("insertNotiView")
	public void insertNotiView(){} 
			
	

		
	/**
	 * 공지게시판 게시글 등록
	 * @param
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@RequestMapping("insertNotiboardInfo")
	public String insertNotiboardInfo(NoticeBoardVO notiboardInfo,
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
					fileInfo.setFile_savename(System.currentTimeMillis()+ file.getOriginalFilename());
					fileInfo.setFile_size(String.valueOf(file.getSize()));
					fileInfo.setFile_type(file.getContentType());
					
					fileName = System.currentTimeMillis()+ file.getOriginalFilename();
					
					File saveFile = new File("D:\\2jo\\FileItem\\Notice", fileName);
					
					file.transferTo(saveFile);
					
					fileList.add(fileInfo);
				}
			}
		}
		
			notiboardInfo.setAttachFileInfo(fileList);
			this.service.insertNotiboardInfo(notiboardInfo);
		
		
		
		return "redirect:/noticeBoard/notiList.do";
		
	}
	
	
	/**
	 * 공지게시판 게시글 상세조회
	 * @param
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@RequestMapping("notiView")
	public ModelAndView getNotiBoInfo(ModelAndView andView,HttpServletRequest request,
			String noti_postnum,Map<String,String> params)
	throws Exception{
		
		
		params.put("noti_postnum", noti_postnum);
		
		List<Map<String,String>> notiboardInfo = this.service.getNotiView(params);
	
		
		
		andView.addObject("notiboardInfo",notiboardInfo);
		andView.setViewName("noticeBoard/notiView");
		return andView;
	}
	

	
	/**
	 * 공지게시판 게시글 리스트 출력
	 * @param
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@RequestMapping("notiList")
	public ModelAndView getNotiboardList(ModelAndView andView, HttpServletRequest request,
			Map<String,String> params) throws Exception{
		
		int currentPage;
		
		if(request.getParameter("currentPage") == null|| request.getParameter("currentPage") == ""){
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
		
		List<Map<String, String>> notiboardList = this.service.getNotiboardList(params);
		
		pagingHtml = pagingUtil.getPageHtml();
		
		
		
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("notiboardList", notiboardList);
		andView.setViewName("noticeBoard/notiList");
		
	
		return andView;
				
		
	}
	
	
	/**
	 * 공지게시판 게시글 삭제
	 * @param
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@RequestMapping("deleteNotiboardInfo")
	public String deleteNotiboardInfo(String noti_postnum, Map<String,String> params)
		throws Exception{
		
		params.put("noti_postnum", noti_postnum);
		
		this.service.deleteNotiboardInfo(params);
		
		return "redirect:/noticeBoard/notiList.do";
	}
	
	
	
	
	/**
	 * 공지게시판 게시글 수정페이지 이동
	 * @param
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@RequestMapping("updateNotiView")
	public ModelAndView updateNotiView(ModelAndView andView, String noti_postnum, Map<String,String> params) throws Exception{
		params.put("noti_postnum", noti_postnum);
		
		List<Map<String,String>> notiboardInfo = this.service.getNotiView(params);
		
		andView.addObject("notiboardInfo", notiboardInfo);
		andView.setViewName("noticeBoard/updateNotiView");
		return andView;
		
	}
	
	
	/**
	 * 공지게시판 게시글 수정
	 * @param
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@RequestMapping("updateNotiboardInfo")
	public String updateNotiboardInfo(NoticeBoardVO notiboardInfo) throws Exception{
		this.service.updateNotiboardInfo(notiboardInfo);
		return "redirect:/noticeBoard/notiList.do";
	}
	
	
	/**
	 * 공지게시판 게시글 파일다운로드
	 * @param
	 * @author 조인호
	 * @since 2017-09-05
	 * 
	 */
	@RequestMapping("notiDownload")
	public ModelAndView notiDownload(String file_seq, Map<String, String> params)throws Exception{
		
		params.put("file_seq", file_seq);
		
		FileItemVO fileInfo = this.service.getNotiFileDownload(params);
		
		File downloadFile = new File("D:\\2jo\\FileItem\\Notice", fileInfo.getFile_savename());
		
		return new ModelAndView("downloadView", "downloadFile", downloadFile);
	}
	
	
	

	
	
	
	
}
