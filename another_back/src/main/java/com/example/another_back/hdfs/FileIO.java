package com.example.another_back.hdfs;

import org.apache.hadoop.conf.Configuration;

public class FileIO {
    /**
     * HDFS 설정
     *
     * @return Configuration
     */
    public Configuration getConf(String hdfsUrl, String hdfsPort) {
        // HDFS 접속 설정
        System.out.println(hdfsUrl + ":" + hdfsPort);
        Configuration conf = new Configuration();
        conf.set("fs.defaultFS", hdfsUrl + ":" + hdfsPort);
        conf.set("dfs.client.use.datanode.hostname", "true");
        return conf;
    }

    /**
     * 전체 데이터 반환
     *
     * @param runningId
     * @return
     */
    public String allData(String runningId, String hdfsUrl, String hdfsPort) {
        String url = hdfsUrl + ":" + hdfsPort + "/another/origin/" + runningId + "/*";
        return url;
    }

    /**
     * 경쟁 시작
     *
     * @param runningId
     * @return String
     */
    public String versusData(String runningId, String hdfsUrl, String hdfsPort) {
        String url = hdfsUrl + ":" + hdfsPort + "/another/test1/" + runningId + "/*";
        return url;
    }
}
