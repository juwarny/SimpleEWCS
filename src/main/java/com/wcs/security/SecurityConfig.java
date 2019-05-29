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
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

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
		.antMatchers("/boards/blist").permitAll()
		.antMatchers("/boards/topic").permitAll()
		.antMatchers("/dailynews/dnlist").permitAll()
		.antMatchers("/boards/bregister")
		.hasAnyRole("BASIC", "MANAGER", "ADMIN");
		
		http.authorizeRequests()
		.antMatchers("/member/signup").permitAll().anyRequest().authenticated();
		
		 http.formLogin();
//		http.formLogin()
//		.loginPage("/sign/signin").successHandler(new LoginSuccessHandler());
		
		
		http.exceptionHandling().accessDeniedPage("/sign/accessDenied");
		
		// http.logout().invalidateHttpSession(true);
		http.logout().logoutUrl("/sign/signout").invalidateHttpSession(true);

		// http.userDetailsService(userService);

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

}
