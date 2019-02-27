/** 
* @ Title: configUtils.java 
* @ Package: com.drink.commonHandler.util 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 22. 오전 8:29:55 
* @ Version V0.0 
*/ 
package com.drink.commonHandler.util;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.dto.model.session.SessionDto;

/** 
* @ ClassName: configUtils 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 22. 오전 8:29:55 
*  
*/
@Component("SessionUtils")
public class SessionUtils {
	
	@Autowired
	private ConfigUtils configUtils;
	
	public void setLoginSession(SessionDto sessionData , HttpServletRequest req) 
    {
		req.getSession().setAttribute(configUtils.getValue("login.sessionId"), sessionData);
    }
	
	public SessionDto getLoginSession(HttpServletRequest req) {
		return (SessionDto) req.getSession().getAttribute(configUtils.getValue("login.sessionId"));
	}
	public void removeLoginSession(HttpServletRequest req){
		req.getSession().removeAttribute(configUtils.getValue("login.sessionId"));
	}
	public void invalidateSession(HttpServletRequest req){
		req.getSession().invalidate();
	}
	
	public SessionDto isLogin(HttpServletRequest req) throws DrinkException{
		SessionDto loginSession = getLoginSession(req);
		if(loginSession == null || (loginSession.getLgin_id() == null || "".equals(loginSession.getLgin_id()))){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		return loginSession;
	}
	
}
