package com.example.another_back.service;

import com.example.another_back.dto.UserJoinDto;
import com.example.another_back.entity.User;
import com.example.another_back.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final S3UploaderService s3UploaderService;

    public Long join(UserJoinDto userJoinDto) throws IOException {
        checkDuplicatedUsername(userJoinDto.getUsername());
        String imageURL;
        imageURL = s3UploaderService.upload(userJoinDto.getProfilePic(), "ssafy308-another", "image");

        User user = User.builder()
                .height(userJoinDto.getHeight())
                .sex(userJoinDto.getSex())
                .exp(0)
                .level(1)
                .weight(userJoinDto.getWeight())
                .username(userJoinDto.getUsername())
                .nickname(userJoinDto.getNickname())
                .profilePic(imageURL)
                .build();
        return userRepository.save(user).getId();
    }

    private void checkDuplicatedUsername(String username) {
        if(!userRepository.findUserByUsername(username).isEmpty()){
            throw new IllegalArgumentException("해당 유저가 이미 존재합니다.");
        }
    }


}
