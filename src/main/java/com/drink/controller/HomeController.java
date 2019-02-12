/** 
* @ Title: HomeController.java 
* @ Package: com.drink.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 9. 29. 오전 10:48:07 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.drink.commonHandler.Exception.DrinkException;

/** 
* @ ClassName: HomeController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 9. 29. 오전 10:48:07 
*  
*/
@Controller
public class HomeController {
	private static final Logger logger = LogManager.getLogger(HomeController.class);
	
	/** 
	* @ Title: home 
	* @ Description: 
	* @ Param: @param locale
	* @ Param: @param model
	* @ Param: @return
	* @ Param: @throws Exception 
	* @ Return: String
	* @ Date: 2017. 9. 29. 오전 10:49:44
	* @ Throws 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	
	@RequestMapping(value = "/")
	public String home(Locale locale, Model model) throws DrinkException {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		
		return "index";
	}
	
}
