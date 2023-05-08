package com.example.another_back.service;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class S3UploaderService {
    private final AmazonS3Client amazonS3Client;

    public List<String> upload(String bucket, String dirName, MultipartFile... multipartFile) throws IOException {
        List<String> list = new ArrayList<>();
        for (int i = 0; i < multipartFile.length; i++) {
            String fileName = dirName + "/" + UUID.randomUUID() + multipartFile[i].getOriginalFilename();

            ObjectMetadata objMeta = new ObjectMetadata();
            objMeta.setContentLength(multipartFile[i].getInputStream().available());

            amazonS3Client.putObject(bucket, fileName, multipartFile[i].getInputStream(), objMeta);
            list.add(amazonS3Client.getUrl(bucket, fileName).toString());
        }
        return list;
    }
}
