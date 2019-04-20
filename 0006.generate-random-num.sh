#!/bin/bash

# ########################################################################################
# 生成随机数的几种方法
# ########################################################################################

len=10

# 方法一
code=`tr -dc "A-Za-z0-9-\+=\!@#\$%\^\&*" < /dev/urandom | head -c ${len}`
echo "m1: generate random number is ${code}, the length is ${len}"

# 方法二
code=`date +%s%N | md5sum | head -c ${len}`
echo "m2: generate random number is ${code}, the length is ${len}"

# 方法三
code=`cat /proc/sys/kernel/random/uuid | md5sum | cut -f1 -d" " | head -c ${len}`
echo "m3: generate random number is ${code}, the length is ${len}"
