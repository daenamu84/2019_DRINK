/** 
* @ Title: loginRepository.java 
* @ Package: com.drink.dao.login 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:33:41 
* @ Version V0.0 
*/ 
package com.drink.dao.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drink.dao.GenericMapperImpl;
import com.drink.dto.model.user.loginDto;
import com.drink.dto.table.user.Cmuser;

/** 
* @ ClassName: loginRepository 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:33:41 
*  
*/
@Repository
public class LoginRepository {
	@Autowired
	GenericMapperImpl<Object, Object> gdi;
	
	public Cmuser selectUser(loginDto param) {
		Cmuser list = (Cmuser) gdi.selectOne("User.getUser",param);
		return list;
	}
}
