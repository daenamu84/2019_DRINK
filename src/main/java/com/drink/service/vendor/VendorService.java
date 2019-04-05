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
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List getVendorList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map---"+ map.getMap());
		param = gdi.selectList("Vendor.getVendorList",map.getMap());
		
		if(map.getInt("perPageNum") !=0 && map.getInt("perPageNum") !=0){
			int TotalCnt = (int) gdi.selectOne("Team.selectTotalRecords");
			map.put("TotalCnt", TotalCnt);		
		}
		
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
			
			String[] relr_divs_cd =  (String[]) map.get("relr_divs_cd");
			String[] relr_nm =  (String[]) map.get("relr_nm");
			String[] relr_postion_nm =  (String[]) map.get("relr_postion_nm");
			String[] relr_dept_nm =  (String[]) map.get("relr_dept_nm");
			String[] relr_tel_no =  (String[]) map.get("relr_tel_no");
			String[] relr_email =  (String[]) map.get("relr_email");
			String[] relr_anvs_dt =  (String[]) map.get("relr_anvs_dt");
			String[] etc =  (String[]) map.get("etc");
			
			if(relr_nm.length > 0) {
				for(int k=0; k< relr_nm.length ; k++) {
					if(relr_nm[k] != "") {
						map.put("relr_divs_cd", relr_divs_cd[k]);
						map.put("relr_nm", relr_nm[k]);
						map.put("relr_postion_nm", relr_postion_nm[k]);
						map.put("relr_dept_nm", relr_dept_nm[k]);
						map.put("relr_tel_no", relr_tel_no[k]);
						map.put("relr_email", relr_email[k]);
						map.put("relr_anvs_dt", relr_anvs_dt[k]);
						map.put("etc", etc[k]);
						gdi.update("Vendor.vendor_userInsert", map.getMap());
					}
				}
			}
			
			map.put("reg_folder_nm" ,"/resources/fileimg");
			
			if(!map.getString("apnd_file_divs_cd1").equals("")) {
				map.put("apnd_file_divs_cd" ,"0001");
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd1"));
				gdi.update("Vendor.fileInsert", map.getMap());
			}
			if(!map.getString("apnd_file_divs_cd2").equals("")) {
				map.put("apnd_file_divs_cd" ,"0002");
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd2"));
				gdi.update("Vendor.fileInsert", map.getMap());
			}
			if(!map.getString("apnd_file_divs_cd3").equals("")) {
				map.put("apnd_file_divs_cd" ,"0003");
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd3"));
				gdi.update("Vendor.fileInsert", map.getMap());
			}
			if(!map.getString("apnd_file_divs_cd4").equals("")) {
				map.put("apnd_file_divs_cd" ,"0004");
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd4"));
				gdi.update("Vendor.fileInsert", map.getMap());
			}
			if(!map.getString("apnd_file_divs_cd5").equals("")) {
				map.put("apnd_file_divs_cd" ,"0005");
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd5"));
				gdi.update("Vendor.fileInsert", map.getMap());
			}
			if(!map.getString("apnd_file_divs_cd6").equals("")) {
				map.put("apnd_file_divs_cd" ,"0006");
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd6"));
				gdi.update("Vendor.fileInsert", map.getMap());
			}
			
		
			
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
			
			gdi.update("Vendor.filedelete", map.getMap());
			
			map.put("reg_folder_nm" ,"/resources/fileimg");
			
			if(!map.getString("apnd_file_divs_cd1").equals("")) {
				map.put("apnd_file_divs_cd" ,"0001");
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd1"));
				gdi.update("Vendor.fileInsert", map.getMap());
			}
			if(!map.getString("apnd_file_divs_cd2").equals("")) {
				map.put("apnd_file_divs_cd" ,"0002");
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd2"));
				gdi.update("Vendor.fileInsert", map.getMap());
			}
			if(!map.getString("apnd_file_divs_cd3").equals("")) {
				map.put("apnd_file_divs_cd" ,"0003");
				gdi.update("Vendor.fileInsert", map.getMap());
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd3"));
			}
			if(!map.getString("apnd_file_divs_cd4").equals("")) {
				map.put("apnd_file_divs_cd" ,"0004");
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd4"));
				gdi.update("Vendor.fileInsert", map.getMap());
			}
			if(!map.getString("apnd_file_divs_cd5").equals("")) {
				map.put("apnd_file_divs_cd" ,"0005");
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd5"));
				gdi.update("Vendor.fileInsert", map.getMap());
			}
			if(!map.getString("apnd_file_divs_cd6").equals("")) {
				map.put("apnd_file_divs_cd" ,"0006");
				map.put("reg_file_nm" , map.getString("apnd_file_divs_cd6"));
				gdi.update("Vendor.fileInsert", map.getMap());
			}
			
			
			gdi.update("Vendor.vendor_userdelete", map.getMap());
			
			String[] relr_divs_cd =  (String[]) map.get("relr_divs_cd");
			String[] relr_nm =  (String[]) map.get("relr_nm");
			String[] relr_postion_nm =  (String[]) map.get("relr_postion_nm");
			String[] relr_dept_nm =  (String[]) map.get("relr_dept_nm");
			String[] relr_tel_no =  (String[]) map.get("relr_tel_no");
			String[] relr_email =  (String[]) map.get("relr_email");
			String[] relr_anvs_dt =  (String[]) map.get("relr_anvs_dt");
			String[] etc =  (String[]) map.get("etc");
			
			if(relr_nm.length > 0) {
				for(int k=0; k< relr_nm.length ; k++) {
					if(relr_nm[k] != "") {
						map.put("relr_divs_cd", relr_divs_cd[k]);
						map.put("relr_nm", relr_nm[k]);
						map.put("relr_postion_nm", relr_postion_nm[k]);
						map.put("relr_dept_nm", relr_dept_nm[k]);
						map.put("relr_tel_no", relr_tel_no[k]);
						map.put("relr_email", relr_email[k]);
						map.put("relr_anvs_dt", relr_anvs_dt[k]);
						map.put("etc", etc[k]);
						gdi.update("Vendor.vendor_userInsert", map.getMap());
					}
				}
			}
			
