/** 
* @ Title: BrandController.java 
* @ Package: com.drink.controller 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
* @ Version V0.0 
*/ 
package com.drink.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.DataMap;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.service.call.CallService;
import com.drink.service.login.LoginService;
import com.drink.service.vendor.VendorService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;


/** 
* @ ClassName: BrandController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
*  
*/


@Controller
public class CallController {
	private static final Logger logger = LogManager.getLogger(CallController.class);
	
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
	
	@RequestMapping(value = "/callList")
	public ModelAndView main(Locale locale, Model model, HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00012"); // 	콜구분코드
		List<DataMap> scallgbnnmMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00019"); // 	콜 방문결과
		List<DataMap> scallrsltcdMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00018"); // 	콜 방문목적코드
		List<DataMap> scallpurposecdMap = vendorService.getCommonCode(paramMap);
		
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		
		List<DataMap> rtnMngMap = vendorService.getMngTeamList(paramMap);
		
		List<DataMap> rtnCallMap = callService.getCallList(paramMap);
		
		mav.addObject("CallList", rtnCallMap);
		mav.addObject("deptList", rtnMngMap);
		mav.addObject("scallgbNmList", scallgbnnmMap);
		mav.addObject("scallrsltcdList", scallrsltcdMap);
		mav.addObject("scallpurposeCdList", scallpurposecdMap);
		mav.setViewName("call/calllist");
		return mav;
	}
	
	@RequestMapping(value = "/callForm")
	public ModelAndView callForm(Locale locale, Model model , HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00012"); // 	콜구분코드
		List<DataMap> scallgbnnmMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00019"); // 	콜 방문결과
		List<DataMap> scallrsltcdMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00018"); // 	콜 방문목적코드
		List<DataMap> scallpurposecdMap = vendorService.getCommonCode(paramMap);
		
		paramMap.clear();
		paramMap.put("cmm_cd_grp_id", "00013"); // 	콜 선호도 코드
		List<DataMap> scallpfrNmMap = vendorService.getCommonCode(paramMap);
		
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		List<DataMap> rtnMngMap = vendorService.getMngTeamList(paramMap);
		
		mav.addObject("deptMngList", rtnMngMap);
		mav.addObject("scallgbNmList", scallgbnnmMap);
		mav.addObject("scallrsltcdList", scallrsltcdMap);
		mav.addObject("scallpurposeCdList", scallpurposecdMap);
		mav.addObject("scallpfrNmList", scallpfrNmMap);
		mav.addObject("deptno", loginSession.getDept_no());
		mav.addObject("emp_no", loginSession.getEmp_no());
		mav.setViewName("call/callfrom");
		return mav;
	}
	
	@RequestMapping(value="/vendorAuto", method=RequestMethod.GET)
	public void auto(String term, HttpServletRequest req, HttpServletResponse response) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		RequestMap paramMap = new RequestMap();
		
		
		paramMap.put("emp_grd_cd", loginSession.getEmp_grd_cd());
		paramMap.put("emp_no", loginSession.getEmp_no());
		paramMap.put("deptno", loginSession.getDept_no());
		paramMap.put("outlet_nm", term);
		
		List<DataMap> rtnVendrMap = vendorService.getVendorList(paramMap);
		
		
		//List<DataMap> list = dao.getAddrList(term);
		
		JsonArray gonarray = new JsonArray();
        // 응답해야 하는 문자열 : [{label:~,value:~},{label:~,value:~}]
		JsonObject sg = null;
		
		if(rtnVendrMap.size()>0) {  
			for(int i=0;i < rtnVendrMap.size();i++) {
				sg = new JsonObject();
				DataMap map1 = rtnVendrMap.get(i);
				sg.addProperty("label", map1.getString("OUTLET_NM"));
				sg.addProperty("code", map1.getString("OUTLET_NM"));
				sg.addProperty("value", map1.getString("VENDOR_NO"));
				
				gonarray.add(sg);
			}
		}else {
			sg = new JsonObject();
			sg.addProperty("label", "검색결과없음");
			sg.addProperty("value", "");
			
			gonarray.add(sg);
		}
		
		
		PrintWriter out;
		try {
			out = response.getWriter();
			out.println(gonarray);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
	}
	
	@RequestMapping(value = "/callInsert", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> CallInsert(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{		
		
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
		
		callService.CallInsert(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
		//return rtnMap;
	}
	
	@RequestMapping(value = "/callSearch")
	public ModelAndView callSearch(Locale locale, Model model, HttpServletRequest req, RequestMap param) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"nobody/common/error","로그인이 필요한 메뉴 입니다."});
		}
		
