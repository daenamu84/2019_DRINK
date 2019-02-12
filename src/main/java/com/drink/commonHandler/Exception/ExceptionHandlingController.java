/** 
* @ Title: ExceptionHandlingController.java 
* @ Package: com.drink.commonHandler.Exception 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 10. 28. 오후 4:45:06 
* @ Version V0.0 
*/
package com.drink.commonHandler.Exception;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.drink.commonHandler.util.DataMap;

/** 
* @ ClassName: ExceptionHandlingController 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 10. 28. 오후 4:45:06 
*  
*/
@ControllerAdvice
public class ExceptionHandlingController {

	private static final Logger logger = LogManager.getLogger(ExceptionHandlingController.class);

	/** 
	* @ Title: handleError 
	* @ Description: Exception 처리 메소드 
	* @ Param: @param req
	* @ Param: @param exception
	* @ Param: @return 
	* @ Return: ModelAndView
	* @ Date: 2016. 10. 28. 오후 5:03:09
	* @ Throws 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/
	@ExceptionHandler({Exception.class,DrinkException.class})
	public ModelAndView handleError(HttpServletRequest req, HttpServletResponse res, Exception exception) {
		ModelAndView mav = new ModelAndView();
		logger.info("Request: " + req.getRequestURL() + " raised " + exception);
		if(exception.getMessage() != null){
		logger.error("filed {} ", exception);
		}
		if(exception instanceof DrinkException){
			if(((DrinkException)exception).getMessageArr().length>0)
			logger.info("★exception★ :" + Arrays.toString(((DrinkException)exception).getMessageArr()) );
			if(((DrinkException) exception).getMap().size() > 0)
			logger.info("★exception★ :" + ((DrinkException)exception).getMap().toString());
		}
		
		boolean isAjax = false;
		String contentType = req.getHeader("content-Type");
		int mediaTypeJson = ((contentType == null ? "" : contentType ).toLowerCase()).indexOf(MediaType.APPLICATION_JSON_VALUE);
		 if( (contentType!=null && mediaTypeJson > -1) ){
			 DataMap map = new DataMap();
			 if(exception instanceof DrinkException){
				 String[] rtnArg = ((DrinkException)exception).getMessageArr();
				 map = ((DrinkException) exception).getMap();
				 if(rtnArg != null && rtnArg.length > 0){
					 map.put("returnCode", "9999");
						map.put("message",  rtnArg[1]);
				 }else if(map.size() == 0){
					map.put("returnCode", "9999");
					map.put("message", "Fail");
				}
			 }else{
			 	 map.put("returnCode", "9999");
			 	 map.put("message", "Fail");
			 }
			 req.setAttribute("resultJson", map);
		 	 mav.setViewName("common/errorJson");
		 }else{
			 String errorPage = null;
			 if(exception instanceof DrinkException){
				 String[] rtnArg = ((DrinkException)exception).getMessageArr();
				 DataMap map =  ((DrinkException) exception).getMap();
				 if(rtnArg != null && rtnArg.length > 0){
					 errorPage = rtnArg[0];
					 if(rtnArg.length > 1)mav.addObject("W_ERROR_MESSAGE", rtnArg[1]);
					 if(map.size() > 0) mav.addObject("W_ERROR_MAP",map);
				 }
			 }
			if(errorPage == null){
				errorPage = "common/error";
			}
			
			 mav.addObject("exception", exception);
			 mav.addObject("url", req.getRequestURL());
			 mav.setViewName(errorPage);
		 }
		return mav;
	}
	
	@ExceptionHandler({MissingServletRequestParameterException.class})
	public ModelAndView missingRequestParamhandleError(HttpServletRequest req, HttpServletResponse res, MissingServletRequestParameterException exception) {
		ModelAndView mav = new ModelAndView();
		
		String paramName = exception.getParameterName();
		
		String contentType = req.getHeader("content-Type");
		int mediaTypeJson = ((contentType == null ? "" : contentType ).toLowerCase()).indexOf(MediaType.APPLICATION_JSON_VALUE);
		
		 if( (contentType!=null && mediaTypeJson > -1) ){
			 DataMap map = new DataMap();
			 map.put("returnCode", "9999");
			 map.put("message", "PARAMETER : " + paramName+" is Missing");
			 req.setAttribute("resultJson", map);
		 	 mav.setViewName("common/errorJson");
		 }else{
			 String errorPage = "common/messageError";
			 mav.addObject("W_ERROR_MESSAGE", "PARAMETER : " + paramName+" is Missing");
			 mav.addObject("exception", exception);
			 mav.addObject("url", req.getRequestURL());
			 mav.setViewName(errorPage);
		 }
		return mav;
	}
}
