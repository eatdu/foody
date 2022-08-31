package kr.co.foody.intercepter;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Signature;
import org.springframework.web.servlet.HandlerInterceptor;

public class UserLoginInterceptor implements HandlerInterceptor {

	/*
	 * preHandle : 컨트롤러 실행 전 postHandle : 컨트롤러 실행 후(view 리턴 전) afterCompletion : 뷰
	 * 실행 후
	 */

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		if (req.getSession().getAttribute("loginInfo") == null && req.getSession().getAttribute("signUp") == null) {
			res.setContentType("text/html;charset=utf-8");
			PrintWriter out = res.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용해주세요.');");
			out.println("location.href='/foody/user/login.do';");
			out.println("</script>");
			out.flush();
			return false;
		} else
			return true;
	}
}
