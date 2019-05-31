package com.wcs.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.java.Log;

@Log
public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	
	public LoginSuccessHandler(String defaultTargetUrl) {
        setDefaultTargetUrl(defaultTargetUrl);
    }
	
	@Override
	protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response) {

		log.info("--------------determineTargetUrl------------------------");

		Object dest = request.getSession().getAttribute("dest");

		String nextURL = null;
		
		if (dest != null) {

			request.getSession().removeAttribute("dest");
			
			nextURL = (String) dest;

		} else {

			nextURL = super.determineTargetUrl(request, response);
		}
		
		log.info("-------------------"+nextURL+"========================");
		return nextURL;
	}
	
	 @Override
	 public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, 
	    	Authentication authentication) throws ServletException, IOException {
	        HttpSession session = request.getSession();
	        if (session != null) {
	            String redirectUrl = (String) session.getAttribute("prevPage");
	            if (redirectUrl != null) {
	                session.removeAttribute("prevPage");
	                getRedirectStrategy().sendRedirect(request, response, redirectUrl);
	            } else {
	                super.onAuthenticationSuccess(request, response, authentication);
	            }
	        } else {
	            super.onAuthenticationSuccess(request, response, authentication);
	        }
	    }
	 
}
