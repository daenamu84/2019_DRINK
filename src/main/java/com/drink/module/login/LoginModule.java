/** 
* @ Title: LoginModule.java 
* @ Package: com.wizwid.module.login 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:29:07 
* @ Version V0.0 
*/ 
package com.drink.module.login;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.dto.model.user.loginDto;
import com.drink.dto.table.user.Cmuser;

/** 
* @ ClassName: LoginModule 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:29:07 
*  
*/
public interface LoginModule {
	
	Cmuser getCmuser(loginDto param) throws DrinkException;
}
