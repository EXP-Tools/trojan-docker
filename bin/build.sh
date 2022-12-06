#!/bin/bash
# ------------------------
# 构建镜像
# bin/build.sh [-c OFF]
#   -c 是否启用缓存构建: OFF/ON(默认)
# ------------------------

PASSWORD="demo_password"
DOMAIN="demo_domain.com"

set -- `getopt p:d: "$@"`
while [ -n "$1" ]
do
  case "$1" in
    -p) PASSWORD="$2"
        shift ;;
    -d) DOMAIN="$2"
        shift ;;
  esac
  shift
done


password=${PASSWORD} \
domain=${DOMAIN} \
docker-compose up -d


docker image ls | grep "${image_name}"
echo "finish ."