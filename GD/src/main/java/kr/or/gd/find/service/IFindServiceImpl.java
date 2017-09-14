package kr.or.gd.find.service;

import java.util.Map;

import kr.or.gd.find.dao.IFindDao;
import kr.or.gd.vo.EmployeeVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IFindServiceImpl implements IFindService {
	
	@Autowired
	private IFindDao dao;

	// 사원 이름 주민번호앞자리 이메일을 비교해서 등록된 사원인지 체크
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public EmployeeVO empNumFind(Map<String, String> params) throws Exception {
		EmployeeVO empNumFind = null;
		empNumFind = dao.empNumFind(params);
		return empNumFind;
	}

	// 사원번호 주민번호앞자리 이메일을 비교해서 등록된 사원인지 체크
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public EmployeeVO passFind(Map<String, String> params) throws Exception {
		EmployeeVO passFind = null;
		passFind = dao.passFind(params);
		return passFind;
	}
}
