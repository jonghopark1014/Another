package com.example.another_back.service;

import com.example.another_back.dto.UserJoinDto;
import com.example.another_back.entity.enums.Role;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class UserServiceTest {

    @Autowired
    private UserService userService;

    @Test
    void 회원가입() throws IOException {
        UserJoinDto dto = UserJoinDto.builder()
                .exp(0)
                .level(1)
                .role(Role.USER)
                .sex("Female")
                .height(128)
                .nickname("응애")
                .password("1234")
                .weight(128)
                .username("abcd")
                .build();
        userService.join(dto);
    }
}