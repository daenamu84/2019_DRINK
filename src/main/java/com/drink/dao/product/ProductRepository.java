/** 
* @ Title: ProductRepository.java 
* @ Package: com.drink.dao.product 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 20. 오후 3:18:22 
* @ Version V0.0 
*/ 
package com.drink.dao.product;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drink.commonHandler.util.DataMap;
import com.drink.dao.GenericMapperImpl;
import com.drink.dao.order.OrderRepository;

/** 
* @ ClassName: ProductRepository 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 20. 오후 3:18:22 
*  
*/
@Repository
public class ProductRepository {
	@Autowired
	GenericMapperImpl<Object, Object> gdi;
	private static final Logger logger = LogManager.getLogger(OrderRepository.class);

	
	public void selectProcessAssort(DataMap map){
			DataMap map2 =  (DataMap)gdi.selectOne("Product.GetAssortCount", map);// 상품승인 건수
			map.put("GetAssortCount", map2);
		
	}
}
 