package com.example.another_back.hdfs;

import org.apache.hadoop.conf.Configuration;
import org.springframework.beans.factory.annotation.Value;

public class FileIO {

    @Value("${data.all-data}")
    private String allData;

    @Value("${data.versus-data}")
    private String versusData;

    /**
     * HDFS 설정
     *
     * @return Configuration
     */
    public Configuration getConf() {
        // HDFS 접속 설정
        Configuration conf = new Configuration();
        conf.set("fs.defaultFS", "hdfs://k8b308m.p.ssafy.io:20000");
        conf.set("dfs.client.use.datanode.hostname","true");
        return conf;
    }

    /**
     *  전체 데이터 반환
     *
     * @param runningId
     * @return
     */
    public String allData(String runningId){
        String url = allData+runningId+"/*";
        return url;
    }

    /**
     * 경쟁 시작
     *
     * @param runningId
     * @return String
     */
    public String versusData(String runningId){
        String url = versusData+runningId+"/*";
        return url;
    }
}
