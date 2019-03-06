/** 
* @ Title: MainService.java 
* @ Package: com.drink.service.brand 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
* @ Version V0.0 
*/ 
package com.drink.service.vendor;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
@Service("VendorService")
public class VendorService {
	private static final Logger logger = LogManager.getLogger(VendorService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;

	public List getVendorList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map---"+ map.getMap());
		param = gdi.selectList("Vendor.getVendorList",map.getMap());
		
		return param;
	}

	public List getTeamList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Vendor.getTeamList",param);
		
		return param;
	}
	
	public List getMngTeamList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		param = gdi.selectList("Vendor.getMngTeamList",map.getMap());
		
		return param;
	}
	
	public List getCommonCode(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Code.getCommonCodeList",map.getMap());
		
		return param;
	}
	
	public List getDeptEmpList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		logger.debug("map=="+ map.toString());
		logger.debug("map=="+ map.get("deptno"));
		
		map.put("deptno", map.get("deptno").toString());
		
		param = gdi.selectList("Vendor.getDeptEmpList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void VendorInsert(RequestMap map) throws DrinkException{
		logger.debug("service 111111111 :: " + map.toString());
		
		DataMap countMap = (DataMap) gdi.selectOne("Vendor.getVendorCnt",  map.getMap()); 
		if(countMap != null && countMap.getInt("CNT") == 0 ){
			gdi.update("Vendor.masterInsert", map.getMap());
			
			DataMap param = new DataMap();
			
			int vendor_no = 0;
			
			param = (DataMap) gdi.selectOne("Vendor.getVendorNo",map.getMap());
			
			if(param.getString("VENDOR_NO")!= ""){
				vendor_no = param.getInt("VENDOR_NO");
			}
			
			if(vendor_no==0) {
				throw new DrinkException(new String[]{"messageError","거래처 입력에 실패했습니다."});
			}
			
			map.put("vendor_no", vendor_no);
			
			gdi.update("Vendor.detailInsert", map.getMap());
			gdi.update("Vendor.vendor_userInsert", map.getMap());
			
		}else{
			int rtCnt = gdi.update("Vendor.masterUpdate", map.getMap());
			if(rtCnt < 1){
				throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
			}
			logger.debug("ext_emmp_no1="+ map.get("ext_emp_no")+", emmp_no1=" + map.get("empno"));
			
			if(!map.get("ext_emp_no").equals(map.get("empno"))) {
				logger.debug("detailUpdate ");
				int rtCntDetail = gdi.update("Vendor.detailUpdate", map.getMap());
				if(rtCntDetail < 1){
					throw new DrinkException(new String[]{"messageError"," 이력 수정에 실패 했습니다."});
				}
				gdi.update("Vendor.detailInsert", map.getMap());
				
			}
			logger.debug("detailUpdate skip");
			int rtCntUser = gdi.update("Vendor.vendor_userUpdate", map.getMap()); 
			
			if(rtCntUser < 1){
				throw new DrinkException(new String[]{"messageError"," 거래처 담당자 정보 수정에 실패 했습니다."});
			}
			
		}
		
	}
	
	public DataMap vendorView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Vendor.getVendorView",map.getMap());
		
		return param;
	}
	
	public List getWholesaleVendorList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Vendor.getWholesaleVendorList",param);
		
		return param;
	}
	
}
