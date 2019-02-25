/** 
* @ Title: ProductController.java 
* @ Package: com.drink.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 25. 오전 9:27:45 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.DataMap;
import com.drink.service.brand.BrandService;

/** 
* @ ClassName: ProductController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 25. 오전 9:27:45 
*  
*/
@Controller
public class ProductController {
	private static final Logger logger = LogManager.getLogger(ProductController.class);
	
	@Autowired 
	private BrandService brandService;
	
	@RequestMapping(value = "/productManager")
	public ModelAndView productManager(Locale locale, Model model) throws DrinkException {
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		List<DataMap> rtnMap = brandService.BrandList(paramMap);
		
		mav.addObject("brandList", rtnMap);
		
		List<DataMap> mBrandCd = brandService.BrandMCdList(paramMap);
		mav.addObject("mBrandCd", mBrandCd);
		//List<DataMap> sBrandCd = brandService.BrandSCdList(paramMap);
		//mav.addObject("sBrandCd", sBrandCd);

		mav.setViewName("product/manager");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/productBrandSearch")
	public ModelAndView productBrandSearch(Locale locale, Model model, RequestMap rtMap) throws DrinkException {
		
		try{
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();

		logger.debug("rtMap :: " + rtMap);
		
		mav.setViewName("nobody/product/managerSearch");
		return mav;
		}catch (Exception e) {
			logger.debug("err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","제품 검색중 에러가 발생 하였습니다."});
		}
		
	}

}
