package com.example.another_back.service;

import com.example.another_back.dto.UserLevelExpDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Transactional
class UserServiceTest {

    @Autowired
    private UserService userService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

//    @Commit
//    @Test
//    void 회원가입() throws IOException {
//        UserJoinDto dto = UserJoinDto.builder()
//                .height(123)
//                .password(passwordEncoder.encode("1234"))
//                .weight(123)
//                .sex("FEMALE")
//                .username("ssafy@ssafy.com")
//                .build();
//        Long join = userService.join(dto);
//        assertThat(join).isEqualTo(12);
//    }

    @Test
    void 레벨경험치가져오기() throws IOException {
        UserLevelExpDto userLevelExp = userService.getUserLevelExp(11L);
        assertThat(userLevelExp.getLevel()).isEqualTo(1);
        assertThat(userLevelExp.getExp()).isEqualTo(10);
    }
}