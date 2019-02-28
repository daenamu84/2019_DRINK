/** 
* @ Title: LoginController.java 
* @ Package: com.wizwid.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 9:51:56 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.dto.model.user.loginDto;
import com.drink.service.login.LoginService;



/** 
* @ ClassName: LoginController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 9:51:56 
*  
*/
@Controller
public class LoginController {

	
	private static final Logger logger = LogManager.getLogger(LoginController.class);

	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private LoginService loginService;
	
	/** 
	* @ Title: logIn 
	* @ Description: 
	* @ Param: @param locale
	* @ Param: @param model
	* @ Param: @param req
	* @ Param: @param res
	* @ Param: @return 
	* @ Return: ModelAndView
	* @ Date: 2017. 10. 16. 오전 9:56:48
	* @ Throws 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	@RequestMapping(value = "/logIn")
	public String logIn(Locale locale,  ModelMap model,  RequestMap param, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		SessionDto xt = sessionUtils.getLoginSession(req);
		if(xt != null){
			return "redirect:/main";
		}
		
		String returnURL="";
		try {
			returnURL = URLEncoder.encode(req.getParameter("returnURL") == null ? "" : req.getParameter("returnURL"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		model.addAttribute("returnURL", returnURL);
		return "user/login";
	}
	
	@Autowired
	private SessionUtils sessionUtils;
	/** 
	* @ Title: logInProcess 
	* @ Description: 
	* @ Param: @param locale
	* @ Param: @param model
	* @ Param: @param param
	* @ Param: @param req
	* @ Param: @param res
	* @ Param: @return
	* @ Param: @throws WizwidException 
	* @ Return: String
	* @ Date: 2017. 10. 16. 오후 2:40:47
	* @ Throws 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	@RequestMapping(value = "/logInProcess")
	public String logInProcess(Locale locale,  ModelMap model,  @ModelAttribute loginDto param, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res, BindingResult bindingResult) throws DrinkException{
		
		logger.debug("rtMap :: " + rtMap.toString());
		
		SessionDto xt = sessionUtils.getLoginSession(req);
		if(xt != null){
			return "redirect:/main";
		}
		sessionUtils.removeLoginSession(req);
		
		RequestMap resultMap = new RequestMap();
		model.addAttribute("returnURL", req.getParameter("returnURL"));
		
		if("".equals(param.getLoginId()) || param.getLoginId() == null ){
			resultMap.put("notNullId", "notNull.loginId");
			model.addAttribute("errorResult", resultMap.getMap());
			return "user/login";
		}
		if("".equals(param.getPasswd()) || param.getPasswd() == null ){
			resultMap.put("notNullPasswd", "notNull.passwd");
			model.addAttribute("errorResult", resultMap.getMap());
			return "user/login";
		}
		
		resultMap.setRequest(req);
		resultMap.put("login_id", rtMap.get("loginId"));
		resultMap.put("login_pwd",rtMap.get("passwd"));
		
		String flag  = loginService.setLogIn(resultMap);   // login 프로세스 
		
		
		if(flag.equals("1")){
			resultMap.put("notEqualId", "notEqual.loginId");
			model.addAttribute("errorResult", resultMap.getMap());
			return "user/login";
		}else if(flag.equals("2")){
			resultMap.put("notEqualPasswd", "notEqual.passwd");
			model.addAttribute("errorResult", resultMap.getMap());
			return "user/login";
		}
		model.clear(); 
		String  returnURL = req.getParameter("returnURL") ;
		
		if(returnURL != null && !"".equals(returnURL.trim())){
			model.addAttribute("returnURL",returnURL);
			return "redirectPage";
		}else{
			return "redirect:/teamList";
		}
	}
	
	/** 
	* @ Title: logOut 
	* @ Description: 
	* @ Param: @param locale
	* @ Param: @param model
	* @ Param: @param req
	* @ Param: @param res
	* @ Param: @return 
	* @ Return: ModelAndView
	* @ Date: 2017. 10. 16. 오전 9:57:21
	* @ Throws 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	@RequestMapping(value = "/logOut")
	public ModelAndView logOut(Locale locale,  ModelMap model, RequestMap param, HttpServletRequest req, HttpServletResponse res){
		SessionDto xt = sessionUtils.getLoginSession(req);
		if(xt != null){
			// 세션 삭제
			sessionUtils.removeLoginSession(req);
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/main");
		return mav;
				
		
	}
}
