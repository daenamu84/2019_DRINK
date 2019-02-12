/** 
* @ Title: LocaleMessage.java 
* @ Package: com.drink.commonHandler 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 10. 28. 오후 12:59:19 
* @ Version V0.0 
*/
package com.drink.commonHandler;

import java.util.Locale;

import org.springframework.context.support.MessageSourceAccessor;

/** 
* @ ClassName: LocaleMessage 
* @ Description: 
* @ Author: 
* @ Date: 2016. 10. 28. 오후 12:59:19 
*  
*/
public class LocaleMessage {

	private static MessageSourceAccessor msAcc = null;

	public static void setMessageSourceAccessor(MessageSourceAccessor msAcc) {
		LocaleMessage.msAcc = msAcc;
	}

	public static String getMessage(String key) {
		return msAcc.getMessage(key, Locale.getDefault());
	}

	public static String getMessage(String key, Object[] objs) {
		return msAcc.getMessage(key, objs, Locale.getDefault());
	}
}
