package kr.or.gd.personalSchedule.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.personalSchedule.dao.IPersonalScheduleDao;
import kr.or.gd.vo.EmployeeScheduleVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IPersonalScheduleServiceImpl implements IPersonalScheduleService {

	@Autowired
	private IPersonalScheduleDao dao;
	
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getEmpSchedule(String emp_num) throws SQLException {
		// 개인일정 가져오는 메서드 
		List<Map<String, String>> empSchList = dao.getEmpSchedule(emp_num);
		
		return empSchList;
	}

	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	public void insertPerSche(EmployeeScheduleVO empScheInfo) throws SQLException{
		String result = null;
		result = dao.insertPerSche(empScheInfo);
		if(result ==null){
			System.out.println("성공");
		}else{
			System.out.println("실패");
		}
	}


	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	public void updatePerSche(EmployeeScheduleVO empScheInfo)
			throws SQLException {
		int result = 0;
		result = dao.updatePerSche(empScheInfo);
		if(result == 0){
			System.out.println("성공");
		}else{
			System.out.println("실패");
		}
	}


	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	public void deletePerSche(EmployeeScheduleVO empScheInfo)throws SQLException {
		int result = 0;
		result = dao.deletePerSche(empScheInfo);
		if(result == 0){
			System.out.println("성공");
		}else{
			System.out.println("실패");
		}
	}


	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public List<Map<String, String>> getEmpProList(String emp_num) throws SQLException{
		List<Map<String, String>> empProList = dao.getEmpProList(emp_num);
		return empProList;
	}
}
