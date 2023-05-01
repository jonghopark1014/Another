package com.example.another_back.hdfs;

import org.apache.spark.sql.SparkSession;

public class SparkSessionInstance {
    private static SparkSession session;
    public SparkSessionInstance() {
            session = SparkSession
                .builder()
                .master("local[*]")
                .config("spark.hadoop.dfs.client.use.datanode.hostname","true")
                .getOrCreate();
    }

    public static SparkSession getSession() {
        return session;
    }
}
