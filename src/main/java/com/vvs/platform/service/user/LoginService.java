package com.vvs.platform.service.user;

import com.vvs.platform.dto.user.LoginDTO;

public interface LoginService {
    LoginDTO login(String userid, String password);
}