/** 
* @ Title: RequestMap.java 
* @ Package: com.drink.commonHandler.bind 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 20. 오후 7:18:19 
* @ Version V0.0 
*/
package com.drink.commonHandler.bind;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 
* @ ClassName: RequestMap 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 20. 오후 7:18:19 
*  
*/
public class RequestMap {
	Map<String, Object> map = new HashMap<String, Object>();
	private transient HttpServletRequest request;
	private transient HttpServletResponse response;

	/**
	 * @return the request
	 */
	public HttpServletRequest getRequest() {
		return request;
	}

	/**
	 * @param request the request to set
	 */
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	/**
	 * @return the response
	 */
	public HttpServletResponse getResponse() {
		return response;
	}

	/**
	 * @param response the response to set
	 */
	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	
	public void setSession(String key, Object value){
		this.request.getSession().setAttribute(key, value);
	}
	
	public Object getSession(String key){
		return this.request.getSession().getAttribute(key);
	}

	public Object get(String key) {
		return map.get(key);
	}
	
	public String getString(String key) {
		if (key == null) {return "";}
		Object value = get(key);
		if(value instanceof Object[]){
			value = ((String[])map.get(key))[0];
		}
		if (value == null) {return "";}
		return value.toString();
	}
	public int getInt(String key) {
		if (key == null) {return 0;}
		Object value = get(key);
		if(value instanceof Object[]){
			value = ((String[])map.get(key))[0];
		}
		if (value == null) {return 0;}
		if (value instanceof java.lang.String) {try {return Integer.parseInt((String)value);} catch(NumberFormatException e) {return 0;}}
		else if (value instanceof java.lang.Number) {return ((Number)value).intValue();}
		else {return 0;}
	}
	public long getLong(String key) {
		if (key == null) {return 0;}
		Object value = get(key);
		if(value instanceof Object[]){
			value = ((String[])map.get(key))[0];
		}
		if (value == null) {return 0;}
		if (value instanceof java.lang.String) {try {return Long.parseLong((String)value);} catch(NumberFormatException e) {return 0;}}
		else if (value instanceof java.lang.Number) {return ((Number)value).longValue();}
		else {return 0;}
	}
	public double getDouble(String key) {
		if (key == null) {return 0;}
		Object value = get(key);
		if(value instanceof Object[]){
			value = ((String[])map.get(key))[0];
		}
		if (value == null) {return 0;}
		if (value instanceof java.lang.String) {try {return Double.parseDouble((String)value);} catch(NumberFormatException e) {return 0;}}
		else if (value instanceof java.lang.Number) {return ((Number)value).doubleValue();}
		else {return 0;}
	}

	public void put(String key, Object value) {
		map.put(key, value);
	}

	public Object remove(String key) {
		return map.remove(key);
	}

	public boolean containsKey(String key) {
		return map.containsKey(key);
	}

	public boolean containsValue(Object value) {
		return map.containsValue(value);
	}

	public void clear() {
		map.clear();
	}

	public Set<Entry<String, Object>> entrySet() {
		return map.entrySet();
	}

	public Set<String> keySet() {
		return map.keySet();
	}

	public boolean isEmpty() {
		return map.isEmpty();
	}

	public void putAll(Map<? extends String, ? extends Object> m) {
		map.putAll(m);
	}

	public Map<String, Object> getMap() {
		return map;
	}

	@Override
	public String toString() {

		StringBuilder sb = new StringBuilder();
		Iterator<Entry<String, Object>> i = map.entrySet().iterator();
		sb.append("RequestMap {");
		for (;;) {
			Entry<String, Object> e = i.next();
			Object key = e.getKey();
			Object value = e.getValue();
			sb.append(key == this ? "(this Map)" : key);
			sb.append('=');
			if (value instanceof Object[]) {
				sb.append(value == this ? "(this Map)" : Arrays.toString((Object[]) value));
			} else {
				sb.append(value == this ? "(this Map)" : value);
			}
			if (!i.hasNext())
				return sb.append('}').toString();
			sb.append(',').append(' ');
		}

	}

}
