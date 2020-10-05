#!/bin/sh

WORKDIR=$1
if [ -z "${WORKDIR}" ] ; then
  WORKDIR="/usr/local/trojan-docker"
fi

docker-compose down

/usr/local/bin/certbot renew
cat /etc/letsencrypt/live/*/fullchain.pem > ${WORKDIR}/cert/fullchain.pem
cat /etc/letsencrypt/live/*/privkey.pem > ${WORKDIR}/cert/privkey.pem

docker-compose up -d
