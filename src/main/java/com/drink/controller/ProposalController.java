/** 
* @ Title: BrandController.java 
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
import com.drink.service.call.CallService;
import com.drink.service.vendor.VendorService;


/** 
* @ ClassName: BrandController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
*  
*/


@Controller
public class ProposalController {
	private static final Logger logger = LogManager.getLogger(ProposalController.class);
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private CallService callService;
	
	@Autowired
	private VendorService vendorService;
	
	@Autowired
	private SessionUtils sessionUtils;
	
		
	@RequestMapping(value = "/proPosalForm")
	public ModelAndView callForm(Locale locale, Model model , HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00021"); // 	제안목적코드
		List<DataMap> p_purposeMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00022"); // 제안액티비티계획코드
		List<DataMap> p_activityMap = vendorService.getCommonCode(paramMap);
		
		
		
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		List<DataMap> rtnMngMap = vendorService.getMngTeamList(paramMap);
		
		mav.addObject("deptMngList", rtnMngMap);
		mav.addObject("p_purposeList", p_purposeMap);
		mav.addObject("p_activityList", p_activityMap);
		mav.addObject("deptno", loginSession.getDept_no());
		mav.addObject("emp_no", loginSession.getEmp_no());
		mav.setViewName("proposal/proposalform");
		return mav;
	}
	
	
	@RequestMapping(value = "/proPosalList")
	public ModelAndView proPosalList(Locale locale, Model model , HttpServletRequest req) throws DrinkException {
		
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		
		RequestMap map = new RequestMap();
		map.put("cmm_cd_grp_id", "00021"); // 제안목적
		List<DataMap> cd00021List = vendorService.getCommonCode(map);
		mav.addObject("cd00021List", cd00021List);

		map = new RequestMap();
		map.put("cmm_cd_grp_id", "00022"); // 엑티비티 계획
		List<DataMap> cd00022List = vendorService.getCommonCode(map);
		mav.addObject("cd00022List", cd00022List);

		map = new RequestMap();
		map.put("cmm_cd_grp_id", "00020"); // 제안상태
		List<DataMap> cd00020List = vendorService.getCommonCode(map);
		mav.addObject("cd00020List", cd00020List);

		List<DataMap> teamList = vendorService.getTeamList(paramMap);
		mav.addObject("teamList", teamList);
		mav.setViewName("proposal/proposalListView");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/proPosalListSearch")
	public ModelAndView proPosalListSearch(Locale locale, Model model , HttpServletRequest req) throws DrinkException {
		
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		
		RequestMap map = new RequestMap();
		
		
		mav.setViewName("nobody/proposal/proposalListSearch");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/proPosalView")
	public ModelAndView proPosalView(Locale locale, Model model , HttpServletRequest req) throws DrinkException {
		
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		
		RequestMap map = new RequestMap();
		map.put("cmm_cd_grp_id", "00021"); // 제안목적
		List<DataMap> cd00021List = vendorService.getCommonCode(map);
		mav.addObject("cd00021List", cd00021List);

		map = new RequestMap();
		map.put("cmm_cd_grp_id", "00022"); // 엑티비티 계획
		List<DataMap> cd00022List = vendorService.getCommonCode(map);
		mav.addObject("cd00022List", cd00022List);

		map = new RequestMap();
		map.put("cmm_cd_grp_id", "00020"); // 제안상태
		List<DataMap> cd00020List = vendorService.getCommonCode(map);
		mav.addObject("cd00020List", cd00020List);

		List<DataMap> teamList = vendorService.getTeamList(paramMap);
		mav.addObject("teamList", teamList);
		mav.setViewName("proposal/proposalDetailView");
		
		
		return mav;
	}
}
