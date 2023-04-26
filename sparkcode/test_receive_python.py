import findspark
from pyspark.sql import SparkSession


findspark.init()
# spark 세션 연결
data_parameter = f"hdfs://k8b308m.p.ssafy.io:20000/another/challenge/4230426/*"
spark = SparkSession.builder.master('local').config("spark.hadoop.dfs.client.use.datanode.hostname", "true").getOrCreate()
data = spark.read.parquet(data_parameter)

# data = data.toPandas()
data.show()
print(type(data))
#print(data.shape)
# print(data)
