/** 
* @ Title: BrandController.java 
* @ Package: com.drink.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.DataMap;
import com.drink.service.call.CallService;
import com.drink.service.login.LoginService;
import com.drink.service.vendor.VendorService;


/** 
* @ ClassName: BrandController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
*  
*/


@Controller
public class CallController {
	private static final Logger logger = LogManager.getLogger(CallController.class);
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private CallService callService;
	
	@Autowired
	private VendorService vendorService;
	
	@RequestMapping(value = "/callList")
	public ModelAndView main(Locale locale, Model model) throws DrinkException {
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		List<DataMap> rtnMap = vendorService.getTeamList(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00012"); // 	콜구분코드
		List<DataMap> scallgbnnmMap = vendorService.getCommonCode(paramMap);
		
		
		logger.debug("rtnMap :: " + rtnMap);
		
		mav.addObject("deptList", rtnMap);
		mav.addObject("scallgbNmList", scallgbnnmMap);
		mav.setViewName("call/calllist");
		return mav;
	}
	
	@RequestMapping(value = "/callForm")
	public ModelAndView callForm(Locale locale, Model model) throws DrinkException {
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00012"); // 	콜구분코드
		List<DataMap> scallgbnnmMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00018"); // 	콜 방문목적코드
		List<DataMap> scallpurposecdMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00013"); // 	콜 선호도 코드
		List<DataMap> scallpfrNmMap = vendorService.getCommonCode(paramMap);
		
		List<DataMap> rtnMap = vendorService.getTeamList(paramMap);
		
		mav.addObject("deptList", rtnMap);
		mav.addObject("scallgbNmList", scallgbnnmMap);
		mav.addObject("scallpurposeCdList", scallpurposecdMap);
		mav.addObject("scallpfrNmList", scallpfrNmMap);
		
		mav.setViewName("call/callfrom");
		return mav;
	}
}
