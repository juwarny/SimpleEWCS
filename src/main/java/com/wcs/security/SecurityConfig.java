package com.wcs.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import lombok.extern.java.Log;

@Log
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	DataSource dataSource;

	@Autowired
	UsersService userService;
	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {

		log.info("security config..............");

		
		http.authorizeRequests()
		.antMatchers("/main").permitAll()
		.antMatchers("/boards/topic").permitAll()
		.antMatchers("/dailynews/dnlist").permitAll()
		.antMatchers("/*.js").permitAll()
		.antMatchers("/*.css").permitAll()
		.antMatchers("/*.svg").permitAll()
		.antMatchers("/*.jpg").permitAll()
		.antMatchers("/*.png").permitAll()
		.antMatchers("/boards/blist").hasAnyRole("BASIC", "MANAGER", "ADMIN")
		.antMatchers("/boards/bregister").hasAnyRole("BASIC", "MANAGER", "ADMIN")
		.antMatchers("/updown/**").hasAnyRole("BASIC", "MANAGER", "ADMIN")
		.antMatchers("/chrooms/**").hasAnyRole("BASIC", "MANAGER", "ADMIN");
		
		http.authorizeRequests()
		.antMatchers("/member/signup").permitAll().anyRequest().permitAll();
		
		http.authorizeRequests()
		.antMatchers("/member/signUpResult").permitAll().anyRequest().permitAll();
		
		http.formLogin()
		.loginPage("/signin").successHandler(successHandler());
		
		
		http.exceptionHandling().accessDeniedPage("/accessDenied");
		
		http.logout().logoutUrl("/signout").logoutSuccessUrl("/index").invalidateHttpSession(true);

		
		http.rememberMe()
		    .key("wcs")
		    .userDetailsService(userService)
		    .tokenRepository(getJDBCRepository())
			.tokenValiditySeconds(60 * 60 * 24);	
	}
	
	 
	

	private PersistentTokenRepository getJDBCRepository() {

		JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
		repo.setDataSource(dataSource);
		return repo;
	}	


	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {

		log.info("build Auth global........");

		auth.userDetailsService(userService).passwordEncoder(passwordEncoder());

	}
	
	@Bean
	public AuthenticationSuccessHandler successHandler() {
	    return new LoginSuccessHandler("/index");
	}
}
