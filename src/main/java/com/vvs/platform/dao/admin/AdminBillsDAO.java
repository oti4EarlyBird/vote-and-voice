package com.vvs.platform.dao.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.vvs.platform.dto.admin.AdminBillsDTO;

@Mapper
public interface AdminBillsDAO {

    /** Oracle INSERT ALL 배치 */
    int insertBatch(@Param("list") List<AdminBillsDTO> list);

    /** (옵션) 중복 방지용 MERGE (BILL_NUMBER 유니크일 때) */
    int mergeOne(AdminBillsDTO bill);
}