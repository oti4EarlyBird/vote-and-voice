package com.vvs.platform.dao;

import org.apache.ibatis.annotations.Mapper;

import com.vvs.platform.dto.bill.AllBillDTO;
import com.vvs.platform.dto.bill.NayjnliqaexiioauyDTO;
import com.vvs.platform.dto.bill.NcocpgfiaoituanbrDTO;
import com.vvs.platform.dto.bill.WebcastvconfDTO;

@Mapper
public interface BillDAO {

	void insertNayjnliqaexiioauy(NayjnliqaexiioauyDTO dto);

	void insertNcocpgfiaoituanbr(NcocpgfiaoituanbrDTO dto);

	void insertWebcastvconf(WebcastvconfDTO dto);
}
