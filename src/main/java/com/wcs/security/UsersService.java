package com.wcs.security;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.wcs.repository.MemberRepository;


@Service
public class UsersService implements UserDetailsService {

	@Autowired
	MemberRepository repo;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		return  
			Optional.ofNullable(repo.findOne(username))
			.filter(m -> m != null)
			.map(m -> new SecurityUser(m)).get();
		
	}

}
