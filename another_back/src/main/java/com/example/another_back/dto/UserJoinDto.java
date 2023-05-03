package com.example.another_back.dto;

import lombok.*;

import javax.validation.constraints.*;

@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserJoinDto {

    @Email(message = "이메일 주소 형식이 올바르지 않습니다.")
    @NotBlank
    private String username;

    @NotNull(message = "비밀번호는 필수 입력 값입니다.")
    @Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}", message = "비밀번호는 8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.")
    private String password;

    @NotBlank
    @Pattern(regexp = "^[ㄱ-ㅎ가-힣a-z0-9-_]{2,10}$", message = "닉네임은 특수문자를 제외한 2~10자리여야 합니다.")
    private String nickname;

    @Min(value = 1, message = "1자리보다 작은 키는 안돼요")
    @Max(value = 999, message = "3자리 넘는 키는 안돼요")
    private Integer height;

    @Min(value = 1, message = "1자리보다 작은 몸무게는 안돼요")
    @Max(value = 999, message = "3자리 넘는 몸무게는 안돼요")
    private Integer weight;

    @Pattern(regexp = "^(MALE|FEMALE)$", message = "성별은 MALE 아니면 FEMALE입니다.")
    private String sex;
}
