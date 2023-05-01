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
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print("*****************************************************")
		print(runningId)
		run_data = spark \
				   .read \
				   .json(f"hdfs:///another/origin/{runningId}/*") \
				   .select("distance","timestamp")

#		record_data =run_data.select([col(c) for c in run_data.columns if c == "timestamp" or c == "distance"])
		
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print("======================================================")
		print(runningId)
		run_data \
			.write \
			.option("maxRecordsPerFile",100000) \
			.json(f"hdfs:///another/challenge/{runningId}")
	except:
		pass

# SparkSession 만들기
spark = SparkSession.builder.appName("endTest").getOrCreate()

# schema 만들기
schema = StructType([
    StructField("runningId", StringType()),
 ])

# 토픽 구독 설정
df = spark \
    .readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers", "k8b308m.p.ssafy.io:9092") \
    .option("startingOffsets", "latest") \
    .option("subscribe", "end") \
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
