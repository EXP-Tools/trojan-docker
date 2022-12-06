#!/bin/bash
# ------------------------
# 构建镜像
# bin/build.sh 
#       [-p ${password}] 设置 trojan 密码
#       [-d ${domain}] 设置 trojan 域名
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
docker-compose build

echo "finish ."