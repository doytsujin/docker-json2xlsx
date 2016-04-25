FROM ubuntu:14.04

MAINTAINER Andrey L <an.lebedevsky@gmail.com>

# update
RUN apt-get update
RUN apt-get install -y git default-jre default-jdk gradle postgresql

# code
WORKDIR /opt
RUN git clone https://github.com/lebedevsky/json-to-xls
WORKDIR /opt/json-to-xls
RUN gradle installApp

# db
FROM library/postgres
ENV POSTGRES_USER docker
ENV POSTGRES_PASSWORD docker
ENV POSTGRES_DB docker

# config
RUN ln -s /opt/json-to-xls/api.txt /opt/json-to-xls/build/install/json-to-xls/api.txt
ADD /opt/json-to-xls/build/install/json-to-xls/json-to-xls.yml /json-to-xls.yml
ADD /opt/json-to-xls/build/install/json-to-xls/start /start
RUN chmod 0755 /opt/json-to-xls/build/install/json-to-xls/start

EXPOSE 8080

CMD ["/opt/json-to-xls/build/install/json-to-xls/start"]