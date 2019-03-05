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
import com.drink.service.code.CodeService;

/** 
* @ ClassName: BrandController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
*  
*/
@Controller
public class CodeController {
	private static final Logger logger = LogManager.getLogger(CodeController.class);
	
	@Autowired 
	private CodeService codeService;
	
	@RequestMapping(value = "/codeList")
	public ModelAndView main(Locale locale, Model model) throws DrinkException {
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		List<DataMap> rtnMap = codeService.CodeList(paramMap);
		
		mav.addObject("codeList", rtnMap);

		mav.setViewName("code/main");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/codeInsert", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> CodeInsert(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{

		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
		RequestMap dt = new RequestMap();
		dt.put("cmm_cd_grp_id", vts.get("cmm_cd_grp_id"));
		dt.put("cmm_cd_grp_nm", vts.get("cmm_cd_grp_nm"));
		dt.put("cmm_cd_grp_cntn", vts.get("cmm_cd_grp_cntn"));
		dt.put("use_yn", vts.get("use_yn"));
		
		codeService.CodeInsert(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/codeView", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> BrandView(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
		RequestMap dt = new RequestMap();
		dt.put("cmm_cd_grp_id", vts.get("cmm_cd_grp_id"));
		
		logger.debug(" ★★★★★★★★★★★★★★" );
		DataMap brandView =  codeService.MasterCodeView(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "조회 성공 하였습니다.");
		rtnMap.put("data", brandView);
		
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/codeSubList")
	public ModelAndView Submain(Locale locale, Model model, RequestMap param) throws DrinkException {
		
		try {
			
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		List<DataMap> rtnMap = codeService.CodeSubList(param);
		
		logger.debug("rtnMap :: " + rtnMap);
		
		mav.addObject("cmm_cd_grp_id", param.getString("cmm_cd_grp_id"));
		logger.debug("11111="+param.getString("cmm_cd_grp_id"));
		mav.addObject("codeSubList", rtnMap);
		
		mav.setViewName("nobody/code/subMain");
		return mav;
		
		} catch (Exception e) {
			logger.debug("codeSubList err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","서브 코드 조회중 에러가 발생 하였습니다."});
		}
	}
	
	
	@RequestMapping(value = "/codeSubInsert", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> BrandSubInsert(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{

		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
		RequestMap dt = new RequestMap();
		dt.put("cmm_cd_grp_id", vts.get("mcmm_cd_grp_id"));
		dt.put("cmm_cd", vts.get("cmm_cd"));
		dt.put("cmm_cd_nm", vts.get("cmm_cd_nm"));
		dt.put("cmm_cd_cntn", vts.get("cmm_cd_cntn"));
		dt.put("sub_use_yn", vts.get("sub_use_yn"));
		
		
		codeService.CodeSubInsert(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/codeSubView", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> BrandSubView(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
		RequestMap dt = new RequestMap();
		dt.put("cmm_cd_grp_id", vts.get("cmm_cd_grp_id"));
		dt.put("cmm_cd", vts.get("cmm_cd"));
		
		logger.debug(" ★★★★★★★★★★★★★★" );
		DataMap brandView =  codeService.CodeSubView(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "조회 성공 하였습니다.");
		rtnMap.put("data", brandView);
		return rtnMap;
	}
	
}
