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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
import com.drink.service.login.LoginService;
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
	
	

	@RequestMapping(value = "/ApprovalConfirm")
	public ModelAndView approvalConfirm(Locale locale, Model model, HttpServletRequest req,  RequestMap rtMap) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
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
		
		mav.addObject("deptno", loginSession.getDept_no());
		mav.addObject("emp_no", loginSession.getEmp_no());
		mav.addObject("emp_grd_cd", loginSession.getEmp_grd_cd());
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
	public String ApprovalInsert(Locale locale,  ModelMap model, RedirectAttributes  redirectAttributes, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		
		logger.debug("map :: " + rtMap.toString());
	
		
		rtMap.put("regId", loginSession.getLgin_id());
		rtMap.put("emp_no", loginSession.getEmp_no());
		
		String appSignEmp[] = req.getParameterValues("appSignEmp");
		rtMap.put("appSignEmp", appSignEmp);
		approvalService.ApprovalInsert(rtMap);
		
		redirectAttributes.addFlashAttribute("returnCode", "0000");
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		
		return "redirect:/ApprovalList";
		//return rtnMap;
	}
}
