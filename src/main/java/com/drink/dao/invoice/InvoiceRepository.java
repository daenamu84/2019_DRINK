/** 
* @ Title: InvoiceRepository.java 
* @ Package: com.drink.dao.invoice 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 20. 오후 3:49:15 
* @ Version V0.0 
*/ 
package com.drink.dao.invoice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drink.commonHandler.util.DataMap;
import com.drink.dao.GenericMapperImpl;

/** 
* @ ClassName: InvoiceRepository 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 20. 오후 3:49:15 
*  
*/
@Repository
public class InvoiceRepository {
	@Autowired
	GenericMapperImpl<Object, Object> gdi;
	
	public List<DataMap> getDeliveryStatus(DataMap map){
		List<DataMap> result = gdi.selectList("Invoice.selectDeliveryStatus", map);
		return result;
	}
	
	public List<DataMap> getDeliveryDuplicationCk(DataMap map){
		List<DataMap> result = gdi.selectList("Invoice.selectDeliveryDuplicationCk", map);
		return result;
	}
	
	public int updateInvoiceLSSHPM(DataMap map){
		return gdi.update("Invoice.updateInvoiceLSSHPM", map);
	}

	public int updateInvoiceLSSHPS(DataMap map){
		return gdi.update("Invoice.updateInvoiceLSSHPS", map);
	}
	public int insertInvoiceLSSHPS(DataMap map){
		return gdi.update("Invoice.insertInvoiceLSSHPS", map);
	}
	public List<DataMap> getInvoiceLSSHPD(DataMap map){
		List<DataMap> result = gdi.selectList("Invoice.getInvoiceLSSHPD", map);
		return result;
	}
	public int updateInvoiceLSSHPD(DataMap map){
		return gdi.update("Invoice.updateInvoiceLSSHPD", map);
	}
	public int updateInvoiceRMORDD(DataMap map){
		return gdi.update("Invoice.updateInvoiceRMORDD", map);
	}
	public int updateInvoiceRMORDS(DataMap map){
		return gdi.update("Invoice.updateInvoiceRMORDS", map);
	}
	public int insertInvoiceRMORDS(DataMap map){
		return gdi.update("Invoice.insertInvoiceRMORDS", map);
	}
	public DataMap selectInvoiceRMORDD(DataMap map){
		return (DataMap) gdi.selectOne("Invoice.selectInvoiceRMORDD", map);
	}
	public int updateInvoiceRMORDM(DataMap map){
		return gdi.update("Invoice.updateInvoiceRMORDM", map);
	}
	public int updateInvoiceRMORDD2(DataMap map){
		return gdi.update("Invoice.updateInvoiceRMORDD2", map);
	}
	public int updateInvoiceLSIVCM(DataMap map){
		return gdi.update("Invoice.updateInvoiceLSIVCM", map);
	}
	public int insertInvoiceLSIVCM(DataMap map){
		return gdi.update("Invoice.insertInvoiceLSIVCM", map);
	}
	public int insertInvoiceCMSMSG(DataMap map){
		return gdi.update("Invoice.insertInvoiceCMSMSG", map);
	}
	public boolean isDeliveryDuplicationCk(List<String > shipId){
		boolean isRtn = true;
		DataMap map = new DataMap();
		map.put("shipId", shipId);
		List<DataMap> deliveryList = gdi.selectList("Invoice.selectDeliveryDuplicationList", map);
		
		for (int i = 0; i < deliveryList.size(); i++) {
			DataMap dm = deliveryList.get(i);
			if(!"01".equals(dm.getString("SHIP_STATUS"))){
				isRtn = false;
				break;
			}
		}
		
		List<DataMap> ListLSSHPD = gdi.selectList("Invoice.selectLSSHPDDuplicationList", map);
		if(ListLSSHPD != null &&  ListLSSHPD.size() > 0) {
				isRtn = false;
		}
		
		return isRtn;
	}
	public int updateInvoiceLSSHPMStatus(DataMap map){
		return gdi.update("Invoice.updateInvoiceLSSHPMStatus", map);
	}
	public int updateInvoiceLSSHPSHistory(DataMap map){
		return gdi.update("Invoice.updateInvoiceLSSHPSHistory", map);
	}
	public int insertInvoiceLSSHPS1(DataMap map){
		return gdi.update("Invoice.insertInvoiceLSSHPS1", map);
	}
	public int insertInvoiceLSIVCM2(DataMap map){
		return gdi.update("Invoice.insertInvoiceLSIVCM2", map);
	}
	public int insertInvoiceLSIVCM3(DataMap map){
		return gdi.update("Invoice.insertInvoiceLSIVCM3", map);
	}
	public int insertInvoiceLSIVCM4(DataMap map){
		return gdi.update("Invoice.insertInvoiceLSIVCM4", map);
	}
	public DataMap selectInvoiceCnt(DataMap map){
		return (DataMap) gdi.selectOne("Invoice.selectInvoiceCnt", map);
	}
	public int updateInvoiceLSSHPM1(DataMap map){
		return gdi.update("Invoice.updateInvoiceLSSHPM1", map);
	}
	
	public DataMap checkDeliveryStatus(DataMap map){
		return (DataMap) gdi.selectOne("Invoice.ckDeliveryStatus", map);
	}
	
	public List<DataMap> selectInvoiceLSHANM(DataMap map){
		return gdi.selectList("Invoice.selectInvoiceLSHANM",map);
	}
	
	public int updateInvoiceLSHANM(DataMap map){
		return gdi.update("Invoice.updateInvoiceLSHANM",map);
	}
	public int updateInvoiceLSSHPM2(DataMap map){
		return gdi.update("Invoice.updateInvoiceLSSHPM2",map);
	}
}
