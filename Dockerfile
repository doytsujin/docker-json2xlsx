FROM ubuntu:16.04
MAINTAINER Andrey L <an.lebedevsky@gmail.com>
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk openjdk-8-jre gradle postgresql git-core
WORKDIR /opt
RUN git clone  https://github.com/onaio/json-to-xls
WORKDIR /opt/json-to-xls
RUN gradle installApp
WORKDIR /opt/json-to-xls/build/install/json-to-xls/
RUN cp /opt/json-to-xls/api.txt .

ADD start /start
RUN chmod 0755 /start
EXPOSE 8080

CMD ["/start"]

