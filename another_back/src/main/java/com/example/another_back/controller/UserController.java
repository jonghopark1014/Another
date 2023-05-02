package com.example.another_back.controller;

import com.example.another_back.dto.UserJoinDto;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.UserService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
    @GetMapping(value = "/test")
    public String test(UserJoinDto userJoinDto) throws IOException {
        return "abcd";
    }

    @GetMapping(value = "/duplicate/nickname/{nickname}")
    @ApiOperation(value = "false : 이미 있음, true : 없음")
    public ResponseEntity checkDuplicatedNickname(@PathVariable("nickname") String nickname) {
        return Response.success(HttpStatus.OK,userService.checkDuplicatedNickname(nickname));
    }
}
