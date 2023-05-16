package com.example.another_back.filter;


import com.example.another_back.config.JwtProvider;
import com.example.another_back.config.auth.PrincipalDetails;
import com.example.another_back.dto.LoginResponseDto;
import com.example.another_back.dto.UserLoginDto;
import com.example.another_back.entity.User;
import com.example.another_back.entity.enums.Role;
import com.example.another_back.repository.UserRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static com.example.another_back.filter.JwtProperties.*;

//스프링시큐리티에서 UsernamePasswordAuthenticationFilter가 있음
// login 요청해서 username,password 전송하면
// usernamePasswordAuthenticationFilter 동작을 함.
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends UsernamePasswordAuthenticationFilter {

    private final AuthenticationManager authenticationManager;
    private final UserRepository userRepository;
    private final JwtProvider jwtProvider;

    //login 요청을 하면 로그인 시도를 위해 실행
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
        System.out.println("JwtAuthenticationFilter : 로그인 시도중");
        // 1.username,password 받아서
        // 2.정상인지 로그인 시도
        // 3. authenticationManager로 로그인 시도를 하면 PrincipalDetatilsService가 호출
        // 4. loadUserByUserId()함수 실행됨.
        // 5. PrincipalDetails를 세션에 담고 (만약에 안담으면 권한 관리가 안됨)
        // 6. JWT토큰을 만들어서 응답해주면 됨.
        try {
            ObjectMapper om = new ObjectMapper();   //json Parsing 해줌
            UserLoginDto user = om.readValue(request.getInputStream(), UserLoginDto.class);

            UsernamePasswordAuthenticationToken authenticationToken =
                    new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword());

            System.out.println("토큰 정보 : " + authenticationToken);

            //PrincipalDetailService의 loadUserByUserId() 함수가 실행됨
            //실행 후 정상이면 authentication이 리턴됨.
            //authentication에 로그인한 정보가 담김
            Authentication authentication =
                    authenticationManager.authenticate(authenticationToken);

            //authentication 객체가 session영역에 저장됨 => 로그인이 됨.
            PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();
            System.out.println("로그인 완료됨 : " + principalDetails);

            //authentication 객체가 session에 저장됨
            //return하는 이유는 권한 관리를 security가 대신 해주기 때문에 편해짐.
            //굳이 JWT토큰을 사용하면서 세션을 만들 이유는 없지만 권한 처리 때문에 session에 넣음
            return authentication;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    // attemptAuthentication 실행 후 인증이 정상 처리되면 successfulAuthentication 함수가 실행됨.
    // jwt 토큰을 만들어 request 요청한 사용자에게 jwt토큰 응답하면 됨.
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authResult) throws IOException, ServletException {
        System.out.println("successfulAuthentication 실행됨 : 인증완료");

        PrincipalDetails principalDetails = (PrincipalDetails) authResult.getPrincipal();
        User user =principalDetails.getUser();
        String username = principalDetails.getUser().getUsername();
        Role role = principalDetails.getUser().getRole();

        //HS256 방식으로 암호화
        String jwt = jwtProvider.createAccessToken(user);

        String rft = jwtProvider.createRefreshToken(user);

//        User user = userRepository.findUserByUsername(username)
//                .orElseThrow(() -> new IllegalArgumentException("해당 유저가 존재하지 않습니다."));
        /*
            refreshToken redis방식으로 저장 로직 구현하기
         */
        //user.setRefreshToken(rft);

//        userRepository.save(user);
        LoginResponseDto loginResponse = new LoginResponseDto(principalDetails.getUser());
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.getWriter().write(convertObjectToJson(loginResponse));

        //리스폰스 해더에 Authorization : "", Refresh : ""로 전달
        //키 몸무게 닉네임 담아서 주기
        response.addHeader(HEADER_STRING, TOKEN_PREFIX + jwt);
        response.addHeader(RT_HEADER_STRING, TOKEN_PREFIX + rft);
        response.getWriter().flush();
    }
    public String convertObjectToJson(Object object) throws JsonProcessingException {
        if (object == null) {
            return null;
        }
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(object);
    }
}
