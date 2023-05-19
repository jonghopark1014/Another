package com.example.another_back.config;

import com.example.another_back.entity.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.context.annotation.Configuration;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static com.example.another_back.filter.JwtProperties.*;

@Configuration
public class JwtProvider {
    public String createAccessToken(User user) {
        Map<String, Object> headers = new HashMap<>();

        //Header부분 설정
        headers.put("typ", "JWT");
        headers.put("alg", "HS256");

        //payload부분 설정
        Map<String, Object> payloads = new HashMap<>();
        payloads.put("userId", user.getId());
        payloads.put("role", user.getRole().toString());
        payloads.put("nickname", user.getNickname());

        Date atExt = new Date(); // 토큰 만료 시간
        atExt.setTime(atExt.getTime() + AT_EXPIRATION_TIME);

        String jwt = Jwts.builder()
                .setSubject("access-token") //토큰 용도
                .setHeader(headers) // header 설정
                .setClaims(payloads) // claims 설정
                .setExpiration(atExt) //토큰 만료시간 설정
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY.getBytes())  //HS256과 key로 sign
                .compact(); //토큰생성
        return jwt;
    }


    public String createRefreshToken(User user) {
        Map<String, Object> headers = new HashMap<>();

        //Header부분 설정
        headers.put("typ", "JWT");
        headers.put("alg", "HS256");

        //payload부분 설정
        Map<String, Object> payloads = new HashMap<>();
        payloads.put("userId", user.getId());
        payloads.put("role", user.getRole().toString());
        payloads.put("nickname", user.getNickname());
        payloads.put("weight", user.getWeight());
        payloads.put("height", user.getHeight());

        Date atExt = new Date(); // 토큰 만료 시간
        atExt.setTime(atExt.getTime() + RT_EXPIRATION_TIME);

        String jwt = Jwts.builder()
                .setSubject("refresh-token") //토큰 용도
                .setHeader(headers) // header 설정
                .setClaims(payloads) // claims 설정
                .setExpiration(atExt) //토큰 만료시간 설정
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY.getBytes())  //HS256과 key로 sign
                .compact(); //토큰생성
        return jwt;
    }

    public Claims getClaim(String token){
        return Jwts.parserBuilder()
                .setSigningKey(SECRET_KEY.getBytes())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }
}
