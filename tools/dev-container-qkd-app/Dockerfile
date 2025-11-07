# 使用 Debian 13 作为基础镜像
FROM docker.io/rust:1.90.0-trixie

# 设置工作目录
WORKDIR /app

# 更新 apt 源为国内镜像
#RUN sed 's#http://deb.debian.org#https://mirrors.aliyun.com#g' -i /etc/apt/sources.list.d/debian.sources

# 安装 tauri 所需软件包
RUN apt update
RUN apt install -y \
  build-essential \
  curl \
  wget \
  file \
  libxdo-dev \
  libssl-dev \
  libayatana-appindicator3-dev \
  librsvg2-dev \
  libsoup-3.0-dev \
  libjavascriptcoregtk-4.1-dev \
  libwebkit2gtk-4.1-dev

# 安装 node 所需软件包
RUN apt install -y nodejs npm

# 安装 android 所需软件包
ENV ANDROID_HOME="/usr/lib/android-sdk"
RUN apt install -y android-sdk sdkmanager
RUN sdkmanager --install \
  'platforms;android-36' \
  'platform-tools' \
  'ndk;29.0.14206865' \
  'build-tools;36.1.0'
RUN rustup target add \
  aarch64-linux-android \
  armv7-linux-androideabi \
  i686-linux-android \
  x86_64-linux-android

STOPSIGNAL SIGKILL

