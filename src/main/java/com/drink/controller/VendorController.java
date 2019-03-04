/** 
* @ Title: BrandController.java 
* @ Package: com.drink.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.util.ArrayList;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.DataMap;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.service.login.LoginService;
import com.drink.service.vendor.VendorService;
import com.drink.commonHandler.Exception.DrinkException;


/** 
* @ ClassName: VendorController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
*  
*/


@Controller
public class VendorController {
	private static final Logger logger = LogManager.getLogger(VendorController.class);
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private VendorService vendorService;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	@RequestMapping(value = "/vendorList")
	public ModelAndView main(Locale locale, Model model, HttpServletRequest req) throws DrinkException {
		
		
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		List<DataMap> rtnMap = vendorService.getTeamList(paramMap);
		
		RequestMap map = new RequestMap();
		map.put("cmm_cd_grp_id", "00001"); // 거래처 상태 코드 
		
		List<DataMap> commonMap = vendorService.getCommonCode(map);
		
		map.clear();
		map.put("cmm_cd_grp_id", "00005"); // 마켓코드
		List<DataMap> marketMap = vendorService.getCommonCode(map);
		
		map.clear();
		map.put("cmm_cd_grp_id", "00006"); // 거래처세크먼크구분코드
		List<DataMap> sgmtMap = vendorService.getCommonCode(map);
		
		map.clear();
		map.put("cmm_cd_grp_id", "00010"); // 거래처 등급 코드
		List<DataMap> vendorgrdcdMap = vendorService.getCommonCode(map);
		
//		
		List<DataMap> rtnVendrMap = vendorService.getVendorList(paramMap);
//		
//		logger.debug("rtnMap :: " + rtnMpa0);
//		logger.debug("rtnMap :: " + rtnMap);
//		
		mav.addObject("deptMMList", rtnMap);
		mav.addObject("vendorList", rtnVendrMap);
		mav.addObject("commonList", commonMap);		
		mav.addObject("marketMap", marketMap);
		mav.addObject("sgmtMap", sgmtMap);
		mav.addObject("vendorgrdcdList", vendorgrdcdMap);
//		mav.addObject("empMList", rtnMap);
		
		mav.setViewName("vendor/vendorlist");
		return mav;
	}
	
	@RequestMapping(value = "/vendorForm")
	public ModelAndView memberForm(Locale locale, Model model) throws DrinkException {
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00005"); // 마켓코드
		List<DataMap> marketMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00006"); // 거래처세크먼크구분코드
		List<DataMap> sgmtMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00008"); // 관계자 구분코드
		List<DataMap> relrdivscdMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00009"); // 거래처 지역 코드
		List<DataMap> vendorareacdMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00010"); // 거래처 등급 코드
		List<DataMap> vendorgrdcdMap = vendorService.getCommonCode(paramMap);
		
		
		List<DataMap> rtnMngMap = vendorService.getMngTeamList(paramMap);
		
		mav.addObject("marketMap", marketMap);
		mav.addObject("sgmtMap", sgmtMap);
		mav.addObject("relrdivscdMap", relrdivscdMap);
		mav.addObject("vendorareacdMap", vendorareacdMap);
		mav.addObject("deptMngList", rtnMngMap);
		mav.addObject("vendorgrdcdList", vendorgrdcdMap);
		
		mav.setViewName("vendor/vendorfrom");
		return mav;
	}
	
