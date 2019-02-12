/** 
* @ Title: Loginservice.java 
* @ Package: com.drink.service.login 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:14:18 
* @ Version V0.0 
*/ 
package com.drink.service.login;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;

/** 
* @ ClassName: Loginservice 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:14:18 
*  
*/
public interface LoginService {

	void setLogIn(RequestMap map) throws DrinkException;
}
