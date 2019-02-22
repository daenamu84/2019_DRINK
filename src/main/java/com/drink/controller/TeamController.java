/** 
* @ Title: BrandController.java 
* @ Package: com.drink.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.util.Locale;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.DataMap;

/** 
* @ ClassName: BrandController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
*  
*/
@Controller
public class TeamController {
	private static final Logger logger = LogManager.getLogger(TeamController.class);
	
	@RequestMapping(value = "/teamList")
	public String main(Locale locale, Model model) throws DrinkException {
		
		RequestMap paramMap = new RequestMap();
		logger.debug("Team contriller " );
		DataMap rtnMap = new DataMap();
		
		System.out.println("rtnMap :: " + rtnMap);
		logger.debug("rtnMap :: " + rtnMap);
		
		return "team/teamlist";
	}
}