//			int rtCntUser = gdi.update("Vendor.vendor_userUpdate", map.getMap()); 
//			
//			if(rtCntUser < 1){
//				throw new DrinkException(new String[]{"messageError"," 거래처 담당자 정보 수정에 실패 했습니다."});
//			}
			
			
			
		}
		
	}
	
	public DataMap vendorView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Vendor.getVendorView",map.getMap());
		
		return param;
	}
	
	public List vendorViewUser(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Vendor.getVendorViewUser", map.getMap());
		
		return param;
	}
	
	
	public List getWholesaleVendorList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Vendor.getWholesaleVendorList",param);
		
		return param;
	}
	
	public List getVendorFileView(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Vendor.getVendorFileView", map.getMap());
		
		return param;
	}
	
	public List VendorSegList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		logger.debug("map=="+ map.toString());
		
		param = gdi.selectList("Vendor.VendorSegList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List getProPosalLedgerList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map---"+ map.getMap());
		param = gdi.selectList("Proposal.getProPosalLedgerList",map.getMap());
		
		int TotalCnt = (int) gdi.selectOne("Team.selectTotalRecords");
		map.put("TotalCnt", TotalCnt);
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public DataMap getProPosalLedger(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		logger.debug("map---"+ map.getMap());
		param = (DataMap) gdi.selectOne("Proposal.getProPosalLedger",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List getCallLedgerList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map---"+ map.getMap());
		param = gdi.selectList("Call.getCallLedgerList",map.getMap());
		
		int TotalCnt = (int) gdi.selectOne("Team.selectTotalRecords");
		map.put("TotalCnt", TotalCnt);
		
		return param;
	}
}
