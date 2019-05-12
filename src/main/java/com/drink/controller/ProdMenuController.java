/** 
* @ Title: ProdMenuController.java 
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
import org.springframework.context.MessageSource;
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
import com.drink.commonHandler.util.CommonConfig;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.DataMap;
import com.drink.commonHandler.util.Paging;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.service.product.ProductService;
import com.drink.service.vendor.VendorService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;


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
	
	@Autowired
	private Paging paging;
	
	@RequestMapping(value = "/ProdMenuAdd")
	public ModelAndView main(Locale locale, Model model, HttpServletRequest req,  RequestMap rtMap) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		List<DataMap> vendorList = vendorService.getVendorList(paramMap);
		mav.addObject("vendorList", vendorList);
		
		mav.setViewName("prodmenu/menuAdd");
		
		
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
		
		
		mav.addObject("vendorId", param.getString("vendorId"));
		mav.addObject("brandId", param.getString("brandId"));
		mav.addObject("subBrandId", param.getString("subBrandId"));
		mav.addObject("prodVendorList", rtnMap);
		
		mav.setViewName("nobody/prodmenu/prodSearch");
		return mav;
		
		} catch (Exception e) {
			logger.debug("brandSubList err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","거래처메뉴 조회중 에러가 발생 하였습니다."});
		}
	}
	
	@RequestMapping(value = "/ProdMenuList")
	public ModelAndView prodMenuList(Locale locale, Model model, HttpServletRequest req,  RequestMap rtMap) throws DrinkException {
		
		String page = (String) rtMap.get("page");
		String pageLine = (String) rtMap.get("pageLine");
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		

		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		

		paging.setCurrentPageNo((page != null) ? Integer.valueOf(page) : CommonConfig.Paging.CURRENTPAGENO.getValue()); // 호출 page
		paging.setRecordsPerPage((pageLine != null) ? Integer.valueOf(pageLine) : CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 레코드 수
		paramMap.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
		paramMap.put("perPageNum", paging.getRecordsPerPage());
		
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		List<DataMap> teamList = vendorService.getMngTeamList(paramMap);
		
		mav.addObject("teamList", teamList);
		
		
		paramMap = new RequestMap();
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		paramMap.put("vendor_nm", rtMap.getString("vendorNm"));
		paramMap.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
		paramMap.put("perPageNum", paging.getRecordsPerPage());
		List<DataMap> vendorList = vendorService.getVendorList(paramMap);
		mav.addObject("vendorList", vendorList);
		
		int totalCnt = paramMap.getInt("TotalCnt");

		paging.makePaging();
		HashMap<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("page", page);
		pagingMap.put("pageLine", paging.getRecordsPerPage());
		pagingMap.put("totalCnt", totalCnt);
		mav.addObject("paging", pagingMap);
		mav.addObject("staDt", rtMap.getString("staDt"));
		mav.addObject("endDt", rtMap.getString("endDt"));
		mav.addObject("scY", rtMap.getString("scY"));
		mav.addObject("dept_no", rtMap.getString("dept_no"));
		mav.addObject("pEmpno", rtMap.getString("pEmpno"));
		
		mav.setViewName("prodmenu/menuList");
		return mav;
	}
	
	@RequestMapping(value = "/prodSearchList")
	public ModelAndView prodSearchList(Locale locale, Model model, RequestMap param, HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"nobody/common/error","로그인이 필요한 메뉴 입니다."});
		}	
		try {
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		String page = (String) param.get("page");
		String pageLine = (String) param.get("pageLine");
		paging.setCurrentPageNo((page != null) ? Integer.valueOf(page) : CommonConfig.Paging.CURRENTPAGENO.getValue()); // 호출 page
		paging.setRecordsPerPage((pageLine != null) ? Integer.valueOf(pageLine) : CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 레코드 수
		 
		param.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
		param.put("perPageNum", paging.getRecordsPerPage());
		param.put("emp_grd_cd", loginSession.getEmp_grd_cd());  // 2019.05.12 add
		
		List<DataMap> rtnMap = productService.prdSearchView(param);
		int totalCnt = param.getInt("TotalCnt");
		
		paging.makePaging();
		HashMap<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("page", page);
		pagingMap.put("pageLine", paging.getRecordsPerPage());
		pagingMap.put("totalCnt", totalCnt);
		mav.addObject("paging", pagingMap);

		mav.addObject("_pgVendorId", param.getString("vendorId"));
		mav.addObject("_pgStaDt", param.getString("staDt"));
		mav.addObject("_pgEndDt", param.getString("endDt"));
		mav.addObject("_pgDeptNo", param.getString("deptNo"));
		mav.addObject("_pgEmpNo", param.getString("empNo"));
		
		mav.addObject("prodVendorList", rtnMap);
		
		mav.setViewName("nobody/prodmenu/prodSearchList");
		return mav;
		
		} catch (Exception e) {
			logger.debug("brandSubList err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","거래처메뉴 조회중 에러가 발생 하였습니다."});
		}
	}
	
	@RequestMapping(value = "/prodMenuAdd", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> prodMenuAdd(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{

		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		logger.debug(" vts ::: "+vts.toString());
		logger.debug(" a ::: "+rtMap.get("a"));
		logger.debug(" b ::: "+rtMap.get("b"));
		logger.debug(" vtsb ::: "+vts.toString());
		
		vts.put("regId", loginSession.getLgin_id());
		
		productService.prdMenuAdd(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}
	
	
	@RequestMapping(value = "/prodUpdateView")
	public ModelAndView prodUpdateView(Locale locale, Model model, RequestMap param, HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"nobody/common/error","로그인이 필요한 메뉴 입니다."});
		}	
		try {
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		DataMap rtnMap = productService.prdMenuDetailView(param);
		
		
		mav.addObject("prodMenuView", rtnMap);
		
		mav.setViewName("nobody/prodmenu/prodUpdateView");
		return mav;
		
		} catch (Exception e) {
			logger.debug("brandSubList err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","거래처메뉴 조회중 에러가 발생 하였습니다."});
		}
	}
	
	
	
	@RequestMapping(value = "/prodMenuDetailUpdate", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> prodMenuDetailUpdate(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{

		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		vts.put("regId", loginSession.getLgin_id());
		
		productService.prdMenuDetailUpdate(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/prodBrandSearch")
	public ModelAndView prodBrandSearch(Locale locale, Model model, RequestMap param, HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"nobody/common/error","로그인이 필요한 메뉴 입니다."});
		}	
		try {
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		List<DataMap> rtnMap = productService.prdBrandSearch(param);
		
		mav.addObject("prodBrandList", rtnMap);
		
		mav.setViewName("nobody/prodmenu/prodBrandSearch");
		return mav;
		
		} catch (Exception e) {
			logger.debug("brandSubList err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","거래처메뉴 조회중 에러가 발생 하였습니다."});
		}
	}
	@RequestMapping(value = "/prodSubBrandSearch")
	public ModelAndView prodSubBrandSearch(Locale locale, Model model, RequestMap param, HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"nobody/common/error","로그인이 필요한 메뉴 입니다."});
		}	
		try {
			ModelAndView mav = new ModelAndView();
			
			RequestMap paramMap = new RequestMap();
			List<DataMap> rtnMap = productService.prdSubBrandSearch(param);
			
			mav.addObject("prodSubBrandList", rtnMap);
			
			mav.setViewName("nobody/prodmenu/prodSubBrandSearch");
			return mav;
			
		} catch (Exception e) {
			logger.debug("brandSubList err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","거래처메뉴 조회중 에러가 발생 하였습니다."});
		}
	}
}
