package com.vvs.platform.service.admin;

public interface AdminBillsService {
	/** age(회기), pIndex, pSize로 OpenAPI를 읽어와 bill 테이블에 적재 **/
    int importBills(String age, int pIndex, int pSize);
}