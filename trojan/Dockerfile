# How to use :
# docker build -t expm02/docker-trojan --build-arg password=demo_password .
# --------------------------------------------------------------------------------

FROM centos:7
MAINTAINER EXP
ARG password=demo_password

RUN yum update -y && \
    yum install -y epel-release gnutls-bin gnutls-doc
RUN mkdir -p /usr/local/bin && \
    mkdir -p /usr/local/etc/trojan/cert/

ADD ./script/trojan /usr/local/bin/trojan
ADD ./etc/config.json /usr/local/etc/trojan/config.json
RUN sed -i "s/YOUR_PASSWORD/${password}/g" /usr/local/etc/trojan/config.json

EXPOSE 443
WORKDIR /usr/local/etc/trojan/
CMD [ "/usr/local/bin/trojan", "/usr/local/etc/trojan/config.json" ]
