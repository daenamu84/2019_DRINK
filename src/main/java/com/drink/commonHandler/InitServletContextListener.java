/** 
* @ Title: InitServletContextListener.java 
* @ Package: com.drink.commonHandler 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 22. 오후 3:02:03 
* @ Version V0.0 
*/ 
package com.drink.commonHandler;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.drink.commonHandler.util.InitServletConfigUtils;

/** 
* @ ClassName: InitServletContextListener 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 22. 오후 3:02:03 
*  
*/
public class InitServletContextListener  implements ServletContextListener{

	/** 
	* @ Title: contextDestroyed 
	* @ Description: 
	* @ Param: @param arg0 
	* @ Date: 2016. 12. 22. 오후 3:02:41
	* @ Throws 
	* @see javax.servlet.ServletContextListener#contextDestroyed(javax.servlet.ServletContextEvent) 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	/** 
	* @ Title: contextInitialized 
	* @ Description: 
	* @ Param: @param arg0 
	* @ Date: 2016. 12. 22. 오후 3:02:41
	* @ Throws 
	* @see javax.servlet.ServletContextListener#contextInitialized(javax.servlet.ServletContextEvent) 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	
	@Override
	public void contextInitialized(ServletContextEvent event) {
		// TODO Auto-generated method stub
		try {
		System.out.println("start ServletContext Initialized");
		InputStream is =getClass().getResourceAsStream("/properties/InitServlet.properties");
		if(is == null)return;
		Properties props = new Properties();
		props.load(is);
		props.setProperty("contextPath", event.getServletContext().getContextPath());
			
		InitServletConfigUtils.initDefault(props);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
