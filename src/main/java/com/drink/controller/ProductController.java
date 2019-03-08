/** 
* @ Title: ProductController.java 
* @ Package: com.drink.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 25. 오전 9:27:45 
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
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.service.brand.BrandService;
import com.drink.service.product.ProductService;
import com.drink.service.vendor.VendorService;

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

	@Autowired 
	private ProductService productService;
	
	@Autowired
	private VendorService vendorService;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	@RequestMapping(value = "/productManager")
	public ModelAndView productManager(Locale locale, Model model) throws DrinkException {
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		List<DataMap> rtnMap = brandService.BrandList(paramMap);
		
		RequestMap map = new RequestMap();
		map.put("cmm_cd_grp_id", "00017"); // 용량
		List<DataMap> cd00017List = vendorService.getCommonCode(map);
		mav.addObject("cd00017List", cd00017List);
		
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
		logger.debug("rtMap :: " + rtMap);
		List<DataMap> rtnMap = productService.productList(rtMap);

		mav.addObject("productList", rtnMap);
		
		mav.setViewName("nobody/product/managerSearch");
		return mav;
		}catch (Exception e) {
			logger.debug("err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","제품 검색중 에러가 발생 하였습니다."});
		}
	}
	
	@RequestMapping(value = "/productInsert", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> productInsert(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		RequestMap dt = new RequestMap();
		dt.put("brandId", vts.get("brandId"));
		dt.put("subBrandId", vts.get("subBrandId"));
		dt.put("prodMlCd", vts.get("prodMlCd"));
		dt.put("useYn", vts.get("useYn"));
		dt.put("regId", loginSession.getLgin_id());
		
		productService.productInsert(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		return rtnMap;
	}
	
	
	@RequestMapping(value = "/productDetailView")
	public ModelAndView productDetailView(Locale locale, Model model, RequestMap rtMap) throws DrinkException {
		
		try{
		ModelAndView mav = new ModelAndView();
		DataMap detail = productService.productDetail(rtMap);

		mav.addObject("productList", detail);
		
		RequestMap map = new RequestMap();
		map.put("cmm_cd_grp_id", "00017"); // 용량
		List<DataMap> cd00017List = vendorService.getCommonCode(map);
		mav.addObject("cd00017List", cd00017List);
		
		
		mav.setViewName("nobody/product/managerUpdate");
		return mav;
		}catch (Exception e) {
			logger.debug("err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","제품상세 검색중 에러가 발생 하였습니다."});
		}
	}
	
	@RequestMapping(value = "/productUpdate", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> productUpdate(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		RequestMap dt = new RequestMap();
		dt.put("prodNo", vts.get("prodNo"));
		dt.put("prodMlCd", vts.get("prodMlCd"));
		dt.put("useYn", vts.get("useYn"));
		dt.put("regId", loginSession.getLgin_id());
		
		productService.productUpdate(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "수정 하였습니다.");
		return rtnMap;
	}
	
}
