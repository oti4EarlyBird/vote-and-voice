package com.vvs.platform.service.user;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vvs.platform.dao.user.UserSignUpDAO;
import com.vvs.platform.dto.user.UserSignUpDTO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SignUpService {

    private final UserSignUpDAO userDAO;

    @Transactional
    public void signUp(UserSignUpDTO userDTO) {
        // 1. 유저 정보 저장
        userDAO.insertUser(userDTO);

        // 2. 선택된 키워드 저장
        if (userDTO.getSelectedKeywords() != null) {
            for (int keywordId : userDTO.getSelectedKeywords()) {
                userDAO.insertUserKeyword(userDTO.getUserId(), keywordId);
            }
        }
    }
}
