# 乾坤袋软件的开发环境容器

## 介绍
在 Debian docker 中编译 **乾坤袋软件** 


## 使用说明

1.  创建 docker 镜像
./qkd_docker.sh docker-debian-qkd-dev build Dockerfile

2.  运行 docker 镜像
./qkd_docker.sh docker-debian-qkd-dev run

3.  保存 docker 镜像
./qkd_docker.sh docker-debian-qkd-dev save

4.  进入 docker 运行环境
docker attach ${USER}-build-qkd-app

5.  构建乾坤袋软件包
./build-qkd-app.sh

## 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request

