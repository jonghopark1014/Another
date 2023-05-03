package com.example.another_back.service;

import com.example.another_back.dto.UserJoinDto;
import com.example.another_back.dto.UserLevelExpDto;
import com.example.another_back.entity.User;
import com.example.another_back.entity.enums.Role;
import com.example.another_back.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final S3UploaderService s3UploaderService;
    private final BCryptPasswordEncoder passwordEncoder;

    /*
    닉네임 중복 API만들기
     */
    public boolean checkDuplicatedNickname(String nickname) {
        Optional<User> user = userRepository.findUserByNickname(nickname);
        return user.isEmpty();
    }

    //유저 Level, EXP 가져오기
    public UserLevelExpDto getUserLevelExp(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 유저가 존재하지 않습니다."));
        return UserLevelExpDto.builder()
                .level(user.getLevel())
                .exp(user.getExp())
                .build();
    }

    /*
    닉네임 2글자 ~ 8글자
    비밀번호 8~16(영어,숫자,특수문자) 3개다 포함
    이메일은 골뱅이다음 두글자이상. 두글자이상
     */
    public Long join(UserJoinDto userJoinDto) throws IOException {
        checkDuplicatedUsername(userJoinDto.getUsername());
        String imageURL;
//        imageURL = s3UploaderService.upload(userJoinDto.getProfilePic(), "ssafy308-another", "image");

        User user = User.builder()
                .height(userJoinDto.getHeight())
                .sex(userJoinDto.getSex())
                .exp(0)
                .level(1)
                .password(passwordEncoder.encode(userJoinDto.getPassword()))
                .weight(userJoinDto.getWeight())
                .username(userJoinDto.getUsername())
                .nickname(userJoinDto.getNickname())
                .role(Role.USER)
                .build();
        return userRepository.save(user).getId();
    }

    private void checkDuplicatedUsername(String username) {
        if (!userRepository.findUserByUsername(username).isEmpty()) {
            String username1 = userRepository.findUserByUsername(username).get().getUsername();
            throw new IllegalArgumentException("해당 유저가 이미 존재합니다. : "+username1);
        }
    }
}
