/** 
* @ Title: InitServletConfigUtils.java 
* @ Package: com.drink.commonHandler.util 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 22. 오후 3:07:12 
* @ Version V0.0 
*/ 
package com.drink.commonHandler.util;

import java.util.Properties;


/** 
* @ ClassName: InitServletConfigUtils 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 22. 오후 3:07:12 
*  
*/
public class InitServletConfigUtils {
	public static String contextPath; 
	public static String initParam1; 
	public static String initParam2; 
	public static String initParam3; 
	public static String initParam4;
	protected InitServletConfigUtils() {
		
	}
	
	public static void initDefault(Properties props){
		if(props == null) return;
		InitServletConfigUtils.contextPath = props.getProperty("contextPath");
		InitServletConfigUtils.initParam1 = props.getProperty("param1");
		InitServletConfigUtils.initParam2 = props.getProperty("param2");
		InitServletConfigUtils.initParam3 = props.getProperty("param3");
		InitServletConfigUtils.initParam4 = props.getProperty("param4");
	}
	
}
