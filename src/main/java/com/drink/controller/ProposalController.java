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

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.DataMap;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.service.brand.BrandService;
import com.drink.service.call.CallService;
import com.drink.service.proposal.ProposalService;
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
	private ProposalService proposalService;
	
	@Autowired
	private VendorService vendorService;
	
	@Autowired 
	private BrandService brandService;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	
	
	@RequestMapping(value = "/proPosalForm")
	public ModelAndView proPosalForm(Locale locale, Model model , HttpServletRequest req) throws DrinkException {
		
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
		paramMap.put("deptno", loginSession.getDept_no());
		
		List<DataMap> vendorList = vendorService.getVendorList(paramMap);
		mav.addObject("vendorList", vendorList);
		
		mav.addObject("p_purposeList", p_purposeMap);
		mav.addObject("p_activityList", p_activityMap);
		mav.addObject("deptno", loginSession.getDept_no());
		mav.addObject("emp_no", loginSession.getEmp_no());
		mav.setViewName("proposal/proposalform");
		return mav;
	}
	
	@RequestMapping(value = "/proPosalForm02")
	public ModelAndView proPosalForm02(Locale locale, Model model , RequestMap rtMap,  HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		logger.debug("==rtMap=="+ rtMap.toString());
		
		ModelAndView mav = new ModelAndView();
		
		List<DataMap> rtnMap = brandService.BrandList(rtMap);
		List<DataMap> mBrandCd = brandService.BrandMCdList(rtMap);
		
		mav.addObject("brandList", rtnMap);
		mav.addObject("mBrandCd", mBrandCd);
		mav.setViewName("proposal/proposalform2");
		return mav;
	}
	
	@RequestMapping(value = "/proPosalForm03")
	public ModelAndView proPosalForm03(Locale locale, Model model , RequestMap rtMap,  HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		logger.debug("==rtMap=="+ rtMap.toString());
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("proposal/proposalform3");
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
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		
		List<DataMap> rtnProPosalMap = proposalService.getProPosalList(paramMap);
		
		List<DataMap> rtnMngMap = vendorService.getMngTeamList(paramMap);
		
		mav.addObject("deptList", rtnMngMap);
		
		mav.addObject("ProPosalList", rtnProPosalMap);
		mav.setViewName("proposal/proposalListView");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/proPosalListSearch")
	public ModelAndView proPosalListSearch(Locale locale, Model model , HttpServletRequest req, RequestMap param) throws DrinkException {
		
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		param.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		param.put("emp_no", loginSession.getEmp_no());
		param.put("deptno", loginSession.getDept_no());
		
		logger.debug("param==" + param.toString());	
		
		List<DataMap> rtnProPosalMap = proposalService.getProPosalList(param);
		
		mav.addObject("ProPosalList", rtnProPosalMap);
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
	
	@RequestMapping(value = "/proposalWork", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> memberWork(Locale locale,   ModelMap model,  @RequestBody Map<String, Object> vts, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
		vts.put("regId", loginSession.getLgin_id());
		vts.put("dept_no", loginSession.getDept_no());
		vts.put("emp_no", loginSession.getEmp_no());
		vts.put("prps_stus_cd", "0001");  // 00020	제안상태코드  : 0001 작성중
		
		DataMap tmap =  proposalService.proposalWork(vts);
		
		logger.debug("tmap="+ tmap);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "insert");
		rtnMap.put("prps_id", tmap.getString("PRPS_ID"));
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}
	
}
