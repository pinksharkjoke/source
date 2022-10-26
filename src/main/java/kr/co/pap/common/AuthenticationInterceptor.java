package kr.co.pap.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class AuthenticationInterceptor implements HandlerInterceptor {

	
	//Controller가 요청을 처리하기전에 호출하는 메소드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//클라이언트에 부여한 세션을 가져온다
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null) {

				//로그인이 아니라면 로그인 페이지로 이동시킴.
			response.sendRedirect(request.getContextPath() + "/login");

			return false;
		}
		
		return true; //로그인이 되어있으면 그냥 통과
	}
	
	//Controller가 요청을 처리한후에 호출하는 메소드
	//예외가 발생되지 않은 경우에만 Controller 작업 후에 호출되는 메소드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	//Controller가 요청을 처리한후에 호출하는 메소드
	//예외 발생여부에 상관없이 Controller 작업 후에 호출되는 메소드
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}

