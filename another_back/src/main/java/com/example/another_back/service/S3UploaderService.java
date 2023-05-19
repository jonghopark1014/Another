package com.example.another_back.service;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class S3UploaderService {

    @Value("${spring.environment}")
    private String environment;

    @Value("${spring.file-dir}")
    private String rootDir;
    private String fileDir;

    private final AmazonS3Client amazonS3Client;

    @PostConstruct
    private void init(){
        if(environment.equals("local")){
            this.fileDir = System.getProperty("user.dir") + this.rootDir;
        }
        else if(environment.equals("development")) {
            this.fileDir = this.rootDir;
        }
    }

    public List<String> upload(String bucket, String dirName, MultipartFile... multipartFile) throws IOException {
        ArrayList<File> list = new ArrayList<>();

        for (MultipartFile file : multipartFile) {
            list.add(convert(file)
                    .orElseThrow(()->new IllegalArgumentException("error : MultipartFile Convert 실패")));
        }

        return upload(bucket, dirName, list);
    }

    public List<String> upload(String bucket, String dirName, ArrayList<File> list) {
        ArrayList<String> lists = new ArrayList<>();
        for (File file : list) {
            String fileName = dirName + "/" + UUID.randomUUID() + file.getName();
            String uploadImageUrl = putS3(file, bucket, fileName);
            removeNewFile(file);

            lists.add(uploadImageUrl);
        }
        return lists;
    }

    private String putS3(File uploadFile, String bucket, String fileName) {
        amazonS3Client.putObject(new PutObjectRequest(bucket, fileName,uploadFile)
                .withCannedAcl(CannedAccessControlList.PublicRead));
        return amazonS3Client.getUrl(bucket, fileName).toString();
    }

    private void removeNewFile(File targetFile) {
        targetFile.delete();
        log.info("File delete fail");
    }

    private Optional<File> convert(MultipartFile multipartFile) throws IOException {
        if (multipartFile.isEmpty()) {
            return Optional.empty();
        }

        String originalFileName = multipartFile.getOriginalFilename();
        String storeFileName = createStoreFileName(originalFileName);

        File folder = new File(fileDir);

        if (!folder.exists()) {
            try{
                folder.mkdir(); //폴더 생성합니다.
            }
            catch(Exception e){
                e.getStackTrace();
            }
        }

        //파일 업로드
        File file = new File(fileDir + storeFileName);

        multipartFile.transferTo(file);

        return Optional.of(file);
    }

    private String createStoreFileName(String originalFileName) {
        String ext = extractExt(originalFileName);
        String uuid = UUID.randomUUID().toString();
        return uuid + "." + ext;
    }

    private String extractExt(String originalFileName) {
        int pos = originalFileName.lastIndexOf(".");
        return originalFileName.substring(pos + 1);
    }

}
