# PowerShell
# ------------------------
# 构建镜像
# bin/build.ps1 
#       [-p ${password}] 设置 trojan 密码
#       [-d ${domain}] 设置 trojan 域名
# ------------------------

param(
    [string]$p="demo_password", 
    [string]$d="demo_domain.com"
)

$PASSWORD = $p
$DOMAIN = $d

$ENV:password=${PASSWORD}; `
$ENV:domain=${DOMAIN}; `
docker-compose build

Write-Host "finish ."