/** 
* @ Title: ProductService.java 
* @ Package: com.drink.service.product 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 26. 오전 8:56:09 
* @ Version V0.0 
*/

package com.drink.service.product;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import com.drink.service.brand.BrandService;

@Service("ProductService")
public class ProductService {
	private static final Logger logger = LogManager.getLogger(BrandService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void productInsert(RequestMap map) throws DrinkException{
		
		if(map.getString("brandId").equals("")){
			 throw new DrinkException(new String[]{"messageError","브랜드코드은 필수 값 입니다."});
		}
		if(map.getString("subBrandId").equals("")){
			throw new DrinkException(new String[]{"messageError","서브브랜드코드은 필수 값 입니다."});
		}
		if(map.getString("prodMlCd").equals("")){
			throw new DrinkException(new String[]{"messageError","용량은 필수 값 입니다."});
		}
		if(map.getString("useYn").equals("")){
			throw new DrinkException(new String[]{"messageError","활성화는 필수 값 입니다."});
		}
		if(map.getString("caserate_amt").equals("")){
			throw new DrinkException(new String[]{"messageError","caserate는  필수 값 입니다."});
		}
		logger.debug("service :: " + map.toString());
		int rtCnt = gdi.update("Product.productInsert", map.getMap());
		if(rtCnt < 1){
			throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
		}
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List productList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		if(map.getString("bsearch").equals("")) {
		map.put("brandId", ((String)map.get("brandId")).split(",") );
		}
		
		param = gdi.selectList("Product.getProductList",map.getMap());
		if(map.getInt("perPageNum") !=0 && map.getInt("perPageNum") !=0){
			int TotalCnt = (int) gdi.selectOne("Brand.selectTotalRecords");
			map.put("TotalCnt", TotalCnt);		
			}
		
		return param;
	}
	
	public DataMap productDetail(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		param = (DataMap) gdi.selectOne("Product.getProductDetail",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void productUpdate(RequestMap map) throws DrinkException{
		
		if(map.getString("prodNo").equals("")){
			 throw new DrinkException(new String[]{"messageError","제품No는 필수 값 입니다."});
		}
		if(map.getString("prodMlCd").equals("")){
			throw new DrinkException(new String[]{"messageError","용량은 필수 값 입니다."});
		}
		if(map.getString("useYn").equals("")){
			throw new DrinkException(new String[]{"messageError","활성화는 필수 값 입니다."});
		}
		
		logger.debug("service :: " + map.toString());
		int rtCnt = gdi.update("Product.productUpdate", map.getMap());
		if(rtCnt < 1){
			throw new DrinkException(new String[]{"messageError","수정된 데이터가 없습니다."});
		}
	}
	
	public List prdSearch(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		param = gdi.selectList("Product.getProdSearchList",map.getMap());
		
		return param;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List prdSearchView(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		param = gdi.selectList("Product.getProdSearchView",map.getMap());
		if(map.getInt("perPageNum") !=0 && map.getInt("perPageNum") !=0){
			int TotalCnt = (int) gdi.selectOne("Brand.selectTotalRecords");
			map.put("TotalCnt", TotalCnt);		
		}
		return param;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void prdMenuAdd( Map<String, Object> map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		String vendorId = (String) map.get("vendorId");
		if(vendorId == null || "".equals(vendorId)){
			throw new DrinkException(new String[]{"messageError","업소가 선택 되지 않았습니다."});
		}
		
		List<Map<String, Object>> data = (List<Map<String, Object>>) map.get("_addPram");
		for(int i=0; i< data.size();i++){
			 logger.debug(i+" :: " + data.get(i).toString());
			 Map<String, Object> svMap = (Map<String, Object>) data.get(i);
			 svMap.put("vendorId", vendorId);
			 svMap.put("regId", map.get("regId"));
			gdi.update("Product.prodMenuAdd",svMap);
		}
		
	}
	
	public DataMap prdMenuDetailView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		param = (DataMap) gdi.selectOne("Product.getProdMenuDetail",map.getMap());
		
		return param;
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void prdMenuDetailUpdate( Map<String, Object> map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		String vendorNo = (String) map.get("vendorNo");
		String prodNo = (String) map.get("prodNo");
		String salePrice = (String) map.get("salePrice");
		String saleStaDt = (String) map.get("saleStaDt");
		String saleEndDt = (String) map.get("saleEndDt");
		if(vendorNo == null || "".equals(vendorNo)){
			throw new DrinkException(new String[]{"messageError","필수 데이터가 누락 되었습니다."});
		}
		if(prodNo == null || "".equals(prodNo)){
			throw new DrinkException(new String[]{"messageError","필수 데이터가 누락 되었습니다."});
		}
		if(salePrice == null || "".equals(salePrice)){
			throw new DrinkException(new String[]{"messageError","가격은 필수 입력 데이터 입니다."});
		}
		if(saleStaDt == null || "".equals(saleStaDt)){
			throw new DrinkException(new String[]{"messageError","시작일은 필수 입력 데이터 입니다."});
		}
		if(saleEndDt == null || "".equals(saleEndDt)){
			throw new DrinkException(new String[]{"messageError","종료일은 필수 입력 데이터 입니다."});
		}
		
		gdi.update("Product.prodMenuUpdate",map);		
	}
	
	
	public List prdBrandSearch(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		param = gdi.selectList("Product.getProdBrandSearchList",map.getMap());
		
		return param;
	}
	
	public List prdSubBrandSearch(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		param = gdi.selectList("Product.getProdSubBrandSearchList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List prodBrandSearchList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		param = gdi.selectList("Product.prodBrandSearchList",map.getMap());
		if(map.getInt("perPageNum") !=0 && map.getInt("perPageNum") !=0){
			int TotalCnt = (int) gdi.selectOne("Brand.selectTotalRecords");
			map.put("TotalCnt", TotalCnt);		
		}
		return param;
	}
}