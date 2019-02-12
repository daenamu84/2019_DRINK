/** 
* @ Title: CommonModuleImpl.java 
* @ Package: com.drink.module.common 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 11. 1. 오전 11:19:00 
* @ Version V0.0 
*/ 
package com.drink.module.common;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.util.DataMap;
import com.drink.dao.common.CommonRepository;

/** 
* @ ClassName: CommonModuleImpl 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 11. 1. 오전 11:19:00 
*  
*/
@Service("CommonModule")
public class CommonModuleImpl implements CommonModule {

	private static final Logger logger = LogManager.getLogger(CommonModuleImpl.class);
	@Autowired
	private CommonRepository commonTx;
	
	/** 
	* @ Title: getDeliveryCompany 
	* @ Description: 
	* @ Param: @param map
	* @ Param: @return
	* @ Param: @throws DrinkException 
	* @ Date: 2017. 11. 1. 오전 11:19:00
	* @ Throws 
	* @see com.drink.module.common.CommonModule#getDeliveryCompany(com.drink.commonHandler.util.DataMap) 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/

	@Override
	public DataMap getDeliveryCompany(String deliCompId) throws DrinkException {
		DataMap  deliveryCompMap = commonTx.getDeliCompanyRefCd(deliCompId);
		return deliveryCompMap;
	}
	@Override
	public List<DataMap> getDeliveryCompanyAll() throws DrinkException {
		List<DataMap>  deliveryCompMap = commonTx.getDeliCompanyAll();
		return deliveryCompMap;
	}

	/** 
	* @ Title: getSysDate 
	* @ Description: 
	* @ Param: @return
	* @ Param: @throws DrinkException 
	* @ Date: 2017. 11. 1. 오전 11:21:50
	* @ Throws 
	* @see com.drink.module.common.CommonModule#getSysDate() 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/ 
	
	@Override
	public DataMap getSysDate() throws DrinkException {
		DataMap getSysDate = commonTx.getSysDate();
		if(getSysDate == null && getSysDate.size() == 0){
			throw new DrinkException(new String[]{"messageError","Date 처리중 에러가 발생 하였습니다."});
		}
		return getSysDate;
	}

}