		try {
			ModelAndView mav = new ModelAndView();
			
			param.put("emp_grd_cd", loginSession.getEmp_grd_cd());
			param.put("emp_no", loginSession.getEmp_no());
			param.put("deptno", loginSession.getDept_no());
			
			logger.debug("param==" + param.toString());	
			
			List<DataMap> rtnVendrMap = callService.getCallList(param);
			
			mav.addObject("CallList", rtnVendrMap);
			mav.setViewName("nobody/call/callSearch");
			
			return mav;
			
			
			} catch (Exception e) {
				logger.debug("brandSubList err :: " + e);
				throw new DrinkException(new String[]{"nobody/common/error","검섹중 에러가 발생 하였습니다."});
			}
	}
	
	
	@RequestMapping(value = "/callDelete", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> CallDelete(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{		
		
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
		
		callService.CallDelete(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "삭제 하였습니다.");
		
		return rtnMap;
		//return rtnMap;
	}
	
	@RequestMapping(value = "/callviewdelete", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> callviewdelete(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{		
		
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
		
		callService.CallViewDelete(vts);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "삭제 하였습니다.");
		
		return rtnMap;
		//return rtnMap;
	}
	
	
	
	@RequestMapping(value = "/callView")
	public ModelAndView callView(Locale locale, Model model, RequestMap param,  HttpServletRequest req) throws DrinkException {
		
		try {
			SessionDto loginSession = sessionUtils.getLoginSession(req);
			logger.debug("==loginSession=" + loginSession.getLgin_id());
			if(loginSession == null || (loginSession.getLgin_id()== null)){
				 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
			}
				
			ModelAndView mav = new ModelAndView();
			
			RequestMap paramMap = new RequestMap();
			logger.debug("param=="+param);
			
			paramMap.clear();
			paramMap.put("cmm_cd_grp_id", "00018"); // 	콜 방문목적코드
			List<DataMap> scallpurposecdMap = vendorService.getCommonCode(paramMap);
			
			paramMap.clear();
			paramMap.put("cmm_cd_grp_id", "00013"); // 	콜 선호도 코드
			List<DataMap> scallpfrNmMap = vendorService.getCommonCode(paramMap);
			
			paramMap.clear();
			paramMap.put("cmm_cd_grp_id", "00019"); // 	콜 방문결과
			List<DataMap> scallrsltcdMap = vendorService.getCommonCode(paramMap);
			
			
			param.put("emp_grd_cd", loginSession.getEmp_grd_cd());
			param.put("emp_no", loginSession.getEmp_no());
			param.put("deptno", loginSession.getDept_no());
			
			
			DataMap callView = callService.CallView(param);
			
			mav.addObject("data",callView);
			mav.addObject("scallpurposeCdList", scallpurposecdMap);
			mav.addObject("scallpfrNmList", scallpfrNmMap);
			mav.addObject("scallrsltcdList", scallrsltcdMap);
			
			mav.setViewName("nobody/call/callView");
			return mav;
			
		} catch (Exception e) {
			logger.debug("codeSubList err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","콜  조회중 에러가 발생 하였습니다."});
		}
	}
	
	
	@RequestMapping(value = "/callUpdate", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> BrandSubInsert(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{

		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		
		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
		
		RequestMap dt = new RequestMap();
		dt.put("scall_no", vts.get("scall_no"));
		dt.put("scall_purpose_cd", vts.get("scall_purpose_cd_u"));
		dt.put("scall_pfr_nm", vts.get("scall_pfr_nm_u"));
		dt.put("scall_rslt_cd", vts.get("scall_rslt_cd_u"));
		dt.put("scall_sale_cntn", vts.get("scall_sale_cntn_u"));
		dt.put("scall_cprt_cntn", vts.get("scall_cprt_cntn_u"));
		dt.put("login_id", loginSession.getLgin_id());
		
		
		callService.CallUpdate(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}

	@RequestMapping(value = "/callCalendar")
	public ModelAndView callCalendar(Locale locale, Model model, HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"messageError","로그인이 필요한 메뉴 입니다."});
		}
		ModelAndView mav = new ModelAndView();
		RequestMap paramMap = new RequestMap();
		
		paramMap.put("year", "2019");
		paramMap.put("yearDt", "201903");
		List<DataMap> callCalendar = callService.getCallCalendar(paramMap);
		
		for (int i = 0; i < callCalendar.size(); i++) {
			DataMap dm = callCalendar.get(i);
			logger.debug("1 "+dm.get("SUN"));
			logger.debug("1 ?",dm.get("SUN"));
			logger.debug("2 "+dm.get("MON"));
			logger.debug("3 "+dm.get("TUE"));
			logger.debug("4 "+dm.get("WED"));
			logger.debug("5 "+dm.get("THU"));
			logger.debug("6 "+dm.get("FRI"));
			logger.debug("7 "+dm.get("SAT"));
			
		}
		
		mav.setViewName("call/callCalendar");
		mav.addObject("callCalendar",callCalendar);
		return mav;
	}
}
