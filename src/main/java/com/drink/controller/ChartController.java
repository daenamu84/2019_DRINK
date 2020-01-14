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
import com.drink.commonHandler.util.Paging;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.service.chart.ChartService;
import com.drink.service.team.TeamService;


/** 
* @ ClassName: BrandController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 19. 오후 6:16:59 
*  
*/


@Controller
public class ChartController {
	private static final Logger logger = LogManager.getLogger(ChartController.class);
	
	@Autowired
	private Paging paging;
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private ChartService chartService;
	
	@Autowired
	private TeamService teamService;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	@RequestMapping(value = "/prod_sumList")
	public ModelAndView main(Locale locale, Model model, RequestMap rtMap) throws DrinkException {
		
		logger.debug("map :: " + rtMap.toString());
		
		
		RequestMap paramMap = new RequestMap();
		ModelAndView mav = new ModelAndView();
		
		//int totalCnt = teamService.GetTotalCnt(paramMap);
		List<DataMap> rtnMap = chartService.getEmpMList(paramMap);
		
		logger.debug("rtnMap :: " + rtnMap);
		
		
		paging.makePaging();
		HashMap<String, Object> pagingMap = new HashMap<>();
		mav.addObject("empList", rtnMap);
		mav.addObject("dropdown06","active");
		mav.setViewName("chart/pord_sumList");
		return mav;
	}
	
	@RequestMapping(value = "/pord_sumSearchList")
	public ModelAndView prodSearchList(Locale locale, Model model, RequestMap param, HttpServletRequest req) throws DrinkException {
		
		SessionDto loginSession = sessionUtils.getLoginSession(req);
		logger.debug("==param=" + param);
		if(loginSession == null || (loginSession.getLgin_id()== null)){
			throw new DrinkException(new String[]{"nobody/common/error","로그인이 필요한 메뉴 입니다."});
		}	
		try {
		ModelAndView mav = new ModelAndView();
		
		RequestMap paramMap = new RequestMap();
		
		List<DataMap> rtnMap1 = chartService.getEmpMList(paramMap);
		
		List<DataMap> rtnMap = chartService.pord_sumSearchList(param);
		
		mav.addObject("_pgStaDt", param.getString("staDt"));
		mav.addObject("empList", rtnMap1);
		mav.addObject("pord_sumSearchList", rtnMap);
		
		mav.setViewName("nobody/chart/pord_sumSearchList");
		return mav;
		
		} catch (Exception e) {
			logger.debug("brandSubList err :: " + e);
			throw new DrinkException(new String[]{"nobody/common/error","거래처메뉴 조회중 에러가 발생 하였습니다."});
		}
	}
}
