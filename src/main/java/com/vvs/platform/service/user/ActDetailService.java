package com.vvs.platform.service.user;

import org.springframework.stereotype.Service;

import com.vvs.platform.dao.user.ActDetailDAO;
import com.vvs.platform.dto.user.ActDetailDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ActDetailService {
	private final ActDetailDAO actDetailDAO;

    public ActDetailDTO getBillDetail(int billBoardId) {
        return actDetailDAO.getBillDetailById(billBoardId);
    }
}
