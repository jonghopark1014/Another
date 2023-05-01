package com.example.another_back.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

import java.util.List;

@Configuration
public class CorsConfig {

    @Bean
    public CorsFilter corsFilter(){
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(true);
        config.setAllowedOriginPatterns(List.of("*"));   //모든 ip에 응답을 허용하겠다
        config.addAllowedHeader("*");   //모든 header에 응답을 허용하겠다.
        config.addAllowedMethod("*");   //모든 http method에 응답을 허용하겠다.
        config.addExposedHeader("*");
        source.registerCorsConfiguration("/**",config);
        return new CorsFilter(source);
    }

}
