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
import com.drink.service.login.LoginService;
import com.drink.service.member.MemberService;


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
	private MessageSource messageSource;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/memberList")
	public ModelAndView main(Locale locale, Model model) throws DrinkException {
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		
		
		List<DataMap> rtnMpa0 = memberService.getDeptList(paramMap);
		
		List<DataMap> rtnMap = memberService.getEmpMList(paramMap);
		
		logger.debug("rtnMap :: " + rtnMpa0);
		logger.debug("rtnMap :: " + rtnMap);
		
		mav.addObject("deptMMList", rtnMpa0);
		mav.addObject("empMList", rtnMap);
		
		mav.setViewName("member/memberlist");
		return mav;
	}
	
	@RequestMapping(value = "/memberForm")
	public ModelAndView memberForm(Locale locale, Model model) throws DrinkException {
		
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		List<DataMap> rtnMpa0 = memberService.getDeptList(paramMap);
		
		logger.debug("rtnMap :: " + rtnMpa0);
		mav.addObject("deptMMList", rtnMpa0);
		
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
		
		mav.setViewName("member/memberfrom");
		return mav;
		
	}
	
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public HashMap<String, Object> memberUpdate(Locale locale,   ModelMap model,  @RequestBody Map<String, Object> vts, RequestMap rtMap, HttpServletRequest req, HttpServletResponse res) throws DrinkException{
		logger.debug("vts :: " + vts.toString());
		logger.debug("map :: " + rtMap.toString());
		
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
		
		memberService.memberupdate(dt);
		
		HashMap<String, Object> rtnMap = new HashMap<>();
		rtnMap.put("returnCode", "0000");
		rtnMap.put("retgubun", "update");
		rtnMap.put("message", "저장 하였습니다.");
		
		return rtnMap;
	}
	
	
}
