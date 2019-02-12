/** 
* @ Title: LoginServiceImpl.java 
* @ Package: com.drink.service.login 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:19:58 
* @ Version V0.0 
*/ 
package com.drink.service.login;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.ConfigUtils;
import com.drink.commonHandler.util.DataMap;
import com.drink.commonHandler.util.SecurityUtils;
import com.drink.commonHandler.util.SessionUtils;
import com.drink.dto.model.session.SessionDto;
import com.drink.dto.model.user.loginDto;
import com.drink.dto.table.user.Cmuser;
import com.drink.module.login.LoginModuleImpl;

/** 
* @ ClassName: LoginServiceImpl 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:19:58 
*  
*/
@Service("LoginService")
public class LoginServiceImpl implements LoginService{
	
	private static final Logger logger = LogManager.getLogger(LoginServiceImpl.class);
	@Autowired
	private LoginModuleImpl loginModule;

	@Autowired
	private SecurityUtils securityUtils;
	
	@Autowired
	private ConfigUtils configUtils;
	
	@Autowired
	private SessionUtils sessionUtils;
	
	/** 
	* @ Title: logIn 
	* @ Description: 
	* @ Param: @return
	* @ Param: @throws DrinkException 
	* @ Date: 2017. 10. 16. 오전 10:20:12
	* @ Throws 
	* @see com.drink.service.login.LoginService#logIn() 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	
	@Override
	public void setLogIn(RequestMap map) throws DrinkException {
		// TODO logIn 프로세스  처리
		
		DataMap resultMap 	= new DataMap();
		Cmuser 	cmuser		= loginModule.getCmuser((loginDto) map.get("param"));
		loginDto 	csdata 		= (loginDto) map.get("param");
		String	 	passwd 		= csdata.getPasswd();
		SessionDto 	sesstionDto 	= new SessionDto();
		
	    passwd =  securityUtils.SHA256Encryptor(passwd);
	    
		if(cmuser == null){
			logger.debug("로그인 실패 : 존재하지 않는 ID입니다.");
			map.put("isLogin", "1");
			
		}else if(!cmuser.getPasswd().equals(passwd)){
			logger.debug("로그인 실패 : 비밀번호가 일치하지 않습니다.");
			map.put("isLogin", "2");
		}else{
			logger.debug("로그인 성공");
			map.put("isLogin", "0");
		
			sesstionDto.setUserId(cmuser.getUserId());
			sesstionDto.setVdNm(cmuser.getVdNm());
			sesstionDto.setVendorId(cmuser.getVendorId());
			
			sesstionDto.setSessionId(map.getRequest().getSession().getId());
			sessionUtils.setLoginSession(sesstionDto, map.getRequest()); 
		}
	}

}
