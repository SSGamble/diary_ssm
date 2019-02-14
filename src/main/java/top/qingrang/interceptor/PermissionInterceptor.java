package top.qingrang.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 权限拦截器
 */
public class PermissionInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

		//获取请求的 URL
		String url = httpServletRequest.getRequestURI();

		//除了 login.jsp 是可以公开访问的，其它的 URL 都进行拦截控制
		if(url.indexOf("login") >= 0){
			return true;
		}
		//获取 Session
		HttpSession session = httpServletRequest.getSession();
		String username = (String)session.getAttribute("userSession");
		if(username != null){
			return true;
		}

		// 验证失败返回登录界面
		httpServletRequest.getRequestDispatcher("WEB-INF/jsp/admin/login.jsp").forward(httpServletRequest, httpServletResponse);
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
//		System.out.println("执行PermissionInterceptor ---- postHandle() ------");
	}

	@Override
	public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
//		System.out.println("执行PermissionInterceptor ---- afterCompletion() ------");
	}
}
