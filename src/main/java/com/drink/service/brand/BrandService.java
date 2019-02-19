/** 
* @ Title: MainService.java 
* @ Package: com.drink.service.brand 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
* @ Version V0.0 
*/ 
package com.drink.service.brand;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.DataMap;
import com.drink.dao.GenericMapperImpl;

/** 
* @ ClassName: MainService 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
*  
*/
@Service("BrandService")
public class BrandService {
	private static final Logger logger = LogManager.getLogger(BrandService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;

	public DataMap test(RequestMap map) throws DrinkException{
		logger.debug("main 서비스 :: ");
		DataMap param = new DataMap();
		param.put("param2", "drink");
		param = (DataMap) gdi.selectOne("User.test",param);
		 logger.debug("query  end ");
		
		return param;
	}
}
