FROM ubuntu:16.04

MAINTAINER Andrey L <an.lebedevsky@gmail.com>

RUN apt-get update
RUN apt-get install -y default-jre default-jdk gradle postgresql 

FROM library/postgres
ENV POSTGRES_USER docker
ENV POSTGRES_PASSWORD docker
ENV POSTGRES_DB docker

WORKDIR /opt
RUN git clone  https://github.com/lebedevsky/json-to-xls
WORKDIR /opt/json-to-xls
RUN gradle installDist

WORKDIR /opt/json-to-xls/build/install/json-to-xls/
RUN ln -s /opt/json-to-xls/api.txt api.txt
ADD json-to-xls.yml /json-to-xls.yml
RUN bin/json-to-xls db migrate json-to-xls.yml
RUN bin/json-to-xls server json-to-xls.yml
EXPOSE 8080