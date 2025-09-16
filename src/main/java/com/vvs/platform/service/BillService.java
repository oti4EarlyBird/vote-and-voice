package com.vvs.platform.service;

import java.io.IOException;
import java.util.List;

import javax.websocket.server.ServerEndpoint;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vvs.platform.controller.user.UserController;
import com.vvs.platform.dao.BillDAO;
import com.vvs.platform.dto.bill.AllBillDTO;
import com.vvs.platform.dto.bill.BillConf;
import com.vvs.platform.dto.bill.NayjnliqaexiioauyDTO;
import com.vvs.platform.dto.bill.NcocpgfiaoituanbrDTO;
import com.vvs.platform.dto.bill.WebcastvconfDTO;

import lombok.extern.slf4j.Slf4j;




@Slf4j
@Component
public class BillService {
	// Log
	private static final Logger logger = LogManager.getLogger(BillService.class);
	
	private final BillConf billConf;
	public BillService(BillConf billConf) {
		this.billConf = billConf;
	}
	// DAO
	@Autowired
	BillDAO billDAO;
	
	// 의안 통합 
	public void allBill() { 
		logger.info("BillService allBill() 호출 ");

		
		RestTemplate restTemplate = new RestTemplate();
		billConf.setBillNo("2123836"); 		//의안번호 필수 입력
		String url = "https://open.assembly.go.kr/portal/openapi/ALLBILL?key="+billConf.getKey()+"&type="+billConf.getType()+"&pindex="+billConf.getPindex()+"&psize="+billConf.getPSize()+"&bill_no="+billConf.getBillNo();
		ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
		
		//System.out.println(response);
		//System.out.println(response.getBody());  // Json형태의 문자열 반환
		
		String jsonStr = response.getBody();
		
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode root = mapper.readTree(jsonStr);
			// ALLBILL 배열 접근
			JsonNode allBillArray = root.path("ALLBILL");
			if(allBillArray.isArray() && allBillArray.size()>1) {
				JsonNode rowArray = allBillArray.get(1).path("row");
				if(rowArray.isArray()) {
					//List<AllBillDTO> billList = mapper.readerFor(new TypeReference<List<AllBillDTO>>() {}).readValue(rowArray);
					List<AllBillDTO> billList = mapper.readValue(rowArray.toString(), new TypeReference<List<AllBillDTO>>() {});

					//System.out.println(billList);
					
					
					for (AllBillDTO dto : billList) {
						System.out.println(dto.getBillId()); // Lombok @ToString 있으면 자동으로 모든 필드 출력됨
					}
				}else {
					logger.error("row 데이터가 배열이 아닙니다." + rowArray);
					log.debug("row 데이터가 배열이 아닙니다." + rowArray);
				}
			}else {
				logger.error("ALLBILL 배열이 없거나 크기가 2 미만입니다.");
				log.debug("ALLBILL 배열이 없거나 크기가 2 미만입니다.");				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	// 법률안 심사 및 처리 
	public void nayjnliqaexiioauy() {
		logger.info("nayjnliqaexiioauy 호출");
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "https://open.assembly.go.kr/portal/openapi/nayjnliqaexiioauy?key="+billConf.getKey()+"&type="+billConf.getType()+"&pindex="+billConf.getPindex()+"&psize="+billConf.getPSize();
		ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
	
		String jsonStr = response.getBody();
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode root = mapper.readTree(jsonStr);
			JsonNode nayArray = root.path("nayjnliqaexiioauy");
			
			if(nayArray.isArray() && nayArray.size()>1) {
				JsonNode rowArray = nayArray.get(1).path("row");
				logger.debug("rowArray: " + rowArray.toString());
				
				if(rowArray.isArray()) {
					List<NayjnliqaexiioauyDTO> nayList = mapper.readerFor(new TypeReference<List<NayjnliqaexiioauyDTO>>() {}).readValue(rowArray);
					
					for (NayjnliqaexiioauyDTO dto : nayList) {
						// DB에 저장 
						try {
							billDAO.insertNayjnliqaexiioauy(dto);
							logger.info("DB저장 성공");
						} catch (Exception e) {
							logger.error("DB저장 실패", dto.getBillId(), e);
							//log.error("DB저장 실패", dto.getBillId(), e);
						}
					}
					
				}else {
					logger.error("row 데이터가 배열이 아닙니다." + rowArray);
					log.debug("row 데이터가 배열이 아닙니다." + rowArray);
				}
			}else {
				logger.error("ALLBILL 배열이 없거나 크기가 2 미만입니다.");
				log.debug("ALLBILL 배열이 없거나 크기가 2 미만입니다.");
			}
			
			
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
	// 의안별 표결 현황: ncocpgfiaoituanbr
	public void ncocpgfiaoituanbr() {
		logger.info("ncocpgfiaoituanbr 호출");
		
		RestTemplate restTemplate = new RestTemplate();
		billConf.setAge("22");	// 대수 입력  필수
		String url = "https://open.assembly.go.kr/portal/openapi/ncocpgfiaoituanbr?key="+billConf.getKey()+"&type="+billConf.getType()+"&pindex="+billConf.getPindex()+"&psize="+billConf.getPSize()+"&age="+billConf.getAge();
		ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
		String jsonStr = response.getBody();
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode root = mapper.readTree(jsonStr);
			JsonNode ncoArray = root.path("ncocpgfiaoituanbr");
			if(ncoArray.isArray() && ncoArray.size()>1) {
				JsonNode rowArray = ncoArray.get(1).path("row");
				if(rowArray.isArray()) {
					List<NcocpgfiaoituanbrDTO> ncoList = mapper.readerFor(new TypeReference<List<NcocpgfiaoituanbrDTO>>() {}).readValue(rowArray);
					
					for(NcocpgfiaoituanbrDTO dto : ncoList) {
						// DB 저장
						billDAO.insertNcocpgfiaoituanbr(dto);
						log.info("ncocpgfiaoituanbr: DB저장 성공");
					}
				}else {
					logger.error("rowArray가 배열이 아닙니다.");					
				}
			}else {
				logger.error("nocArray가 2개 이상이 아닙니다.");
			}
			
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 영상회의 목록 : WEBCASTVCONF
	public void webcastvconf() {
		logger.info("webcastvconf 호출");
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "https://open.assembly.go.kr/portal/openapi/WEBCASTVCONF?key="+billConf.getKey()+"&type="+billConf.getType()+"&pindex="+billConf.getPindex()+"&psize="+billConf.getPSize();
		ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
		String jsonStr = response.getBody();
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			JsonNode root = mapper.readTree(jsonStr);
			JsonNode webArray = root.path("WEBCASTVCONF");
			if(webArray.isArray() & webArray.size()>1) {
				JsonNode rowArray = webArray.get(1).path("row");
				if(rowArray.isArray()) {
					List<WebcastvconfDTO> webList = mapper.readerFor(new TypeReference<List<WebcastvconfDTO>>() {}).readValue(rowArray);
					
					for(WebcastvconfDTO dto : webList) {
						// DB 저장 
						billDAO.insertWebcastvconf(dto);
						logger.info("webcastvconf : DB저장 성공");
					}
					
				}else {
					logger.error("rowArray 배열이 아닙니다." + rowArray);					
				}
			}else {
				logger.error("webArray 배열이 없거나 크기가 2 미만입니다.");
			}
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
}
