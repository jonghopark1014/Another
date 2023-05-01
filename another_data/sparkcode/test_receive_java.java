package com.example.another_back.hdfs;

import org.apache.hadoop.shaded.com.nimbusds.jose.shaded.json.JSONArray;
import org.apache.hadoop.shaded.com.nimbusds.jose.shaded.json.JSONObject;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

import static org.apache.spark.sql.functions.col;

public class Test {

    private static SparkSessionInstance sparkSessionInstance = new SparkSessionInstance();

    public static JSONArray toJson(Dataset<Row> dataset) {
        JSONArray jsonArray = new JSONArray();
        for (Row row : dataset.collectAsList()) {
            JSONObject jsonObject = new JSONObject();
            for (int i = 0; i < row.length(); i++) {
                String fieldName = row.schema().apply(i).name();
                Object fieldValue = row.get(i);
                jsonObject.put(fieldName, fieldValue);
            }
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }
    public static void main(String[] args) {
        SparkSession session = sparkSessionInstance.getSession();
        Dataset<Row> readDS = session.read().parquet("hdfs://k8b308m.p.ssafy.io:20000/another/challenge/4230426/*").sort(col("distance"));
        JSONArray json = toJson(readDS);
        System.out.println(json);
        System.out.println("here");
    }
}