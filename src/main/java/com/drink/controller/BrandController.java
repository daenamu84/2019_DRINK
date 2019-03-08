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
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.service.brand.BrandService;
import com.drink.service.vendor.VendorService;

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
	
	@Autowired
	private VendorService vendorService;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	@RequestMapping(value = "/brandList")
	public ModelAndView main(Locale locale, Model model) throws DrinkException {
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		List<DataMap> rtnMap = brandService.BrandList(paramMap);
		
		RequestMap map = new RequestMap();
		map.put("cmm_cd_grp_id", "00014"); // 자사/경쟁사
		List<DataMap> sgmtMap = vendorService.getCommonCode(map);
		
		mav.addObject("brandList", rtnMap);
		mav.addObject("cd00014", sgmtMap);

		mav.setViewName("brand/main");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/brandInsert", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> BrandInsert(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{

		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		RequestMap dt = new RequestMap();
		dt.put("brandId", vts.get("brandId"));
		dt.put("brandNm", vts.get("brandNm"));
		dt.put("useYn", vts.get("useYn"));
		dt.put("orcoBrandYn", vts.get("orcoBrandYn"));
		dt.put("sortOrd", vts.get("sortOrd"));
		dt.put("regId", loginSession.getLgin_id());
		
		
		brandService.BrandInsert(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}
	@RequestMapping(value = "/brandView", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> BrandView(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
		RequestMap dt = new RequestMap();
		dt.put("brandId", vts.get("brandId"));
		
		logger.debug(" ★★★★★★★★★★★★★★" );
		DataMap brandView =  brandService.BrandView(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "조회 성공 하였습니다.");
		rtnMap.put("data", brandView);
		
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/brandSubList")
	public ModelAndView Submain(Locale locale, Model model, RequestMap param) throws DrinkException {
		
		try {
			
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		List<DataMap> rtnMap = brandService.BrandSubList(param);
		
		logger.debug("rtnMap :: " + rtnMap);
		
		mav.addObject("masterBrandId", param.getString("masterBrandId"));
		mav.addObject("brandSubList", rtnMap);
		

		RequestMap map = new RequestMap();
		map.put("cmm_cd_grp_id", "00015"); // 주류유형코드
		List<DataMap> liqKdCdList = vendorService.getCommonCode(map);
		mav.addObject("liqKdCdList", liqKdCdList);
		
		map = new RequestMap();
		map.put("cmm_cd_grp_id", "00016"); // STCASE
		List<DataMap> stcaseCdList = vendorService.getCommonCode(map);
		mav.addObject("stcaseCdList", stcaseCdList);
		
		mav.setViewName("nobody/brand/subMain");
		return mav;
		
		} catch (Exception e) {
			logger.debug("brandSubList err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","서브 브랜드 조회중 에러가 발생 하였습니다."});
		}
	}
	
	@RequestMapping(value = "/brandSubInsert", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> BrandSubInsert(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{

		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		RequestMap dt = new RequestMap();
		dt.put("masterBrandId", vts.get("masterBrandId"));
		dt.put("subBrandId", vts.get("subBrandId"));
		dt.put("subBrandNm", vts.get("subBrandNm"));
		dt.put("subUseYn", vts.get("subUseYn"));
		dt.put("liqKdCd", vts.get("liqKdCd"));
		dt.put("stcaseCd", vts.get("stcaseCd"));
		dt.put("subSortOrd", vts.get("subSortOrd"));
		dt.put("regId", loginSession.getLgin_id());
		
		
		brandService.BrandSubInsert(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/brandSubView", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> BrandSubView(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
		RequestMap dt = new RequestMap();
		dt.put("masterBrandId", vts.get("masterBrandId"));
		dt.put("brandId", vts.get("brandId"));
		
		logger.debug(" ★★★★★★★★★★★★★★" );
		DataMap brandView =  brandService.BrandSubView(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "조회 성공 하였습니다.");
		rtnMap.put("data", brandView);
		return rtnMap;
	}
	
	@RequestMapping(value = "/brandSCd")
	public ModelAndView brandSCd(Locale locale, Model model, RequestMap param) throws DrinkException {
		try {
			ModelAndView mav = new ModelAndView();
			
			RequestMap paramMap = new RequestMap();
			List<DataMap> rtnMap = brandService.BrandSCdList(param);
			
			logger.debug("rtnMap :: " + rtnMap);
			
			mav.addObject("brandSCd", rtnMap);
			
			mav.setViewName("nobody/brand/brandSCd");
			return mav;
		
		} catch (Exception e) {
			logger.debug("brandSubList err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","서브 브랜드 조회중 에러가 발생 하였습니다."});
		}
	}
	
}
