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
     * 디테일 페이지 그래프
     *
     * @param runningId
     * @param hdfsUrl
     * @param hdfsPort
     * @return String
     */
    public String originData(String runningId, String hdfsUrl, String hdfsPort) {
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
