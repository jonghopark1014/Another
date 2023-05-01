package com.example.another_back.controller;

import com.example.another_back.dto.Response;
import com.example.another_back.dto.UserJoinDto;
import com.example.another_back.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/user")
public class UserController {

    private final UserService userService;
    @PostMapping(value = "/join", consumes =
            {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity join(UserJoinDto userJoinDto) throws IOException {
        Long userId = userService.join(userJoinDto);

        return Response.success(HttpStatus.OK);
    }
}