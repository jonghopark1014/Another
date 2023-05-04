package com.example.another_back.controller;

import com.example.another_back.dto.UserJoinDto;
import com.example.another_back.dto.UserUpdateForm;
import com.example.another_back.dto.response.Response;
import com.example.another_back.service.UserService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.jetbrains.annotations.Nullable;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/user")
public class UserController {
/*

 */
    private final UserService userService;
    @PostMapping(value = "/join")
    public ResponseEntity join(@RequestBody @Valid UserJoinDto userJoinDto, BindingResult result, Model model) {
        ResponseEntity BAD_REQUEST = getErrors(result);
        if (BAD_REQUEST != null) return BAD_REQUEST;
        Long userId = userService.join(userJoinDto);

        return Response.success(HttpStatus.OK);
    }
    @PatchMapping(value = "profile/image/{userId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity updateProfileImage(@PathVariable("userId") Long userId, @RequestParam("profileImage") MultipartFile file) throws IOException {
        String image = userService.updateProfileImage(file, userId);
        return Response.success(HttpStatus.OK, image);
    }

    @PatchMapping(value = "profile/{userId}")
    public ResponseEntity updateUser(@PathVariable Long userId, @RequestBody @Valid UserUpdateForm userUpdateForm, BindingResult result) {
        ResponseEntity BAD_REQUEST = getErrors(result);
        if (BAD_REQUEST != null) return BAD_REQUEST;
        userService.updateUser(userId, userUpdateForm);
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

    @Nullable
    private ResponseEntity getErrors(BindingResult result) {
        if (result.hasErrors()) {
            //유효성 통과 못한 필드와 메세지를 핸들링
            Map<String, String> validatorResult = userService.validateHandling(result);
            return Response.error(HttpStatus.BAD_REQUEST, validatorResult);
        }
        return null;
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity IllegalArgumentException(IllegalArgumentException e){
        return Response.fail(HttpStatus.BAD_REQUEST, e.getMessage());
    }
}
