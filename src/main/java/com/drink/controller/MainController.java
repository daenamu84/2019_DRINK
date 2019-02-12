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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.drink.commonHandler.Exception.DrinkException;

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
	
	@RequestMapping(value = "/main")
	public String main(Locale locale, Model model) throws DrinkException {
		
		return "main/main";
	}
}
