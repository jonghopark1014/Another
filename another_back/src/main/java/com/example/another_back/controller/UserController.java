package com.example.another_back.controller;

import com.example.another_back.dto.UserJoinDto;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.UserService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/user")
public class UserController {
/*
, consumes =
            {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE}
 */
    private final UserService userService;
    @PostMapping(value = "/join")
    public ResponseEntity join(@RequestBody @Valid UserJoinDto userJoinDto, BindingResult result, Model model) {
        if (result.hasErrors()) {
            //회원가입 실패시 입력 데이터 값을 유지
            model.addAttribute("userJoinDto", userJoinDto);

            //유효성 통과 못한 필드와 메세지를 핸들링
            Map<String, String> validatorResult = userService.validateHandling(result);
            for (String key : validatorResult.keySet()) {
                model.addAttribute(key, validatorResult.get(key));
            }
            return Response.error(HttpStatus.BAD_REQUEST, validatorResult);
        }
        Long userId = userService.join(userJoinDto);

        return Response.success(HttpStatus.OK);
    }
    @GetMapping(value = "/test")
    public String test(@RequestBody UserJoinDto userJoinDto) throws IOException {
        return "abcd";
    }

    @GetMapping(value = "/duplicate/nickname/{nickname}")
    @ApiOperation(value = "false : 이미 있음, true : 없음")
    public ResponseEntity checkDuplicatedNickname(@PathVariable("nickname") String nickname) {
        return Response.success(HttpStatus.OK,userService.checkDuplicatedNickname(nickname));
    }
}
