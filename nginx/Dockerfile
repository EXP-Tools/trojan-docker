FROM nginx:mainline
ARG domain="demo_domain.com"

RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get clean && \
    apt-get update -y && \
    apt-get install -y procps build-essential libpq-dev nodejs

ADD ./html /usr/share/nginx/html
ADD ./etc/camouflage_site.conf /etc/nginx/conf.d/camouflage_site.conf
RUN mkdir -p /etc/nginx/cert/ && \
    mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak && \ 
    sed -i "s/YOUR_DOMAIN/${domain}/g" /etc/nginx/conf.d/camouflage_site.conf

RUN echo "alias ll='ls -alF'" >> /root/.bashrc
EXPOSE 80 8443
WORKDIR /etc/nginx/

