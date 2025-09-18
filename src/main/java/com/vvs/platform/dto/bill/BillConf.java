package com.vvs.platform.dto.bill;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
public class BillConf {
	private String key = "0fd123dd4d674de68ddf50b38cd2a5d4";
	private String type = "json";  //기본 : xml
	private int pindex = 1;
	private int pSize = 100;
	private String billNo;
	private String age;
	
	

	
}
