import random
import time
from kafka import KafkaProducer
from json import dumps

producer = KafkaProducer(
    acks=0,
    compression_type='gzip',
    bootstrap_servers=['k8b308m.p.ssafy.io:9092'],
    value_serializer=lambda v: dumps(v).encode('utf-8'),
)

times = 1000
walk = 100
kcal = 150
km = 1000

def random_value_producer():
    global times, walk, kcal, km
    rd = random.random()
    key = '8230426'
    a = rd * 20
    b = rd * 15
    c = rd * 30

    running1 = {}
    running1['distance'] = km
    running1['runningId'] = key
    running1['latitude'] = a
    running1['longitude'] = b
    running1['speed'] = c
    running1['timestamp'] = times
    running1['walkCount'] = walk
    running1['kcal'] = kcal

    # producer code
    producer.send('testtest', running1)
    producer.flush()
    print("토픽1을 보냈습니다")
    time.sleep(1)
    print("토픽1 보낸 후 1초가 지났습니다")

def random_value_producer2():
    global times, walk, kcal, km
    rd = random.random()
    key = '9230426'
    a = rd * 10
    b = rd * 15
    c = rd * 20

    running2 = {}
    running2['distance'] = km/10
    running2['runningId'] = key
    running2['latitude'] = a
    running2['longitude'] = b
    running2['speed'] = c
    running2['timestamp'] = times
    running2['walkCount'] = walk/10
    running2['kcal'] = kcal/10

    # producer code
    producer.send('testtest', running2)
    producer.flush()
    print("토픽2를 보냈습니다")
    time.sleep(1)
    print("토픽 2를 보낸지 1초가 지났습니다")

def random_value_producer3():
    global times, walk, kcal, km
    rd = random.random()
    key = '10230426'
    a = rd * 10
    b = rd * 15
    c = rd * 20

    running3 = {}
    running3['distance'] = km/5
    running3['runningId'] = key
    running3['latitude'] = a
    running3['longitude'] = b
    running3['speed'] = c
    running3['timestamp'] = times
    running3['walkCount'] = walk/5
    running3['kcal'] = kcal/5

    # producer code
    producer.send('testtest', running3)
    producer.flush()
    print("토픽3을 보냈습니다")
    time.sleep(1)
    print("토픽3을 보낸지 1초가 지났습니다")

while True:
    random_value_producer()
    random_value_producer2()
    random_value_producer3()
    times += 1
    walk += 100
    kcal += 50
    km += 1000
