package kr.co.pap.common;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import kr.co.pap.account.LoginVO;

public class Admininterceptor implements HandlerInterceptor {

	
	//Controller媛� �슂泥��쓣 泥섎━�븯湲곗쟾�뿉 �샇異쒗븯�뒗 硫붿냼�뱶
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//�겢�씪�씠�뼵�듃�뿉 遺��뿬�븳 �꽭�뀡�쓣 媛��졇�삩�떎
		HttpSession session = request.getSession();
		LoginVO user = (LoginVO) session.getAttribute("user");
		if(session.getAttribute("user") == null||!((user.getUi_grade().equals("관리자"))||(user.getUi_grade().equals("매니저")))) {

				//愿�由ъ옄�굹 留ㅻ땲��媛��븘�땲�씪硫� 寃쎄퀬李쎈쓣�슦怨� 硫붿씤�쑝濡쒖씠�룞
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('권한이 없습니다.');location.href = ('/pap')</script>");
			out.flush();
			out.close();
			response.sendRedirect(request.getContextPath() + "/login");

			return false;
		}
		
		return true; //濡쒓렇�씤�씠 �릺�뼱�엳�쑝硫� 洹몃깷 �넻怨�
	}
	
	//Controller媛� �슂泥��쓣 泥섎━�븳�썑�뿉 �샇異쒗븯�뒗 硫붿냼�뱶
	//�삁�쇅媛� 諛쒖깮�릺吏� �븡�� 寃쎌슦�뿉留� Controller �옉�뾽 �썑�뿉 �샇異쒕릺�뒗 硫붿냼�뱶
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	//Controller媛� �슂泥��쓣 泥섎━�븳�썑�뿉 �샇異쒗븯�뒗 硫붿냼�뱶
	//�삁�쇅 諛쒖깮�뿬遺��뿉 �긽愿��뾾�씠 Controller �옉�뾽 �썑�뿉 �샇異쒕릺�뒗 硫붿냼�뱶
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}

