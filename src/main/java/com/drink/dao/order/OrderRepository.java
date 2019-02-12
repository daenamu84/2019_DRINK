/** 
* @ Title: OrderRepository.java 
* @ Package: com.drink.dao.login 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 20. 오후 3:09:41 
* @ Version V0.0 
*/ 
package com.drink.dao.order;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drink.commonHandler.util.DataMap;
import com.drink.dao.GenericMapperImpl;

/** 
* @ ClassName: OrderRepository 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 20. 오후 3:09:41 
*  
*/
@Repository
public class OrderRepository {
	
	private static final Logger logger = LogManager.getLogger(OrderRepository.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;
	
	public void selectOrderNew(DataMap map){
		 DataMap map1 =  (DataMap) gdi.selectOne("Order.selectOrderNew", map);//신규주문건수
			map.put("result", map1);
		
	}
	public void selectSenbackOrder(DataMap map){
			DataMap map2 = (DataMap)  gdi.selectOne("Order.Getsendback_all_qty", map);//  자동반품확정예정 건수
			map.put("Getsendback_all_qty", map2);
		 
	}
	public void selectReturnOrder(DataMap map){
			DataMap map2 = (DataMap)  gdi.selectOne("Order.Getreturn_qty", map);//  교환예정 건수
			map.put("Getreturn_qty", map2);
		
	}
	public void getNewOrderList(DataMap map){
		List<DataMap> map2 =  gdi.selectList("Order.getNewOrderList", map);//  신규주문리스트
		DataMap map3 =  (DataMap) gdi.selectOne("Order.getDATETIME", map);
		
		for (int i = 0; i < map2.size(); i++) {
			DataMap Stmap = map2.get(i);
			Stmap.put("UserID", map.getString("UserID"));
			Stmap.put("STD_DATETIME", map3.getString("STD_DATETIME"));
			Stmap.put("END_DATETIME", map3.getString("END_DATETIME"));
			int cnt =gdi.update("Order.updLsshpsStatus",Stmap);
			
			if(cnt>0){
				gdi.update("Order.insLsshpsStatus",Stmap);
				gdi.update("Order.updLsshpmStatus",Stmap);
			}
		}
		
		map.put("GetNewOrderList", map2);
	
	}
	public void getNewOrderDetail(DataMap map){
		DataMap map2 =  (DataMap) gdi.selectOne("Order.getNewOrderDetail", map);//  신규주문리스트
		map.put("GetNewOrderDetail", map2);
	
	}
	public List<DataMap> getOrderShippingList(DataMap map) {
		return gdi.selectList("Order.getDeliveryShippingList", map);
	}
	public DataMap getOrderShippingDetail(DataMap map) {
		return (DataMap) gdi.selectOne("Order.getDeliveryShippingDetail", map);
	}
}
