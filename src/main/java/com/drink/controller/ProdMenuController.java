/** 
* @ Title: ProdMenuController.java 
* @ Package: com.drink.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.DataMap;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.service.product.ProductService;
import com.drink.service.vendor.VendorService;


/** 
* @ ClassName: ProdMenuController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
*  
*/


@Controller
public class ProdMenuController {
	private static final Logger logger = LogManager.getLogger(ProdMenuController.class);
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private VendorService vendorService;

	@Autowired
	private ProductService productService;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	@RequestMapping(value = "/ProdMenuList")
	public ModelAndView main(Locale locale, Model model, HttpServletRequest req,  RequestMap rtMap) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		List<DataMap> vendorList = vendorService.getVendorList1(rtMap);
		mav.addObject("vendorList", vendorList);
		mav.setViewName("prodmenu/menuList");
		return mav;
	}
	
	@RequestMapping(value = "/prodSearch")
	public ModelAndView prodSearch(Locale locale, Model model, RequestMap param, HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"nobody/common/error","로그인이 필요한 메뉴 입니다."});
		}	
		try {
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		List<DataMap> rtnMap = productService.prdSearch(param);
		
		
		mav.addObject("prodVendorList", rtnMap);
		
		mav.setViewName("nobody/prodmenu/prodSearch");
		return mav;
		
		} catch (Exception e) {
			logger.debug("brandSubList err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","거래처메뉴 조회중 에러가 발생 하였습니다."});
		}
	}
	
}
