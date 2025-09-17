package com.vvs.platform.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vvs.platform.dao.user.LoginDAO;
import com.vvs.platform.dto.user.LoginDTO;
import com.vvs.platform.service.user.LoginService;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private LoginDAO loginDAO;

    //private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public LoginDTO login(String userid, String password) {
        LoginDTO user = loginDAO.login(userid);
        if (user != null && user.getPassword().equals(password)) {
            return user; // 로그인 성공
        }
        return null; // 실패
    }

}

