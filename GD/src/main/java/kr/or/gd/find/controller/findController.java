package kr.or.gd.find.controller;

import java.net.URL;
import java.util.Map;

import kr.or.gd.custom.annotation.Loggable;
import kr.or.gd.find.service.IFindService;
import kr.or.gd.vo.EmployeeVO;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.ImageHtmlEmail;
import org.apache.commons.mail.SimpleEmail;
import org.apache.commons.mail.resolver.DataSourceUrlResolver;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
/**
 * @ClassName   findController.java
 * @Description  사원번호 / 사원비밀번호 찾기
 * @Modification Information
 * @author       강대성
 * @since        2017. 09. 07.
 * @version    1.0
 * @see
 * << 개정이력(Modification Information) >>
 * 수정일      수정자   수정내용
 * -------   -------   -------------------
 * 2017. 09. 07.   강대성   최초 작성
 */
@Controller
@RequestMapping("/find/")
public class findController {

	@Loggable
	private Logger logger;
	
	@Autowired
	private IFindService service;
	
	/**
	 * 사원번호 찾기 뷰 이동
	 * @author 강대성
	 * @since 2017-09-07
	 */
	@RequestMapping("employeeNumberFind")
	public void employeeNumberFind(){ }
	
	/**
	 * 비밀번호 찾기 뷰 이동
	 * @author 강대성
	 * @since 2017-09-07
	 */	
	@RequestMapping("passwordFind")
	public void passwordFind(){ }

	/**
	 * 사원 이름 주민번호앞자리 이메일을 비교해서 
	 * 등록된 사원인지 체크 
	 * @author 강대성
	 * @since 2017-09-07
	 */
	@RequestMapping("empNumFind")
	public ModelAndView empNumFind(ModelAndView andView,
			String emp_name, String emp_regnum1, String emp_mail,
			Map<String, String> params)throws Exception{
		
		params.put("emp_name", emp_name);
		params.put("emp_regnum1", emp_regnum1);
		params.put("emp_mail", emp_mail);
		
		EmployeeVO empInfo = this.service.empNumFind(params);
		
		andView.addObject("empInfo", empInfo);
		andView.setViewName("jsonConvertView");
		
		return andView;
	}
	
	/**
	 * 사원번호 이름 이메일을 비교해서 
	 * 등록된 사원인지 체크 
	 * @author 강대성
	 * @since 2017-09-07
	 */	
	@RequestMapping("passFind")
	public ModelAndView passFind(ModelAndView andView,
			String emp_num, String emp_name, String emp_mail,
			Map<String, String> params)throws Exception{
		
		params.put("emp_num", emp_num);
		params.put("emp_name", emp_name);
		params.put("emp_mail", emp_mail);
		
		
		EmployeeVO empInfo = this.service.passFind(params);
		
		andView.addObject("empInfo", empInfo);
		andView.setViewName("jsonConvertView");
		
		return andView;
	}

	/**
	 * 사원번호 이메일로 보내기
	 * @author 강대성
	 * @since 2017-09-07
	 */	
	@RequestMapping("empNumSend") 
	public String empNumSend(String emp_mail, String emp_num)throws Exception{
		
		String html ="<html>"
				+ "<img src=\'http://postfiles3.naver.net/MjAxNzA5MDhfMjg2/MDAxNTA0ODU0MTE3NTkz.8VU83Oh8Kln_AItgQmXP2_SrGnQGdchzagkkie1UkaEg.W-UYDvNr0Bp-c7qDC9jElKY1FL99ZRN9v0_T9Uc8ulEg.PNG.zaxsrr/ghgh.png?type=w3\' "
				+ "style='margin-left: auto; margin-right: auto; display: block;'>"
				+ "<h2 style='text-align : center'>GD그룹웨어</h2>"
				+ "<p style='text-align : center'>문의 하신 사원번호는 : '" + emp_num + "'</p>"
				+ "<img src=\'http://postfiles3.naver.net/MjAxNzA5MDhfMTYw/MDAxNTA0ODU0MTQ3MTc1.Q_Jc0bTYSFMVrCyyJQa_N31whvwd29kC1kVT8GE-yaUg.9EWsNnPE7870U6CU99zsLQzCvNhf5CvaVlq1SmxCH28g.PNG.zaxsrr/%ED%95%98%ED%95%98.png?type=w3\'"
				+ "style='margin-left: auto; margin-right: auto; display: block;'>"
				+ "</html>";
		
		HtmlEmail email = new HtmlEmail();
		email.setCharset("euc-kr");
		email.setHostName("smtp.googlemail.com");
		email.setSmtpPort(465);
		email.setAuthenticator(new DefaultAuthenticator("zaxsrr@gmail.com", "eotjd24897"));
		email.setSSLOnConnect(true);

		email.addTo(emp_mail, emp_mail);
		email.setFrom("admin@gd.or.kr", "관리자");
		email.setSubject("[GD]사원번호 찾기");

		email.setHtmlMsg(html);
		email.send();
			
		return "redirect:/join/login.do";
	}
	
	
	/**
	 * 비밀번호 이메일로 보내기
	 * @author 강대성
	 * @since 2017-09-07
	 */
	@RequestMapping("passSend")
	public String passSend(String emp_mail, String ep)throws Exception{
		
		String html ="<html>"
				+ "<img src=\'http://postfiles3.naver.net/MjAxNzA5MDhfMjg2/MDAxNTA0ODU0MTE3NTkz.8VU83Oh8Kln_AItgQmXP2_SrGnQGdchzagkkie1UkaEg.W-UYDvNr0Bp-c7qDC9jElKY1FL99ZRN9v0_T9Uc8ulEg.PNG.zaxsrr/ghgh.png?type=w3\' "
				+ "style='margin-left: auto; margin-right: auto; display: block;'>"
				+ "<h2 style='text-align : center'>GD그룹웨어</h2>"
				+ "<p style='text-align : center'>문의 하신 사원 비밀번호는 : '" + ep + "'</p>"
				+ "<img src=\'http://postfiles3.naver.net/MjAxNzA5MDhfMTYw/MDAxNTA0ODU0MTQ3MTc1.Q_Jc0bTYSFMVrCyyJQa_N31whvwd29kC1kVT8GE-yaUg.9EWsNnPE7870U6CU99zsLQzCvNhf5CvaVlq1SmxCH28g.PNG.zaxsrr/%ED%95%98%ED%95%98.png?type=w3\'"
				+ "style='margin-left: auto; margin-right: auto; display: block;'>"
				+ "</html>";
		
		HtmlEmail email = new HtmlEmail();
		email.setCharset("euc-kr");
		email.setHostName("smtp.googlemail.com");
		email.setSmtpPort(465);
		email.setAuthenticator(new DefaultAuthenticator("zaxsrr@gmail.com", "eotjd24897"));
		email.setSSLOnConnect(true);

		email.addTo(emp_mail, emp_mail);
		email.setFrom("admin@gd.or.kr", "관리자");
		email.setSubject("[GD]사원 비밀번호 찾기");

		email.setHtmlMsg(html);
		email.send();
		
		return "redirect:/join/login.do";
	}
}
























