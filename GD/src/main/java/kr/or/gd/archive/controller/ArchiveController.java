package kr.or.gd.archive.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.gd.archive.service.IArchiveService;
import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.utils.RolePagingUtil;
import kr.or.gd.vo.ArchiveVO;
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
 * @ClassName   ArchiveController.java
 * @Description  자료실
 * @Modification Information
 * @author       강대성
 * @since        2017. 8. 29.
 * @version    1.0
 * @see
 * << 개정이력(Modification Information) >>
 * 수정일      수정자   수정내용
 * -------   -------   -------------------
 * 2017. 8. 29.   강대성   최초 작성
 */
@Controller
@RequestMapping("/archive/")
public class ArchiveController {

	@Loggable
	private Logger logger;
	
	@Autowired
	private IArchiveService service;

	/**
	 * 자료실 리스트 불러오기
	 * @param 
	 * @author 강대성
	 * @since 2017-08-29
	 * @since 2017-08-30
	 * @since 2017-08-31
	 */
	@RequestMapping("getArcList")
	public ModelAndView getArcList(ModelAndView andView, HttpServletRequest request,
			Map<String, String> params) throws Exception{
		
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
		
		int totalCount = service.getTotalCount(params);
		
		pagingUtil = new RolePagingUtil(currentPage, totalCount, request);
		params.put("startCount", pagingUtil.getStartCount());
		params.put("endCount", pagingUtil.getEndCount());
		
		List<Map<String, String>> archiveList = this.service.getArcList(params);
		
		pagingHtml = pagingUtil.getPageHtml();
		
		andView.addObject("pagingHtml", pagingHtml);
		andView.addObject("archiveList", archiveList);
		andView.setViewName("archive/getArcList");
		
		return andView;
	}
	
	/**
	 * 자료실 상세정보출력
	 * @param arc_postnum 
	 * @author 강대성
	 * @since 2017-08-29
	 * @since 2017-09-05 파일정보 불러오기 수정
	 */
	@RequestMapping("getArcInfoView")
	public ModelAndView getArcInfoView(ModelAndView andView, String arc_postnum, Map<String, String> params)
			throws Exception{
		params.put("arc_postnum", arc_postnum);
		
		List<Map<String, String>> archiveInfo = this.service.getArcInfoView(params);
		FileItemVO fileInfo = this.service.getFileInfo(params);
		
		andView.addObject("fileInfo", fileInfo);
		andView.addObject("archiveInfo", archiveInfo);
		andView.setViewName("archive/getArcInfoView");
		
		return andView;
	}
	
	/**
	 * 자료실 글 삭제
	 * @param arc_postnum 
	 * @author 강대성
	 * @since 2017-08-29
	 */
	@RequestMapping("deleteArc")
	public String deleteArc(String arc_postnum, Map<String, String> params)
			throws Exception{
		
		params.put("arc_postnum", arc_postnum);
		
		this.service.deleteArc(params);
		
		return "redirect:/archive/getArcList.do";
	}
	
	/**
	 * 자료실 글등록뷰 이동
	 * @author 강대성
	 * @since 2017-08-29
	 */
	@RequestMapping("insertArcView")
	public void insertArcView(){ }
	
	/**
	 * 자료실 글등록
	 * @param archiveInfo 
	 * @author 강대성
	 * @since 2017-08-29
	 * @since 2017-08-30
	 */
	@RequestMapping("insertArc")
	public String insertArc(ArchiveVO archiveInfo,
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
					
					File saveFile = new File("D:\\2jo\\FileItem\\Archive", fileName);
					
					file.transferTo(saveFile);
					
					fileList.add(fileInfo);
				}
			}
		}
		
		archiveInfo.setAttachFileInfo(fileList);
		this.service.insertArc(archiveInfo);
		
		return "redirect:/archive/getArcList.do";
		
	}
	
	/**
	 * 자료실 파일 다운로드
	 * @param file_seq 
	 * @author 강대성
	 * @since 2017-08-30
	 */
	@RequestMapping("arcDownload")
	public ModelAndView arcDownload(String file_seq, Map<String, String> params)throws Exception{
		
		params.put("file_seq", file_seq);
		
		FileItemVO fileInfo = this.service.getArcFileDownload(params);
		
		File downloadFile = new File("D:\\2jo\\FileItem\\Archive", fileInfo.getFile_savename());
		
		return new ModelAndView("downloadView", "downloadFile", downloadFile);
	}
	
	/**
	 * 자료실 정보 수정뷰 이동
	 * @param arc_postnum
	 * @author 강대성
	 * @since 2017-08-30
	 */
	@RequestMapping("updateArcView")
	public ModelAndView updateArcView(ModelAndView andView, String arc_postnum, Map<String, String> params)throws Exception{
		params.put("arc_postnum", arc_postnum);
		
		List<Map<String, String>> archiveInfo = this.service.getArcInfoView(params);
		
		andView.addObject("archiveInfo", archiveInfo);
		andView.setViewName("archive/updateArcView");
		
		return andView;
	}
	
	/**
	 * 자료실 정보 수정
	 * @param arc_postnum
	 * @author 강대성
	 * @since 2017-08-30
	 * @since 2017-09-05 파일수정 추가
	 */
	@RequestMapping("updateArc")
	public String updateArc(ArchiveVO archiveInfo,
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
					
					File saveFile = new File("D:\\2jo\\FileItem\\Archive", fileName);
					
					file.transferTo(saveFile);
					
					fileList.add(fileInfo);
				}
			}
		}
		
		archiveInfo.setAttachFileInfo(fileList);

		this.service.updateArc(archiveInfo);
		return "redirect:/archive/getArcList.do";
	}
	
	/**
	 * 자료실 댓글 등록 뷰
	 * @author 강대성
	 * @since 2017-08-30
	 */
	@RequestMapping("insertReplyArcView")
	public void insertReplyArcView(){ }
	

	/**
	 * 자료실 댓글 등록
	 * @param archiveInfo
	 * @author 강대성
	 * @since 2017-08-31
	 */
	@RequestMapping("insertReplyArc")
	public String insertReplyArc(ArchiveVO archiveInfo,
			@RequestBody String parameters,
			RedirectAttributes redirectAttributes)throws Exception{
			
		this.service.insertReplyArc(archiveInfo);
		return "redirect:/archive/getArcList.do";
	}
	
}

