package cos.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = { 
		"/system/dean/*", 
		"/system/departmentHead/*",
		"/system/insituteOffice/*",
		"/system/teacher/*",
		"/system/admin/*" })
public class LoginFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		HttpSession session = httpServletRequest.getSession();
		Object object = session.getAttribute("user");
		if (object == null) {
			httpServletResponse.sendRedirect("/cos/system/login.html");
		} else {
			chain.doFilter(request, response);
		}
	}

}
