package com.vvs.platform.dao.user;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.vvs.platform.dto.user.KeywordDTO;
import com.vvs.platform.dto.user.UserSignUpDTO;

@Repository
public class UserSignUpDAO {

	@Autowired
    private SqlSessionTemplate sqlSession; 

    public int insertUser(UserSignUpDTO userDTO) {
        return sqlSession.insert("com.vvs.platform.mapper.SignUpMapper.insertUser", userDTO);
    }

    public void insertUserKeyword(String userId, int keywordId) {
    	Map<String, Object> param = new HashMap<>();
    	param.put("userId", userId);
    	param.put("keywordId", keywordId);
    	sqlSession.insert("com.vvs.platform.mapper.SignUpMapper.insertUserKeyword", param);

    }
    //전체 키워드 조회
    public List<KeywordDTO> getAllKeywords() {
        return sqlSession.selectList("com.vvs.platform.mapper.SignUpMapper.getAllKeywords");
    }
    //인증키로 사용자 조회
    public UserSignUpDTO selectUserByAuthKey(String authKey) {
    	return sqlSession.selectOne("com.vvs.platform.mapper.SignUpMapper.selectUserByAuthKey", authKey);
    }
    //인증 완료 처리
    public int updateAuthStatus(String authKey) {
    	return sqlSession.update("com.vvs.platform.mapper.SignUpMapper.updateAuthStatus", authKey);
    }
}
    
