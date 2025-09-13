package com.vvs.platform.service.user;

import java.time.LocalDate;
import java.util.List;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.vvs.platform.dao.user.SignUpKeywordDAO;
import com.vvs.platform.dao.user.UserSignUpDAO;
import com.vvs.platform.dto.user.KeywordDTO;
import com.vvs.platform.dto.user.UserSignUpDTO;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j 
public class SignUpService {
	//의존성 주입
	@Autowired
    private UserSignUpDAO userSignUpDAO;  // 인스턴스 변수로 선언
	@Autowired
    private SignUpKeywordDAO signUpKeywordDAO;
    @Autowired  
    private BCryptPasswordEncoder passwordEncoder;
	// 이메일 형식 검증용 정규식 패턴
    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    
    //사용자 입력값 전체 검증
	public void validateUserInput(UserSignUpDTO usersignupDTO) {
		validateRequiredFields(usersignupDTO);
        validatePasswordMatch(usersignupDTO);
        validateEmailFormat(usersignupDTO.getEmail());
        validateBirthDate(usersignupDTO.getBirth());
		
	}
	//필수 필드 체크
	private void validateRequiredFields(UserSignUpDTO usersignupDTO) {
        if (!StringUtils.hasText(usersignupDTO.getUserId())) {
            throw new IllegalArgumentException("아이디를 입력해주세요.");
        }
        
        if (!StringUtils.hasText(usersignupDTO.getName())) {
            throw new IllegalArgumentException("이름을 입력해주세요.");
        }
        
        if (!StringUtils.hasText(usersignupDTO.getPwd())) {
            throw new IllegalArgumentException("비밀번호를 입력해주세요.");
        }
        
        if (!StringUtils.hasText(usersignupDTO.getPwdConfirm())) {
            throw new IllegalArgumentException("비밀번호 확인을 입력해주세요.");
        }
        
        if (!StringUtils.hasText(usersignupDTO.getEmail())) {
            throw new IllegalArgumentException("이메일을 입력해주세요.");
        }
        
        if (usersignupDTO.getBirth() == null) {
            throw new IllegalArgumentException("생년월일을 입력해주세요.");
        }
    }
	//비밀번호 확인 일치
	private void validatePasswordMatch(UserSignUpDTO usersignupDTO) {
		String password = usersignupDTO.getPwd();
		String passwordConfirm = usersignupDTO.getPwdConfirm();
		if(!password.equals(passwordConfirm)) {
			throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
		}
	}
	//이메일 형식 검증
	private void validateEmailFormat(String email) {
		if(!EMAIL_PATTERN.matcher(email).matches()) {
			throw new IllegalArgumentException("이메일 형식이 올바르지 않습니다.");
		}
	}
	//생년월일 유효성 검증
	private void validateBirthDate(LocalDate birthDate) {
		LocalDate today = LocalDate.now();
		LocalDate minDate = LocalDate.of(1900, 1, 1);
		if(birthDate.isAfter(today)) {
			throw new IllegalArgumentException("생년월일은 오늘 날짜보다 이후일 수 없습니다.");
		}
		if(birthDate.isBefore(minDate)) {
			throw new IllegalArgumentException("생년월일이 너무 과거입니다.");
		}
		// 나이 제한 체크 (만 14세 이상)
        LocalDate minBirthForAge = today.minusYears(14);
        if (birthDate.isAfter(minBirthForAge)) {
            throw new IllegalArgumentException("만 14세 이상만 가입 가능합니다.");
        }
	}
	//중복 체크
	private void checkDuplicateId(String userId) {
		boolean isDuplicate = userSignUpDAO.checkId(userId);
		if(isDuplicate) {
			throw new IllegalArgumentException("이미 사용중인 아이디입니다");
		}
	}
	private void checkDuplicateEmail(String email) {
		boolean isDuplicate = userSignUpDAO.checkEmail(email);
		if(isDuplicate) {
			throw new IllegalArgumentException("이미 사용중인 이메일입니다");
		}
	}
	//비번 암호화
	private String encryptPassword(String plainPassword) {
		return passwordEncoder.encode(plainPassword);
	}
	//회원가입 검증 프로세스
    public void validateSignUpProcess(UserSignUpDTO usersignupDTO) {
        // 1. 입력값 검증
        validateUserInput(usersignupDTO);
        
        // 2. 중복 체크
        checkDuplicateId(usersignupDTO.getUserId());
        checkDuplicateEmail(usersignupDTO.getEmail());
    }
    
