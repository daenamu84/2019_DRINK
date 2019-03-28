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
import com.drink.commonHandler.util.CommonConfig;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.DataMap;
import com.drink.commonHandler.util.Paging;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.service.login.LoginService;
import com.drink.service.member.MemberService;
import com.drink.service.team.TeamService;
import com.drink.service.vendor.VendorService;


/** 
* @ ClassName: BrandController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
*  
*/


@Controller
public class MemberController {
	private static final Logger logger = LogManager.getLogger(MemberController.class);
	
	@Autowired
	private Paging paging;
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private TeamService teamService;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	
	@RequestMapping(value = "/memberList")
	public ModelAndView memberList(Locale locale, Model model, RequestMap rtMap) throws DrinkException {
		
		
		logger.debug("map :: " + rtMap.toString());
		
		String page = (String) rtMap.get("page");
		String pageLine = (String) rtMap.get("pageLine");
		
		
		
		ModelAndView mav = new ModelAndView();
		RequestMap paramMap = new RequestMap();
		
		paging.setCurrentPageNo((page != null) ? Integer.valueOf(page) : CommonConfig.Paging.CURRENTPAGENO.getValue()); // 호출 page
		paging.setRecordsPerPage((pageLine != null) ? Integer.valueOf(pageLine) : CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 레코드 수
		 
		paramMap.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
		paramMap.put("perPageNum", paging.getRecordsPerPage());
		paramMap.put("Query","Member.getEmpMListCnt");
		int totalCnt = teamService.GetTotalCnt(paramMap);
		
		
		List<DataMap> rtnMpa0 = memberService.getDeptList(paramMap);
		
		List<DataMap> rtnMap = memberService.getEmpMList(paramMap);
		
		paging.makePaging();
		HashMap<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("page", page);
		pagingMap.put("pageLine", paging.getRecordsPerPage());
		pagingMap.put("totalCnt", totalCnt);
		mav.addObject("paging", pagingMap);
		mav.addObject("deptMMList", rtnMpa0);
		mav.addObject("empMList", rtnMap);
		mav.addObject("dropdown05","active");
		mav.setViewName("member/memberlist");
		return mav;
	}
	
	@RequestMapping(value = "/memberSearch")
	public ModelAndView memberSearch(Locale locale, Model model, HttpServletRequest req, RequestMap param) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		logger.debug("param==" + param.toString());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"nobody/common/error","로그인이 필요한 메뉴 입니다."});
		}
		
		try {
			
			String page = (String) param.get("page");
			String pageLine = (String) param.get("pageLine");
			
			ModelAndView mav = new ModelAndView();
			
			
			paging.setCurrentPageNo((page != null) ? Integer.valueOf(page) : CommonConfig.Paging.CURRENTPAGENO.getValue()); // 호출 page
			paging.setRecordsPerPage((pageLine != null) ? Integer.valueOf(pageLine) : CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 레코드 수
			param.put("pageStart", (paging.getCurrentPageNo()-1) * paging.getRecordsPerPage());
			param.put("perPageNum", paging.getRecordsPerPage());
			param.put("Query","Member.getEmpMListCnt");
			
			int totalCnt = teamService.GetTotalCnt(param);
			
			List<DataMap> rtnMap = memberService.getEmpMList(param);
			
			paging.makePaging();
			HashMap<String, Object> pagingMap = new HashMap<>();
			pagingMap.put("page", page);
			pagingMap.put("pageLine", paging.getRecordsPerPage());
			pagingMap.put("totalCnt", totalCnt);
			mav.addObject("paging", pagingMap);
			mav.addObject("empList", rtnMap);
			mav.addObject("dropdown05","active");
			mav.setViewName("nobody/member/memberSearch");
			
			return mav;
			
			} catch (Exception e) {
				logger.debug("brandSubList err :: " + e);
				throw new DrinkException(new String[]{"nobody/common/error","검섹중 에러가 발생 하였습니다."});
			}
	}
	
	@RequestMapping(value = "/memberForm")
	public ModelAndView memberForm(Locale locale, Model model) throws DrinkException {
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		List<DataMap> rtnMpa0 = memberService.getDeptList(paramMap);
		
		RequestMap map = new RequestMap();
		map.put("cmm_cd_grp_id", "00002"); // 사원등급 
		
		List<DataMap> commonMap = memberService.getCommonCode(map);
		logger.debug("rtnMap :: " + rtnMpa0);
		mav.addObject("deptMMList", rtnMpa0);
		mav.addObject("commonList", commonMap);
		mav.addObject("dropdown05","active");
		mav.setViewName("member/memberfrom");
		return mav;
	}
	
	@RequestMapping(value = "/duplicateIDCheck", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> duplicateIDCheck(Locale locale, @RequestBody Map<String, Object> vts,  ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
		RequestMap map = new RequestMap();
		map.put("login_id", vts.get("login_id"));
		
		DataMap param = new DataMap();
		
		param = memberService.duplicateIDCheck(map);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		
		if(param.getInt("CNT")==0){
			rtnMap.put("returnCode", "0000");
			rtnMap.put("message", "사용 가능합니다.");	
		}else {
			rtnMap.put("returnCode", "0001");
			rtnMap.put("message", "중복된 ID 입니다..");
		}
		
		return rtnMap;
	
	}
	@RequestMapping(value = "/memberWork", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> memberWork(Locale locale,   ModelMap model,  @RequestBody Map<String, Object> vts, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		
		RequestMap dt = new RequestMap();
		dt.put("emp_nm", vts.get("emp_nm"));
		dt.put("emp_hp_no", vts.get("emp_hp_no"));
		dt.put("login_id", vts.get("login_id"));
		dt.put("login_pwd", vts.get("login_pwd"));
		dt.put("entco_dt", vts.get("entco_dt"));
		dt.put("zip_cd", vts.get("zip_cd"));
		dt.put("emp_addr", vts.get("emp_addr"));
		dt.put("emp_birth", vts.get("emp_birth"));
		dt.put("use_yn", vts.get("use_yn"));
		dt.put("emp_grd_cd", vts.get("emp_grd_cd"));
		dt.put("deptno", vts.get("deptno"));
		dt.put("mng_dept_no", vts.get("mng_dept_no"));
		dt.put("regId", loginSession.getLgin_id());
		
		memberService.memberWork(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "insert");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}
	
	
	@RequestMapping(value = "/memberView", method = RequestMethod.POST)
	
	public ModelAndView memberView(Locale locale, ModelMap model,  RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		
		ModelAndView mav = new ModelAndView();
		
		logger.debug("map :: " + rtMap.toString());
		RequestMap paramMap = new RequestMap();
		List<DataMap> rtnMpa0 = memberService.getDeptList(paramMap);
		
		RequestMap map = new RequestMap();
		map.put("cmm_cd_grp_id", "00002"); // 사원등급 
		
		List<DataMap> commonMap = memberService.getCommonCode(map);
		
		
		RequestMap dt = new RequestMap();
		dt.put("emp_no", rtMap.get("emp_no"));
		dt.put("gubun", rtMap.get("gubun"));
		
		DataMap memberView =  memberService.memberView(dt);
		List<DataMap> memberDeptList = memberService.getMngDeptEmplList(dt);
		
//		HashMap<String, Object> rtnMap = new HashMap<>();
//		rtnMap.put("data", memberView);
//		rtnMap.put("memberDeptList", memberDeptList);
//		rtnMap.put("gubun",rtMap.get("gubun"));
		mav.addObject("deptMMList", rtnMpa0);
		mav.addObject("data",memberView);
		mav.addObject("memberDeptList",memberDeptList);
		mav.addObject("gubun",rtMap.get("gubun"));
		mav.addObject("commonList", commonMap);	
		
		mav.setViewName("member/memberfrom");
		return mav;
		
	}
	
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> memberUpdate(Locale locale,   ModelMap model,  @RequestBody Map<String, Object> vts, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		
		RequestMap dt = new RequestMap();
		dt.put("emp_nm", vts.get("emp_nm"));
		dt.put("emp_no", vts.get("emp_no"));
		dt.put("emp_hp_no", vts.get("emp_hp_no"));
		dt.put("login_id", vts.get("login_id"));
		dt.put("login_pwd", vts.get("login_pwd"));
		dt.put("entco_dt", vts.get("entco_dt"));
		dt.put("zip_cd", vts.get("zip_cd"));
		dt.put("emp_addr", vts.get("emp_addr"));
		dt.put("emp_birth", vts.get("emp_birth"));
		dt.put("use_yn", vts.get("use_yn"));
		dt.put("emp_grd_cd", vts.get("emp_grd_cd"));
		dt.put("deptno", vts.get("deptno"));
		dt.put("ex_dept_no", vts.get("ex_dept_no"));
		dt.put("mng_dept_no", vts.get("mng_dept_no"));
		dt.put("regId", loginSession.getLgin_id());
		
		memberService.memberupdate(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "update");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}
	
	
	
	@RequestMapping(value = "/EmpSearchPop")
	public ModelAndView EmpSearchPop(Locale locale, Model model, HttpServletRequest req, RequestMap param) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==loginSession=" + loginSession.getLgin_id());
		logger.debug("param==" + param.toString());
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			 throw new DrinkException(new String[]{"nobody/common/error","로그인이 필요한 메뉴 입니다."});
		}
		
		try {
			ModelAndView mav = new ModelAndView();
			
			
			List<DataMap> rtnMap = memberService.getEmpMList(param);
			
			mav.addObject("empList", rtnMap);
			mav.setViewName("nobody/member/emplist");
			
			return mav;
			
			
			} catch (Exception e) {
				logger.debug("brandSubList err :: " + e);
				throw new DrinkException(new String[]{"nobody/common/error","팀원  조회중 에러가 발생 하였습니다."});
			}
	}
	
	
}
