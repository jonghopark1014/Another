package com.example.another_back.filter;

public interface JwtProperties {
    String SECRET_KEY = "ssafy308_anotherssafy308_anotherssafy308_anotherssafy308_anotherssafy308_anotherssafy308_anotherssafy308_anotherssafy308_anotherssafy308_another"; //비밀키
    long AT_EXPIRATION_TIME = 1000 * 60; // 만료시간 72시간
    long RT_EXPIRATION_TIME = 1000 * 60 * 60 * 24 * 7;    //만료시간 72시간
    String TOKEN_PREFIX = "Bearer ";
    String HEADER_STRING = "Authorization";
    String RT_HEADER_STRING = "Refresh";
}
