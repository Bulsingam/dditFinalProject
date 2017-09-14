package kr.or.gd.filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class ContentHeaderFilter implements Filter {

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		
		String requestURI = request.getRequestURI();				//URI는 localhost 뒤  싹다 가져옴
		String requestURISprit = requestURI.split("/")[1];
		String requestPath = requestURI.split("/")[2];
//		String requestPath = request.getPathInfo();
		String requestURINecessity = requestPath.substring(0,requestPath.length()-3);
		
		Map<String, String> menuInfo = new HashMap<String, String>();
		ResourceBundle bundle = ResourceBundle.getBundle("kr.or.gd.filter.contentHeader");
		
		Enumeration<String> keys = bundle.getKeys();
		while(keys.hasMoreElements()){
			String URI = keys.nextElement();
			String menuName = bundle.getString(URI);
			
			menuInfo.put(URI, menuName);
		}
		request.setAttribute("requestURINecessity",requestURINecessity);
		request.setAttribute("requestPath",requestPath);
		request.setAttribute("requestURISprit",requestURISprit);
		request.setAttribute("menuName",menuInfo.get(requestURISprit));
		
		chain.doFilter(req, res);
		

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
