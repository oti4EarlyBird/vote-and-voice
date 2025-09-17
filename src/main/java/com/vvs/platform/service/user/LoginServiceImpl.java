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
        System.out.println("DB 조회 결과: " + user);

        if (user != null) {
            System.out.println("DB userid=" + user.getUserid() 
                             + ", DB password=" + user.getPassword() 
                             + ", 입력 password=" + password);
        }
        if (user != null && user.getPassword().equals(password)) {
            return user; // 로그인 성공
        }
        return null; // 실패
    }

}
