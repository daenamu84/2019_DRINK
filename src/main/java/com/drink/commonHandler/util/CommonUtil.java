/** 
* @ Title: CommonUtil.java 
* @ Package: com.drink.commonHandler.util 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 11. 오전 11:27:41 
* @ Version V0.0 
*/ 
package com.drink.commonHandler.util;

import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

/** 
* @ ClassName: CommonUtil 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 11. 오전 11:27:41 
*  
*/
@Component
public class CommonUtil {

	String[] loginUrl = {"/logIn","/logInProcess"};
	
	/** 
	* @ Title: getParameter 
	* @ Description: 
	* @ Param: @param request
	* @ Param: @return 
	* @ Return: String
	* @ Date: 2017. 10. 26. 오전 9:48:41
	* @ Throws 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	public String getParameter(HttpServletRequest request){
		Enumeration<String> params = request.getParameterNames();
		String strParam = "";
		while(params.hasMoreElements()) {
		    String name = (String)params.nextElement();
		    if( !("LOGINID".equals(name.toUpperCase()) || "PASSWD".equals(name.toUpperCase())) ){
			    String[] value = request.getParameterValues(name);
			    if(value != null || value.length > 0){
			    	try {
			    		for(String arg : value){
			    			strParam += name + "=" + arg + "&";
			    		}
					} catch (Exception e) {
						e.printStackTrace();
					}
			    }
			}
		}
		if(strParam.length() > 0) strParam = strParam.substring(0, strParam.length()-1);
		return strParam;
	}
	
	//로그인이 필요한 url 체크.
	public Boolean checkLoginUrl(HttpServletRequest request){
		Boolean isLoginUrl = false;
		if(Arrays.asList(loginUrl).indexOf(request.getRequestURI()) >= 0){
			isLoginUrl = true;
		}
		return !isLoginUrl;
	}
}
