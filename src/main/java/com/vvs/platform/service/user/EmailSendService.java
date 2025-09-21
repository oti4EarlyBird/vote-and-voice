package com.vvs.platform.service.user;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmailSendService {

    private final JavaMailSender mailSender;

    // 이메일로 인증코드 전송
    public String sendAuthCode(String toEmail) {
        String code = generateCode(); // 6자리 코드 생성
        try {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, "UTF-8");
        helper.setFrom("parkjihae698@gmail.com");
        helper.setTo(toEmail);
        helper.setSubject("Vote & Voice 이메일 인증 코드");
        helper.setText("인증 코드: " + code);
        mailSender.send(message);
        } catch (MailException | MessagingException e) {
        	e.printStackTrace();
        	return null;
        }
        return code; // 세션에 저장해서 확인용
    }

    private String generateCode() {
        return String.valueOf((int)(Math.random() * 900000) + 100000); // 6자리 난수
    }

}
