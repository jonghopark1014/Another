package com.example.another_back.service;

import com.example.another_back.dto.*;
import com.example.another_back.entity.FeedPic;
import com.example.another_back.entity.Running;
import com.example.another_back.entity.User;
import com.example.another_back.entity.enums.Status;
import com.example.another_back.hdfs.FileIO;
import com.example.another_back.repository.FeedPicRepository;
import com.example.another_back.repository.RunningRepository;
import com.example.another_back.repository.UserRepository;
import com.example.another_back.repository.WithRunRepository;
import lombok.RequiredArgsConstructor;
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
public class FeedService {
    @Value("${data.hdfs-url}")
    private String hdfsUrl;

    @Value("${data.hdfs-port}")
    private String hdfsPort;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    private final UserRepository userRepository;

    private final RunningRepository runningRepository;

    private final FeedPicRepository feedPicRepository;

    private final S3UploaderService s3UploaderService;

    private final WithRunRepository withRunRepository;

    /**
     * 오운완 등록
     *
     * @param addFeedRequestDto
     * @return String
     * @throws IOException
     */
    public String addFeed(AddFeedRequestDto addFeedRequestDto) throws IOException {
        Running running = runningRepository.findById(addFeedRequestDto.getRunningId())
                .orElseThrow(() -> new IllegalArgumentException("해당 러닝기록을 찾지 못했습니다."));
        running.setStatus(Status.LIVE);
        List<String> list = s3UploaderService.upload(bucket, "image", addFeedRequestDto.getFeedPics());
        for (String url :
                list) {
            FeedPic feedPic = new FeedPic(url, running);
            feedPicRepository.save(feedPic);
        }
        return running.getId();
    }

    /**
     * 피드 리스트 기능
     *
     * @param pageable
     * @return Page<RunningResponseDto>
     */
    public Page<FeedListResponseDto> getFeedList(Pageable pageable) {
        List<Running> feedList = runningRepository.findRunningByStatusWithFeedPics(Status.LIVE);
        Page<FeedListResponseDto> feedListResponseDtos = new PageImpl<>(feedList.stream().map(FeedListResponseDto::new).collect(Collectors.toList()), pageable, feedList.size());
        return feedListResponseDtos;
    }

    /**
     * 내 피드만 가져오기
     *
     * @param userId
     * @param pageable
     * @return MyFeedListResponseDto
     */
    public MyFeedListResponseDto getMyFeedList(Long userId, Pageable pageable) {
        User user = userRepository.findById(userId).orElseThrow((() -> new IllegalArgumentException("유저를 찾지 못하였습니다.")));
        List<Running> feedList = runningRepository.findRunningByUserIdAndStatusWithFeedPics(userId, Status.LIVE);
        Page<MyFeedListDto> myFeedListDtos = new PageImpl<>(feedList.stream().map(MyFeedListDto::new).collect(Collectors.toList()), pageable, feedList.size());
        MyFeedListResponseDto feedListResponseDtos = new MyFeedListResponseDto(user.getProfilePic(), myFeedListDtos);
        return feedListResponseDtos;
    }

    /**
     * 디테일 페이지 그래프를 위한 OriginData JSONArray로 반환
     *
     * @param runningId
     * @return JSONArray
     */
    public JSONArray getOringinData(String runningId) {
        JSONArray jsonArray = new JSONArray();
        try {
            FileIO fileIO = new FileIO();

            // HDFS 파일 시스템 객체 생성
            FileSystem fs = FileSystem.get(fileIO.getConf(hdfsUrl, hdfsPort));

            // 파일 경로 설정
            Path filePath = new Path(fileIO.originData(runningId, hdfsUrl, hdfsPort));

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
                    // distance와 speed 추출
                    JSONObject select = new JSONObject();
                    select.put("distance", jsonObject.get("distance"));
                    select.put("speed", jsonObject.get("speed"));
                    jsonArray.add(select);
                }
                br.close();
            }
        } catch (IOException e) {
            new IllegalArgumentException("러닝기록을 읽어오는 부분에서 에러가 발생했습니다.");
        } catch (ParseException e) {
            new IllegalArgumentException("Json 변환 과정에서 에러가 발생했습니다.");
        }
        if (jsonArray.isEmpty())
            new IllegalArgumentException("해당 러닝기록이 비어있습니다.");
        return jsonArray;
    }

    /**
     * 피드 디테일 가져오기
     *
     * @param runningId
     * @return FeedDetailResponseDto
     */
    public FeedDetailResponseDto getFeedDetail(String runningId) {
        Running running = runningRepository.findRunningByIdWithFeedPics(runningId).orElseThrow(
                () -> new IllegalArgumentException("해당하는 러닝 기록이 없습니다."));
        FeedDetailResponseDto response = new FeedDetailResponseDto(running);
        response.setGraph(getOringinData(runningId));
        response.setWithRunCount(withRunRepository.countByRunningHostId(runningId));
        return response;
    }
}
