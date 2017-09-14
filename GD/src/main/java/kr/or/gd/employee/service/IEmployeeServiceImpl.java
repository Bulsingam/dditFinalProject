package kr.or.gd.employee.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.gd.anonymousBoard.service.IAnonymousBoardService;
import kr.or.gd.archive.service.IArchiveService;
import kr.or.gd.companyBoard.service.ICompanyBoardService;
import kr.or.gd.employee.dao.IEmployeeDao;
import kr.or.gd.noticeBoard.service.INoticeBoardService;
import kr.or.gd.project.service.IProjectService;
import kr.or.gd.vo.ArchiveVO;
import kr.or.gd.vo.EmployeeVO;
import kr.or.gd.vo.PositionVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.supercsv.cellprocessor.ParseInt;

@Service
public class IEmployeeServiceImpl implements IEmployeeService {
	@Autowired
	private IEmployeeDao dao;

	@Autowired
	private IArchiveService archiveService;
	@Autowired
	private INoticeBoardService noticeService;
	@Autowired
	private ICompanyBoardService companyService;
	@Autowired
	private IAnonymousBoardService anonymousService;
	@Autowired
	private IProjectService projectService;
	
	
	
	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public List<Map<String, String>> getEmpList(Map<String, String> params)
			throws SQLException {
		List<Map<String, String>> empList = null;
		empList = dao.getEmpList(params);
		return empList;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public List<Map<String, String>> getEmpListByPos(Map<String, String> params)
			throws SQLException {
		List<Map<String, String>> result = dao.getEmpListByPos(params);
		return result;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public String getEmpImgName(String emp_num) throws SQLException {
		return dao.getEmpImgName(emp_num);
	}
	
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public Map<String, String> getEmpInfo(String emp_num) throws SQLException {
		
		Map<String,String> empInfo = null;
		empInfo = dao.getEmpInfo(emp_num); 
		return empInfo;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int updateEmp(EmployeeVO empInfo) throws SQLException{
		int result = dao.updateEmp(empInfo);
		return result;
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public Map<String, List<Map<String, String>>> getMyPage(Map<String, String> empInfo) throws Exception {
		// controller로 돌아갈때 list를 담아서 가져갈거야 
		// searchInfo는 list를 가져올때 emp_num 을 가지고 갈거라 
		// EMP_NUMBER라고 새로 만든 이유는 EMP_NUM이라고 검색을 하는 곳이 있는데 EMP_NAME으로 검색하는곳이 중복되어서 
		Map<String, String> searchInfo = new HashMap<String, String>();
		searchInfo.put("search_keycode","EMP_NUMER");
		searchInfo.put("search_keyword", empInfo.get("EMP_NUM"));
		searchInfo.put("emp_num",empInfo.get("EMP_NUM"));
		// View에 띄울때는 1 ~ 5 다섯개만 가지고 가서 뿌릴 것
		searchInfo.put("endCount", "1");
		searchInfo.put("startCount", "5");
		
		// list를 가져오는 메서드라 조금 있다 쓸 예정
		Map<String, List<Map<String, String>>> bo_AllList = new HashMap<String, List<Map<String,String>>>();
		List<Map<String, String>> archiveList = archiveService.getArcList(searchInfo);
		List<Map<String, String>> anonymousBoList = anonymousService.getAnyList(searchInfo);
		List<Map<String, String>> companyBoList = companyService.getComboardList(searchInfo);
		List<Map<String, String>> notiList = noticeService.getNotiboardList(searchInfo);
		
		Map<String, List<Map<String, String>>> ingList = projectService.getIngCheckList(searchInfo);
		
		bo_AllList.put("ingList",ingList.get("ingList"));
		bo_AllList.put("endList",ingList.get("endList"));
		bo_AllList.put("archiveList", archiveList);
		bo_AllList.put("anonymousBoList",anonymousBoList);
		bo_AllList.put("notiList",notiList);
		bo_AllList.put("comBoList",companyBoList);
		
		return bo_AllList;
	}

	@Override
	public String getTotalCount(Map<String, String> searchInfo) throws SQLException {
		String result = null;
		result = dao.getTotalCount(searchInfo);
		return result;
	}

	@Override
	public List<Map<String, String>> getEmpAllList(
			Map<String, String> searchInfo) throws SQLException {
		return dao.getEmpAllList(searchInfo);
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String,String>> salaryInfo() throws Exception {
		List<Map<String,String>> salaryInfo = null;
		salaryInfo = dao.salaryInfo();
		return salaryInfo;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int updateSalary(Map<String, String> params) throws Exception {
		int updateSalary = -1;
		updateSalary = dao.updateSalary(params);
		return updateSalary;
		
	}
	
	
}
