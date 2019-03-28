/** 
* @ Title: CommonConfig.java 
* @ Package: com.drink.commonHandler.util 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 11. 2. 오후 1:34:27 
* @ Version V0.0 
*/
package com.drink.commonHandler.util;

/** 
* @ ClassName: CommonConfig 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 11. 2. 오후 1:34:27 
*  
*/
public class CommonConfig {
	public enum Paging {
		RECORDSPERPAGE(5), CURRENTPAGENO(1), SIZEOFPAGE(5);

		private int value;

		Paging(int value) {
			this.value = value;
		}

		public int getValue() {
			return this.value;
		}
	};
}
