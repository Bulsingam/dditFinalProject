package kr.or.gd.humanResource.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.humanResource.dao.IHumanResourceDao;
import kr.or.gd.vo.EmployeeAttendenceVO;
import kr.or.gd.vo.EmployeeVO;
import kr.or.gd.vo.PositionVO;
import kr.or.gd.vo.RoleVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IHumanResourceServiceImpl implements IHumanResourceService {
	@Autowired
	private IHumanResourceDao dao;
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public String insertEmp(EmployeeVO empInfo) throws SQLException {
		String empName = null;
		String empNum = null;
		//사원 번호 존재 여부 체크
		empNum = dao.empCheck();
		if(empNum==null){
			empNum = dao.firstEmpNum();
			empInfo.setEmp_num(empNum);
			empName = dao.insertEmp(empInfo);
		}else{
			empNum = dao.secondEmpNum();
			empInfo.setEmp_num(empNum);
			empName = dao.insertEmp(empInfo);
		}
		return empName;
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<PositionVO> getPositionList() throws SQLException {
		List<PositionVO> positionList = null;
		positionList = dao.getPositionList();
		return positionList;
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<RoleVO> getRoleList() throws SQLException {
		List<RoleVO> poleList = null;
		poleList = dao.getRoleList();
		return poleList;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public Map<String, String> deleteEmp(Map<String, String> params)
			throws SQLException {
		Map<String, String> deleteName = null;
		deleteName = dao.deleteEmp(params);
		return deleteName;
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getEmpListAll(Map<String, String> params) throws SQLException {
		List<Map<String, String>> empList = null;
		empList = dao.getEmpListAll(params);
		return empList;
	}
	
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public Map<String,String> getEmpInfoAdmin(String emp_num) throws SQLException {
		Map<String,String> empInfo = null;
		empInfo = dao.getEmpInfoAdmin(emp_num); 
		return empInfo;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public int updateEmp(EmployeeVO empInfo){
		
		int result=-1;
		try {
			result = dao.updateEmp(empInfo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> empAttList(Map<String, String> params)
			throws SQLException {
		List<Map<String, String>> attList = null;
		attList = dao.empAttList(params);
		return attList;
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public String getAttTotalCount(Map<String, String> searchInfo)
			throws SQLException {
		String total = null;
		total = dao.getAttTotalCount(searchInfo);
		return total;
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> getEmpWorkRateList(
			Map<String, String> empNum) throws SQLException {
		List<Map<String, String>> workRateList = null;
		workRateList = dao.getEmpWorkRateList(empNum);
		return workRateList;
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public String getDeleteTotalCount(Map<String, String> searchInfo) throws SQLException {
		String count = null;
		count = dao.getDeleteTotalCount(searchInfo);
		return count;
	}
	
}
