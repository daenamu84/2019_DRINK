/** 
* @ Title: BrandController.java 
* @ Package: com.drink.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
	private Paging paging;
	
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
	public ModelAndView proPosalForm(Locale locale, Model model , RequestMap rtMap, HttpServletRequest req) throws DrinkException {
		
		logger.debug("==rtMap=="+ rtMap.toString());
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00020"); // 	제안상태코드
		List<DataMap> p_stusMap = vendorService.getCommonCode(paramMap);
		
		
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
		
		if(rtMap.getString("gubun").equals("update")) {
			DataMap proPosalView =  proposalService.proposalView(rtMap);
			mav.addObject("data",proPosalView);
		}
		
		mav.addObject("gubun",rtMap.get("gubun"));
		mav.addObject("p_purposeList", p_purposeMap);
		mav.addObject("p_activityList", p_activityMap);
		mav.addObject("p_stusList", p_stusMap);
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
		
		if(rtMap.getString("gubun").equals("update")) {
			List<DataMap> rtnProPosalDMap1 = proposalService.ProPosalProdD_DViewI(rtMap);
			mav.addObject("ProPosalDList1", rtnProPosalDMap1);
			List<DataMap> rtnProPosalDMap2 = proposalService.ProPosalProdD_DViewA(rtMap);
			mav.addObject("ProPosalDList2", rtnProPosalDMap2);
		}
		
		mav.addObject("gubun",rtMap.get("gubun"));
		mav.addObject("prps_id", rtMap.getString("prps_id"));
		mav.addObject("brandList", rtnMap);
		mav.addObject("mBrandCd", mBrandCd);
		mav.setViewName("proposal/proposalform2");
		return mav;
	}

	@RequestMapping(value = "/proPosalForm02-1")
	public ModelAndView proPosalForm02_1(Locale locale, Model model , RequestMap rtMap,  HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		logger.debug("==rtMap=="+ rtMap.toString());
		
		ModelAndView mav = new ModelAndView();
		
		List<DataMap> rtnMap = brandService.BrandList(rtMap);
		List<DataMap> mBrandCd = brandService.BrandMCdList(rtMap);
		
		List<DataMap> rtnProPosalDMap1 = proposalService.ProPosalProdD_DViewI(rtMap);
		
		if(rtMap.getString("gubun").equals("update")) {
			List<DataMap> rtnProPosalDMap2 = proposalService.ProPosalProdD_DViewA(rtMap);
			mav.addObject("ProPosalDList2", rtnProPosalDMap2);
		}
		
		mav.addObject("ProPosalDList1", rtnProPosalDMap1);
		mav.addObject("gubun",rtMap.get("gubun"));
		mav.addObject("prps_id", rtMap.getString("prps_id"));
		mav.addObject("brandList", rtnMap);
		mav.addObject("mBrandCd", mBrandCd);
		mav.setViewName("proposal/proposalform2-1");
		return mav;
	}
	
	@RequestMapping(value = "/proPosalForm03")
	public ModelAndView proPosalForm03(Locale locale, Model model , RequestMap rtMap,  HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();

		logger.debug("==rtMap=="+ rtMap.toString());
		
		ModelAndView mav = new ModelAndView();
		
		rtMap.put("prps_id", rtMap.getString("prps_id"));
		
		List<DataMap> listStep03 = proposalService.getProPosal03List(rtMap);
		try {
			for(int i=0; i<listStep03.size(); i++){
				DataMap dm = listStep03.get(i);
				List<Object> dateList = new ArrayList<>();
				for(int x=0; x<=dm.getInt("monthCnt");x++){
					cal.setTime(sdf1.parse(dm.getString("PRPS_STR_DT")));
					cal.add(Calendar.MONTH, x);
					DataMap paramDm = new DataMap();
					paramDm.put("prpsId", dm.getString("PRPS_ID"));
					paramDm.put("prodSitemDivsCd", dm.getString("PROD_SITEM_DIVS_CD"));
					paramDm.put("prodNoSitemNm", dm.getString("PROD_NO_SITEM_NM"));
					paramDm.put("deliDate", sdf.format(cal.getTime()));
					DataMap dtList =  proposalService.proposalProdMonD(paramDm);
					if(dtList ==null) {
						dtList = new DataMap();
					}
					dtList.put("deliDate", sdf.format(cal.getTime()));
					dateList.add(dtList);
					
				}
				dm.put("dateList", dateList);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new DrinkException(new String[]{"messageError","조회중 오류가 발생 하였습니다."});
		}
		
		mav.addObject("listStep03", listStep03);
		mav.addObject("prps_id", rtMap.getString("prps_id"));
		mav.addObject("gubun",rtMap.get("gubun"));
		mav.setViewName("proposal/proposalform3");
		return mav;
	}
	
	@RequestMapping(value = "/proPosalForm04")
	public ModelAndView proPosalForm04(Locale locale, Model model , RequestMap rtMap,  HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();

		logger.debug("==rtMap=="+ rtMap.toString());
		
		ModelAndView mav = new ModelAndView();
		
		rtMap.put("prps_id", rtMap.getString("prps_id"));
		
		List<DataMap> listStep03 = proposalService.getProPosal03List(rtMap);
		try {
			for(int i=0; i<listStep03.size(); i++){
				DataMap dm = listStep03.get(i);
				List<Object> dateList = new ArrayList<>();
				for(int x=0; x<=dm.getInt("monthCnt");x++){
					cal.setTime(sdf1.parse(dm.getString("PRPS_STR_DT")));
					cal.add(Calendar.MONTH, x);
					DataMap paramDm = new DataMap();
					paramDm.put("prpsId", dm.getString("PRPS_ID"));
					paramDm.put("prodSitemDivsCd", dm.getString("PROD_SITEM_DIVS_CD"));
					paramDm.put("prodNoSitemNm", dm.getString("PROD_NO_SITEM_NM"));
					paramDm.put("deliDate", sdf.format(cal.getTime()));
					DataMap dtList =  proposalService.proposalProdMonD(paramDm);
					if(dtList ==null) {
						dtList = new DataMap();
					}
					dtList.put("deliDate", sdf.format(cal.getTime()));
					dateList.add(dtList);
					
				}
				dm.put("dateList", dateList);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new DrinkException(new String[]{"messageError","조회중 오류가 발생 하였습니다."});
		}
		
		mav.addObject("listStep03", listStep03);
		mav.addObject("prps_id", rtMap.getString("prps_id"));
		mav.addObject("gubun",rtMap.get("gubun"));
		mav.setViewName("proposal/proposalform4");
		return mav;
	}
	
	@RequestMapping(value = "/proPosalList")
	public ModelAndView proPosalList(Locale locale, Model model , RequestMap rtMap,  HttpServletRequest req) throws DrinkException {
		
		String page = (String) rtMap.get("page");
		String pageLine = (String) rtMap.get("pageLine");
		
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

		map.clear();
		map.put("cmm_cd_grp_id", "00005"); // 마켓코드
		List<DataMap> marketMap = vendorService.getCommonCode(map);
		
		List<DataMap> teamList = vendorService.getTeamList(paramMap);
		mav.addObject("teamList", teamList);
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		
		paging.setCurrentPageNo((page != null) ? Integer.valueOf(page) : CommonConfig.Paging.CURRENTPAGENO.getValue()); // 호출 page
		paging.setRecordsPerPage((pageLine != null) ? Integer.valueOf(pageLine) : CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 레코드 수
		paramMap.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
		paramMap.put("perPageNum", paging.getRecordsPerPage());
		
		List<DataMap> rtnProPosalMap = proposalService.getProPosalList(paramMap);
		int totalCnt = paramMap.getInt("TotalCnt");
		
		paging.makePaging();
		HashMap<String, Object> pagingMap = new HashMap<>();
		mav.addObject("marketMap", marketMap);
		pagingMap.put("page", page);
		pagingMap.put("pageLine", paging.getRecordsPerPage());
		pagingMap.put("totalCnt", totalCnt);
		mav.addObject("paging", pagingMap);
		mav.addObject("dropdown01","active");
		
		List<DataMap> rtnMngMap = vendorService.getMngTeamList(paramMap);
		
		mav.addObject("deptList", rtnMngMap);
		
		mav.addObject("ProPosalList", rtnProPosalMap);
		mav.setViewName("proposal/proposalListView");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/proPosalListSearch")
	public ModelAndView proPosalListSearch(Locale locale, Model model , RequestMap rtMap, HttpServletRequest req, RequestMap param) throws DrinkException {
		
		String page = (String) rtMap.get("page");
		String pageLine = (String) rtMap.get("pageLine");
		
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
		
		paging.setCurrentPageNo((page != null) ? Integer.valueOf(page) : CommonConfig.Paging.CURRENTPAGENO.getValue()); // 호출 page
		paging.setRecordsPerPage((pageLine != null) ? Integer.valueOf(pageLine) : CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 레코드 수
		param.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
		param.put("perPageNum", paging.getRecordsPerPage());
		List<DataMap> rtnProPosalMap = proposalService.getProPosalList(param);
		
		int totalCnt = param.getInt("TotalCnt");
		
		paging.makePaging();
		HashMap<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("page", page);
		pagingMap.put("pageLine", paging.getRecordsPerPage());
		pagingMap.put("totalCnt", totalCnt);
		mav.addObject("paging", pagingMap);
		mav.addObject("dropdown01","active");
		
		mav.addObject("ProPosalList", rtnProPosalMap);
		mav.setViewName("nobody/proposal/proposalListSearch");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/proPosalView")
	public ModelAndView proPosalView(Locale locale, Model model , RequestMap rtMap, HttpServletRequest req) throws DrinkException {
		
		logger.debug("rtMap :: " + rtMap.toString());
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		// STEP 1
		DataMap proPosalView =  proposalService.proposalView(rtMap);
		
		//STEMP2 인센티브
		List<DataMap> rtnProPosalIMap = proposalService.ProPosalProdD_DViewI(rtMap);
		DataMap rtnProPosalISumMap =  proposalService.ProPosalProdD_DViewI_Sum(rtMap);
		
		//STEP2 A&P
		List<DataMap> rtnProPosalAMap = proposalService.ProPosalProdD_DViewA(rtMap);
		DataMap rtnProPosalASumMap =  proposalService.ProPosalProdD_DViewA_Sum(rtMap);
		
		DataMap rtnProPosalTTL_AMOUNTMap =  proposalService.ProPosalProdD_TTL_AMOUNT(rtMap);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		
		rtMap.put("prps_id", rtMap.getString("prps_id"));
		int j =  1;
		List<DataMap> listStep03 = proposalService.getProPosal03List(rtMap);
		try {
			
			for(int i=0; i<listStep03.size(); i++){
				DataMap dm = listStep03.get(i);
				List<Object> dateList = new ArrayList<>();
				
				for(int x=0; x<=dm.getInt("monthCnt");x++){
					cal.setTime(sdf1.parse(dm.getString("PRPS_STR_DT")));
					cal.add(Calendar.MONTH, x);
					DataMap paramDm = new DataMap();
					paramDm.put("prpsId", dm.getString("PRPS_ID"));
					paramDm.put("prodSitemDivsCd", dm.getString("PROD_SITEM_DIVS_CD"));
					paramDm.put("prodNoSitemNm", dm.getString("PROD_NO_SITEM_NM"));
					paramDm.put("deliDate", sdf.format(cal.getTime()));
					DataMap dtList =  proposalService.proposalProdMonD(paramDm);
					if(dtList==null) {
						dtList = new DataMap();
						j = 0;
					}
					dtList.put("deliDate", sdf.format(cal.getTime()));
					dateList.add(dtList);
					
				}
				
				dm.put("dateList", dateList);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new DrinkException(new String[]{"messageError","조회중 오류가 발생 하였습니다."});
		}
		mav.addObject("d_cnt", j);
		mav.addObject("data",proPosalView);
		mav.addObject("ProPosalIList", rtnProPosalIMap);
		mav.addObject("ProPosalISum", rtnProPosalISumMap);
		mav.addObject("ProPosalAList", rtnProPosalAMap);
		mav.addObject("ProPosalASum", rtnProPosalASumMap);
		mav.addObject("ProPosalTTLSum", rtnProPosalTTL_AMOUNTMap);
		mav.addObject("listStep03", listStep03);
		mav.setViewName("proposal/proposalDetailView");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/proposalWork", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> proposalWork(Locale locale,   ModelMap model,  @RequestBody Map<String, Object> vts, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
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
	
	@RequestMapping(value = "/proposalWork2", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> proposalWork2(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{		
		
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
		
		logger.debug("map :: " + rtMap.toString());
		
		proposalService.proposalWork2(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "insert");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
		//return rtnMap;
	}
	
	@RequestMapping(value = "/proposalWork2-1", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> proposalWork2_1(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{		
		
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
		
		logger.debug("map :: " + rtMap.toString());
		
		proposalService.proposalWork2_1(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "insert");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
		//return rtnMap;
	}
	
	@RequestMapping(value = "/proposalUpdate", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> proposalUpdate(Locale locale,   ModelMap model,  @RequestBody Map<String, Object> vts, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
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
		
		
		proposalService.proposalUpdate(vts);
		
		
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "update");
		rtnMap.put("prps_id", rtMap.getString("prps_id"));
		rtnMap.put("message", "수정 하였습니다.");
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/proposalUpdate2", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> proposalUpdate2(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{		
		
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
		
		logger.debug("map :: " + rtMap.toString());
		
		//proposalService.proposalDelete2(vts);
		
		proposalService.proposalWork2(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "update");
		rtnMap.put("message", "수정 하였습니다.");
		
		return rtnMap;
		//return rtnMap;
	}
	
	@RequestMapping(value = "/proposalUpdate2-1", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> proposalUpdate2_1(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{		
		
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
		
		logger.debug("map :: " + rtMap.toString());
		
		proposalService.proposalDelete2_1(vts);
		
		proposalService.proposalWork2_1(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "update");
		rtnMap.put("message", "수정 하였습니다.");
		
		return rtnMap;
		//return rtnMap;
	}
	
	
	@RequestMapping(value = "/proposalWork3", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> proposalWork3(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{		
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		logger.debug(" vts ::: "+vts.toString());
		logger.debug(" vtsb ::: "+vts.toString());
		
		
		vts.put("regId", loginSession.getLgin_id());
		
		logger.debug("map :: " + rtMap.toString());
		
		proposalService.proposalWork3(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "insert");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
		//return rtnMap;
	}
	
	@RequestMapping(value = "/proposalUpdate3", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> proposalUpdate3(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{		
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		logger.debug(" vts ::: "+vts.toString());
		logger.debug(" vtsb ::: "+vts.toString());
		
		
		vts.put("regId", loginSession.getLgin_id());
		
		logger.debug("map :: " + rtMap.toString());
		
		proposalService.proposalWork3(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "update");
		rtnMap.put("message", "수정 하였습니다.");
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/proposalWork4", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> proposalWork4(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{		
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		logger.debug(" vts ::: "+vts.toString());
		logger.debug(" vtsb ::: "+vts.toString());
		
		
		vts.put("regId", loginSession.getLgin_id());
		
		logger.debug("map :: " + rtMap.toString());
		
		proposalService.proposalWork4(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "insert");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
		//return rtnMap;
	}
}
