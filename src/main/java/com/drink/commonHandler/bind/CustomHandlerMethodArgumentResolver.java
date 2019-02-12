/** 
* @ Title: CustomHandlerMethodArgumentResolver.java 
* @ Package: com.drink.commonHandler.bind 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 20. 오후 7:03:02 
* @ Version V0.0 
*/ 
package com.drink.commonHandler.bind;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

/** 
* @ ClassName: CustomHandlerMethodArgumentResolver 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 20. 오후 7:03:02 
*  
*/
public class CustomHandlerMethodArgumentResolver implements HandlerMethodArgumentResolver{

	/** 
	* @ Title: supportsParameter 
	* @ Description: 
	* @ Param: @param parameter
	* @ Param: @return 
	* @ Date: 2017. 10. 20. 오후 7:03:32
	* @ Throws 
	* @see org.springframework.web.method.support.HandlerMethodArgumentResolver#supportsParameter(org.springframework.core.MethodParameter) 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	
	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		return RequestMap.class.isAssignableFrom(parameter.getParameterType());
	}

	/** 
	* @ Title: resolveArgument 
	* @ Description: 
	* @ Param: @param parameter
	* @ Param: @param mavContainer
	* @ Param: @param webRequest
	* @ Param: @param binderFactory
	* @ Param: @return
	* @ Param: @throws Exception 
	* @ Date: 2017. 10. 20. 오후 7:03:32
	* @ Throws 
	* @see org.springframework.web.method.support.HandlerMethodArgumentResolver#resolveArgument(org.springframework.core.MethodParameter, org.springframework.web.method.support.ModelAndViewContainer, org.springframework.web.context.request.NativeWebRequest, org.springframework.web.bind.support.WebDataBinderFactory) 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	
	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		RequestMap requestMap = new RequestMap();
		
		HttpServletRequest request = (HttpServletRequest) webRequest.getNativeRequest();			
		requestMap.setRequest(request);
		Enumeration<?> enumeration = request.getParameterNames();
		requestMap.put("referer", webRequest.getHeader("referer"));
		while(enumeration.hasMoreElements()){
			String key = (String) enumeration.nextElement();
			String[] values = request.getParameterValues(key);
			if(values!=null){
				requestMap.put(key, (values.length > 1) ? values:values[0] );
			}
		}
		
		return requestMap;
	}

}
