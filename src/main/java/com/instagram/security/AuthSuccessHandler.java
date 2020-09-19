package com.instagram.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.instagram.dto.LoginLog;
import com.instagram.service.SecurityService;
 

 
/*
 * 스프링 시큐리티를 사용하며, 로그인 성공시 부가 작업을 하려면, 
 * org.springframework.security.web.authentication.AuthenticationSuccessHandler를 구현해야 한다.
 *별도로 authenticationSuccessHandler를 지정하지 않으면 기본적으로 
 * org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler를 사용하게 된다.
 */
 
@Component
public class AuthSuccessHandler extends SimpleUrlAuthenticationSuccessHandler{
    
    private static final Logger logger = LoggerFactory.getLogger(AuthSuccessHandler.class);
    
    @Autowired
    SecurityService securityService;
 
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException{
      
        
        logger.info("::::::::::::::::::::::::::::: 로그인 성공 ::::::::::::::::::::::::::::: ");
        LoginLog loginLog = new LoginLog();
        String id = "";
        try {
            
            id = authentication.getName().toString();                        
            securityService.setUpdatePasswordLockCntReset(id);            
            
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        super.setDefaultTargetUrl("/");
        super.onAuthenticationSuccess(request, response, authentication);
    }
 
}


