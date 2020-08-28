# trojan-docker

> docker 一键部署 trojan 服务端

------

## 概要

![](imgs/trojan.png)

如图所示为 trojan 服务端架构，其中有两个关键组件 trojan 和 nginx 。

因为从零开始部署这个架构对新手不够友好，故本项目将其封装成 docker 以实现一键部署。

另外强调下，本项目使用 certbot 为伪装站点签发 HTTPS 证书。 但由于 certbot 对各个组件的侵入性太强、而且首次安装有交互，所有该组件没有做成 docker 容器，而是将其直接安装到宿主机使用。

> 本项目主要目的是简化 trojan 服务端的搭建流程，默认你已对 trojan 的原理有一定的熟悉，例如为什么要申请域名、为什么要申请证书等等，所以不会对这些内容做过多解释，有需要请自行谷歌百度

## 环境要求

![](https://img.shields.io/badge/Platform-Linux%20x64-brightgreen.svg)


## 事前准备

域名


## 部署步骤

### 安装 docker

过程略，自行谷歌或百度即可，要求安装：

- docker
- docker-compose

### 安装 certbot

建议通过 python3 安装：

```python
python3 -m pip install certbot --default-timeout=600 -i https://pypi.tuna.tsinghua.edu.cn/simple
```

> 考虑到国内安装超时问题，该命令已指定了安装源为清华源

### 申请域名的 HTTPS 证书



# 第一次要输入邮箱注册，以后不用
/usr/local/bin/certbot certonly --standalone -d exp-blog.xyz -d www.exp-blog.xyz

# 到期前 30 天可以用这个命令更新证书； 其余时间可以用上面命令更新证书（每次有效期是3个月）
/usr/local/bin/certbot renew

# 设置定时更新(定时任务要关掉80端口)
crontab -e
0 0 1 */2 0 docker-compose down; /usr/bin/certbot renew; docker-compose up -d


./renew.sh



password=123456 domain=abc.com docker-compose build
./renew.sh
docker-compose up -d
docker-compose down
