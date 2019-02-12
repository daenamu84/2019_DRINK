/** 
* @ Title: CommonModule.java 
* @ Package: com.drink.module.common 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 11. 1. 오전 11:18:07 
* @ Version V0.0 
*/ 
package com.drink.module.common;

import java.util.List;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.util.DataMap;

/** 
* @ ClassName: CommonModule 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 11. 1. 오전 11:18:07 
*  
*/
public interface CommonModule {
	DataMap getDeliveryCompany(String deliCompId) throws DrinkException;
	DataMap getSysDate() throws DrinkException;
	List<DataMap> getDeliveryCompanyAll() throws DrinkException;
}
