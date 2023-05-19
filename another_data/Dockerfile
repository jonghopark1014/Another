FROM ubuntu:20.04
RUN mkdir -p /root/install
RUN apt-get update

WORKDIR /root/install

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

RUN apt-get install openjdk-11-jdk -y
RUN apt-get install wget -y
RUN apt-get install vim -y

# confluent-community 설치
RUN wget http://packages.confluent.io/archive/7.3/confluent-community-7.3.3.tar.gz
RUN tar -zxvf confluent-community-7.3.3.tar.gz
RUN mv confluent-7.3.3 /usr/local/confluent

# kafka-rest 설정파일 복사
COPY confluent_config/kafka-rest.properties /usr/local/confluent/etc/kafka-rest/kafka-rest.properties
RUN sed -i 's/\r//g' /usr/local/confluent/etc/kafka-rest/kafka-rest.properties

# kakfa-rest 실행
CMD /usr/local/confluent/bin/kafka-rest-start /usr/local/confluent/etc/kafka-rest/kafka-rest.properties