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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.CommonConfig;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.DataMap;
import com.drink.commonHandler.util.Paging;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.service.vendor.VendorService;


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
	private Paging paging;
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private VendorService vendorService;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	@RequestMapping(value = "/vendorList")
	public ModelAndView vendorList(Locale locale, Model model, RequestMap rtMap,  HttpServletRequest req) throws DrinkException {
		
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
		
		List<DataMap> rtnMap = vendorService.getTeamList(paramMap);
		
		RequestMap map = new RequestMap();
		map.put("cmm_cd_grp_id", "00001"); // 거래처 상태 코드 
		
		List<DataMap> commonMap = vendorService.getCommonCode(map);
		
		map.clear();
		map.put("cmm_cd_grp_id", "00005"); // 마켓코드
		List<DataMap> marketMap = vendorService.getCommonCode(map);
		
//		map.clear();
//		map.put("cmm_cd_grp_id", "00006"); // 거래처세크먼크구분코드
//		List<DataMap> sgmtMap = vendorService.getCommonCode(map);
		
		map.clear();
		map.put("cmm_cd_grp_id", "00010"); // 거래처 등급 코드
		List<DataMap> vendorgrdcdMap = vendorService.getCommonCode(map);
		
		logger.debug("==loginSession=" + loginSession.getDept_no() + "/" + loginSession.getEmp_grd_cd()+ "/" + loginSession.getEmp_no());
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		List<DataMap> rtnVendrMap = vendorService.getVendorList(paramMap);
		int totalCnt = paramMap.getInt("TotalCnt");
		
		paging.makePaging();
		HashMap<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("page", page);
		pagingMap.put("pageLine", paging.getRecordsPerPage());
		pagingMap.put("totalCnt", totalCnt);
		mav.addObject("paging", pagingMap);
		mav.addObject("dropdown03","active");		
		mav.addObject("deptMMList", rtnMap);
		mav.addObject("vendorList", rtnVendrMap);
		mav.addObject("commonList", commonMap);		
		mav.addObject("marketMap", marketMap);
//		mav.addObject("sgmtMap", sgmtMap);
		mav.addObject("vendorgrdcdList", vendorgrdcdMap);
//		mav.addObject("empMList", rtnMap);
		
		mav.setViewName("vendor/vendorlist");
		return mav;
	}
	
	@RequestMapping(value = "/vendorForm")
	public ModelAndView vendorForm(Locale locale, Model model, HttpServletRequest req) throws DrinkException {
		
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
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getDept_no() + "/" + loginSession.getEmp_grd_cd()+ "/" + loginSession.getEmp_no());
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
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
	public ModelAndView DeptEmpList(Locale locale, Model model, RequestMap rtMap, HttpServletRequest req) throws DrinkException {
		
		try{
			SessionDto loginSession = sessionUtils.getLoginSession(req);
			ModelAndView mav = new ModelAndView();
			logger.debug("rtMap 1:: " + rtMap + "/" + rtMap.getString("gubun"));
			if (rtMap.getString("gubun").equals("")) {
				rtMap.put("gubun", "new");
			}
			logger.debug("gubun=" + rtMap.getString("gubun"));

			rtMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
			rtMap.put("emp_no", loginSession.getEmp_no());

			List<DataMap> rtnMap = vendorService.getDeptEmpList(rtMap);

			mav.addObject("EmpList", rtnMap);
			mav.addObject("emp_no", loginSession.getEmp_no());
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
		
		logger.debug("req :: " + req.getParameterValues("relr_nm"));
		
		String relr_divs_cd[] = req.getParameterValues("relr_divs_cd");
		String relr_nm[] = req.getParameterValues("relr_nm");
		String relr_postion_nm[] = req.getParameterValues("relr_postion_nm");
		String relr_dept_nm[] = req.getParameterValues("relr_dept_nm");
		String relr_tel_no[] = req.getParameterValues("relr_tel_no");
		String relr_email[] = req.getParameterValues("relr_email");
		String relr_anvs_dt[] = req.getParameterValues("relr_anvs_dt");
		String etc[] = req.getParameterValues("etc");
		
		rtMap.put("wholesale_vendor_no", rtMap.getInt("wholesale_vendor_no"));
		
		rtMap.put("relr_divs_cd", relr_divs_cd);
		rtMap.put("relr_nm", relr_nm);
		rtMap.put("relr_postion_nm", relr_postion_nm);
		rtMap.put("relr_dept_nm", relr_dept_nm);
		rtMap.put("relr_tel_no", relr_tel_no);
		rtMap.put("relr_email", relr_email);
		rtMap.put("relr_anvs_dt", relr_anvs_dt);
		rtMap.put("etc", etc);
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
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getDept_no() + "/" + loginSession.getEmp_grd_cd()+ "/" + loginSession.getEmp_no());
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		
		List<DataMap> rtnMngMap = vendorService.getMngTeamList(paramMap);
		
		
		DataMap vendorView =  vendorService.vendorView(rtMap);
		
		List<DataMap> vendorViewUser  = vendorService.vendorViewUser(rtMap);
		
		List<DataMap> rtnFileMap  = vendorService.getVendorFileView(rtMap);
		
		if(rtnFileMap.size()>0) {
			for(int i=0; i<rtnFileMap.size();i++) {
				DataMap  filemap = rtnFileMap.get(i);
				
				if(filemap.getString("APND_FILE_DIVS_CD").equals("0001")) {
					mav.addObject("apnd_file_divs_cd1", filemap.getString("REG_FILE_NM"));
				}
				if(filemap.getString("APND_FILE_DIVS_CD").equals("0002")) {
					mav.addObject("apnd_file_divs_cd2", filemap.getString("REG_FILE_NM"));
				}
				if(filemap.getString("APND_FILE_DIVS_CD").equals("0003")) {
					mav.addObject("apnd_file_divs_cd3", filemap.getString("REG_FILE_NM"));
				}
				if(filemap.getString("APND_FILE_DIVS_CD").equals("0004")) {
					mav.addObject("apnd_file_divs_cd4", filemap.getString("REG_FILE_NM"));
				}
				if(filemap.getString("APND_FILE_DIVS_CD").equals("0005")) {
					mav.addObject("apnd_file_divs_cd5", filemap.getString("REG_FILE_NM"));
				}
				if(filemap.getString("APND_FILE_DIVS_CD").equals("0006")) {
					mav.addObject("apnd_file_divs_cd6", filemap.getString("REG_FILE_NM"));
				}
			}
		}
		
		mav.addObject("data",vendorView);
		mav.addObject("marketMap", marketMap);
		mav.addObject("sgmtMap", sgmtMap);
		mav.addObject("relrdivscdMap", relrdivscdMap);
		mav.addObject("vendorareacdMap", vendorareacdMap);
		mav.addObject("deptMngList", rtnMngMap);
		mav.addObject("vendorstatList", vendorstatcdMap);
		mav.addObject("vendorgrdcdList", vendorgrdcdMap);
		mav.addObject("gubun",rtMap.get("gubun"));
		mav.addObject("vendorViewUser",vendorViewUser);
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
			paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
			paramMap.put("emp_no", loginSession.getEmp_no());
			paramMap.put("deptno", loginSession.getDept_no());
			paramMap.put("outlet_nm", param.getString("vendorNm"));
			List<DataMap> vendorList = vendorService.getVendorList(paramMap);
			
			
			mav.addObject("vendorList", vendorList);
			mav.setViewName("nobody/prodmenu/popVendorList");

			return mav;
			
			} catch (Exception e) {
				logger.debug("brandSubList err :: " + e);
				throw new DrinkException(new String[]{"nobody/common/error","거래처메뉴 조회중 에러가 발생 하였습니다."});
			}
	}
	
	@RequestMapping(value = "/vendorSearch")
	public ModelAndView vendorSearch(Locale locale, Model model, HttpServletRequest req, RequestMap param) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		logger.debug("param==" + param.toString());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"nobody/common/error","로그인이 필요한 메뉴 입니다."});
		}
		
		String page = (String) param.get("page");
		String pageLine = (String) param.get("pageLine");
		
		try {
			ModelAndView mav = new ModelAndView();
			
			paging.setCurrentPageNo((page != null) ? Integer.valueOf(page) : CommonConfig.Paging.CURRENTPAGENO.getValue()); // 호출 page
			paging.setRecordsPerPage((pageLine != null) ? Integer.valueOf(pageLine) : CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 레코드 수
			param.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
			param.put("perPageNum", paging.getRecordsPerPage());
			
			
			param.put("emp_grd_cd", loginSession.getEmp_grd_cd());
			param.put("emp_no", loginSession.getEmp_no());
			param.put("deptno", loginSession.getDept_no());
			
			List<DataMap> rtnVendrMap = vendorService.getVendorList(param);
			int totalCnt = param.getInt("TotalCnt");
			HashMap<String, Object> pagingMap = new HashMap<>();
			pagingMap.put("page", page);
			pagingMap.put("pageLine", paging.getRecordsPerPage());
			pagingMap.put("totalCnt", totalCnt);
			mav.addObject("paging", pagingMap);
			mav.addObject("dropdown03","active");	
			mav.addObject("vendorList", rtnVendrMap);
			mav.setViewName("nobody/vendor/vendorSearch");
			
			return mav;
			
			
			} catch (Exception e) {
				logger.debug("brandSubList err :: " + e);
				throw new DrinkException(new String[]{"nobody/common/error","검섹중 에러가 발생 하였습니다."});
			}
	}
	
	@RequestMapping(value = "/VendorSegList")
	public ModelAndView VendorSegList(Locale locale, Model model, RequestMap rtMap) throws DrinkException {
		
		try{
		ModelAndView mav = new ModelAndView();
		
		
		List<DataMap> sgmtMap = vendorService.VendorSegList(rtMap);
		
		mav.addObject("_pVendor_sgmt_divs_cd", rtMap.get("_pVendor_sgmt_divs_cd"));
		mav.addObject("gubun", rtMap.get("gubun"));
		mav.addObject("sgmtMap", sgmtMap);
		
		mav.setViewName("nobody/vendor/vendorSegList");
		return mav;
		}catch (Exception e) {
			logger.debug("err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","세그먼트  검색중 에러가 발생 하였습니다."});
		}
	}
	
	
	@RequestMapping(value = "/vendorLedger", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView vendorLedger(Locale locale, ModelMap model, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		ModelAndView mav = new ModelAndView();

		RequestMap paramMap = new RequestMap();
		paramMap = new RequestMap();
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		List<DataMap> vendorList = vendorService.getVendorList(paramMap);
		mav.addObject("vendorList", vendorList);
		
		mav.addObject("dropdown03","active");		
		
		mav.setViewName("vendor/vendorLedger");
		return mav;
	}
	
	@RequestMapping(value = "/vendorLedgerSearch", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView vendorLedgerSearch(Locale locale, ModelMap model, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		ModelAndView mav = new ModelAndView();
		
		DataMap vendorView =  vendorService.vendorView(rtMap);
		
		rtMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		rtMap.put("emp_no", loginSession.getEmp_no());
		
		List<DataMap> rtnVendrMap = vendorService.getProPosalLedgerList(rtMap);
		int ProposaltotalCnt = rtMap.getInt("TotalCnt");
		
		List<DataMap> rtnVenderCallMap = vendorService.getCallLedgerList(rtMap);
		int VenderCalltotalCnt = rtMap.getInt("TotalCnt");
		
		
		mav.addObject("vendorView", vendorView);
		mav.addObject("vendorProposalList", rtnVendrMap);
		mav.addObject("ProposaltotalCnt", ProposaltotalCnt);
		mav.addObject("vendorCallList", rtnVenderCallMap);
		mav.addObject("VenderCalltotalCnt", VenderCalltotalCnt);
		
		
		mav.addObject("vendorView", vendorView);
		mav.setViewName("nobody/vendor/vendorLedgerSearch");
		return mav;
	}
}
