/** 
* @ Title: ApprovalController.java 
* @ Package: com.wizwid.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 9:51:56 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.DataMap;
import com.drink.commonHandler.util.Paging;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.dto.model.user.loginDto;
import com.drink.service.login.LoginService;



/** 
* @ ClassName: ApprovalController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 9:51:56 
*  
*/
@Controller
public class ApprovalController {

	
	private static final Logger logger = LogManager.getLogger(ApprovalController.class);

	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	@Autowired
	private Paging paging;

	@RequestMapping(value = "/ApprovalList")
	public ModelAndView approvalList(Locale locale, Model model, HttpServletRequest req,  RequestMap rtMap) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		mav.setViewName("approval/list");
		
		
		return mav;
	}
}
