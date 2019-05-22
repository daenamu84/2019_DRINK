/** 
* @ Title: MainService.java 
* @ Package: com.drink.service.brand 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
* @ Version V0.0 
*/ 
package com.drink.service.member;

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
@Service("MemberService")
public class MemberService {
	private static final Logger logger = LogManager.getLogger(MemberService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;

	
	public List getDeptList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Member.getDeptList",param);
		
		return param;
	}
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List getEmpMList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		logger.debug("map===" + map.getMap());
		param = gdi.selectList("Member.getEmpMList",map.getMap());

		int TotalCnt = (int) gdi.selectOne("Team.selectTotalRecords");
		map.put("TotalCnt", TotalCnt);	
		
		return param;
	}
	
	public DataMap duplicateIDCheck(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Member.duplicateIDCheck",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void memberWork(RequestMap map) throws DrinkException{
		
		logger.debug("map==="+ map.toString());
		DataMap param = new DataMap();
		
		gdi.update("Member.empInsert", map.getMap());
		
		int empNo = 0;
		
		param = (DataMap) gdi.selectOne("Member.getEmpNo",map.getMap());
		
		if(param.getString("EMP_NO")!= ""){
			empNo = param.getInt("EMP_NO");
		}
		
		if(empNo==0) {
			throw new DrinkException(new String[]{"messageError","팀원입력에 실패했습니다."});
		}
		
		map.put("emp_no", empNo);
		gdi.update("Member.empteam_dept_relInsert", map.getMap());
				
		
		List<DataMap> tempList = (List)map.get("mng_dept_no");
		//logger.debug("tempList==="+tempList.size());
		if(tempList.size()>0) {
			for (int i=0;i<tempList.size();i++) {
				logger.debug("1--"+tempList.get(i));
				map.put("deptno",tempList.get(i));
				gdi.update("Member.empteam_mng_dept_relInsert", map.getMap());
			}	
		}
	}
	
	public DataMap memberView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Member.getmemberMView",map.getMap());
		
		return param;
	}
	
	
	public List getMngDeptEmplList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Member.getMngDeptEmplList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void memberupdate(RequestMap map) throws DrinkException{
		
		logger.debug("map==="+ map.toString());
		
		DataMap param = new DataMap();
		String pwd = "";
		param = (DataMap) gdi.selectOne("Member.getEmPassWD",map.getMap());
		
//		if(param.getString("LOGIN_PWD")!= ""){
//			pwd = param.getString("LOGIN_PWD");
//			
//			if(!map.get("login_pwd").equals(pwd)) {
//				throw new DrinkException(new String[]{"messageError","비밀번호가 상이합니다."});
//			}
//		}else {
//			throw new DrinkException(new String[]{"messageError","수정에 실패했습니다.1"});
//		}
		
		int rtCnt = gdi.update("Member.empUpdate", map.getMap());
		if(rtCnt < 1){
			throw new DrinkException(new String[]{"messageError","수정에 실패했습니다.2"});
		}
		
		logger.debug("deptno==="+ map.get("deptno") + ", ex_dept_no="+map.get("ex_dept_no"));
		
		if(!map.getString("deptno").equals(map.getString("ex_dept_no"))) {
			int rtCnt0 = gdi.update("Member.empteam_dept_relUpdate", map.getMap());
			if(rtCnt0 < 1){
				throw new DrinkException(new String[]{"messageError","수정에 실패했습니다.2"});
			}
			
			gdi.update("Member.empteam_dept_relInsert", map.getMap());
		}
		
		List<DataMap> tempList = (List)map.get("mng_dept_no");
		
		if(tempList.size()>0) {
			gdi.update("Member.empteam_mng_dept_relUpdate", map.getMap());
			for (int i=0;i<tempList.size();i++) {
				map.put("deptno",tempList.get(i));
				gdi.update("Member.empteam_mng_dept_relInsert", map.getMap());
			}	
		}
	}
	
	public List getCommonCode(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Code.getCommonCodeList",map.getMap());
		
		return param;
	}
}
