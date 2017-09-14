package kr.or.gd.schedule.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.schedule.service.IScheduleService;
import kr.or.gd.vo.ProjectScheduleVO;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * @ClassName	ScheduleController.java
 * @Description	프로젝트 참여인원의 스케줄을 관리하기위한 화면을 제어하는 클래스
 * @Modification Information
 * @author		김길태
 * @since		2017. 8. 25.
 * @version     1.0
 * <pre>
 * << 개정이력(Modification Information) >>
 * 수정일		     	수정자	수정내용
 * ------------		-------	--------------------------
 * 2017. 08. 30.	김길태	최초작성
 * 2017. 09. 01.	김길태	insert 후 List출력, 수정, 삭제 기능 구현
 * 2017. 09. 05.	김길태	프로젝트에 등록된 멤버의 수정, 삭제 기능 구현
 * </pre>
 */
@Controller
@RequestMapping("/schedule/")
public class ScheduleController {
	
	@Loggable
	private Logger logger;
	
	@Autowired
	private IScheduleService service;
	
	/**
	 * 프로젝트에서 세부 스케줄을 등록하는 기능
	 * @param scheVO 스케줄의 정보를 담은 VO
	 * @author 김길태
	 * @since 2017. 08. 31
	 */
	@RequestMapping("insertSchedule")
	public ModelAndView insertSche(ModelAndView andView, ProjectScheduleVO scheVO, String plID){
		andView.setViewName("redirect:/project/projectScheduleView.do");
		service.insertSche(scheVO);
		andView.addObject("pickProjectPlID", plID);
		andView.addObject("pickProjectID", scheVO.getSche_proid());
		return andView;
	}
	
	/**
	 * 프로젝트에 등록된 스케줄들을 json형식으로 보내는 기능
	 * @param proID 선택된 프로젝트의 ID
	 * @author 김길태
	 * @since 2017. 08. 31
	 */
	@RequestMapping("loadingSchedule")
	public ModelAndView loadingScheInfo(ModelAndView andView, String proID){
		// 선택된 project의 ID에 맞는 스케줄을 불러오고 모든 사원의 List를 불러오는 작업
		List<Map<String, String>> scheList = service.getScheList(proID);
		List<Map<String, String>> projectMember = service.getScheMemList(proID);
		List<Map<String, String>> schedule = new ArrayList<Map<String,String>>();
		
		// 받아온 스케줄의 List를 fullcalendar에 등록시키기 위한 작업
		// 받아온 정보가 DB에 저장된 key값으로 반환되기 때문에 
		// fullcalendar에 맞게 key값을 수정하는 작업
		for (Map<String, String> map : scheList) {
			HashMap scheduleBox = new HashMap();
			scheduleBox.put("id", map.get("SCHE_SEQ"));
			scheduleBox.put("title", map.get("SCHE_NAME"));
			scheduleBox.put("start", map.get("SCHE_STARTDATE"));
			scheduleBox.put("end", map.get("SCHE_ENDDATE"));
			scheduleBox.put("cont", map.get("SCHE_CONT"));
			scheduleBox.put("emp", map.get("SCHE_EMP"));
			// 스케줄에 등록된 사원번호와 일치하는 사원을 찾아서 그 사원의 이름을 불러와
			// List에 add하는 작업
			for (Map<String, String> mem : projectMember) {
				if(mem.get("MEM_EMP").equals(map.get("SCHE_EMP"))){
					scheduleBox.put("name", mem.get("EMP_NAME"));
				}
			}
			schedule.add(scheduleBox);
		}
		
		andView.addObject("schedule", schedule);
		andView.setViewName("jsonConvertView");
		return andView;
	}
	
	/**
	 * 스케줄의 세부 정보를 열람하는 기능
	 * @param sche_seq 스케줄의 ID를 담당하는 시퀀스
	 * @param proID 프로젝트의 ID
	 * @author 김길태
	 * @since 2017. 09. 01 
	 */
	@RequestMapping("deleteSchedule")
	public ModelAndView deleteSche(ModelAndView andView, String sche_seq, String proID, String plID){
		andView.setViewName("redirect:/project/projectScheduleView.do");
		service.deleteSche(sche_seq);
		andView.addObject("pickProjectPlID", plID);
		andView.addObject("pickProjectID", proID);
		return andView;
	}
	
	/**
	 * 스케줄의 정보를 수정하는 기능
	 * @param scheVO 스케줄의 정보를 담은 VO
	 * @author 김길태
	 * @since 2017. 09. 01
	 */
	@RequestMapping("updateSchedule")
	public ModelAndView updateSche(ModelAndView andView, ProjectScheduleVO scheVO, String sche_empInfo, String plID){
		andView.setViewName("redirect:/project/projectScheduleView.do");
		service.updateSche(scheVO, sche_empInfo);
		andView.addObject("pickProjectPlID", plID);
		andView.addObject("pickProjectID", scheVO.getSche_proid());
		return andView;
	}
}
