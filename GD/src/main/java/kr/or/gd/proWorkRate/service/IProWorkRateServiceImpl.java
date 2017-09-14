package kr.or.gd.proWorkRate.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.gd.proWorkRate.dao.IProWorkRateDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IProWorkRateServiceImpl implements IProWorkRateService{
	@Autowired
	private IProWorkRateDao dao;

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> plProList(Map<String, String> params) throws SQLException {
		List<Map<String, String>> proList = dao.plProList(params);
		return proList;
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public List<Map<String, String>> workRateEmpList(Map<String, String> params)
			throws SQLException {
		List<Map<String, String>> workRateEmpList = null;
		workRateEmpList = dao.workRateEmpList(params);
		return workRateEmpList;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={SQLException.class})
	@Override
	public void insertProWorkRate(List<String> proId, String wrt_rater,
			List<String> empList, List<String> gradList,
			List<String> contentList) throws SQLException {
		
		String wrt_proid = null;
		
		for(int i = 0; i<proId.size(); i++){
			wrt_proid = proId.get(i);
		}
		
		dao.insertProWorkRate(wrt_proid,wrt_rater,empList,gradList,contentList);
	}

	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	@Override
	public boolean getWorkRateInfo(List<String> proId, List<String> empList) throws SQLException {
		boolean result=false;
		Map<String,String> params = new HashMap<String, String>();
		Map<String,String> workInfo = null;
		String wrt_proid = null;
		
		for(int i = 0; i<proId.size(); i++){
			wrt_proid = proId.get(i);
		}
		
		for(String emp : empList){
			params.put("emp_num", emp);
			params.put("wrt_proid", wrt_proid);
			workInfo = dao.getWorkRateInfo(params);
			if(workInfo==null){
				//정보가 없으면
				result=true;
			}else{
				//정보가 있으면
				result=false;
			}
		}
		return result;
	}
	
	

}
