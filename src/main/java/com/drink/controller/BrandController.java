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
import com.drink.commonHandler.util.DataMap;
import com.drink.service.brand.BrandService;

/** 
* @ ClassName: BrandController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
*  
*/
@Controller
public class BrandController {
	private static final Logger logger = LogManager.getLogger(BrandController.class);
	
	@Autowired 
	private BrandService brandService;
	
	@RequestMapping(value = "/brandList")
	public ModelAndView main(Locale locale, Model model) throws DrinkException {
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		logger.debug("메인 contriller " );
		
		List<DataMap> rtnMap = brandService.BrandList(paramMap);
		
		logger.debug("rtnMap :: " + rtnMap);
		
		mav.addObject("brandList", rtnMap);

		mav.setViewName("brand/main");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/brandInsert", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> BrandInsert(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{

		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
		RequestMap dt = new RequestMap();
		dt.put("brandId", vts.get("brandId"));
		dt.put("brandNm", vts.get("brandNm"));
		dt.put("useYn", vts.get("useYn"));
		dt.put("orcoBrandYn", vts.get("orcoBrandYn"));
		dt.put("sortOrd", vts.get("sortOrd"));
		
		brandService.BrandInsert(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}
}
