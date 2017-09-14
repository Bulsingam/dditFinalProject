package kr.or.gd.personalSchedule.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.personalSchedule.service.IPersonalScheduleService;
import kr.or.gd.vo.EmployeeScheduleVO;
import kr.or.gd.vo.PositionVO;
import kr.or.gd.vo.RoleVO;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/personalSchedule/")
public class PersonalScheduleController {

	@Loggable
	private Logger logger;
	
	@Autowired
	private IPersonalScheduleService service;
	/**
	 * 사원 개인 일정 출력뷰
	 * MethodName : personalSchduleView
	 * ClassName  : PersonalScheduleController
	 * @return ModelAndView
	 * @throws Exception
	 * @since  : 2017. 9. 1.
	 * @author  : 박예연
	 */
	@RequestMapping("personalScheduleView")
	public ModelAndView personalSchduleView(ModelAndView andView , String emp_num) throws SQLException{
		//View 로 가려면 emp_num 을 가지고 그 개인의 일정을 다 검색해서 그 날짜에 맞는걸 뿌려줘야해 
		// 일정을 싹다 가져오자 
		List<Map<String, String>> schedule = new ArrayList<Map<String,String>>();
		List<Map<String, String>> empScheList = service.getEmpSchedule(emp_num);
//		List<Map<String, String>> proList = service.getEmpProList(emp_num);
////		 가져와서 empSche에 담아서 넘어간다 
//		andView.addObject("proList",proList);
		andView.addObject("emp_num",emp_num);
		andView.addObject("schedule",schedule);
		andView.addObject("empScheList",empScheList);
		andView.setViewName("employee/empScheView");
		return andView;
	}
	/**
	 * 개인 스케줄을 다시 로딩 시키는 ajax를 위한 
	 * MethodName : loadingPerSche
	 * ClassName  : PersonalScheduleController
	 * @return ModelAndView
	 * @throws Exception
	 * @since  : 2017. 9. 2.
	 * @author  : 박예연
	 */
	@RequestMapping("loadingPersonalSchedule")
	public ModelAndView loadingPerSche(ModelAndView andView , String emp_num, String mem_proId) throws SQLException{
		//View 로 가려면 emp_num 을 가지고 그 개인의 일정을 다 검색해서 그 날짜에 맞는걸 뿌려줘야해 
		// 일정을 싹다 가져오자 
		List<Map<String, String>> schedule = new ArrayList<Map<String,String>>();
		List<Map<String, String>> empScheList = service.getEmpSchedule(emp_num);
//		 가져와서 empSche에 담아서 넘어간다 
//		
		for (Map<String, String> map : empScheList) {
			HashMap scheduleBox = new HashMap();
			scheduleBox.put("id", map.get("SCHE_NUM"));
			scheduleBox.put("title", map.get("SCHE_NAME"));
			scheduleBox.put("start", map.get("SCHE_STARTDATE"));
			scheduleBox.put("end", map.get("SCHE_ENDDATE"));
			scheduleBox.put("backgroundColor","#f39c12");
			scheduleBox.put("borderColor","#f39c12");
			
			schedule.add(scheduleBox);
		}
		
		andView.addObject("emp_num",emp_num);
		andView.addObject("schedule",schedule);
		andView.addObject("empScheList",empScheList);
		andView.setViewName("jsonConvertView");
		return andView;
	}
	/**
	 * 개인이 진행중인 프로젝트의 일정에 들어갈 list출력하는 메서드
	 * MethodName : loadingProList
	 * ClassName  : PersonalScheduleController
	 * @return ModelAndView
	 * @throws Exception
	 * @since  : 2017. 9. 3.
	 * @author  : 박예연
	 */
	@RequestMapping("loadingProjectList")
	public ModelAndView loadingProList(ModelAndView andView , String emp_num) throws SQLException{
		List<Map<String, String>> proList = service.getEmpProList(emp_num);
		
		andView.addObject("proList",proList);
		andView.setViewName("jsonConvertView");
		return andView;
	}
	
	/**
	 * 개인 스케줄 등록
	 * MethodName : insertPerSche
	 * ClassName  : PersonalScheduleController
	 * @return ModelAndView
	 * @throws Exception
	 * @since  : 2017. 9. 3.
	 * @author  : 박예연
	 */
	@RequestMapping("insertPersonalSchedule")
	public ModelAndView insertPerSche(ModelAndView andView , String emp_num ,EmployeeScheduleVO empScheInfo) throws SQLException{
		
		service.insertPerSche(empScheInfo);
		andView.setViewName("redirect:/personalSchedule/personalScheduleView.do");
		return andView;
	}
	/**
	 * 개인 스케줄 수정
	 * MethodName : updatePerSche
	 * ClassName  : PersonalScheduleController
	 * @return ModelAndView
	 * @throws Exception
	 * @since  : 2017. 9. 3.
	 * @author  : 박예연
	 */
	@RequestMapping("updatePersonalSchedule")
	public ModelAndView updatePerSche(ModelAndView andView, EmployeeScheduleVO empScheInfo ) throws SQLException{
		
		service.updatePerSche(empScheInfo);
		andView.setViewName("redirect:/personalSchedule/personalScheduleView.do");
		return andView;
		
	}
	/**
	 * 사원개인 일정 삭제 
	 * MethodName : deletePerSche
	 * ClassName  : PersonalScheduleController
	 * @return ModelAndView
	 * @throws Exception
	 * @since  : 2017. 9. 5.
	 * @author  : 박예연
	 */
	@RequestMapping("deletePersonalSchedule")
	public ModelAndView deletePerSche(ModelAndView andView, EmployeeScheduleVO empScheInfo)throws SQLException{
		
		service.deletePerSche(empScheInfo);
		andView.setViewName("redirect:/personalSchedule/personalScheduleView.do");
		return andView;
	}
}
