/** 
* @ Title: LoginModuleImpl.java 
* @ Package: com.drink.module.login 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:31:36 
* @ Version V0.0 
*/ 
package com.drink.module.login;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.dao.login.LoginRepository;
import com.drink.dto.model.user.loginDto;
import com.drink.dto.table.user.Cmuser;

/** 
* @ ClassName: LoginModuleImpl 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:31:36 
*  
*/
@Service("LoginModule")
public class LoginModuleImpl implements LoginModule {

	private static final Logger logger = LogManager.getLogger(LoginModuleImpl.class);
	@Autowired
	private LoginRepository loginTx;
	
	/** 
	* @ Title: getCmuser 
	* @ Description: 
	* @ Param: @return
	* @ Param: @throws DrinkException 
	* @ Date: 2017. 10. 16. 오전 10:31:36
	* @ Throws 
	* @see com.drink.module.login.LoginModule#getCmuser() 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/

	@Override
	public Cmuser getCmuser(loginDto param) throws DrinkException {
		// TODO login 정보 가져오기
		
		Cmuser cmuser = loginTx.selectUser(param);
		return cmuser;
	}

}
