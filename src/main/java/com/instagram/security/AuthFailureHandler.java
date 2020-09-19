package com.instagram.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;
 

import com.fasterxml.jackson.databind.ObjectMapper;
import com.instagram.dto.LoginLog;
import com.instagram.service.SecurityService;
 
/**
 * 로그인 실패 핸들러
 */
@Component
public class AuthFailureHandler implements AuthenticationFailureHandler  {
    
    @Autowired
    SecurityService securityService;
    
    private static final Logger logger = LoggerFactory.getLogger(AuthFailureHandler.class);
    
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        
       
        logger.info(" :::::::::::::::::::::::::::: 로그인실패 :::::::::::::::::::::::: ");
        
        String id = "";
        String msg = "";
 
        try {
            
            id = exception.getMessage();
            
            if(securityService.getSelectMeberInfo(id) != null) {
            
                msg="비밀번호가 틀렸습니다.";
            }else {
                msg="아이디가 없습니다.";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    
        response.sendRedirect("/login?msg="+msg);
    }
 
}


