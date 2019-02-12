/** 
* @ Title: configUtils.java 
* @ Package: com.drink.commonHandler.util 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 22. 오전 8:29:55 
* @ Version V0.0 
*/ 
package com.drink.commonHandler.util;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/** 
* @ ClassName: configUtils 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 22. 오전 8:29:55 
*  
*/
@Component
public class ConfigUtils {
	
	@Autowired
	private Properties configProp;
	
	public String getValue(String key){
		return configProp.getProperty(key);
	}
}
