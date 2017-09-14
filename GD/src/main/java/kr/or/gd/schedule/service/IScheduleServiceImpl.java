package kr.or.gd.schedule.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.schedule.dao.IScheduleDao;
import kr.or.gd.vo.ProjectScheduleVO;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IScheduleServiceImpl implements IScheduleService {
	@Loggable
	private Logger logger;
	
	@Autowired
	private IScheduleDao dao;
	
	@Override
	public List<Map<String, String>> getScheMemList(String proID) {
		List<Map<String, String>> scheMemList = null;
		try {
			scheMemList = dao.getScheMemList(proID);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return scheMemList;
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public String insertSche(ProjectScheduleVO scheVO) {
		String success = "-1";
		try {
			success = dao.insertSche(scheVO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}

	@Override
	public List<Map<String, String>> getScheList(String proID) {
		List<Map<String, String>> scheList = null;
		try {
			scheList = dao.getScheList(proID);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return scheList;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public int updateSche(ProjectScheduleVO scheVO, String sche_empInfo) {
		int success = -1;
		try {
			success = dao.updateSche(scheVO, sche_empInfo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW, readOnly=true)
	public int deleteSche(String sche_seq) {
		int success = -1;
		try {
			success = dao.deleteSche(sche_seq);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}

}
