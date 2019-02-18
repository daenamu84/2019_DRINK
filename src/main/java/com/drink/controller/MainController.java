/** 
* @ Title: MainController.java 
* @ Package: com.drink.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 12. 오후 5:51:05 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.util.Locale;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.DataMap;
import com.drink.service.main.MainService;

/** 
* @ ClassName: MainController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 12. 오후 5:51:05 
*  
*/
@Controller
public class MainController {
	private static final Logger logger = LogManager.getLogger(MainController.class);
	
	@Autowired
	private MainService mainService;
	
	@RequestMapping(value = "/main")
	public String main(Locale locale, Model model) throws DrinkException {
		
		RequestMap paramMap = new RequestMap();
		logger.debug("메인 contriller " );
		DataMap rtnMap = new DataMap();
		rtnMap = mainService.test(paramMap);
		
		System.out.println("rtnMap :: " + rtnMap);
		logger.debug("rtnMap :: " + rtnMap);
		
		return "main/main";
	}
}
