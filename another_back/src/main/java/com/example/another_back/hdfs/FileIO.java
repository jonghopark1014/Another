package com.example.another_back.hdfs;

import org.apache.hadoop.conf.Configuration;

public class FileIO {

    public Configuration getConf() {
        // HDFS 접속 설정
        Configuration conf = new Configuration();
        conf.set("fs.defaultFS", "hdfs://k8b308m.p.ssafy.io:20000");
        return conf;
    }

    public String allData(String runningId){
        String url = "hdfs://k8b308m.p.ssafy.io:20000/another/origin/"+runningId+"/*";
        return url;
    }

    public String versusData(String runningId){
        String url = "hdfs://k8b308m.p.ssafy.io:20000/another/test1/"+runningId+"/*";
        return url;
    }
}
