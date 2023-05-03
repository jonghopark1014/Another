package com.example.another_back.service;

import com.example.another_back.dto.RunningResponseDto;
import com.example.another_back.dto.SearchRequestDto;
import com.example.another_back.dto.SearchResponseDto;
import com.example.another_back.entity.Running;
import com.example.another_back.hdfs.FileIO;
import com.example.another_back.repository.RunningRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class VersusService {

    @Value("${data.hdfs-url}")
    private String hdfsUrl;

    @Value("${data.hdfs-port}")
    private String hdfsPort;

    private final RunningRepository runningRepository;

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
            FileSystem fs = FileSystem.get(fileIO.getConf(hdfsUrl, hdfsPort));

            // 파일 경로 설정
            Path filePath = new Path(fileIO.versusData(runningId, hdfsUrl, hdfsPort));

            // 파일 목록 가져오기
            FileStatus[] fileStatuses = fs.globStatus(filePath);
            // 파일 읽기
            JSONParser parser = new JSONParser();
            for (FileStatus fileStatus : fileStatuses) {
                Path path = fileStatus.getPath();
                // 파일 읽기 코드 작성
                BufferedReader br = new BufferedReader(new InputStreamReader(fs.open(path)));
                String line;
                JSONObject jsonObject;

                while ((line = br.readLine()) != null) {
                    // json 형태로 변환
                    jsonObject = (JSONObject) parser.parse(line);
                    response.add(jsonObject);
                }
                br.close();
            }
        } catch (IOException e) {
            new IllegalArgumentException("러닝기록을 읽어오는 부분에서 에러가 발생했습니다.");
        } catch (ParseException e) {
            new IllegalArgumentException("Json 변환 과정에서 에러가 발생했습니다.");
        }
        if (response.isEmpty())
            new IllegalArgumentException("해당 러닝기록이 비어있습니다.");
        return response;
    }

    /**
     * 내 기록 가져오기
     *
     * @param userId
     * @param pageable
     * @return Page<RunningResponseDto>
     */
    public Page<RunningResponseDto> getMyRecord(Long userId, Pageable pageable) {
        List<Running> runningList = runningRepository.findByUserId(userId);
        Page<RunningResponseDto> response = new PageImpl<>(runningList.stream().map(RunningResponseDto::new).collect(Collectors.toList()), pageable, runningList.size());
        return response;
    }

    /**
     * 비슷한 목표 가져오기
     *
     * @param searchRequestDto
     * @param pageable
     * @return Page<SearchResponseDto>
     */
    public Page<SearchResponseDto> getSearchRecord(SearchRequestDto searchRequestDto, Pageable pageable) {
        Float distance = searchRequestDto.getRunningDistance();
        Float time = Float.parseFloat(searchRequestDto.getRunningTime());
        Float distanceBoundary = distance / 10;
        Float startTimeBoundary = time - time / 10;
        Float endTimeBoundary = time + time / 10;
        List<Running> runningList = runningRepository.findByRunningDistanceBetweenAndRunningTimeBetweenAndUserIdNot(distance - distanceBoundary, distance + distanceBoundary, startTimeBoundary.toString(), endTimeBoundary.toString(), searchRequestDto.getUserId());
        Page<SearchResponseDto> response = new PageImpl<>(runningList.stream().map(SearchResponseDto::new).collect(Collectors.toList()), pageable, runningList.size());
        return response;
    }
}
