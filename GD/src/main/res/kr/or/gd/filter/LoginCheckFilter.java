package kr.or.gd.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import kr.or.gd.vo.EmployeeVO;
/**
 * @ClassName	LoginCheckFilter.java
 * @Description	로그인 정보 확인 필터 클래스
 * @Modification Information
 * @author		박일훈
 * @since		2017. 9. 5.
 * @version 1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 * 수정일		수정자	수정내용
 * -------		-------	-------------------
 * 2017. 9. 5.	박일훈	최초작성 및 구현
 * </pre>
 */
public class LoginCheckFilter implements Filter {

	@Override
	public void destroy() {
		System.out.println("LoginCheckFilter is destroyed!!");
	}

	@Override
	public void doFilter
		(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		
		boolean isRedirect = false;
		String requestURI = request.getRequestURI();
		
		if( !requestURI.equals("/join/login.do") 
			&& !requestURI.equals("/join/loginCheck.do") && !requestURI.equals("/find/employeeNumberFind.do")
			&& !requestURI.equals("/find/passwordFind.do") && !requestURI.equals("/find/empNumFind.do") && !requestURI.equals("/find/passFind.do")
			&& !requestURI.equals("/find/passSend.do") && !requestURI.equals("/find/empNumSend.do") ){
			//요청 URI가 /join/login.do 혹은 /join/loginCheck.do가 아닐 때
			EmployeeVO loginEmp = (EmployeeVO) request.getSession().getAttribute("LOGIN_EMPINFO");
			if(loginEmp==null){
				//로그인한 정보가 없으면
				isRedirect = true;
			}
		} 
		
		if(isRedirect == true){
			req.getRequestDispatcher("/join/login.do").forward(req, resp);			
		} else {
			chain.doFilter(req, resp);
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

}
