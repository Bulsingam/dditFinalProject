package kr.or.gd.proWorkRate.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.proWorkRate.service.IProWorkRateService;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * @ClassName   ProWorkRateController.java
 * @Description  프로젝트 근무평가 제어 클래스 
 * @Modification Information
 * @author       정준혁
 * @since        2017. 8. 31.
 * @version    1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 * 수정일      수정자   수정내용
 * -------   -------   -------------------
 * 2017. 8. 31.   정준혁   최초 작성
 * </pre>
 */
@Controller
@RequestMapping("/proWorkRate/")
public class ProWorkRateController {
	@Loggable
	private Logger logger;
	
	@Autowired
	private IProWorkRateService service;

	/**
	 * 프로젝트 근무평가하기 위한 리스트 출력
	 * @author 정준혁
	 * @since 2017. 08. 31
	 */
	@RequestMapping("proWorkRateList")
	public ModelAndView ProWorkRateList(ModelAndView andView, String emp_num) throws SQLException{
		Map<String, String> params = new HashMap<String, String>();
		params.put("emp_num", emp_num);
		
		List<Map<String, String>> plProList = this.service.plProList(params);
		
		andView.addObject("plProList",plProList);
		andView.setViewName("project/proWorkRateList");
		return andView;
	}
	
	/**
	 * 프로젝트 근무평가 작성 페이지
	 * @author 정준혁
	 * @since 2017. 08. 31
	 */
	@RequestMapping("insertProWorkRateView")
	public ModelAndView insertProWorkRateView(ModelAndView andView, String pro_id) throws SQLException{
		Map<String, String> params = new HashMap<String, String>();
		params.put("pro_id", pro_id);
		
		List<Map<String, String>> workRateList = this.service.workRateEmpList(params);
		
		andView.addObject("workRateList",workRateList);
		andView.setViewName("project/insertProWorkRateView");
		return andView;
	}
	
	/**
	 * 프로젝트 근무평가 등록
	 * @author 정준혁
	 * @throws SQLException 
	 * @since 2017. 09. 01
	 */
	@RequestMapping("insertProWorkRate")
	public String insertProWorkRate(RedirectAttributes redirect, @RequestParam (value="wrt_tar")List<String> empList, 
																@RequestParam (value="wrt_proid")List<String> proId,
																@RequestParam (value="wrt_lev")List<String> gradList,
																@RequestParam (value="wrt_cont")List<String> contentList,
										  String wrt_rater,String emp_num) throws SQLException{
	
		boolean result = this.service.getWorkRateInfo(proId,empList);
		String message = null;
		
		//true  : 정보가 없음
		//false : 정보가 있음
		if(result==true){
			this.service.insertProWorkRate(proId, wrt_rater, empList, gradList, contentList);
			message="등록되었습니다.";
		}else{
			message="이미 평가 했습니다.";
		}
			
		redirect.addFlashAttribute("message",message);
		redirect.addFlashAttribute("emp_num",emp_num);
		return "redirect:/proWorkRate/proWorkRateList.do?emp_num="+emp_num;
	}
}
