package kr.or.gd.schedule.service;

import java.util.List;
import java.util.Map;

import kr.or.gd.vo.ProjectScheduleVO;

public interface IScheduleService {
	/**
	 * 선택된 프로젝트에 투입된 사원을 불러오기 위한 메서드
	 * @param proID 선택된 프로젝트의 ID
	 * @author 김길태
	 * @since 2017. 08. 31
	 */
	public List<Map<String, String>> getScheMemList(String proID);
	/**
	 * 선택된 프로젝트의 스케줄을 추가하기 위한 메서드
	 * @param scheVO 스케줄의 정보가 담긴 VO
	 * @author 김길태
	 * @since 2017. 08. 31
	 */
	public String insertSche(ProjectScheduleVO scheVO);
	/**
	 * 선택된 프로젝트의 스케줄을 받아오기 위한 메서드
	 * @param proID 선택된 프로젝트의 ID
	 * @author 김길태
	 * @since 2017. 08. 31
	 */
	public List<Map<String, String>> getScheList(String proID);
	/**
	 * 스케줄을 수정하기위한 메서드
	 * @param scheVO 프로젝트의 기준이 되는 시퀀스 값
	 * @param sche_empInfo 스케줄을 수행한 기존 팀원
	 * @author 김길태
	 * @since 2017. 09. 01
	 */
	public int updateSche(ProjectScheduleVO scheVO, String sche_empInfo);
	/**
	 * 스케줄을 삭제하기위한 메서드
	 * @param sche_seq 프로젝트의 기준이 되는 시퀀스 값
	 * @author 김길태
	 * @since 2017. 09. 01
	 */
	public int deleteSche(String sche_seq);
	
}
