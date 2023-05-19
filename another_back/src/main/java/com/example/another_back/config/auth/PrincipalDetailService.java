package com.example.another_back.config.auth;

import com.example.another_back.entity.User;
import com.example.another_back.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

//시큐리티 설정에서 loginProcessingUrl("/login");
// /login 요청이 오면 자동으로 UserDetailsService 타입으로 IoC되어 있는 loadUserByUsername 메소드 실행
@Service
@RequiredArgsConstructor
public class PrincipalDetailService implements UserDetailsService {

    private final UserRepository userRepository;

    //현재 메소드의 username은 프론트의 input name="username"의 username이므로 동일하게 세팅해야함
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findUserByUsername(username)
                .orElseThrow(()->new IllegalArgumentException("해당 유저가 존재하지 않습니다."));
        System.out.println("UserDetial이 잘 받아짐" + user.getUsername());
        return new PrincipalDetails(user);
    }
}
