/** 
* @ Title: ApprovalController.java 
* @ Package: com.wizwid.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 9:51:56 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.CommonConfig;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.DataMap;
import com.drink.commonHandler.util.Paging;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.dto.model.user.loginDto;
import com.drink.service.approval.ApprovalService;
import com.drink.service.brand.BrandService;
import com.drink.service.login.LoginService;
import com.drink.service.member.MemberService;
import com.drink.service.proposal.ProposalService;
import com.drink.service.vendor.VendorService;



/** 
* @ ClassName: ApprovalController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 9:51:56 
*  
*/
@Controller
public class ApprovalController {

	
	private static final Logger logger = LogManager.getLogger(ApprovalController.class);

	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	@Autowired
	private VendorService vendorService;
	
	@Autowired
	private ApprovalService approvalService;
	
	@Autowired
	private ProposalService proposalService;
	
	@Autowired 
	private BrandService brandService;

	@Autowired
	private Paging paging;

	@RequestMapping(value = "/ApprovalList")
	public ModelAndView approvalList(Locale locale, Model model, HttpServletRequest req,  RequestMap rtMap) throws DrinkException {
		
		String page = (String) rtMap.get("page");
		String pageLine = (String) rtMap.get("pageLine");
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		RequestMap map = new RequestMap();
		
		ModelAndView mav = new ModelAndView();
		
		map.put("cmm_cd_grp_id", "00026"); // 결제코드
		List<DataMap> C00026 = vendorService.getCommonCode(map);
		mav.addObject("C00026", C00026);
		
		RequestMap paramMap = new RequestMap();
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		
		paging.setCurrentPageNo((page != null) ? Integer.valueOf(page) : CommonConfig.Paging.CURRENTPAGENO.getValue()); // 호출 page
		paging.setRecordsPerPage((pageLine != null) ? Integer.valueOf(pageLine) : CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 레코드 수
		paramMap.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
		paramMap.put("perPageNum", paging.getRecordsPerPage());
		List<DataMap> rtnApprovalMap = approvalService.getApprovalList(paramMap);
		int totalCnt = paramMap.getInt("TotalCnt");
		
		paging.makePaging();
		HashMap<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("page", page);
		pagingMap.put("pageLine", paging.getRecordsPerPage());
		pagingMap.put("totalCnt", totalCnt);
		mav.addObject("paging", pagingMap);
		mav.addObject("ApprovalList", rtnApprovalMap);
		mav.addObject("dropdown04","active");
		mav.setViewName("approval/list");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/ApprovalSearchList")
	public ModelAndView approvalSearchList(Locale locale, Model model, HttpServletRequest req,  RequestMap rtMap) throws DrinkException {
		
		String page = (String) rtMap.get("page");
		String pageLine = (String) rtMap.get("pageLine");
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		RequestMap map = new RequestMap();
		
		ModelAndView mav = new ModelAndView();
		
		map.put("cmm_cd_grp_id", "00026"); // 결제코드
		List<DataMap> C00026 = vendorService.getCommonCode(map);
		mav.addObject("C00026", C00026);
		
		RequestMap paramMap = new RequestMap();
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		paramMap.put("appr_divs_cd", rtMap.getString("appr_divs_cd"));
		paramMap.put("appr_nm", rtMap.getString("appr_nm"));
		
		
		paging.setCurrentPageNo((page != null) ? Integer.valueOf(page) : CommonConfig.Paging.CURRENTPAGENO.getValue()); // 호출 page
		paging.setRecordsPerPage((pageLine != null) ? Integer.valueOf(pageLine) : CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 레코드 수
		paramMap.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
		paramMap.put("perPageNum", paging.getRecordsPerPage());
		List<DataMap> rtnApprovalMap = approvalService.getApprovalList(paramMap);
		int totalCnt = paramMap.getInt("TotalCnt");
		
		paging.makePaging();
		HashMap<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("page", page);
		pagingMap.put("pageLine", paging.getRecordsPerPage());
		pagingMap.put("totalCnt", totalCnt);
		mav.addObject("paging", pagingMap);
		mav.addObject("ApprovalList", rtnApprovalMap);
		mav.addObject("dropdown04","active");
		mav.setViewName("nobody/approval/searchlist");
		
		
		return mav;
	}
	
	
	@RequestMapping(value = "/ApprovalView", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView approvalView(Locale locale, ModelMap model, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		logger.debug("map :: " + rtMap.toString());
		logger.debug("map2 :: " + model.toString());

		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		paramMap.put("cmm_cd_grp_id", "00026"); // 결제코드
		List<DataMap> C00026 = vendorService.getCommonCode(paramMap);
		mav.addObject("C00026", C00026);
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getDept_no() + "/" + loginSession.getEmp_grd_cd()+ "/" + loginSession.getEmp_no());
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		
		
		DataMap approvalView =  approvalService.approvalView(rtMap);
		
		List<DataMap> approvalSignUser  = approvalService.approvalSignUser(rtMap);
		
		DataMap approvalFile =  approvalService.getVendorFileView(rtMap);
		
		List<DataMap> approvalComment  = approvalService.approvalComment(rtMap);
		
		
		mav.addObject("data",approvalView);
		mav.addObject("approvalSignUser",approvalSignUser);
		mav.addObject("approvalComment",approvalComment);
		mav.addObject("data1",approvalFile);
		mav.setViewName("approval/approvalform");
		return mav;
		
	}
	
	@RequestMapping(value = "/ApprovalSignView", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView approvalSignView(Locale locale, ModelMap model, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		logger.debug("map :: " + rtMap.toString());
		logger.debug("map2 :: " + model.toString());

		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		paramMap.put("cmm_cd_grp_id", "00026"); // 결제코드
		List<DataMap> C00026 = vendorService.getCommonCode(paramMap);
		mav.addObject("C00026", C00026);
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getDept_no() + "/" + loginSession.getEmp_grd_cd()+ "/" + loginSession.getEmp_no());
		
		rtMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		rtMap.put("emp_no", loginSession.getEmp_no());
		
		
		DataMap approvalView =  approvalService.approvalSignView(rtMap);
		
		List<DataMap> approvalSignUser  = approvalService.approvalSignUser(rtMap);
		
		DataMap approvalFile =  approvalService.getVendorFileView(rtMap);

		List<DataMap> approvalComment  = approvalService.approvalComment(rtMap);
		
		
		mav.addObject("data",approvalView);
		mav.addObject("approvalSignUser",approvalSignUser);
		mav.addObject("approvalComment",approvalComment);
		mav.addObject("data1",approvalFile);
		mav.setViewName("approval/approvalSignform");
		return mav;
		
	}
	
	

	@RequestMapping(value = "/ApprovalConfirm")
	public ModelAndView approvalConfirm(Locale locale, Model model, HttpServletRequest req,  RequestMap rtMap) throws DrinkException {
		
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		String page = (String) rtMap.get("page");
		String pageLine = (String) rtMap.get("pageLine");
		
		RequestMap map = new RequestMap();
				
		
		map.put("cmm_cd_grp_id", "00026"); // 결제코드
		List<DataMap> C00026 = vendorService.getCommonCode(map);
		mav.addObject("C00026", C00026);
		
		RequestMap paramMap = new RequestMap();
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		
		paging.setCurrentPageNo((page != null) ? Integer.valueOf(page) : CommonConfig.Paging.CURRENTPAGENO.getValue()); // 호출 page
		paging.setRecordsPerPage((pageLine != null) ? Integer.valueOf(pageLine) : CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 레코드 수
		paramMap.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
		paramMap.put("perPageNum", paging.getRecordsPerPage());
		
		List<DataMap> rtnApprovalMap = approvalService.getApprovalSignList(paramMap);
		
		int totalCnt = paramMap.getInt("TotalCnt");
		
		
		paging.makePaging();
		HashMap<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("page", page);
		pagingMap.put("pageLine", paging.getRecordsPerPage());
		pagingMap.put("totalCnt", totalCnt);
		mav.addObject("paging", pagingMap);
		mav.addObject("ApprovalList", rtnApprovalMap);
		mav.addObject("dropdown04","active");
		
		mav.setViewName("approval/confirmList");
		
		return mav;
	}
	
	@RequestMapping(value = "/ApprovalSend")
	public ModelAndView approvalSend(Locale locale, Model model, HttpServletRequest req,  RequestMap rtMap) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		
		RequestMap map = new RequestMap();
		
		ModelAndView mav = new ModelAndView();
		
		map.put("cmm_cd_grp_id", "00026"); // 결제코드
		List<DataMap> C00026 = vendorService.getCommonCode(map);
		mav.addObject("C00026", C00026);
		
		RequestMap paramMap = new RequestMap();
		paramMap.put("dept_no", loginSession.getDept_no());
		paramMap.put("empNo", loginSession.getEmp_no());
		List<DataMap> empSignList = approvalService.getEmpSignList(paramMap);
		
		mav.addObject("deptno", loginSession.getDept_no());
		mav.addObject("emp_no", loginSession.getEmp_no());
		mav.addObject("emp_grd_cd", loginSession.getEmp_grd_cd());
		mav.addObject("empSignList", empSignList);
		mav.addObject("dropdown04","active");
		mav.setViewName("approval/approvalSend");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/Apporval_doc_Search")
	public ModelAndView wholesaleVendorSearch(Locale locale, Model model, HttpServletRequest req, RequestMap param)
			throws DrinkException {
		logger.debug("rtMap===" + param);
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		logger.debug("param==" + param.toString());
		if (loginSession == null || (loginSession.getLgin_id() == null)) {
			throw new DrinkException(new String[] { "nobody/common/error", "로그인이 필요한 메뉴 입니다." });
		}

		String page = (String) param.get("page");
		String pageLine = (String) param.get("pageLine");

		try {
			ModelAndView mav = new ModelAndView();

			RequestMap paramMap = new RequestMap();
			paramMap.clear();
			paging.setCurrentPageNo((page != null) ? Integer.valueOf(page) : CommonConfig.Paging.CURRENTPAGENO.getValue()); // 호출 page
			paging.setRecordsPerPage((pageLine != null) ? Integer.valueOf(pageLine) : CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 레코드 수
			paramMap.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
			paramMap.put("perPageNum", paging.getRecordsPerPage());
			
			paramMap.put("pageStart", (paging.getCurrentPageNo() - 1) * paging.getRecordsPerPage());
			paramMap.put("perPageNum", paging.getRecordsPerPage());
			paramMap.put("emp_no", loginSession.getEmp_no());
			paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
			paramMap.put("apporval_doc", param.getString("apporval_doc"));
			paramMap.put("vendor_nm", param.getString("vendor_nm"));
			paramMap.put("outlet_no", param.getString("outlet_no"));
			
			if (param.getString("apporval_doc").equals("0001")) {
				List<DataMap> rtnVendrMap = vendorService.getVendorList(paramMap);
				int totalCnt = paramMap.getInt("TotalCnt");

				paging.makePaging();
				HashMap<String, Object> pagingMap = new HashMap<>();
				pagingMap.put("page", page);
				pagingMap.put("pageLine", paging.getRecordsPerPage());
				pagingMap.put("totalCnt", totalCnt);
				mav.addObject("paging", pagingMap);
				mav.addObject("vendorList", rtnVendrMap);
				mav.addObject("apporval_doc", param.getString("apporval_doc"));
				mav.addObject("vendor_nm", param.getString("vendor_nm"));
				mav.setViewName("nobody/approval/approval_vendorlist");

			} else if (param.getString("apporval_doc").equals("0002")) {
				List<DataMap> rtnProPosalMap = proposalService.getProPosalList(paramMap);
				int totalCnt = paramMap.getInt("TotalCnt");
				
				paging.makePaging();
				HashMap<String, Object> pagingMap = new HashMap<>();
				pagingMap.put("page", page);
				pagingMap.put("pageLine", paging.getRecordsPerPage());
				pagingMap.put("totalCnt", totalCnt);
				mav.addObject("paging", pagingMap);
				mav.addObject("apporval_doc", param.getString("apporval_doc"));
				mav.addObject("vendor_nm", param.getString("vendor_nm"));
				mav.addObject("outlet_no", param.getString("outlet_no"));
				mav.addObject("ProPosalList", rtnProPosalMap);
				mav.setViewName("nobody/approval/approval_proposallist");
			}
			return mav;

		} catch (Exception e) {
			logger.debug("brandSubList err :: " + e);
			throw new DrinkException(new String[] { "nobody/common/error", "검섹중 에러가 발생 하였습니다." });
		}
	}
	
	@RequestMapping(value = "/approvalInsert")
	public String approvalInsert(Locale locale,  ModelMap model, RedirectAttributes  redirectAttributes, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
			SessionDto loginSession = sessionUtils.getLoginSession(req);
			
			logger.debug("map :: " + rtMap.toString());
		
			
			rtMap.put("regId", loginSession.getLgin_id());
			rtMap.put("emp_no", loginSession.getEmp_no());
			
			String appSignEmp[] = req.getParameterValues("appSignEmp");
			rtMap.put("appSignEmp", appSignEmp);
			approvalService.approvalInsert(rtMap);
			
			redirectAttributes.addFlashAttribute("returnCode", "0000");
			
			HashMap<String, Object> rtnMap = new HashMap<>();
			rtnMap.put("returnCode", "0000");
			rtnMap.put("message", "저장 하였습니다.");
			
			return "redirect:/ApprovalList";
			//return rtnMap;
	}
	
	@RequestMapping(value = "/approvalCommentInsert")
	public ModelAndView approvalCommentInsert(Locale locale,  ModelMap model, RedirectAttributes  redirectAttributes, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
			SessionDto loginSession = sessionUtils.getLoginSession(req);
			
			logger.debug("map :: " + rtMap.toString());
		
			
			rtMap.put("regId", loginSession.getLgin_id());
			rtMap.put("emp_no", loginSession.getEmp_no());
			
			
			approvalService.approvalCommentInsert(rtMap);
			
			List<DataMap> approvalComment  = approvalService.approvalComment(rtMap);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("approvalComment",approvalComment);
			mav.addObject("emp_no",loginSession.getEmp_no());
			mav.setViewName("nobody/approval/approvalform_comment_list");
			
			
			return mav;
			//return rtnMap;
	}
	
	@RequestMapping(value = "/approvalCommentDelete")
	@ResponseBody
	public ModelAndView approvalCommentDelete(Locale locale,  ModelMap model, RedirectAttributes  redirectAttributes, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
	
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		rtMap.put("regId", loginSession.getLgin_id());
		rtMap.put("emp_no", loginSession.getEmp_no());
		
		logger.debug("map :: " + rtMap.toString());
		
		approvalService.approvalCommentDelete(rtMap);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "삭제 하였습니다.");
		
		List<DataMap> approvalComment  = approvalService.approvalComment(rtMap);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("approvalComment",approvalComment);
		mav.addObject("emp_no",loginSession.getEmp_no());
		mav.setViewName("nobody/approval/approvalform_comment_list");
		
		
		return mav;
		//return rtnMap;
	}
	
	@RequestMapping(value = "/ApprovalSingIn", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> ApprovalSingIn(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{

		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		vts.put("emp_no", loginSession.getEmp_no());
		vts.put("regId", loginSession.getLgin_id());
		approvalService.ApprovalSingIn(vts);

		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		if("02".equals(vts.get("_type"))){
			rtnMap.put("message", "반려 처리 되었습니다.");
		}else{
			rtnMap.put("message", "승인 처리 되었습니다.");
		}
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/AppVendorView", method = {RequestMethod.POST, RequestMethod.GET})
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
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00024"); // 	행정구역 시도 구분
		List<DataMap> vendorarea2cdMap = vendorService.getCommonCode(paramMap);

		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getDept_no() + "/" + loginSession.getEmp_grd_cd()+ "/" + loginSession.getEmp_no());
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		
		List<DataMap> rtnMngMap = vendorService.getMngTeamList(paramMap);
		
		List<DataMap> brandList = brandService.getVendorBrandMasterList(rtMap);
		
		mav.addObject("brandList", brandList);
		
		
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
		mav.addObject("vendorarea2cdMap", vendorarea2cdMap);
		mav.addObject("relrdivscdMap", relrdivscdMap);
		mav.addObject("vendorareacdMap", vendorareacdMap);
		mav.addObject("deptMngList", rtnMngMap);
		mav.addObject("vendorstatList", vendorstatcdMap);
		mav.addObject("vendorgrdcdList", vendorgrdcdMap);
		mav.addObject("gubun",rtMap.get("gubun"));
		mav.addObject("vendorViewUser",vendorViewUser);
		mav.addObject("returnCode",rtMap.get("returnCode"));
		mav.setViewName("nobodyView/approval/approval_vendorfrom");
		return mav;
		
	}
	
	
	@RequestMapping(value = "/AppProPosalView")
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
		mav.setViewName("nobodyView/approval/approval_proposalDetailView");
		
		return mav;
	}
	
}
