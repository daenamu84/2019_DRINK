/** 
* @ Title: MainService.java 
* @ Package: com.drink.service.brand 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
* @ Version V0.0 
*/ 
package com.drink.service.approval;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
@Service("ApprovalService")
public class ApprovalService {
	private static final Logger logger = LogManager.getLogger(ApprovalService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List getApprovalList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map---"+ map.getMap());
		param = gdi.selectList("Approval.getApprovalList",map.getMap());
		
		if(map.getInt("perPageNum") !=0 && map.getInt("perPageNum") !=0){
			int TotalCnt = (int) gdi.selectOne("Team.selectTotalRecords");
			map.put("TotalCnt", TotalCnt);		
		}
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List getApprovalSignList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map---"+ map.getMap());
		param = gdi.selectList("Approval.getApprovalSignList",map.getMap());
		
		if(map.getInt("perPageNum") !=0 && map.getInt("perPageNum") !=0){
			int TotalCnt = (int) gdi.selectOne("Team.selectTotalRecords");
			map.put("TotalCnt", TotalCnt);		
		}
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void approvalInsert(RequestMap map) throws DrinkException{
		logger.debug("service 111111111 :: " + map.toString());
		
		if(map.getString("appr_ref_no").equals("")){
			map.put("appr_ref_no", null);
		}
		int rtCnt = gdi.update("Approval.approvalInsert", map.getMap());
		
		if(rtCnt < 1){
			throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
		}
		
		DataMap param = new DataMap();
		int appr_no = 0;
		
	/*	param = (DataMap) gdi.selectOne("Approval.getAppr_NO",map.getMap());
		
		if(param.getString("APPR_NO")!= ""){
			appr_no = param.getInt("APPR_NO");
		}*/
		
		map.put("appr_no", map.getString("APPR_NO"));
		
		String[] appSignEmp =  (String[]) map.get("appSignEmp");
		
		if(appSignEmp.length > 0) {
			for(int k=0; k< appSignEmp.length ; k++) {
				if(appSignEmp[k] != "") {
					map.put("appr_sign_seq", (k+1));
					map.put("appr_sign_emp_no", appSignEmp[k]);
					int rtCnt1 = gdi.update("Approval.approval_SignInsert", map.getMap());
					if(rtCnt1 < 1){
						throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
					}
				}
			}
		}
		
		map.put("reg_folder_nm" ,"/resources/fileimg");
		
		if(!map.getString("apnd_file_divs_cd1").equals("")) {
			map.put("apnd_file_divs_cd" ,"0001");
			map.put("reg_file_nm" , map.getString("apnd_file_divs_cd1"));
			gdi.update("Approval.approval_FileInsert", map.getMap());
		}
		
	}
	
	public DataMap approvalView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Approval.getApprovalView",map.getMap());
		
		return param;
	}
	
	public DataMap approvalSignView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Approval.getApprovalSignView",map.getMap());
		
		return param;
	}
	
	public List approvalSignUser(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Approval.approvalSignUser", map.getMap());
		
		return param;
	}
	
	public List approvalComment(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Approval.approvalComment", map.getMap());
		
		return param;
	}
	
	public DataMap getVendorFileView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param =  (DataMap) gdi.selectOne("Approval.getApprovalFileView", map.getMap());
		
		return param;
	}
	
	public List getEmpSignList(RequestMap map)throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Approval.getApproval_SignList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void approvalCommentInsert(RequestMap map) throws DrinkException{
		logger.debug("service 111111111 :: " + map.toString());
		
		if(map.getString("appr_ref_no").equals("")){
			map.put("appr_ref_no", null);
		}
		int rtCnt = gdi.update("Approval.approvalCommentInsert", map.getMap());
		
		if(rtCnt < 1){
			throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
		}
		
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void approvalCommentDelete ( RequestMap map ) throws DrinkException{
		
		logger.debug("service 111111111 :: " + map.toString());
		int rtCnt = gdi.update("Approval.approvalCommentDelete",map.getMap());
		

		if(rtCnt < 1){
			throw new DrinkException(new String[]{"messageError","삭제에 실패했습니다."});
		}
	}
}
