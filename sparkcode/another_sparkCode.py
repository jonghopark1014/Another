# spark import
import findspark
findspark.init()

import pyspark

# kafka, json
from kafka import KafkaConsumer
from json import loads

# pyspark 세션, 함수 설정
from pyspark import SparkContext
from pyspark.sql.functions import *
from pyspark.sql import SparkSession
from pyspark.sql.types import *
from pyspark.sql.functions import lit

# HDFS에 데이터 쓰는 함수
def write_to_hdfs(df, epoch_id):
	try:  
		runningId = df.select("runningId").collect()[0][0]
		print(runningId)
		run_data = df.select([col(c) for c in df.columns if c != "runningId"])
		record_data = df.select([col(c) for c in df.columns if c == "timestamp" or c == "distance"])
    # running_id에 따른 hdfs 적재
		run_data.write.format("parquet").mode("append").save(f"/another/origin/{runningId}")
		record_data.write.format("parquet").mode("append").save(f"/another/challenge/{runningId}")
	except:
		pass
# SparkSession 만들기
spark = SparkSession.builder.appName("KafkaStreamReader").getOrCreate()

# schema 만들기
schema = StructType([
    StructField("runningId", StringType()),
    StructField("latitude", FloatType()),
    StructField("longitude", FloatType()),
    StructField("speed", FloatType()),
	StructField("distance", FloatType()),
    StructField("timestamp", TimestampType()),
    StructField("walkCount", IntegerType()),
    StructField("kcal", IntegerType()),
])

# 토픽 구독 설정
df = spark \
    .readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers", "k8b308m.p.ssafy.io:9092") \
    .option("startingOffsets", "latest") \
    .option("subscribe", "testtest") \
    .option("maxOffsetsPerTrigger", 1) \
    .load()

# json 형식으로 변환
df2 = df.selectExpr("CAST(value AS STRING)").select(from_json("value", schema).alias("data"))

# 전체 추출
df3 = df2.select("data.*")
# MySQL에 저장
query = df3.writeStream \
    .foreachBatch(write_to_hdfs) \
    .start() \
    .awaitTermination()
