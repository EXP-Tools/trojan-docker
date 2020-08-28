#!/bin/sh


docker-compose down

/usr/local/bin/certbot renew
cat /etc/letsencrypt/live/*/fullchain.pem > ./cert/fullchain.pem
cat /etc/letsencrypt/live/*/privkey.pem > ./cert/privkey.pem

docker-compose up -d
