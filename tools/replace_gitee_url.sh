#!/bin/bash

# 指定要遍历的目录
DIR="$PWD"

# 使用 find 命令查找所有文件，并通过 while 循环读取
find "$DIR" -type f | while IFS= read -r file;
do
  echo "Processing $file"
  # 在这里添加你要对每个文件执行的操作
  sed "s#https://github.com/david921518/qkd-app/blob/master#https://gitee.com/david921518/qkd-app/blob/gitee#g" -i $file
done
