package kr.or.gd.join.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.gd.anonymousBoard.service.IAnonymousBoardService;
import kr.or.gd.archive.service.IArchiveService;
import kr.or.gd.companyBoard.service.ICompanyBoardService;
import kr.or.gd.join.dao.IJoinDao;
import kr.or.gd.noticeBoard.service.INoticeBoardService;
import kr.or.gd.project.service.IProjectService;
import kr.or.gd.vo.EmployeeAttendenceVO;
import kr.or.gd.vo.EmployeeVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IJoinServiceImpl implements IJoinService{

	@Autowired
	private IJoinDao dao;
	
	@Autowired
	private INoticeBoardService noticeService;
	@Autowired
	private ICompanyBoardService companyService;
	@Autowired
	private IProjectService projectService;

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public EmployeeVO loginCheck(Map<String, String> params) throws SQLException {
		EmployeeVO empInfo = null;
		empInfo = dao.loginCheck(params);
		return empInfo;
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public String attCheck(Map<String, String> params)
			throws SQLException {
		String attInfo = null;
		attInfo = dao.attCheck(params);
		return attInfo;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public String insertApp(Map<String, String> params) throws SQLException {
		String insertApp = null;
		insertApp = dao.insertApp(params);
		return insertApp;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int updateDap(Map<String, String> params) throws SQLException {
		int updateDap = 0;
		updateDap = dao.updateDap(params);
		return updateDap;
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getEmpProList(Map<String, String> params) throws SQLException {
		List<Map<String, String>> empProList = null;
		empProList = dao.getEmpProList(params);
		return empProList;
	}

	@Override
	public Map<String, List<Map<String, String>>> getMainInfoEmp(String emp_num) throws Exception {
		Map<String, List<Map<String, String>>> mainInfo  = new HashMap<String, List<Map<String,String>>>();
		Map<String, String> searchInfo = new HashMap<String, String>();
		searchInfo.put("emp_num", emp_num);
		// 프로젝트 List 출력 진행중인것과 진행중이지 않은거 둘다 가지고 돌아온다 Map<String, List<Map<String,String>>>형태로 
		Map<String , List<Map<String, String>>> projectAllList = projectService.getIngCheckList(searchInfo);
		
		searchInfo.put("endCount", "1");
		searchInfo.put("startCount", "5");
		List<Map<String, String>> notiList = noticeService.getNotiboardList(searchInfo);
		List<Map<String, String>> comBoList = companyService.getComboardList(searchInfo);
		
		
		mainInfo.put("projectIngList", projectAllList.get("ingList"));
		mainInfo.put("projectEndList", projectAllList.get("endList"));
		mainInfo.put("notiList", notiList);
		mainInfo.put("comBoList", comBoList);
		
		
		
//		mainInfo = dao.getMainInfoEmp(emp_num);
		return mainInfo;
	}
}
