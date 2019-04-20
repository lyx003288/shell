#!/bin/bash

# ########################################################################################
# 按行读文件
# ########################################################################################

file="$0"

# 方法一 利用管道读取文件，读文件操作在子shell中执行
line_num=1
cat $file | while read line; do
    echo $line_num ":" $line
    ((line_num++))
done

# 方法二 每打印一个单词就换一次行，因为for循环使用空格作为默认的IFS
line_num=1
for word in $(cat $file); do
    echo $line_num ":" $word
    ((line_num++))
done

# 方法三 
line_num=1
while read line; do
    echo $line_num ":" $line
    ((line_num++))
done < $file