	@RequestMapping(value = "/Dept_EmpList")
	public ModelAndView DeptEmpList(Locale locale, Model model, RequestMap rtMap) throws DrinkException {
		
		try{
		ModelAndView mav = new ModelAndView();
		logger.debug("rtMap :: " + rtMap);
		List<DataMap> rtnMap = vendorService.getDeptEmpList(rtMap);

		mav.addObject("EmpList", rtnMap);
		mav.addObject("emp_no", rtMap.get("empno"));
		mav.setViewName("nobody/vendor/vendorTeamList");
		return mav;
		}catch (Exception e) {
			logger.debug("err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","제품 검색중 에러가 발생 하였습니다."});
		}
	}

	@RequestMapping(value = "/vendorInsert")
	public String VendorInsert(Locale locale,  ModelMap model, RedirectAttributes  redirectAttributes, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		
		rtMap.put("login_id", loginSession.getLgin_id());
		
		logger.debug("map :: " + rtMap.toString());
		
		rtMap.put("wholesale_vendor_no", rtMap.getInt("wholesale_vendor_no"));
		vendorService.VendorInsert(rtMap);
		
		redirectAttributes.addFlashAttribute("returnCode", "0000");
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		
		return "redirect:/vendorList";
		//return rtnMap;
	}
	
	@RequestMapping(value = "/vendorView", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView vendorView(Locale locale, ModelMap model, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		logger.debug("map :: " + rtMap.toString());
		logger.debug("map2 :: " + model.toString());
		
		
//		logger.debug("rtMap.vendorno:" + rtMap.get("vendor_no"));
//		if(rtMap.get("vendor_no")==null) {
//			rtMap.put("vendor_no", model.get("vendor_no"));
//			rtMap.put("gubun", model.get("gubun"));
//			rtMap.put("returnCode", model.get("returnCode"));
//		}
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00005"); // 마켓코드
		List<DataMap> marketMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00006"); // 거래처세크먼크구분코드
		List<DataMap> sgmtMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00008"); // 관계자 구분코드
		List<DataMap> relrdivscdMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00009"); // 거래처 지역 코드
		List<DataMap> vendorareacdMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00010"); // 거래처 등급 코드
		List<DataMap> vendorgrdcdMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00001"); // 거래처 상태 코드
		List<DataMap> vendorstatcdMap = vendorService.getCommonCode(paramMap);
		
		
		List<DataMap> rtnMngMap = vendorService.getMngTeamList(paramMap);
		
		
		DataMap vendorView =  vendorService.vendorView(rtMap);
		
		mav.addObject("data",vendorView);
		mav.addObject("marketMap", marketMap);
		mav.addObject("sgmtMap", sgmtMap);
		mav.addObject("relrdivscdMap", relrdivscdMap);
		mav.addObject("vendorareacdMap", vendorareacdMap);
		mav.addObject("deptMngList", rtnMngMap);
		mav.addObject("vendorstatList", vendorstatcdMap);
		mav.addObject("vendorgrdcdList", vendorgrdcdMap);
		mav.addObject("gubun",rtMap.get("gubun"));
		mav.addObject("returnCode",rtMap.get("returnCode"));
		
		mav.setViewName("vendor/vendorfrom");
		return mav;
		
	}
	
	@RequestMapping(value = "/wholesaleVendorList")
	public ModelAndView wholesaleVendorList(Locale locale, Model model, HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		List<DataMap> rtnVendrMap = vendorService.getWholesaleVendorList(paramMap);
		
		mav.addObject("WholesaleVendorList", rtnVendrMap);
		mav.setViewName("nobody/vendor/wholesaleVendorList");
		
		return mav;
	}
	
	@RequestMapping(value = "/vendorUpdate")
	public ModelAndView vendorUpdate(Locale locale,   RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		
		rtMap.put("login_id", loginSession.getLgin_id());
		
		logger.debug("map :: " + rtMap.toString());
		
		rtMap.put("wholesale_vendor_no", rtMap.getInt("wholesale_vendor_no"));
		vendorService.VendorInsert(rtMap);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "수정 하였습니다.");
		
		
		//RedirectView redirectView = new RedirectView("/vendorView"); // redirect url 설정
		RedirectView redirectView = new RedirectView("vendorView?vendor_no="+rtMap.get("vendor_no")+ "&gubun=update"); // redirect url 설정
	//	redirectView.setExposeModelAttributes(true);
		ModelAndView mav = new ModelAndView(redirectView);

//		mav.addObject("vendor_no", rtMap.get("vendor_no"));
		mav.addObject("returnCode", "0000");
//		mav.addObject("gubun", "update");
		
//		mav.setView(redirectView);

		//return new ModelAndView(redirectView);
		return mav;
			
//		return "redirect:/vendorView?vendor_no="+rtMap.get("vendor_no")+ "&returnCode=0000&gubun=update";
		//return rtnMap;
	}
	
	@RequestMapping(value = "/vendorSearchPop")
	public ModelAndView vendorSearchPop(Locale locale, Model model, HttpServletRequest req, RequestMap param) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"nobody/common/error","로그인이 필요한 메뉴 입니다."});
		}
		
		try {
			ModelAndView mav = new ModelAndView();
			
			RequestMap paramMap = new RequestMap();
			List<DataMap> vendorList = vendorService.getVendorList1(param);
			
			
			mav.addObject("vendorList", vendorList);
			mav.setViewName("nobody/prodmenu/popVendorList");

			return mav;
			
			} catch (Exception e) {
				logger.debug("brandSubList err :: " + e);
				throw new DrinkException(new String[]{"nobody/common/error","거래처메뉴 조회중 에러가 발생 하였습니다."});
			}
	}
	
}
