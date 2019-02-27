/** 
* @ Title: Interceptor.java 
* @ Package: com.drink.commonHandler
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 10. 28. 오전 10:11:25 
* @ Version V0.0 
*/
package com.drink.commonHandler;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.drink.commonHandler.util.CommonUtil;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.meta.MetaTagDto;
import com.drink.dto.model.session.SessionDto;

/** 
* @ ClassName: Intercopter 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 10. 28. 오전 10:11:25 
*  
*/
public class Interceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LogManager.getLogger("REQUEST");
	@Autowired
	private CommonUtil commonUtil;
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		long currTime = System.currentTimeMillis();
		String param = "";
		String currentParam = "";
		String refererStr =  request.getHeader("referer");
		String contentType = request.getHeader("content-Type");
		
		logger.info("request hostName :: {}  =====  serverName:: {}   =====    remoteIP :: {}", request.getLocalName(), request.getServerName(),  request.getRemoteAddr());
		logger.info("request sessionID:: {} ",request.getSession().getId());
		logger.info("request info:: {} ",request.getRequestURL());
		logger.info("request referer:: {} ", refererStr);
		logger.info("request header contenT-Type:: {} ", contentType);
		logger.info("request header brawser:: {} ", request.getHeader("User-Agent"));
		logger.info("request header Aceept:: {} ", request.getHeader("Accept"));
		logger.info("request method:: {} ", request.getMethod());
		logger.info("request param:: {} ", request.getParameterMap());
		
		MetaTagDto metaDto = new MetaTagDto();
		metaDto.setHeadTitle("DRINK MOBILE ");
		
		request.setAttribute("globalTimeStamp", currTime);
		request.setAttribute("metaTag", metaDto);

		//Boolean loginYn  = false;  // 로그인 확인 프로세스를 만드세요.    로그인 true  미로그인 false 로 설정
		Boolean loginYn  = false;
		
		SessionDto sessionDto = sessionUtils.getLoginSession(request);
		logger.debug("sessionDto="+sessionDto);
		if(sessionDto != null)
			loginYn = true;
		else
			loginYn = false;
		
		currentParam = request.getQueryString();
		request.setAttribute("currentURL", "".equals(currentParam) || currentParam == null ? request.getRequestURL() : request.getRequestURL()+"?"+currentParam);  // 현재 페이지
		
		if(!"logIn".equals(request.getRequestURI()) && !"logOut".equals(request.getRequestURI())){
			param = commonUtil.getParameter(request);
			param = "returnURL="+URLEncoder.encode(request.getRequestURI() +("".equals(param) ? "" : "?"+param),"UTF-8");
		}
		
		if(commonUtil.checkLoginUrl(request)){  // 로그인이 필요한 Url 인지 체크 util
			if(!loginYn){  // 미로그인시 
				if( contentType !=null && (contentType.toLowerCase()).indexOf(MediaType.APPLICATION_JSON_VALUE) > -1 ){
					response.sendError(403);
					logger.debug("403 에러");
					return false;
				}else if("POST".equals(request.getMethod())){ //  이전 페이지가  post 방식 일경우 main 으로 보낸다.
					response.sendRedirect(configUtils.getValue("url.domain.http")+"/logIn");
					return false;
				}else{
					response.sendRedirect(configUtils.getValue("url.domain.http")+"/logIn" + ("".equals(param) ? "" : "?"+param));
					return false;
				}
			}
		}
		
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		//컨트롤러 응답 전달
		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		System.out.println("afterConcurrent");
		super.afterConcurrentHandlingStarted(request, response, handler);
	}

}
