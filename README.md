# trojan-docker

> docker 一键部署 trojan 服务端

------

## 概要

![](nginx/html/imgs/trojan.png)

如图所示为 trojan 服务端架构，其中有两个关键组件 trojan 和 nginx 。

因为从零开始部署这个架构对新手不够友好，故本项目将其封装成 docker 以实现一键部署。

另外强调下，本项目使用 certbot 为伪装站点签发 HTTPS 证书。 但由于 certbot 对各个组件的侵入性太强、而且首次安装有交互，所有该组件没有做成 docker 容器，而是将其直接安装到宿主机使用。

> 本项目主要目的是简化 trojan 服务端的搭建流程，默认你已对 trojan 的原理有一定的熟悉，例如为什么要申请域名、为什么要申请证书等等，所以不会对这些内容做过多解释，有需要请自行谷歌百度

## 环境要求

![](https://img.shields.io/badge/Platform-Linux%20amd64-brightgreen.svg)


## 事前准备

- 宿主机安装 docker、docker-compose
- 宿主机安装 python3
- 已申请可用域名（如 demo_domain.com），并解析到宿主机的公网 IP


## 部署步骤

### 1. 安装 certbot

建议通过 python3 安装：

```shell

# 考虑到国内安装超时问题，该命令已指定了安装源为清华源
python3 -m pip install certbot --default-timeout=600 -i https://pypi.tuna.tsinghua.edu.cn/simple
```

> 之所以不把 certbot 也做成 docker 容器，是因为它的入侵性太强，做成容器反而不方便


### 2. 用 certbot 为域名申请免费 HTTPS 证书

```shell
/usr/local/bin/certbot certonly --standalone -d demo_domain.com -d www.demo_domain.com
```

> 第一次执行该命令，需要根据交互步骤先注册邮箱，以后不再需要。


### 3. 安装 trojan 服务

```shell

# 下载本项目仓库
git clone https://github.com/lyy289065406/trojan-docker /usr/local/trojan-docker
cd /usr/local/trojan-docker

# 构建 docker 镜像
# password 为之后客户端连接 trojan 的密码
# domain 为前面准备好的域名
password=demo_password domain=demo_domain.com docker-compose build

# 刷新证书有效期，并复制宿主机的 HTTPS 证书到 docker 容器
./renew_cert.sh

# 在后台启动 trojan 服务
docker-compose up -d

# 停止 trojan 服务
docker-compose down
```


### 4. 自定义伪装站点内容

把 [`nginx/html`](nginx/html) 下的内容替换为你站点的内容。



## 自动刷新证书

certbot 申请的证书有效期为 90 天，在到期前的 30 天可以重新执行以下命令为更新证书有效期：

```
/usr/local/bin/certbot renew
```

> 该命令会占用 80 端口，执行前要停止相关进程（如 nginx）

但是每次都手动更新会比较麻烦，可以把 [renew_cert.sh](renew_cert.sh) 脚本设置到 crontab 自动更新证书：


```shell

# 编辑定时任务
crontab -e

# 每两个月更新一次证书
0 0 1 */2 0 /bin/sh /usr/local/trojan-docker/renew_cert.sh
```


## 各开放端口用途一览

| 端口 | 进程 | 用途 | 备注 |
|:---:|:---:|:---:|:---:|
| 443 | trojan | trojan 代理服务 | - |
| 8443 | nginx | 伪装 HTTPS 服务 | - |
| 80 | nginx | 伪装 HTTP 服务 | - |
| 80 | certbot | HTTPS 证书申请服务 | 与 nginx 服务端口冲突，<br/>故申请/续期证书时需要先停止 nginx |

