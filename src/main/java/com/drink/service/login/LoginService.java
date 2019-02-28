/** 
* @ Title: MainService.java 
* @ Package: com.drink.service.brand 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
* @ Version V0.0 
*/ 
package com.drink.service.login;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.DataMap;
import com.drink.dao.GenericMapperImpl;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;

/** 
* @ ClassName: MainService 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
*  
*/
@Service("LoginService")
public class LoginService {
	private static final Logger logger = LogManager.getLogger(LoginService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;
	
	@Autowired
	private SessionUtils sessionUtils;

	
	public String setLogIn(RequestMap map) throws  DrinkException{
		
		String flag = "";
		SessionDto 	sesstionDto 	= new SessionDto();
		
		logger.debug("map="+map.toString());
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Member.getLoginPassWD",map.getMap());
		
		try {
			if(param==null) {
				flag = "1";
			}else if(!param.getString("LOGIN_PWD").equals(map.get("login_pwd"))) {
				flag = "2";
			}else {
				flag ="0";
				sesstionDto.setLgin_id(param.getString("LOGIN_ID"));
				sesstionDto.setEmp_no(param.getString("EMP_NO"));
				sesstionDto.setEmp_grd_cd(param.getString("EMP_GRD_CD"));
				sesstionDto.setLog_nm(param.getString("EMP_NM"));
				
				sesstionDto.setSessionId(map.getRequest().getSession().getId());
				
				sessionUtils.setLoginSession(sesstionDto, map.getRequest()); 
				
			}
		}catch(Exception e) {
			logger.debug(e.getMessage());
		}
		return flag;
	}
	
}
