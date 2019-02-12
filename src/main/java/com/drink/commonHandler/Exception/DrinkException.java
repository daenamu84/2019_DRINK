/** 
* @ Title: JsonException.java 
* @ Package: com.drink.commonHandler.Exception 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 12. 오전 8:51:11 
* @ Version V0.0 
*/ 
package com.drink.commonHandler.Exception;

import com.drink.commonHandler.util.DataMap;

/** 
* @ ClassName: JsonException 
* @ Description: 	
* @ Author: Daenamu
* @ Date: 2017. 10. 12. 오전 8:51:11 
*  
*/
@SuppressWarnings("serial")
public class DrinkException extends Exception {

	DataMap map = new DataMap();
	String message = null;
	String[] messageArr= {};
	
	public DrinkException(String message) {
		super();
		this.message = message;
	}

	public DrinkException(DataMap map) {
		super();
		this.map = map;
	}

	public DrinkException(String[] messageArr) {
		super();
		this.messageArr = messageArr;
	}
	
	public DrinkException( String message, DataMap map) {
		super();
		this.map = map;
		this.message = message;
	}

	public DrinkException(String message, String[] messageArr) {
		super();
		this.message = message;
		this.messageArr = messageArr;
	}

	public DrinkException(String[] messageArr, DataMap map) {
		super();
		this.map = map;
		this.messageArr = messageArr;
	}

	public DrinkException( String message, DataMap map, String[] messageArr) {
		super();
		this.map = map;
		this.message = message;
		this.messageArr = messageArr;
	}

	/**
	 * @return the messageArr
	 */
	public String[] getMessageArr() {
		return messageArr;
	}

	/**
	 * @param messageArr the messageArr to set
	 */
	public void setMessageArr(String[] messageArr) {
		this.messageArr = messageArr;
	}

	@Override
	public String getMessage() {
		// TODO Auto-generated method stub
		return this.message;
	}

	public DrinkException() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @return the map
	 */
	public DataMap getMap() {
		return map;
	}

	public DrinkException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
		// TODO Auto-generated constructor stub
	}

	public DrinkException(String message, Throwable cause) {
		super(message, cause);
		this.message = cause.getMessage();
	}

	public DrinkException(Throwable cause) {
		super(cause);
		this.message = cause.getMessage();
	}

	
}
