package com.example.another_back.dto;

import lombok.Data;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

@Data
public class UserUpdateForm {

    @NotBlank
    @Pattern(regexp = "^[ㄱ-ㅎ가-힣a-z0-9-_]{2,10}$", message = "닉네임은 특수문자를 제외한 2~10자리여야 합니다.")
    private String nickname;

    @Min(value = 1, message = "1자리보다 작은 키는 안돼요")
    @Max(value = 999, message = "3자리 넘는 키는 안돼요")
    private Integer weight;

    @Min(value = 1, message = "1자리보다 작은 키는 안돼요")
    @Max(value = 999, message = "3자리 넘는 키는 안돼요")
    private Integer height;
}
