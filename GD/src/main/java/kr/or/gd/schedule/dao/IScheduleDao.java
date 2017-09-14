package kr.or.gd.schedule.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ProjectScheduleVO;

public interface IScheduleDao {

	public String insertSche(ProjectScheduleVO scheVO) throws SQLException;

	public List<Map<String, String>> getScheMemList(String proID) throws SQLException;

	public List<Map<String, String>> getScheList(String proID) throws SQLException;

	public int updateSche(ProjectScheduleVO scheVO, String sche_empInfo) throws SQLException;

	public int deleteSche(String sche_seq) throws SQLException;

}
