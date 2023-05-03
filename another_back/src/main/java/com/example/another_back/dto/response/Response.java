package com.example.another_back.dto.response;

import lombok.Builder;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;

public class Response {

    @Getter
    @Builder
    public static class ResponseDto<T> {
        private String status;

        @Nullable
        private T data;
    }

    public static final String SUCCESS = "success";
    public static final String FAIL = "fail";
    public static final String ERROR = "error";

    public static <T> ResponseEntity success(HttpStatus status, @Nullable T body) {
        ResponseDto<Object> responseBody = ResponseDto.builder()
                .status(SUCCESS)
                .data(body)
                .build();
        return ResponseEntity.status(status).body(responseBody);
    }

    public static ResponseEntity success(HttpStatus status) {
        ResponseDto<Object> responseBody = ResponseDto.builder()
                .status(SUCCESS)
                .data(null)
                .build();
        return ResponseEntity.status(status).body(responseBody);
    }

    public static <T> ResponseEntity fail(HttpStatus status, T body) {
        ResponseDto<Object> responseBody = ResponseDto.builder()
                .status(FAIL)
                .data(body)
                .build();
        return ResponseEntity.status(status).body(responseBody);
    }

    public static <T> ResponseEntity error(HttpStatus status, T body) {
        ResponseDto<Object> responseBody = ResponseDto.builder()
                .status(ERROR)
                .data(body)
                .build();
        return ResponseEntity.status(status).body(responseBody);
    }
}