    //dto 전처리
    public UserSignUpDTO prepareUserForSignUp(UserSignUpDTO usersignupDTO) {
        // 비밀번호 암호화
        String encryptedPassword = encryptPassword(usersignupDTO.getPwd());
        usersignupDTO.setPwd(encryptedPassword);
        
        // 기본값 설정
        usersignupDTO.setRole("USER");
        usersignupDTO.setAccStatus("ACTIVE");
        usersignupDTO.setNotificationOptIn("Y");
        usersignupDTO.setSignupDate(LocalDate.now());
        
        return usersignupDTO;
    }
	//DB 저장
    //회원가입 기본정보 저장
    private int insertUserInfo(UserSignUpDTO usersignupDTO) {
    	int result = userSignUpDAO.insertUser(usersignupDTO);
    	if(result <= 0 ) {
    		throw new RuntimeException("회원 정보 저장에 실패했습니다.");
    	}
    	log.info("회원 정보 저장에 성공하였습니다: {}", usersignupDTO.getUserId());
    	return result;
    }

	//키워드 저장
    private void insertUserKeywords(String userId, List<KeywordDTO> keywords) {
        if (keywords == null || keywords.isEmpty()) {
            log.info("선택된 키워드가 없어서 키워드 저장을 건너뜁니다: {}", userId);
            return;
        }
        
        int successCount = 0;
        for (KeywordDTO keyword : keywords) {
            keyword.setUserId(userId);  // 사용자 ID 설정
            
            int result = signUpKeywordDAO.insertUserKeyword(keyword);
            if (result > 0) {
                successCount++;
                log.debug("키워드 저장 성공: {} - {}", userId, keyword.getKeyword());
            } else {
                throw new RuntimeException("키워드 저장에 실패했습니다: " + keyword.getKeyword());
            }
        }
        
        log.info("키워드 저장 완료: {} ({}개)", userId, successCount);
    }
    
    //회원가입 메인 메서드
    @Transactional
    public String registerUser(UserSignUpDTO usersignupDTO, List<KeywordDTO> keywords) {
        try {
            log.info("회원가입 시작: {}", usersignupDTO.getUserId());
            
            // 1. 전체 검증 (입력값 + 중복체크)
            validateSignUpProcess(usersignupDTO);
            
            // 2. 전처리 (암호화, 기본값 설정)
            usersignupDTO = prepareUserForSignUp(usersignupDTO);
            
            // 3. 회원 기본정보 저장
            insertUserInfo(usersignupDTO);
            
            // 4. 키워드 저장
            insertUserKeywords(usersignupDTO.getUserId(), keywords);
            
            log.info("회원가입 성공: {}", usersignupDTO.getUserId());
            return "회원가입이 성공적으로 완료되었습니다.";
            
        } catch (IllegalArgumentException e) {
            // 검증 실패 (사용자 입력 오류)
            log.warn("회원가입 검증 실패: {} - {}", usersignupDTO.getUserId(), e.getMessage());
            throw e;
        } catch (Exception e) {
            // 시스템 오류 (DB 저장 실패 등)
            log.error("회원가입 시스템 오류: {} - {}", usersignupDTO.getUserId(), e.getMessage());
            throw new RuntimeException("회원가입 처리 중 오류가 발생했습니다.", e);
        }
        //아이디 중복체크(AJAX)
       public boolean checkUserIdDuplicate(String userId) {
           return userSignUpDAO.checkId(userId);
       }
       
       //이메일 중복 체크(AJAX)
       public boolean checkEmailDuplicate(String email) {
           return userSignUpDAO.checkEmail(email);
    }
}
