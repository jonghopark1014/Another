package com.example.another_back.service;

import com.example.another_back.hdfs.FileIO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

@Service
@RequiredArgsConstructor
@Slf4j
public class VersusService {

    /**
     * 경쟁 시작
     *
     * @param runningId
     * @return JSONArray
     */
    public JSONArray getVersusData(String runningId) {
        JSONArray response = new JSONArray();
        try {
            FileIO fileIO = new FileIO();
            // HDFS 파일 시스템 객체 생성

            FileSystem fs = FileSystem.get(fileIO.getConf());

            // 파일 경로 설정
            Path filePath = new Path(fileIO.versusData(runningId));

            // 파일 목록 가져오기
            FileStatus[] fileStatuses = fs.globStatus(filePath);
            // 파일 읽기
            JSONParser parser = new JSONParser();
            for (FileStatus fileStatus : fileStatuses) {
                Path path = fileStatus.getPath();
                // 파일 읽기 코드 작성
                BufferedReader br = new BufferedReader(new InputStreamReader(fs.open(path)));
                String line;
                JSONObject jsonObject ;

                while ((line = br.readLine()) != null) {
                    if(line==null)break;
                    // json 형태로 변환
                    jsonObject = (JSONObject) parser.parse(line);
                    response.add(jsonObject);
                }
                br.close();
                if(response.isEmpty())
                    new IllegalArgumentException("해당 러닝기록이 비어있습니다.");
            }
        } catch (IOException e) {
            new IllegalArgumentException("러닝기록을 읽어오는 부분에서 에러가 발생했습니다.");
        }
        catch (ParseException e) {
            new IllegalArgumentException("Json 변환 과정에서 에러가 발생했습니다.");
        }
        return response;
    }
}
