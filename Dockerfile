FROM ubuntu:14.04

MAINTAINER Andrey L <an.lebedevsky@gmail.com>

# update
RUN apt-get update
RUN apt-get install -y git default-jre default-jdk gradle postgresql

# db
#FROM library/postgres
#ENV POSTGRES_USER docker
#ENV POSTGRES_PASSWORD docker
#ENV POSTGRES_DB docker

# code
WORKDIR /opt
RUN git clone https://github.com/lebedevsky/json-to-xls
WORKDIR /opt/json-to-xls
RUN gradle installApp

# config
WORKDIR /opt/json-to-xls/build/install/json-to-xls
ADD json-to-xls.yml json-to-xls.yml
ADD start start
RUN chmod 0755 start

EXPOSE 8080

CMD ["start"]